Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3020E7DEFEC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346488AbjKBK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345942AbjKBK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:28:05 -0400
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28464189
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:28:02 -0700 (PDT)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-507d0e4eedaso632245e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698920879; x=1699525679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXavQptMw6imFSgFZcFRvrc2OMV1znfpMMkkj7fkIKk=;
        b=FOkZBx+C2qi/t0GD/KP7bWExSKxshg/5oHG0cDINFGQLPBUlixLIkXQLpbXkZph5ai
         KS1/BdPhNp6JP7WrhBwGFb1WMN0X3I/uOBYkdPdfY7o9rLORBNbRd3NvkdkTWLD5MT7+
         w7X13pp36nsUF9IV90WB2imEdtJBFxxyLq5/OalSQoooCz34uvnOIU4drWe5GnzoBa/P
         XTMKBHBUsjB36Fz3Bc9WOZjURtShLaquqTMn/MYmPCrtbDSLJwcHKXYGBW1nnPOSUbGB
         4vH8kZFZaIHJSJme0S8ahzl8rL8gEZX3EHI6t95L3ulhP4bHGw+sTbFTAEOuZTewXz5R
         /c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698920879; x=1699525679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXavQptMw6imFSgFZcFRvrc2OMV1znfpMMkkj7fkIKk=;
        b=UbjLB0G4tgyujdMoByuNBqtLghcjUoEop8Qbv3cnQXlJ7dORzlbQwq+iCZ5UXC3Q5e
         /yFrjBl+RWhdvbmYdqgwmfJC1BoJuisc8DBImUj+STEQDQoOGqo2+3cM/Z4nKV12XPCu
         OY6ihXpvUSie25tidjrtpWOguVXWWLbcr3Uvd0YpOmZzc8EJCJBX9qa7I0qVDO5C6lXB
         bCNF2pUs0Fgyako8m2aqppJo3SlTuz3RL0CmsWAZr3ruK+WjRq7JrFu+GRpgrLDWRywU
         vpE3lyhbJsZt6waoqn9FHhH6ZEdYnAVlzxFXRvdqookSrqkiv/awzrXuL0NqRx292xGo
         gNoA==
X-Gm-Message-State: AOJu0YxDBc1ijoYEX+W7El5MK/uAdAUqiLIJTGNsaR11y+kPSZ0a7Z8k
        D44S6jqfn454FJTCenrnJBqaG7hdwI8Bn20=
X-Google-Smtp-Source: AGHT+IFiCgId1VdigJnT4JYPj0yD3/qeTRKlBVdkklmQdqscFfveqmw6VO4OE5YmlaoSadV0PxM7U6CTTytWEYA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:368f:b0:509:4956:515f with SMTP
 id d15-20020a056512368f00b005094956515fmr10148lfs.8.1698920879312; Thu, 02
 Nov 2023 03:27:59 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:27:56 +0000
In-Reply-To: <ZUKYKw8QlPguQEBM@boqun-archlinux>
Mime-Version: 1.0
References: <ZUKYKw8QlPguQEBM@boqun-archlinux>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231102102756.909978-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC 01/20] rust_binder: define a Rust binder driver
From:   Alice Ryhl <aliceryhl@google.com>
To:     boqun.feng@gmail.com
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, brauner@kernel.org, cmllamas@google.com,
        gary@garyguo.net, gregkh@linuxfoundation.org, jeffv@google.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        maco@android.com, mattgilbride@google.com, mmaurer@google.com,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tkjos@android.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boqun Feng <boqun.feng@gmail.com> writes:
>> +#include <uapi/linux/android/binder.h>
>
> I wonder whether we could (and should) move this into
> rust/uapi/uapi_helpers.h

Sure. That was introduced after I wrote this part, but I'm happy to move
it if you think it would make sense.

Alice


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4458031FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjLDL5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjLDL5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E2318B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3eafe3d17so24402827b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691039; x=1702295839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7P6J0JgVhwjPM5/pNpvRdm7XN5awnCG2ekeIh9Yh/JY=;
        b=lus50no76LkLXkQmY0JTdbkEXPDWqDqHnfRecFQ8747KzRZ/kDEuHMGlODxdpiCqVs
         0COCAPJxYze//U5J7dykr3yo7jyGC/O4TQE52Ro6tPgV0vR7WxSA6eNQbiTFxkHXJ6cC
         xRDTNvtwaf00526kcDv5HNwHE6Q9xsLF7sB9P+mxwFIuJPBxiNA1TjxgPNWt1yiE6v3r
         IDneTz25cZJSKb9QpcrtPvDcg4M+yzjXs/CtHTaVlJRyoWW3EDiTSsq7fG56kaSwWeM1
         tpWL3B5v+4MQN7DpkUHpbbXpu7HDGT46gU3M1zdc3VXxUSgGlNVz237lX+VmjZRtgQ2A
         V3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691039; x=1702295839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7P6J0JgVhwjPM5/pNpvRdm7XN5awnCG2ekeIh9Yh/JY=;
        b=BzHBXNjlvw0QHSXsG6XF/eT4MnqWpqUi35NBd4RheM+lbB9wZg2NzZwflTeAneH1ua
         GFNL6b7nO6pESwvFihi8cU5KCjSKztuZQlfUZbenBd+zzDeIpKa+rn5XgdxJ0ROcqYy5
         MeVYCu3b7ziUJipnYgAekeh7Y8WnMJ6+1MtDZkRtXYlKxUQR+y9r9hom4Qgekl+hozwe
         TXdAWnVS8kfd1iFePDjYJfa2pEDoJi07KDHr8GyPI9qbrCQ/QkEj0J9PMXCX1kUegJCe
         +HApcnJRZRDdZ0BOoNED8l9wcNg+256z5SiMHHsCbcupfVUd49MWZ6Uq8SkVpAAxIUH4
         v32w==
X-Gm-Message-State: AOJu0YwrN3SGR8mcUviDKNVAcGCF3rTWgyRGypWfXpQzfL5yjx9WuC1o
        eFRBoqPP9F1KW1VfaRfqo9IUGycepCqIqTI=
X-Google-Smtp-Source: AGHT+IGPig5j+No5IoRJdHDwR59xFfNkhmyW3ynVHgeVjnxFQH9tc8VPnlE/HcduEHh14fisCGNF1PTMYmQ2htc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:be15:0:b0:5d3:56a4:9073 with SMTP id
 i21-20020a81be15000000b005d356a49073mr550210ywn.2.1701691039143; Mon, 04 Dec
 2023 03:57:19 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:57:15 +0000
In-Reply-To: <20231201172212.1813387-21-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-21-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115715.41430-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 20/28] binder: remove redundant debug log
From:   Alice Ryhl <aliceryhl@google.com>
To:     cmllamas@google.com
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com, Alice Ryhl <aliceryhl@google.com>
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

> The debug information in this statement is already logged earlier in the
> same function. We can get rid of this duplicate log.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

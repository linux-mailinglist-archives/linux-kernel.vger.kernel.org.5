Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32297E3736
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjKGJJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbjKGJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:37 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592911A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:25 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-507f20a111fso3667511e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348104; x=1699952904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jdBn3S4js/l9w9fbnbImdcyCevaHmMvFucicp7ucn8c=;
        b=qVtdRFSH3s6EzSDDdbFO+FbHUcDTtPNk01Wf6YXYkwtwhJOtCJT88extJqCfcCVRkf
         TDRZDajEa+A5WpLX8rKADMnSbB3T5qmEedX2glAPuf3CRmwwTXXYDlGXovcBoQY7U7cC
         +Kyh7KzbP+TzzAbNX8kJXhS26X4Xa57FKa+NtK1CbdUp8mFqMNabM/KqYZiRxJO0c0Lf
         Yn/DFLFSjwYRO1ON3lrjB96W1nuOwG4vihapXvl8d5WlZF/na4DDovcs7+MvQIWKRIgm
         DYX9qr2t8MN1ysnuzspFbQKXovoqnaG97Q+edCwVcMg2cSS+A8ZLF7U96hundB1vZqtO
         1mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348104; x=1699952904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdBn3S4js/l9w9fbnbImdcyCevaHmMvFucicp7ucn8c=;
        b=NSUvjOtlOPOlSN1D6q3G1gCq8KrnvlKoPcwI+Ws8sgQOKmLn60Feil2+UYhiu/ZpbL
         7zm7JgatItiJOSW4LyXM4apmDW3iJS0PhGrzvKzF20e7zAU1aDeVKvuJ1ZitcuFTnBEz
         IYctBkkFvlAdXqeaz/RuHMKbF9XEqtQvrhiHHPNpgMwn3bZRNF9Qb6h8c7nl0c+juO35
         a3degytfoeDOgLGbpfUNPNTma4Yovh9UYNGvan/CEl7+hzWztAjc8JyTe5nyF+T854wM
         cbMA7miq8tBFdjPuwyZpS9FsV3NPajKACBqmQGnussQ7uCrGEE6WgJLrsJ40JvMp/JOl
         qtIg==
X-Gm-Message-State: AOJu0Yy8g8bt1TX20kMOKBgy0tTd2ZhbjGOU3hs0wgZe9z9qlCd3eM34
        /iT6q+g6Vtr3v8s5iEjHm5IlGsilQZ5PLT8=
X-Google-Smtp-Source: AGHT+IHyOoj3oHJI2k0kduiGdFQZ/ZVOc99M9QN484IBitUoU1OoygGR3uMyKzmSTdTgB/Ygt/I1QjaeOiHgo1M=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:4951:0:b0:502:9f97:3286 with SMTP id
 o17-20020ac24951000000b005029f973286mr35014lfi.1.1699348104021; Tue, 07 Nov
 2023 01:08:24 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:21 +0000
In-Reply-To: <20231102185934.773885-12-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-12-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090821.258938-1-aliceryhl@google.com>
Subject: Re: [PATCH 11/21] binder: remove pid param in binder_alloc_new_buf()
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
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

Carlos Llamas <cmllamas@google.com> writes:
> Binder attributes the buffer allocation to the current->tgid everytime.
> There is no need to pass this as a parameter so drop it.
> 
> Also add a few touchups to follow the coding guidelines. No functional
> changes are introduced in this patch.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

You could argue that this code would be cleaner without this change,
since it now relies on global state. However, I'm okay either way.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261097537D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbjGNKVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbjGNKVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:21:00 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E976198A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:20:59 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-994320959f4so96452466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689330058; x=1691922058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ake/2lNPSYG4Kup6Znr90jxcuDjnCQa+kK9QxHmxIwE=;
        b=FdFgSbE9EX08KPCV3DFRa0KauNWmUSSKQuD9KCfK4mOB1MOb00hUTblNSomfgkxhXE
         lktUE68J2GJstAUj/3c+jsVLoFGKsyNmD+spCDoSEq9pliOoU/eTeGKuECVOQJrW96JW
         0DVOb7zMv+7uYhP2k11Kxl4mudnbg+7chPKt8ON/beLgn35QBKRpxoMgV1d5B1uNfFG3
         AgxMMV52IQLUcoM3lpUr88qrhOm889EDxsbpie2PXgMV/VEPfl+Rvtil+sLok6f8e1nb
         hqEwDY8sB3TJuxoDWtQB6lvtOAXTfuQNn+0jvX40UPp1Eoy/88cODPzkhRG3lBSO3Q1c
         ul/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689330058; x=1691922058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ake/2lNPSYG4Kup6Znr90jxcuDjnCQa+kK9QxHmxIwE=;
        b=DUJ71dbR6I/m2fvWW5M2hQzS9UMHqGwOcqnTNx6TZ3OOGUmeOaQnDTwcIfhz/uMaQC
         OSBaaUBKERVL8uf0K/q2jsYwDi8Al00tuDHHv+lKINISNlc0H6CIPtpvw5c5OWEOw+56
         pc4PFgRhCvtfgvSh+VsaZ670m/u5/sNb5OLCAfCMdukcCRGo8NrkEtpKlbuY+vLinn/y
         vUOgJQT1VKzN5Hd2DwHO6ZdlKBCDQPavPdGBOALb9InKPvhg0lLwG6OfD50i7Y+yeuae
         GBqenIh+119i29vfgvMg7wXRtTc+5kOdQ/FrVgcLd1CbYXVdXemdKmt7aBnjAu98QjDG
         weTw==
X-Gm-Message-State: ABy/qLZTCpBWPBTGmPZpvYYTit5K1sPU+wSs1Tiqx9ZjDnRiLgryCuHA
        Ks85rK1Po/RBsMfaUgC6uHRryc8YpF6umLk=
X-Google-Smtp-Source: APBJJlFUTjwiYHQXGcSMMNCtJzQc7XCp95jN1C2fnAoH9M2eakhZaTVLYzm8MTgye2tlwRUOsp8FX+gnfVMrb1M=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:8a62:b0:978:67a2:f503 with SMTP
 id hy2-20020a1709068a6200b0097867a2f503mr8783ejc.12.1689330057916; Fri, 14
 Jul 2023 03:20:57 -0700 (PDT)
Date:   Fri, 14 Jul 2023 10:15:01 +0000
In-Reply-To: <20230714-classless_lockdep-v1-1-229b9671ce31@asahilina.net>
Mime-Version: 1.0
References: <20230714-classless_lockdep-v1-1-229b9671ce31@asahilina.net>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230714101501.2194205-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC 01/11] rust: types: Add Opaque::zeroed()
From:   Alice Ryhl <aliceryhl@google.com>
To:     lina@asahilina.net
Cc:     alex.gaynor@gmail.com, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, daniel@ffwll.ch, gary@garyguo.net,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, marcan@marcan.st, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        sven@svenpeter.dev, trix@redhat.com, wedsonaf@gmail.com,
        Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asahi Lina <lina@asahilina.net> writes:
> Opaque types are internally MaybeUninit, so it's safe to actually
> zero-initialize them as long as we don't claim they are initialized.
> This is useful for many FFI types that are expected to be zero-inited by
> the user.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>

LGTM. This is useful on its own.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


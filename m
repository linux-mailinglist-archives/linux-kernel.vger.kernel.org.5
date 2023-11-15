Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2700A7EBCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 05:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjKOEcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 23:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKOEcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 23:32:20 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E643D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 20:32:17 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a98517f3so8461781e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 20:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700022735; x=1700627535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LN7sL9L7rvPrvS+OOge88EHfPOu+JSJwpJeO/wkyEyU=;
        b=Uyz0BJBaDocy967aV2J1rBLB9b1pRFE58yaD33gem5k1FSxPdaSt2anp4zuFD9rikO
         pNMaQTq5r/5TtK4TuBGxeKJxhBnSo/k+xF+nmspJaiINXSQ8el8joZDaFZeKmhmbTlSb
         zy87ZfZ7+GKAKT1ViXts3B4CTCOrbAeDbKukU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700022735; x=1700627535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LN7sL9L7rvPrvS+OOge88EHfPOu+JSJwpJeO/wkyEyU=;
        b=uQJ/TeGZn2RQ3QOsFqT/DfZZqPEP8QJX7ZxHxr8ct4cQ8n3IVlbS6dk0agbmMu/HQn
         SJuqmyXNRKoBxF/M1oSq/EoWCWqdERCmtvtSPB4P3LNH3ap2M45MZPMiAnqm+HofNbeV
         CZTt3r+FM0x1r6BthgI1gd2rgpCG24hhNJwI9Aghoxb1ja6SVBZoIRSn0yw98kJs2Ba6
         w2n6U7wQwWBwz9t5cFZSY1SsR8xx6GAbS9UHXP44BhpUBl276ssJdA4kE8i40QN7hv+L
         PyQrdo/dDrL2OQSp0gDoaWGS2qBUdx9xBA/4uOP92HWWJPGymfI7z+bcX+H/WFOnNblg
         CpmA==
X-Gm-Message-State: AOJu0YwmqEJ6zHtXHzmBQRMeMUCt1Ti/mokhO7M5S0sVCeVRgMDuleBU
        H4DUDhNl1vA1pNC5p073ZL/QCUO9NYIEA/pICZOWAA==
X-Google-Smtp-Source: AGHT+IFdBfdtfukdeTFRFC5Q1a/kJe4vofNP3xY8k/1x9lOwt3zr/Ah8zgSsn70Hq8AzoS38r5KIzA==
X-Received: by 2002:ac2:4852:0:b0:509:8a68:eb8b with SMTP id 18-20020ac24852000000b005098a68eb8bmr6292057lfy.2.1700022735224;
        Tue, 14 Nov 2023 20:32:15 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k8-20020a05651210c800b0050a76331c7fsm1426062lfg.185.2023.11.14.20.32.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 20:32:14 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-507e85ebf50so8461731e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 20:32:14 -0800 (PST)
X-Received: by 2002:ac2:4e0f:0:b0:50a:26b:6ddf with SMTP id
 e15-20020ac24e0f000000b0050a026b6ddfmr9911649lfr.63.1700022734143; Tue, 14
 Nov 2023 20:32:14 -0800 (PST)
MIME-Version: 1.0
References: <11692A57-6A65-4ADE-BAE3-169D50A1FC16@meta.com>
In-Reply-To: <11692A57-6A65-4ADE-BAE3-169D50A1FC16@meta.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Nov 2023 20:31:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSBZG6ZaYe0pFm7iJL9Yab64zGdOVkLg2-FfhsXTtx+g@mail.gmail.com>
Message-ID: <CAHk-=wgSBZG6ZaYe0pFm7iJL9Yab64zGdOVkLg2-FfhsXTtx+g@mail.gmail.com>
Subject: Re: [GIT PULL] Zstd fixes for v6.7
To:     Nick Terrell <terrelln@meta.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 17:17, Nick Terrell <terrelln@meta.com> wrote:
>
> Only a single line change to fix a benign UBSAN warning that has been
> baking in linux-next for a month. I just missed the merge window, but I
> think it is worthwhile to include this fix in the v6.7 kernel. If you
> would like me to wait for v6.8 please let me know.

Hmm. You claim it's been in linux-next for a month, but why the hell
was it then rebased *minutes* before you sent the pull request?

That's really not ok. Rebasing literally removes the test coverage you
had. What possible reason was there for rebasing? And why didn't you
mention it?

So stop doing these dodgy things.

I have pulled this, but despite this being a "trivial" one-liner, I
think there is a bug in there somewhere.

In particular, we *used* to have

  typedef struct {
       short ncount[FSE_MAX_SYMBOL_VALUE + 1];
       FSE_DTable dtable[1]; /* Dynamically sized */
  } FSE_DecompressWksp;

and in FSE_decompress_wksp_body() we have

    FSE_DecompressWksp* const wksp = (FSE_DecompressWksp*)workSpace;
    ...
    if (wkspSize < sizeof(*wksp)) return ERROR(GENERIC);
    ...
    wkspSize -= sizeof(*wksp) + FSE_DTABLE_SIZE(tableLog);

and note that "sizeof(*wksp)".

Because it has *changed* with that one-liner fix, since now we have an
unsized array there:

  typedef struct {
       short ncount[FSE_MAX_SYMBOL_VALUE + 1];
       FSE_DTable dtable[]; /* Dynamically sized */
  } FSE_DecompressWksp;

so while the logic actually looks better to me with the change (no
more off-by-one errors), the fact that it used to work with what looks
like an off-by-one error in the sizeof() calculation just makes me go
"Hmm".

In particular, that

    wkspSize -= sizeof(*wksp) + FSE_DTABLE_SIZE(tableLog);

seems to have removed too much from the wkspSize variable, but it
still ended up not triggering any limit checks. Hmm?

End result: this may be a one-liner change, but honestly, I think it
was done HORRIBLY BADLY. That one-liner has serious implications and
just a trivial check of mine seems to say this code is or was seriosly
buggy exactlky when it comes to that one-liner.

And no, rebasing minutes before sending a pull request is not ok.

                   Linus

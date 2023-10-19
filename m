Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463E27CFE0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346331AbjJSPhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346115AbjJSPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:37:16 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2DCF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:37:14 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7b6e3dc54e0so613664241.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697729833; x=1698334633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=49fagu2cnGMwxsc7JEmJZKgqBj5vWAdKuaR8p7iEFTY=;
        b=ddQLSnFzIvwVsIo2Ys1PVINSvPHTUf2oaahS6o6d1mb8bzZarRthNI6jJPWZW9/N0P
         K4dY5c5Y43BQO3UmcmKqJ7zfL4iBW+qUqGfug53tZXxh0/tkbGbXh8iOsSblwewubawL
         WzrqZG5FpCM31vfYnO3VC16ZX48yJ/M2lZjVHWrgE1Qe/XUw57NJUS+UqNI0HxmRvY+V
         zdH5tXEMh4g/uDBeMEwKPn/2opEJ+9roIBlC+MU3CXC16esSpsegAizZ5+OWwYIIH2uN
         L/uySStsQah5KDRZnEQ567yVy2FxIigz0RwkwNjiEFYSlj5dsCk5Sy8JTnHmYdGvf8Zm
         3uDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729833; x=1698334633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49fagu2cnGMwxsc7JEmJZKgqBj5vWAdKuaR8p7iEFTY=;
        b=rRYZfzTkP8KCyC8lm5lor73GeiarJvPlWL/gtHYj33WDKktsnLuxa+2DVaWFxv8Fs6
         T4+eIfJxe9mDmvAzbzByrBb7yhZ3hRHGrF4hnUp1rHkAY4dCZ067LnZn4R1asvPHLvZd
         mEG9AlEgl1cWDbwmnlA9NHB5+a2epXbreeFgH7USicTn+/dDTlxYxEJT3Uc/CxDbnBRa
         NeKR71yccQSvk4lBvhwYltyWD5HSuttZaLhcR7W6TXWS0pVQ0eCRvNdXmPAZok4rd/fb
         ZrY/WOrZM0nSWkAhV03slWjyskV2oxzY1GTdPpt90D/SUrwb31ufVfWTwBvp+ZwKhOnj
         gfjg==
X-Gm-Message-State: AOJu0YzgMID90MLrvULJTquDn3u2Zmng++Qmu4M3VcAyzdwfgEQjwkXE
        t47ZTrYTyXU+mAd06rSdLWXmPdy4IuZnIpVeWTPUZg==
X-Google-Smtp-Source: AGHT+IF/TIxqGeiS2XhR+1vH5JCmmpN+VeV9SgvLUgpDO8Ap7VcLJ6Dhf6Nf3ZlHfe7THOF4vu9OLSSM93ulRd5ziLg=
X-Received: by 2002:a05:6122:459e:b0:48d:11d1:9feb with SMTP id
 de30-20020a056122459e00b0048d11d19febmr1317623vkb.8.1697729833434; Thu, 19
 Oct 2023 08:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
 <ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk>
In-Reply-To: <ad5b7442-385d-41db-9202-a36414460610@sirena.org.uk>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 19 Oct 2023 21:07:02 +0530
Message-ID: <CA+G9fYsbwWpDVR9KJXx8UO5MXsYT81uAJbLLNDnLianr8jmXUA@mail.gmail.com>
Subject: Re: selftests: ftrace: Internal error: Oops: sve_save_state
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 at 17:52, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Oct 17, 2023 at 01:34:18PM +0530, Naresh Kamboju wrote:
>
> > Following kernel crash noticed while running selftests: ftrace:
> > ftracetest-ktap on FVP models running stable-rc 6.5.8-rc2.
>
> > This is not an easy to reproduce issue and not seen on mainline and next.
> > We are investigating this report.
>
> To confirm have you seen this on other stables as well or is this only
> v6.5?  For how long have you been seeing this?

This is only seen on 6.5.8-rc2 and seen only once.
I have checked on mainline / next and other stable branches and this crash
is not seen anywhere else.

However, I will keep checking them on other branches and next and mainline.

>
> > [  764.987161] Unable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000000
>
> > [  765.074221] Call trace:
> > [  765.075045]  sve_save_state+0x4/0xf0
> > [  765.076138]  fpsimd_thread_switch+0x2c/0xe8
> > [  765.077305]  __switch_to+0x20/0x158
> > [  765.078384]  __schedule+0x2cc/0xb38
> > [  765.079464]  preempt_schedule_irq+0x44/0xa8
> > [  765.080633]  el1_interrupt+0x4c/0x68
> > [  765.081691]  el1h_64_irq_handler+0x18/0x28
> > [  765.082829]  el1h_64_irq+0x64/0x68
> > [  765.083874]  ftrace_return_to_handler+0x98/0x158
> > [  765.085090]  return_to_handler+0x20/0x48
> > [  765.086205]  do_sve_acc+0x64/0x128
> > [  765.087272]  el0_sve_acc+0x3c/0xa0
> > [  765.088356]  el0t_64_sync_handler+0x114/0x130
> > [  765.089524]  el0t_64_sync+0x190/0x198
>
> So something managed to get flagged as having SVE state without having
> the backing storage allocated.  We *were* preempted in the SVE access
> handler which does the allocation but I can't see the path that would
> trigger that since we allocate the state before setting TIF_SVE.  It's
> possible the compiler did something funky, a decode of the backtrace
> might help show that?

We have not uploaded vmlinux and System.map to this specific build.
However, I have requested to have these files get uploaded for upcoming
builds.

- Naresh

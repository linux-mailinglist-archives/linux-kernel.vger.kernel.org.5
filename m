Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EDA779769
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjHKTAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjHKTAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:00:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A380D30CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:00:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso34857941fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691780411; x=1692385211;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=2tX4f5CxXwqQixuwBvoHfWLxIWpN0kImRL3p6vNuUzM=;
        b=j8vSASKGirWUNk7iguwpnl+3vF0oqWasXtQrqVt7wt2BgyqwPkXWDwha9gLLISBUKV
         iGKi6QH63mKvDBPYK9oYrIHZNzFjdXUGKEbNc0PX6OCa28t1kouW1WUl+wxSDG2O5W6B
         snxBGmnneshbH6UEnINoRg0LEvGLK+19Ar9/pGo93D15GGpvCa/DNaT/Y6esnTX7izXV
         d2PwV3nEnHbB9plozz05AiLJ6TAzZJM0nNytcxCVS77RDKFjVy4a8wMk8Rv2VLamrXWO
         b9IfArlNA6LSxpXONDCSukiteldSR7UB00rvPbvj35Imt65y9XfKOGuyj3R6ZYMTXjyl
         yZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691780411; x=1692385211;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tX4f5CxXwqQixuwBvoHfWLxIWpN0kImRL3p6vNuUzM=;
        b=X1+RTi204D9gnkFVNv/rvtUjaeOF9Jeypeav48sOwZqi9H39FFquo/Dko93qFcp/fl
         VPDYqLuOFp/NhxhRTeqaPlUloamK/q1xezw7tu/gAjy7CzcbjcdgS1tmV+fP/mGAv6J2
         a0CjT+bi1nGdRn+jkODLkEEnc2o6jmkaPeZR69fCoXtx8f2PIsXQOx2tDpxPHzr7xgv/
         EgEhEjTXnUOo8+u58wRW8Sjd1gVw7DGNijEtGrD0nxYK1kLuK2vpLI+YFXgMS3gvRLyg
         ZlpX2JLDE/Xwwrswhftgo+yOGlxvUii+Ph8aZdTbP65l6Q5CONLWXw3U2xgRIy1YrEEf
         b+Gg==
X-Gm-Message-State: AOJu0YxAbftlagvSfFUck54i2uNv7aluXnnS6jwfyTjDgpD4KDYYfgVb
        FBilZxWwTHaDhbUvZCPYT4c=
X-Google-Smtp-Source: AGHT+IE21JkPWy5VzYd+vFT13uAi07aShArndTFVzf+n/csoJ4n2q0W2aKxFaqnloQOGjW/oW/mniQ==
X-Received: by 2002:a2e:3518:0:b0:2b6:e283:32cb with SMTP id z24-20020a2e3518000000b002b6e28332cbmr2320415ljz.23.1691780410463;
        Fri, 11 Aug 2023 12:00:10 -0700 (PDT)
Received: from razdolb (95-24-154-238.broadband.corbina.ru. [95.24.154.238])
        by smtp.gmail.com with ESMTPSA id y18-20020a2e9792000000b002b6e13fcedcsm1002637lji.122.2023.08.11.12.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 12:00:09 -0700 (PDT)
References: <87v8dmr6ty.fsf@gmail.com>
 <f32b4636-969c-3b9e-6802-5991f511739e@leemhuis.info>
User-agent: mu4e 1.10.4; emacs 29.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [REGRESSION] HDMI connector detection broken in 6.3 on Intel(R)
 Celeron(R) N3060 integrated graphics
Date:   Fri, 11 Aug 2023 21:10:05 +0300
In-reply-to: <f32b4636-969c-3b9e-6802-5991f511739e@leemhuis.info>
Message-ID: <87il9l2ymf.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Thorsten!

On 2023-08-11 at 08:45 +02, Thorsten Leemhuis <regressions@leemhuis.info> wrote:

> [CCing the i915 maintainers and the dri maintainers]
>
> Hi, Thorsten here, the Linux kernel's regression tracker.
>
> On 10.08.23 21:33, Mikhail Rudenko wrote:
>> The following is a copy an issue I posted to drm/i915 gitlab [1] two
>> months ago. I repost it to the mailing lists in hope that it will help
>> the right people pay attention to it.
>
> Thx for your report. Wonder why Dmitry (who authored a4e771729a51) or
> Thomas (who committed it) it didn't look into this, but maybe the i915
> devs didn't forward the report to them.
>
> Let's see if these mails help. Just wondering: does reverting
> a4e771729a51 from 6.5-rc5 or drm-tip help as well?

I've redone my tests with 6.5-rc5, and here are the results:
(1) 6.5-rc5 -> still affected
(2) 6.5-rc5 + revert a4e771729a51 -> not affected
(3) 6.5-rc5 + two patches [1][2] suggested on i915 gitlab by @ideak -> not affected (!)

Should we somehow tell regzbot about (3)?

> BTW, there was an earlier report about a problem with a4e771729a51 that
> afaics was never addressed, but it might be unrelated.
>
> https://lore.kernel.org/all/20230328023129.3596968-1-zhouzongmin@kylinos.cn/
>
> Ciao, Thorsten

[1] https://patchwork.freedesktop.org/patch/548590/?series=121050&rev=1
[2] https://patchwork.freedesktop.org/patch/548591/?series=121050&rev=1

--
Best regards,
Mikhail Rudenko

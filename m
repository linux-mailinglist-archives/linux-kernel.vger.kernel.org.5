Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336D17FE068
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjK2Toi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjK2Toh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:44:37 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33526E6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:44:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a185fb3aa18so401566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 11:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701287081; x=1701891881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qnqDzHz4INacq1KvdtyKE0oHpbQHSFD4sKrps3p8dnw=;
        b=klBCYmmttvMbB7FzFto8DDcJB0W3AFoMOyRDjLkyqMMPCAcmUj/PCiDKX+rR7brFXo
         tWpWxDqv0qmLRc8z0YbQ/CBze9Cyuz3laR1utPtpRbRcTCLTq1UyIhAdsnLxXg+c8b2Y
         ffvXfvMn59Py8rkIpgT/RNjrwWRSxrQVJKFKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701287081; x=1701891881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnqDzHz4INacq1KvdtyKE0oHpbQHSFD4sKrps3p8dnw=;
        b=RC6xYouDdw8P0kfTkStWhDrGDrUQIBT/WbKmnlFs54MxPMWcxJ69WPQDDlIgnpAz3S
         bRuDIUncyQuWVi+ZtdRKb6s+NoVEIBPZGrG2DP0+GBqkJpPwARLUibBgndQ4hNYxkTI5
         raGjm8vjcHZ3k1U6WwJ+fSPToydAHCUXlx452CtCcqPu95R7VRdCOvh+gBKieIqrGPgC
         D+zlDMEdaSJmjZu/8sd0lejInP/EQ4HNGXGsiJ6L+dWg1A2OyfEeLcqtckViRU4KK4Ts
         nCcOtKik0TBwj9iySyDBNPzqIpvwfave5P4z8hcv5dzi+kJY4UJ28uPuLKIfCKp23EIv
         xvTw==
X-Gm-Message-State: AOJu0YxFePj3e50hQzucaQE48ole+oiAP3TKt7cCF0MtK0ueQw0kqm+d
        UZvVZYgQ/79wt0u70ucrrYV51DZ+LzrtikFfGNJUSg==
X-Google-Smtp-Source: AGHT+IE6/sJe2xAn+cU+B0tf6CKENoUuHsXD0ZZK1FLCMTWZCVk2aryXnmPQVK+Mqb2N+AK5h9Dj5uGpcs1SpVI/Rug=
X-Received: by 2002:a17:906:105c:b0:9ae:659f:4d2f with SMTP id
 j28-20020a170906105c00b009ae659f4d2fmr18732284ejj.26.1701287081372; Wed, 29
 Nov 2023 11:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org> <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de> <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
 <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de> <CAPnjgZ0UCkm5QCx+JXe1ggSshozPnOLB6cN=UoJyMn6S4wfFkg@mail.gmail.com>
 <06281f7c-e0f2-405c-95a9-0f7e9e84a7f6@pengutronix.de>
In-Reply-To: <06281f7c-e0f2-405c-95a9-0f7e9e84a7f6@pengutronix.de>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 29 Nov 2023 12:44:25 -0700
Message-ID: <CAPnjgZ2TT+0BvbjwfnGLQ3EPEXnLW6f1epiFdaBHRYaSAn5xsA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

On Wed, 29 Nov 2023 at 12:33, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> On 29.11.23 20:27, Simon Glass wrote:
> > On Wed, 29 Nov 2023 at 12:15, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >> On 29.11.23 20:02, Simon Glass wrote:
> >>> On Wed, 29 Nov 2023 at 11:59, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>> The specification says that this is the root U-Boot compatible,
> >>>> which I presume to mean the top-level compatible, which makes sense to me.
> >>>>
> >>>> The code here though adds all compatible strings from the device tree though,
> >>>> is this intended?
> >>>
> >>> Yes, since it saves needing to read in each DT just to get the
> >>> compatible stringlist.
> >>
> >> The spec reads as if only one string (root) is supposed to be in the list.
> >> The script adds all compatibles though. This is not really useful as a bootloader
> >> that's compatible with e.g. fsl,imx8mm would just take the first device tree
> >> with that SoC, which is most likely to be wrong. It would be better to just
> >> specify the top-level compatible, so the bootloader fails instead of taking
> >> the first DT it finds.
> >
> > We do need to have a list, since we have to support different board revs, etc.
>
> Can you give me an example? The way I see it, a bootloader with
> compatible "vendor,board" and a FIT with configuration with compatibles:
>
>   "vendor,board-rev-a", "vendor,board"
>   "vendor,board-rev-b", "vendor,board"
>
> would just result in the bootloader booting the first configuration, even if
> the device is actually rev-b.

You need to find the best match, not just any match. This is
documented in the function comment for fit_conf_find_compat().

>
>
> >>>>> +        fsw.property_string('description', model)
> >>>>> +        fsw.property_string('type', 'flat_dt')
> >>>>> +        fsw.property_string('arch', arch)
> >>>>> +        fsw.property_string('compression', compress)
> >>>>> +        fsw.property('compatible', bytes(compat))
> >>>>
> >>>> I think I've never seen a compatible for a fdt node before.
> >>>> What use does this serve?
> >>>
> >>> It indicates the machine that the DT is for.
> >>
> >> Who makes use of this information?
> >
> > U-Boot uses it, I believe. There is an optimisation to use this
> > instead of reading the DT itself.
>
> The configuration already has a compatible entry. What extra use is the compatible
> entry in the FDT node?

It allows seeing the compatible stringlist without having to read the
FDT itself. I don't believe it is necessary though, so long as we are
scanning the configurations and not the FDT nodes.

Regards,
Simon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4067E0216
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346538AbjKCLRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346433AbjKCLQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:16:55 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12541A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:16:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1883313276.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699010208; x=1699615008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xKHI0k8nzChvhVsaB9D37QiIrFajCLKKOBjE3n1Grbw=;
        b=smwzoLdOi4Ps+70SlYBJlmazovFek2oLvKyNwCVQPSwAUoEPUj6DS+X3S5bDfzFf/T
         AKWQwsfhNYeJO59Fx77fyWz8nlxTSh8xy6fccnVLPOheG0vq28GRGehr1gqUeU4POf9a
         kl9y5AMb2X6etfW/Vq0Vk8JYSD1wTtLbgFcP/il7vIG8SsMW6elwOKc6YsR6J2Mk7saP
         hb4O5QXzcq8SQyYKpvu/m84HnFf6Bib5hlJmnifHKMtJeUzPGZ/jP4rbnLuRIGggjI08
         JT7o3xMyKkh9FyfsUHdaZyAq2GEkWH7f+aXP8R0FUO4O5BMl6fuZ+BrUixq00X6KGD8H
         Wm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010208; x=1699615008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKHI0k8nzChvhVsaB9D37QiIrFajCLKKOBjE3n1Grbw=;
        b=I6NeMuGIRumZ+D6yQ4xc6wvR26GI4TsukFyoTN5wgEb/RBo8f84klwVtS7eh2TknqS
         ed32onP2AJKVD8luGjc6fp9m/aiPpAxMdsAxsfPlzcbyDD5N1zNoYa3fI4dJr96pyuAR
         oUwRE+r/Oygvlo7/NO85ZaYTaPby/fhHqdbRH4WNcdUZs1YR3tJ28Drr0rYfOSUaLwwu
         63PlhsD2dGY7QxjtTi8C0hLy8ZT6Aw/XvZ9sRhZU4HWP4Op9gimkwlxlRVy2K1F0cFGI
         dvB/ddJzu3OEpldWANZS/IXe6k/lVB4IMSH3YtaDR8Po6cUvKLDqU8Xx0bNpkFfYA712
         FAVQ==
X-Gm-Message-State: AOJu0Yx669EVJ6T1bSQgq1nigsMGSljyx3rDDyadFnL6aq1eeY510wLe
        UYdnIm76WD7efVwK28gnzxHoV/VqWBmQpAGDR0BE5Q==
X-Google-Smtp-Source: AGHT+IGmV803BXUlUgCOSEnde/6YW5dwT6J76wUXUY/NtHZW3BUKdm1jumFpk8mkx5rjrlMiHzX+lacdXUIn3C8xP2w=
X-Received: by 2002:a25:dfc7:0:b0:d0f:846c:ef7b with SMTP id
 w190-20020a25dfc7000000b00d0f846cef7bmr18708560ybg.17.1699010207876; Fri, 03
 Nov 2023 04:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231026061458.1116276-1-n-yadav@ti.com> <8b7f948d-316c-4135-875a-de455ff4849c@intel.com>
 <8148dae9-e3fc-4589-ba57-a3f7a3e63b80@intel.com> <7054b3bb-de99-3fb0-5f17-78249f31c53f@ti.com>
 <42f1b9a6-2dad-42ca-a41c-3a57f87323cc@ti.com>
In-Reply-To: <42f1b9a6-2dad-42ca-a41c-3a57f87323cc@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Nov 2023 12:16:12 +0100
Message-ID: <CAPDyKFrCSTW3G6H7qS89d+UQ6RJcAYcKSPULVT8J7XKsUDpHdw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: fix start loop index for TAP value parsing
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Nitin Yadav <n-yadav@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 09:07, Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> Hi Nitin, Adrian
>
> On 27/10/23 11:41, Nitin Yadav wrote:
> > Hi Adrian,
> >
> > On 26/10/23 12:33, Adrian Hunter wrote:
> >> On 26/10/23 10:00, Adrian Hunter wrote:
> >>> On 26/10/23 09:14, Nitin Yadav wrote:
> >>>> ti,otap-del-sel-legacy/ti,itap-del-sel-legacy passed from DT
> >>>> are currently ignored for all SD/MMC and eMMC modes. Fix this
> >>>> by making start loop index to MMC_TIMING_LEGACY.
> >>>>
> >>>> Fixes: 8ee5fc0e0b3be ("mmc: sdhci_am654: Update OTAPDLY writes")
> >>>>
> >>>
> >>> There isn't usually a blank line here
> >>>
> >>> Perhaps a Cc: stable@vger.kernel.org tag?
> >>>
> >>>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> >>>
> >>> Nevertheless:
> >>>
> >>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >>
> >> Sorry, sent that prematurely - see comment below
> >>
> >>>
> >>>
> >>>> ---
> >>>>  drivers/mmc/host/sdhci_am654.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> >>>> index 544aaaf5cb0f..aae9d255c6a1 100644
> >>>> --- a/drivers/mmc/host/sdhci_am654.c
> >>>> +++ b/drivers/mmc/host/sdhci_am654.c
> >>>> @@ -606,7 +606,7 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
> >>>>            return 0;
> >>>>    }
> >>>>
> >>
> >> Isn't the MMC_TIMING_LEGACY information read at the top of
> >> sdhci_am654_get_otap_delay()?
> > Loop also take care of ITAP. Looks like at some point single property
> > ti,otap-del-sel was used for all modes and then we moved to one property
> > per mode:
> > https://lore.kernel.org/r/20200108150920.14547-3-faiz_abbas@ti.com
> > (since v5.7)
>
> Looks like ti,otap-del-sel is deprecated for a while now (since v5.7+).
> I think that's sufficient enough time to drop it now (don't see any in
> kernel DT use this property). Lets drop the above code which handles
> MMC_TIMING_LEGACY separately, so that below for() loop can handle the
> whole set of bindings efficiently.
>
> Since this patch is marked for stable, can we get rid of the check for
> deprecated property in a follow up patch?

This seems reasonable to me, however, let's also get the DT
maintainers view on this.

I have queued up $subject patch as a fix and tagged it for stable
kernels. Feel free to post the patches to remove the support for the
deprecated binding on top.

Kind regards
Uffe


>
> Something like below? (completely untested):
>
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index c125485ba80e..50c8d3051096 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -577,32 +577,17 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
>         int i;
>         int ret;
>
> -       ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].otap_binding,
> -                                &sdhci_am654->otap_del_sel[MMC_TIMING_LEGACY]);
> -       if (ret) {
> -               /*
> -                * ti,otap-del-sel-legacy is mandatory, look for old binding
> -                * if not found.
> -                */
> -               ret = device_property_read_u32(dev, "ti,otap-del-sel",
> -                                              &sdhci_am654->otap_del_sel[0]);
> -               if (ret) {
> -                       dev_err(dev, "Couldn't find otap-del-sel\n");
> -
> -                       return ret;
> -               }
> -
> -               dev_info(dev, "Using legacy binding ti,otap-del-sel\n");
> -               sdhci_am654->legacy_otapdly = true;
> -
> -               return 0;
> -       }
> -
> -       for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
> +       for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
>
>                 ret = device_property_read_u32(dev, td[i].otap_binding,
>                                                &sdhci_am654->otap_del_sel[i]);
>                 if (ret) {
> +                       if (i == MMC_TIMING_LEGACY) {
> +                               dev_err(dev, "ti,otap-del-sel-legacy is mandatory");
> +                               return ret;
> +                       }
> +
>                         dev_dbg(dev, "Couldn't find %s\n",
>                                 td[i].otap_binding);
>                         /*
>
>
>
> >>
> >>>> -  for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
> >>>> +  for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
> >>>>
> >>>>            ret = device_property_read_u32(dev, td[i].otap_binding,
> >>>>                                           &sdhci_am654->otap_del_sel[i]);
> >>>
> >>
> >
>
> --
> Regards
> Vignesh

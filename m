Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC45C78000D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355400AbjHQVlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355387AbjHQVlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:41:13 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131732D69
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:41:10 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a7f74134e7so167306b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692308469; x=1692913269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UHP45uaFg26bDt9C3NjYmwlB/Xxdc09WAmYuHekD+ac=;
        b=CCrCjXjFN5onVCafgHStwnPqHLtQWJTLFQVipHt2IjUeR5cIWDYbOJLvvfXU1d4Uzo
         pnY9e3NLLuSBbx8gkstQR6gSvbiOVH7VFpr9oxVpA6gJk8g8ONxO+URIEiaYkY9vrvpT
         LUAFEJhUuNdU/O8gN97INDqbTBsXO6IvnofvBRFyS3WwQammeQ/4xTpfFcbt5rUBoFkK
         fZI0p/tFWaHaHV/nVC+LNOuhgWH4MpLX6JFKDFJbUeG1zDBRw6oIoURDOUahPbyd30e5
         GX4BtX0yQ8U3Ao+ViRaa2FeJ2yLj5wdxc4WiQQ0pyDQ/tmiw2+3iwoUouKD3v3ru+RBO
         Garg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692308469; x=1692913269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHP45uaFg26bDt9C3NjYmwlB/Xxdc09WAmYuHekD+ac=;
        b=QO0dFWeM0/chnZPcRPiAmCTWi6/86x4Np6nIcCvdkfkMc3FZcKMib5+QgC62DevTni
         b/5yXIT9Rlvtv829NI9xSLfHIUcoFz/tO3wN7KvUtixQRekfX2Xrttbv/KyejuaI0IMd
         V3WKDNVTSACpopErQjxxPB47hcBneB3h/s1GMezzsWgm+JW22U5EDWfBoDgJm5ZIKio0
         TmqC+4nhvD/IS8hwSnMoU0/pt2kpqmhWRUmfSD+A3+GCVu5IVnji2ETkfXC1UC2K2uk5
         AsMUF2n+y+gTWj6CBYJTrZoSOD/vxmNxXdO0NDmOePUTLK+pFVsPX2vVDHxI256WKm8G
         I6Eg==
X-Gm-Message-State: AOJu0YxluG9MDxRULeEEwurov/pmo0CyF2QMpLMA92IspupBz9OWjOBz
        av32wmaj117bxXnAgFXdVUXt1iR/6dOPlRi/dUrFLQ==
X-Google-Smtp-Source: AGHT+IFUZs8ZPSWUYmwSLIkhAyTIYgwiQYbgBz6pIl0IEMdSU6JAncGTpZTGOHR7YdG6+DJPI3Zrggdniiye1Xhemkc=
X-Received: by 2002:a05:6358:428e:b0:133:7f9:303f with SMTP id
 s14-20020a056358428e00b0013307f9303fmr893048rwc.23.1692308469265; Thu, 17 Aug
 2023 14:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230712210505.1536416-1-Frank.Li@nxp.com> <f1d4ed62-8d01-173f-6e41-4671228782fd@linaro.org>
 <ZLGDhOffQwh7xW/n@lizhi-Precision-Tower-5810> <7eacc4da-ab14-3df5-2864-44a7262bac27@linaro.org>
 <ZNz5Drb+EVLjWxRV@lizhi-Precision-Tower-5810> <dd42952c-4dea-ea57-7ad2-73fa159d265d@linaro.org>
 <ZN0CVa9or/FltHJM@lizhi-Precision-Tower-5810> <80324fb7-3d2a-ecd3-f1ca-9745a366eb0a@linaro.org>
 <CAPDyKFp8-XwwHEt9dKeTMj0ZmoS6nzXrUYAFmpzZm16-Uf6=xw@mail.gmail.com> <ZN49MnvZ4XWQPGd7@lizhi-Precision-Tower-5810>
In-Reply-To: <ZN49MnvZ4XWQPGd7@lizhi-Precision-Tower-5810>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Aug 2023 23:40:33 +0200
Message-ID: <CAPDyKFqKibp2d7GHZwxi1Kf3oPhM+wF1c+YEfO3viRc0HSufwA@mail.gmail.com>
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: return -EAGAIN when
 SCFW turn off resource
To:     Frank Li <Frank.li@nxp.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 at 17:31, Frank Li <Frank.li@nxp.com> wrote:
>
> On Wed, Aug 16, 2023 at 11:23:17PM +0200, Ulf Hansson wrote:
> > On Wed, 16 Aug 2023 at 22:46, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > >
> > > On 16/08/2023 19:07, Frank Li wrote:
> > > > On Wed, Aug 16, 2023 at 06:47:17PM +0200, Daniel Lezcano wrote:
> > > >> On 16/08/2023 18:28, Frank Li wrote:
> > > >>> On Wed, Aug 16, 2023 at 10:44:32AM +0200, Daniel Lezcano wrote:
> > > >>>>
> > > >>>> Hi Frank,
> > > >>>>
> > > >>>> sorry for the delay
> > > >>>>
> > > >>>> On 14/07/2023 19:19, Frank Li wrote:
> > > >>>>> On Thu, Jul 13, 2023 at 02:49:54PM +0200, Daniel Lezcano wrote:
> > > >>>>>> On 12/07/2023 23:05, Frank Li wrote:
> > > >>>>>>> Avoid endless print following message when SCFW turns off resource.
> > > >>>>>>>      [ 1818.342337] thermal thermal_zone0: failed to read out thermal zone (-1)
> > > >>>>>>>
> > > >>>>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > >>>>>>> ---
> > > >>>>>>>      drivers/thermal/imx_sc_thermal.c | 4 +++-
> > > >>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
> > > >>>>>>>
> > > >>>>>>> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> > > >>>>>>> index 8d6b4ef23746..0533d58f199f 100644
> > > >>>>>>> --- a/drivers/thermal/imx_sc_thermal.c
> > > >>>>>>> +++ b/drivers/thermal/imx_sc_thermal.c
> > > >>>>>>> @@ -58,7 +58,9 @@ static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> > > >>>>>>>         hdr->size = 2;
> > > >>>>>>>         ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
> > > >>>>>>> -       if (ret)
> > > >>>>>>> +       if (ret == -EPERM) /* NO POWER */
> > > >>>>>>> +               return -EAGAIN;
> > > >>>>>>
> > > >>>>>> Isn't there a chain call somewhere when the resource is turned off, so the
> > > >>>>>> thermal zone can be disabled?
> > > >>>>>
> > > >>>>> A possible place in drivers/firmware/imx/scu-pd.c. but I am not sure how to
> > > >>>>> get thermal devices. I just found a API thermal_zone_get_zone_by_name(). I
> > > >>>>> am not sure if it is good to depend on "name", which add coupling between
> > > >>>>> two drivers and if there are external thermal devices(such as) has the
> > > >>>>> same name, it will wrong turn off.
> > > >>>>
> > > >>>> Correct
> > > >>>>
> > > >>>>> If add power domain notification in thermal driver, I am not how to get
> > > >>>>> other devices's pd in thermal driver.
> > > >>>>>
> > > >>>>> Any example I can refer?
> > > >>>>>
> > > >>>>> Or this is simple enough solution.
> > > >>>>
> > > >>>> The solution works for removing the error message but it does not solve the
> > > >>>> root cause of the issue. The thermal zone keeps monitoring while the sensor
> > > >>>> is down.
> > > >>>>
> > > >>>> So the question is why the sensor is shut down if it is in use?
> > > >>>
> > > >>> Do you know if there are any code I reference? I supposed it is quite common.
> > > >>
> > > >> Sorry, I don't get your comment
> > > >>
> > > >> What I meant is why is the sensor turned off if it is in use ?
> > > >
> > > > One typical example is cpu hotplug. The sensor is located CPU power domain.
> > > > If CPU hotplug off,  CPU power domain will be turn off.
> > > >
> > > > It doesn't make sensor keep monitor such sensor when CPU already power off.
> > > > It doesn't make sensor to keep CPU power on just because want to get sensor
> > > > data.
> > > >
> > > > Anthor example is GPU, if there are GPU0 and GPU1. Most case just GPU0
> > > > work.  GPU1 may turn off when less loading.
> > > >
> > > > Ideally, thermal can get notification from power domain driver.
> > > > when such power domain turn off,  disable thermal zone.
> > > >
> > > > So far, I have not idea how to do that.
> > >
> > > Ulf,
> > >
> > > do you have a guidance to link the thermal zone and the power domain in
> > > order to get a poweron/off notification leading to enable/disable the
> > > thermal zone ?
> >
> > I don't know the details here, so apologize for my ignorance to start
> > with. What platform is this?
>
> i.MX8QM.

Thanks!

>
> >
> > A vague idea could be to hook up the thermal sensor to the
> > corresponding CPU power domain. Assuming the CPU power domain is
> > modelled as a genpd provider, then this allows the driver for the
> > thermal sensor to register for power-on/off notifications of the genpd
> > (see dev_pm_genpd_add_notifier()).
> >
> > Can this work?
>
> I don't think. dev_pm_genpd_ad_notifier() need a dev, which binded to pd.

Yes, correct.

>
> tsens: thermal-sensor {
>         compatible = "fsl,imx-sc-thermal";
>         tsens-num = <6>;
>         #thermal-sensor-cells = <1>;
> };

Are you saying that the above doesn't have a corresponding struct
device created for it? That sounds like a problem that can be fixed,
right? Not sure if it makes sense though.

>
> we have 6 thermal-sensor, which assocated with 6 pd,
>         IMX_SC_R_SYSTEM, IMX_SC_R_PMIC_0,
>         IMX_SC_R_AP_0, IMX_SC_R_AP_1,
>         IMX_SC_R_GPU_0_PID0, IMX_SC_R_GPU_1_PID0,
>         IMX_SC_R_DRC_0
>
> We don't want to hold PD on just because want to get temperature. GPU pd
> consume much power.

Of course, that would be a bad idea it seems like.

The corresponding struct device that's hooked up to a genpd, can
remain runtime suspended as long as you think it makes sense. Thus it
would not keep the PM domain powered on when it isn't needed.

>
> I want to register one callback at thermal-sensor driver, when GPU pd on,
> enable thermal-zone. when GPU pd off, disable thermal zone.

Right, that should work fine too, I think. It seems like this is just
a matter of modelling this correctly in DT, I have no strong opinion
in this regard.

>
> we can do more common way.
>
>         gpu-thermal1 {
>                         polling-delay-passive = <250>;
>                         polling-delay = <2000>;
>         >>>             pd=<&GPU1_PD>
>                         thermal-sensors = <&tsens IMX_SC_R_GPU_1_PID0>;
>
>                 };
>
> if GPU1_PD on, then gpu-thermal1 enable,
> if GPU1_PD off, then gpu-thermal1 disable.
>

Sounds like it's worth a try! Please keep me posted.

Kind regards
Uffe

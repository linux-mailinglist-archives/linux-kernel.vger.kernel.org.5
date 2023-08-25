Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE87883FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbjHYJlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244398AbjHYJlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:41:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925E1FD7;
        Fri, 25 Aug 2023 02:41:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26fb8225268so447339a91.1;
        Fri, 25 Aug 2023 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692956500; x=1693561300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w3EFSJ+fFn4Kfma/veW4zBMk56UKoqqEoSOXHPI+3hg=;
        b=X5Zd6yoHuc40HQJ7CKsdoC9SSOpRA3LR1+dMz1Yj290kyBG7Kk952YcXkc5hV+qN6q
         vRxsxOnlplce/QmnyiH7Jd+0H4xnZslpbgtZK6dB0+4e6jvOdhEBPLKRP4Fjt2BYWlQg
         gvwlGP7JhlPaosAyuy9lDCccJ5ZpeK7nJzPMjlCdisfD7SbLCTtUZDSGzyQ/bq3wDQPx
         3+xUdNS0uxN40IHw1KlOk8cHCSBpiCvo6MnOPXtIzf22Z8xiZHrBxnHlnFFPOD0xAEkM
         WZqNTYRglZuky8C6DvPrmwgMrAWwePKzujBuYytWq11ZQYpzxDDb7ZLuiAUU/bvP4PBO
         0Amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692956500; x=1693561300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3EFSJ+fFn4Kfma/veW4zBMk56UKoqqEoSOXHPI+3hg=;
        b=P2Jd8XU0GBWfpaViaZrKkwaRrYz1uCqOOogSLAPZc0kgsooCm94MmP2+1McgdFj01m
         OKX4wQ2adYsyfWHvNi+pe4vciN2ko4323rPtrEURNdbC72CmO3wIi5l2DVlou+WSko4/
         5Cj7w5l33ckzrDSgZC45URCfCjOF8aybTyEVWZmSuxJ5oA0C4sCTn1V2nliSQdqw7UMz
         LaWsy346fTLxQ5ylF88tagIp/mmgNwh4ALCu4J59Go80uW5Qar9KQzRrZBjJ1Hyv0zv6
         IA6oRcvlAQ30c9Ay+yJHkqfbwMx4LFUH/EYUQmGkeVzc+hHNS9ZrcsT1sRsKlci+MDCI
         0wgA==
X-Gm-Message-State: AOJu0YzJhs2xLapTa/eoybDbKYSF4NbkB1k14dP+RHiYppSDCWDAbTnV
        1icfeL9jAFQhR9DA9k48QbbbDlD/S+8d7fu9Zxigi1Cv
X-Google-Smtp-Source: AGHT+IEjJ90TtlMF8Q8GbIACxekfZckGKmE7ETA7Fud31+HLSEbbinIFedzpt23nzSw6kE+IRkmpmpod3df546wCZLo=
X-Received: by 2002:a17:90b:46d4:b0:26b:698f:dda7 with SMTP id
 jx20-20020a17090b46d400b0026b698fdda7mr15020937pjb.32.1692956500056; Fri, 25
 Aug 2023 02:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230816164641.3371878-1-robimarko@gmail.com> <20230816164641.3371878-2-robimarko@gmail.com>
 <ff9ec6f5-9c7c-546b-5814-159d7e2843a8@quicinc.com>
In-Reply-To: <ff9ec6f5-9c7c-546b-5814-159d7e2843a8@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 25 Aug 2023 11:41:29 +0200
Message-ID: <CAOX2RU7wbZopGErQ71frXFMz4+Y9QU6SjfrYbZPT_3yd0gU73A@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] firmware: qcom_scm: disable SDI if required
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, computersforpeace@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 at 17:38, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
>
>
> On 8/16/2023 10:15 PM, Robert Marko wrote:
> > IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
> > means that WDT being asserted or just trying to reboot will hang the board
> > in the debug mode and only pulling the power and repowering will help.
> > Some IPQ4019 boards like Google WiFI have it enabled as well.
> >
> > Luckily, SDI can be disabled via an SCM call.
> >
> > So, lets use the boolean DT property to identify boards that have SDI
> > enabled by default and use the SCM call to disable SDI during SCM probe.
> > It is important to disable it as soon as possible as we might have a WDT
> > assertion at any time which would then leave the board in debug mode,
> > thus disabling it during SCM removal is not enough.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes in v3:
> > * Squashed ("firmware: qcom: scm: Add SDI disable support") and
> > ("firmware: qcom_scm: disable SDI if required")
> > ---
> >   drivers/firmware/qcom_scm.c | 29 +++++++++++++++++++++++++++++
> >   drivers/firmware/qcom_scm.h |  1 +
> >   2 files changed, 30 insertions(+)
> >
> > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > index 06fe8aca870d..de9d1a11d097 100644
> > --- a/drivers/firmware/qcom_scm.c
> > +++ b/drivers/firmware/qcom_scm.c
> > @@ -403,6 +403,29 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_scm_set_remote_state);
> >
> > +static int qcom_scm_disable_sdi(void)
> > +{
> > +     int ret;
> > +     struct qcom_scm_desc desc = {
> > +             .svc = QCOM_SCM_SVC_BOOT,
> > +             .cmd = QCOM_SCM_BOOT_SDI_CONFIG,
> > +             .args[0] = 1, /* Disable watchdog debug */
> > +             .args[1] = 0, /* Disable SDI */
> > +             .arginfo = QCOM_SCM_ARGS(2),
> > +             .owner = ARM_SMCCC_OWNER_SIP,
> > +     };
> > +     struct qcom_scm_res res;
> > +
> > +     ret = qcom_scm_clk_enable();
> > +     if (ret)
> > +             return ret;
> > +     ret = qcom_scm_call(__scm->dev, &desc, &res);
>
> Would you not be wanting this call to be atomic ?

This is implemented based off the downstream 5.4 kernel as I dont have
the SCM docs
so I dont know if its even supported in the atomic version.
>
> > +
> > +     qcom_scm_clk_disable();
> > +
> > +     return ret ? : res.result[0];
> > +}
> > +
> >   static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
> >   {
> >       struct qcom_scm_desc desc = {
> > @@ -1468,6 +1491,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
> >       if (download_mode)
> >               qcom_scm_set_download_mode(true);
> >
> > +     /*
> > +      * Disable SDI if indicated by DT that it is enabled by default.
> > +      */
> > +     if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
> > +             qcom_scm_disable_sdi();
>
> Why don't we do this call in qcom_scm_shutdown()
> also does it not conflict with above download_mode
> we have enabled download mode but disabling SDI
> means (hard reset) and will not be collecting
> crash dump?

Because doing it in SCM removal is too late, what if we have a WDT
assertion and not a
regular reboot?
It would mean that the board will get stuck in the debug mode which is
not useful for users and
requires the power to be pulled in order to boot normally again.

I am not sure about the download mode, this is where insight from QCA
really help as I am
doing this with very limited docs.

Regards,
Robert
>
> -Mukesh
>
> > +
> >       return 0;
> >   }
> >
> > diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> > index e6e512bd57d1..7b68fa820495 100644
> > --- a/drivers/firmware/qcom_scm.h
> > +++ b/drivers/firmware/qcom_scm.h
> > @@ -80,6 +80,7 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
> >   #define QCOM_SCM_SVC_BOOT           0x01
> >   #define QCOM_SCM_BOOT_SET_ADDR              0x01
> >   #define QCOM_SCM_BOOT_TERMINATE_PC  0x02
> > +#define QCOM_SCM_BOOT_SDI_CONFIG     0x09
> >   #define QCOM_SCM_BOOT_SET_DLOAD_MODE        0x10
> >   #define QCOM_SCM_BOOT_SET_ADDR_MC   0x11
> >   #define QCOM_SCM_BOOT_SET_REMOTE_STATE      0x0a

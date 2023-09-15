Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6DD7A26F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbjIOTK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbjIOTKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:10:48 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA4310D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:10:44 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7e741729a2so2432332276.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694805043; x=1695409843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t6Jy9kUIu2DIIzGv4f0XPwXh3BxzxnRtd2YRKiqx28g=;
        b=OZxwhH5VUt4XRyl1wQQPpAAwK6XyCAOE8PteVePIRNM1g5+Lkat5taGgULlraJiY8Q
         JXCyPwn9+h4zVjt6GfPKtBfyQihcAFl6UkWt/YcOSUjHrGXBCZhsBi/o1y+crpi/fnf+
         d8l+9NnaP2Xaa03cLL+MYRuqzZ2k0PB/0Phthbv3Njw83e5UQ2FYKtNUTXW+jFid8uwV
         V0TaUQJHYnhIiJvO+eAEnjr8ziHOad8bd+7y+tO1/UPH+eu0F5MOK0va1fJ//rdfWCRW
         PKzSi+U5e7QomCbIf1VqK1BJOLlZ/6u/GasVjLVRd92qaJYfMC+w99VoqGGduZJ4nKL5
         wUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694805043; x=1695409843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6Jy9kUIu2DIIzGv4f0XPwXh3BxzxnRtd2YRKiqx28g=;
        b=hkxdAiHy9BxCoPkrtF8dqdpf+C/kqq+X/6aids+sp8+Bz9sWloiexTtKuFdskL9MZo
         Eeg7lU51fgbxecysXCUW09ZwkyVhj7RRMUnMVs1KAPEUSMUQGQHtHalRtb9mzdaNegWx
         3qGtWPR3+/7TQyP/hs/Fj7vxKvBkqSw/a51Z+OZwAX5May7s8Y6COqQjeCQ21GJegvoJ
         VO6OZV95hR98sNwtbs44w7j85pGYkJdE+g3CXxDeN3JBg2GOTSzscYiI1V47syVMlfKr
         yWFZPU/02UaU4sjI43hztcE/YFu8Z7RzjUTFsGT0FNWQ61ATVa4sD0H2baYcS0bDOqWr
         NQ9w==
X-Gm-Message-State: AOJu0Yw4u9C/fCdyGxtann+hvH7hprcuSS3x6Ln9u2kgZVTj+y5+MLdf
        8Li9FjLvDWhb+cYMZhGj24fe9gZ0SOt9P6nblbvzNw==
X-Google-Smtp-Source: AGHT+IFuczj9yuZz9ftZW2btw7mlFe/+y+3qOVlsqeBJ+2RnoZHP30asBXJFzxiczp4dPPSlVOjCo2KBkT1ZdT3gSjA=
X-Received: by 2002:a25:585:0:b0:d78:3f9c:138e with SMTP id
 127-20020a250585000000b00d783f9c138emr2468180ybf.37.1694805043192; Fri, 15
 Sep 2023 12:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230607045345.25049-1-quic_kathirav@quicinc.com> <rzxxoofebcyuoktsl72diwv575md62bxqse4uizfns247gyklp@tdoixme3qrjq>
In-Reply-To: <rzxxoofebcyuoktsl72diwv575md62bxqse4uizfns247gyklp@tdoixme3qrjq>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 15 Sep 2023 22:10:32 +0300
Message-ID: <CAA8EJprVQZXXVnNCULDYeUha0-mSyLZr1r6axbmw1MUiP_O9zg@mail.gmail.com>
Subject: Re: [PATCH V2] firmware: qcom_scm: use the SCM_CONVENTION based on
 ARM / ARM64
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Kathiravan T <quic_kathirav@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 18:17, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, Jun 07, 2023 at 10:23:45AM +0530, Kathiravan T wrote:
> > During SCM probe, to identify the SCM convention, scm call is made with
> > SMC_CONVENTION_ARM_64 followed by SMC_CONVENTION_ARM_32. Based on the
> > result what convention to be used is decided.
> >
> > IPQ chipsets starting from IPQ807x, supports both 32bit and 64bit kernel
> > variants, however TZ firmware runs in 64bit mode. When running on 32bit
> > kernel, scm call is made with SMC_CONVENTION_ARM_64 is causing the
> > system crash, due to the difference in the register sets between ARM and
> > AARCH64, which is accessed by the TZ.
> >
> > To avoid this, use SMC_CONVENTION_ARM_64 only on ARM64 builds.
> >
>
> My memory of this is cloudy, but I feel the logic is complicated because
> early 64-bit boards all used 32-bit TZ. So, I really would like Elliot's
> input before picking this change.

But this codepath is not changed by this patch. Only the 32-bit
codepath is altered.

>
> Regards,
> Bjorn
>
> > Cc: stable@vger.kernel.org
> > Fixes: 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC and legacy conventions")
> > Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> > ---
> > Changes in V2:
> >       - Added the Fixes tag and cc'd stable mailing list
> >
> >  drivers/firmware/qcom_scm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > index fde33acd46b7..db6754db48a0 100644
> > --- a/drivers/firmware/qcom_scm.c
> > +++ b/drivers/firmware/qcom_scm.c
> > @@ -171,6 +171,7 @@ static enum qcom_scm_convention __get_convention(void)
> >       if (likely(qcom_scm_convention != SMC_CONVENTION_UNKNOWN))
> >               return qcom_scm_convention;
> >
> > +#if IS_ENABLED(CONFIG_ARM64)
> >       /*
> >        * Device isn't required as there is only one argument - no device
> >        * needed to dma_map_single to secure world
> > @@ -191,6 +192,7 @@ static enum qcom_scm_convention __get_convention(void)
> >               forced = true;
> >               goto found;
> >       }
> > +#endif
> >
> >       probed_convention = SMC_CONVENTION_ARM_32;
> >       ret = __scm_smc_call(NULL, &desc, probed_convention, &res, true);
> > --
> > 2.17.1
> >



-- 
With best wishes
Dmitry

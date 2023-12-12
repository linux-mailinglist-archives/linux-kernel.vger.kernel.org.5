Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2FA80F18D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376306AbjLLPyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjLLPyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:54:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382A2AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702396494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QcwGwIBGwy0nrsg+JvhlsAjgWrO4lyub+YaeXL8a/M8=;
        b=gQihuANv80cve7q5ZJxLDRr0inddopojcHa65yIivjBuj/HQvtMeSd4yLnGcYJUHqbTyXG
        +JtYIkrC+53pG8z/KCE6/O2+DM3BwAxPBPDckvQU+XsyIMvSXvmSTxy7AGp+/2OijskuMt
        yTfMujv0gptL67WxSJc9oYGlU394nMw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-mkBHx96qPH25szlc6NXCHA-1; Tue, 12 Dec 2023 10:54:53 -0500
X-MC-Unique: mkBHx96qPH25szlc6NXCHA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-425d963aec1so16117961cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702396492; x=1703001292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcwGwIBGwy0nrsg+JvhlsAjgWrO4lyub+YaeXL8a/M8=;
        b=io+3krKZkd/Go7ynfiAK0kdre98pC4yZbcfWoQG7XPWjqFnEL282NiijYJ0QhdfoxF
         uZ8TDtsvcFb1/DwQnPMsOFohyvM5kOQ81ajIF8YDDNWPyVG77yciBiR/ZAroCvvdhPUX
         WAKZYKAKd1Z3ECFmwdGT5oBW4ttt8DEDox3qNAoCZ7hDdVKzRm7jh2izTefaDDL4YSBr
         J2zWttdcf2tyQtCGpUU9kGKmHK3twtnkU8YNHLihyUx7vEjyja9FqvBk32aRt5pMvlM4
         RuWMEgC+z1hiKZ+1dBvNZWnDOeYmqFf84ZKV4KKWLeqwkz7c8e6SgVvbwoyqXj8gpWUA
         DEzg==
X-Gm-Message-State: AOJu0YxCpLDKKButXn829oNF9pKJNwbY3WGV3YhGPTfGu2Yw62gEvDQ5
        EC3tasMkfwk/WaPQD339VHi0lbat7KZTNfr4HbIO/C5gB4+t3AobWozuPrAFfIzv+d5MSxXXnZt
        YNmmvQmi+iw69953mzkZQvznB
X-Received: by 2002:a05:622a:1b8e:b0:425:4043:7621 with SMTP id bp14-20020a05622a1b8e00b0042540437621mr9219958qtb.73.1702396492472;
        Tue, 12 Dec 2023 07:54:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlgCs+8vzMWF2YABEna2/x53mLtpw+foBe2AuUDEw7Su7i5zS6a3vwgeepPYI5GMIwH/6eqg==
X-Received: by 2002:a05:622a:1b8e:b0:425:4043:7621 with SMTP id bp14-20020a05622a1b8e00b0042540437621mr9219952qtb.73.1702396492128;
        Tue, 12 Dec 2023 07:54:52 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id m18-20020ac86892000000b00419801b1094sm4141016qtq.13.2023.12.12.07.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:54:51 -0800 (PST)
Date:   Tue, 12 Dec 2023 09:54:48 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] soc: qcom: pmic_pdcharger_ulog: Search current
 directory for headers
Message-ID: <k77ayy4xwlnghjefvw3yl4aenwyq272pezjaazx65bvdle37et@5fnbae4fxnjz>
References: <20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com>
 <20231205-pmicpdcharger-ulog-fixups-v1-1-71c95162cb84@redhat.com>
 <320864f5-fdd2-4345-a0dd-b97bcf17f473@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <320864f5-fdd2-4345-a0dd-b97bcf17f473@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 04:23:20PM +0100, Neil Armstrong wrote:
> Hi Andrew,
> 
> On 06/12/2023 00:05, Andrew Halaney wrote:
> > As specified in samples/trace_events/Makefile:
> > 
> >      If you include a trace header outside of include/trace/events
> >      then the file that does the #define CREATE_TRACE_POINTS must
> >      have that tracer file in its main search path. This is because
> >      define_trace.h will include it, and must be able to find it from
> >      the include/trace directory.
> > 
> > Without this the following compilation error is seen:
> > 
> >        CC      drivers/soc/qcom/pmic_pdcharger_ulog.o
> >      In file included from drivers/soc/qcom/pmic_pdcharger_ulog.h:36,
> >                       from drivers/soc/qcom/pmic_pdcharger_ulog.c:15:
> >      ./include/trace/define_trace.h:95:42: fatal error: ./pmic_pdcharger_ulog.h: No such file or directory
> >         95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >            |                                          ^
> >      compilation terminated.
> 
> I never experienced such error, and no CI even reported it, can you explain how you got this ?

To be honest, I am unsure why I'm experiencing this (and until I saw
another thread about it today I thought maybe I had screwed something
up!).

I just took it as an opportunity to try and read up on the tracing
infrastructure and sent this series. Definitely no expertise with the
in's and out's of tracing :)

I'm able to reproduce this on next-20231211:

    ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stmmac-handle-mdio-enodev] % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make mrproper
    <snip>
    ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stmmac-handle-mdio-enodev] % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make defconfig
    <snip>
    *** Default configuration is based on 'defconfig'
    #
    # configuration written to .config
    #
    130 ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stmmac-handle-mdio-enodev] % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make drivers/soc/qcom/pmic_pdcharger_ulog.o
      HOSTCC  scripts/dtc/dtc.o
    <snip>
      CC      drivers/soc/qcom/pmic_pdcharger_ulog.o
    In file included from drivers/soc/qcom/pmic_pdcharger_ulog.h:36,
		     from drivers/soc/qcom/pmic_pdcharger_ulog.c:15:
    ./include/trace/define_trace.h:95:42: fatal error: ./pmic_pdcharger_ulog.h: No such file or directory
       95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
    <snip>
    2 ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stmmac-handle-mdio-enodev] %

I even tried it in a fedora container with the above build commands and
the following podman invocation (plus some package installs) and saw the error:

    podman run -it -v ~/git/linux-next:/linux-next:z quay.io/fedora/fedora:latest /bin/bash

So I'm unsure if it's a fedora package version thing (which I'm running on my host)
or something else... Once I saw it was sort of spelled out in the
examples I referenced here I just decided it was something needed
fixing, regardless of why I'm hitting it while others seem ok.

> 
> Thanks,
> Neil
> 
> > 
> > Fixes: 086fdb48bc65 ("soc: qcom: add ADSP PDCharger ULOG driver")
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> >   drivers/soc/qcom/Makefile | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> > index 110108e23669..05b3d54e8dc9 100644
> > --- a/drivers/soc/qcom/Makefile
> > +++ b/drivers/soc/qcom/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
> >   obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
> >   obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
> >   obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
> > +CFLAGS_pmic_pdcharger_ulog.o	:=  -I$(src)
> >   obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
> >   qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
> >   obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
> > 
> 


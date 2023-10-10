Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6187C42F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjJJVuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjJJVuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:50:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05162B0;
        Tue, 10 Oct 2023 14:50:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so60680315e9.3;
        Tue, 10 Oct 2023 14:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696974603; x=1697579403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uhhCfmEihEvzPfEJHxe6vuWeG2oCPRjB6A9CxxsOshQ=;
        b=U0QjOXFohUtoud7MtbbAmyuwfAWsex1nv2JChk4OjeZp7/nOFUwShj8sAqozP+6Vab
         61w3NhzBfukw6PLPeKiiHlZVHrmA9+vTCDIZuYcyiQ1Zd2Mcm5ZqtBiLKFjVdClz/QWL
         OhFr0IOX7kGca/EyYhpNCpqMb1PTg5k1jkbeyNSf3vOXHXKMIFIT6R/C+chJufSwoJ8k
         EjEgY80uLGmcaQPmJQ5k95wlPBtWCom5ncHdb0Hlcdj7MZT9KpLLL607zCMbrLPpXsLm
         Q32WJKDwrtKWt6ymp6yGREJ15jmkT5DrEKZkFqFpl/3aOwMgsxyyUKJOe3UNufHSJ1cV
         MUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696974603; x=1697579403;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhhCfmEihEvzPfEJHxe6vuWeG2oCPRjB6A9CxxsOshQ=;
        b=kLn5b/odwE8AZTB2W+L9KJqOnaicsuf85VktYhw2QRhyNDNg+Int9ikPAzctRiZ7ED
         6zDjOmRspszAdVfL3RlgGa8h5cqmDKZ68lQ20HWrK/HVukcl3Drd/8N64Q2nIRlFD3tH
         IOzMwXyEYMaQIBQcAMQdGHaWAoXd2SqEkXCBsgEZmr1X85dA9oXRzfMpkRpfAMkMHlaH
         UdSyvxFBS3cjRsOT1577hONNRxz0Fcpv1yfAmImIROlpk7/mfmRrFKRJaFuqPfMunZEa
         dmSo+/gEvwz54AC+4t70FsDMF58Wg3X4VUbKusIekGh1PKBLzdZHupQYRMoZDqKb8YWd
         DmAA==
X-Gm-Message-State: AOJu0YxUBorhE6Rb0fE0+n0juUX1/BcmBX/DGTUdT5nfWMh8tDqLXH3s
        hYm3EEzA8GiolX8L6vhWDYOUhf5Fz8I=
X-Google-Smtp-Source: AGHT+IH37+bvK5d+zP39zcoxUMywDp8ldTWiFrQQobM+sUnXyLPZXlocTrRGqEKJ75FPlR4B1MYd3A==
X-Received: by 2002:a05:600c:3786:b0:3fe:2b8c:9f0b with SMTP id o6-20020a05600c378600b003fe2b8c9f0bmr16606360wmr.23.1696974602725;
        Tue, 10 Oct 2023 14:50:02 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm15140387wma.45.2023.10.10.14.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:50:02 -0700 (PDT)
Message-ID: <6525c70a.7b0a0220.3e593.d92d@mx.google.com>
X-Google-Original-Message-ID: <ZSXHCDSZ+SC9PCj3@Ansuel-xps.>
Date:   Tue, 10 Oct 2023 23:50:00 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-4-robimarko@gmail.com>
 <e255dcbd-6342-49e6-9bfe-17a47b2a3c8a@linaro.org>
 <65255c81.050a0220.141f8.7b8f@mx.google.com>
 <1aea4a86-7f7c-46ee-9cbe-655eb7663c2a@linaro.org>
 <6525ad59.1c0a0220.e3509.8545@mx.google.com>
 <3c3c80da-8986-4a8b-8b53-c33b36107e95@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3c80da-8986-4a8b-8b53-c33b36107e95@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:17:34PM +0200, Konrad Dybcio wrote:
> 
> 
> On 10/10/23 22:00, Christian Marangi wrote:
> > On Tue, Oct 10, 2023 at 09:52:50PM +0200, Konrad Dybcio wrote:
> > > 
> > > 
> > > On 10/10/23 16:15, Christian Marangi wrote:
> > > > On Tue, Oct 10, 2023 at 03:40:32PM +0200, Konrad Dybcio wrote:
> > > > > 
> > > > > 
> > > > > On 9/30/23 12:21, Robert Marko wrote:
> > > > > > From: Christian Marangi <ansuelsmth@gmail.com>
> > > > > > 
> > > > > > Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
> > > > > > Use opp-supported-hw binding to correctly enable and disable the
> > > > > > frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
> > > > > > 1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
> > > > > > 1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.
> > > > > > 
> > > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > > > ---
> > > > > Christian/Robert, can you provide a downstream source for this?
> > > > > 
> > > > 
> > > > Sure, consider that everything is with +/-5%.
> > > Hm, so you're e.g. putting ipq8062 384MHz voltage for PVS3 equal to
> > > 0.95*800000 = 760000, but I'm not sure if it's a good idea?
> > > 
> > > The comment in downstream:
> > > 
> > > "These are based on +/-5% Margin on the VDD_APCx that is advertised in our
> > > Datasheet across Temperature"
> > > 
> > > suggests this is already not very accurate, and betting that the lower
> > > threshold works on all chips is probably not the best idea.
> > > 
> > 
> > Consider that everything is driven by the rpm. The original qsdk used the
> > same approach of taking the value, apply +-5% and pass it as a voltage
> > triplet to the rpm regulator. Also the driver have ranges so it
> > autodecide the best voltage in the range of the voltage triplet based on
> > the one supported by the regulator. Normally the normal voltage is
> > always used.
> Eeh? So you pass any half-random value to it and RPM edits it in flight?
> 
> Please be more specific, I'm not very familiar with this platform
> 

Sorry, probably I was a bit confusing.

ipq806x mount on 99% of the devices (this is the suggested design by
qcom) smb208 regulator. These have selector and step since not every
voltage is supported. So the closest one is selected in the range of the
provided min and max.

Most of the time the normal voltage is correctly used by sometimes an
higher one is used. The ranges are described here [1].

Consider that in later version of the qsdk where the moved to DT
definition, they started using OPP v1 where voltage-tollerance binding
is used. The voltage-tollerance was set to 5.

You can find how this value was used for OPPv1 here [2].

As you can see they internally calculate the min and max value and set
them. OPP v2 dropped this and make the dev directly provide min and max.

Effectively we pass the same voltage values.

For the voltage and how it's set, we use cpufreq-dt where if an attached
regulator is found, the set_voltage_triplet is used by providing normal
min and max value and then internally the best value is selected. This
same implementation was used in the qsdk source when they moved to dt
implementation.

Hope it's more clear now how the voltages are set on this platform.
For the RPM part, the voltage is requested but there isn't a direct
control of the system on the regulator since everything is handled by
RPM so there is also that extra step.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/regulator/qcom_rpm-regulator.c#L178
[2] https://elixir.bootlin.com/linux/latest/source/drivers/opp/core.c#L1956
-- 
	Ansuel

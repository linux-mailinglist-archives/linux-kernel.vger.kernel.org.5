Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503DE7C40D1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjJJUHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjJJUH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:07:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CC01BFC;
        Tue, 10 Oct 2023 13:05:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405417465aaso58396385e9.1;
        Tue, 10 Oct 2023 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696968327; x=1697573127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uvdQ8oQKu8Aprzrh7sBdRyTzraBANoJZwsaVttcUpNw=;
        b=gyZ8sDlDQKHSwo/ZZVsee8yuoaCSxVnL8LgLx1M/biU88co5WmQ2B8QGpALpUO36Jf
         HRCFlOUwkDAl0oChhxH+Dn4HDYUcIs230GSypBuF9GiRua0Whd/n8hPjRBBJ1pWfXRQf
         BgxmsEGnK+hYb+rbiPnKlalZRmN0dGdPFbdiPKumHJMdUSc7urKC3mr3YFrJvlXNwpbR
         aS6Jtbd4mJFp6NFS5jKJhscRC9vdQpTOe4WFfPWNPzuenOa35XcZeEG6eaJG8HE152+R
         X6M/8iYI3OVfgMrvxOtM/vZCVfl/phi81y/ZaRN33GCZixoMmBp8hM9UWaI1QkMAritx
         o6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696968327; x=1697573127;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvdQ8oQKu8Aprzrh7sBdRyTzraBANoJZwsaVttcUpNw=;
        b=G7HcJBaauXdAhiopzl3y7vnoQwGnpoMtzib/LRzD5o6tZrp8ByjcTXz6/MtpoitCZV
         HSfB7mCNDutntbWzWNpW6Fo84XVyfZPD2seWSlInk5AuOQYqgR7jGY6FgLxB5hnbbmpQ
         KG8QnExW3ev40K9x5gMJICdDyhy1fkz8OjzE+EftwXQAbjwqtCj86CtEADdYPvxxaSXt
         VDlS724mumhH1bILZ1f/6pb917KkpsRZTiZDioNBN8ae+5iPGQImYOrkzdLUGGwtBxsW
         3NYR/O5bMF2P9EAc9eNaAjebWbvx2iBtK39vCKf6SAwqNCBpGynSuj1bsFgwnLnTSzGI
         CJ9Q==
X-Gm-Message-State: AOJu0Ywh0V/w3d7qiWBbp1Uk8dSImRbIpuMCNLrDAozWV3USiubW8R7L
        7ylue9BniJl3zc2e+7M2FWk=
X-Google-Smtp-Source: AGHT+IHO4aDIeIdZ+DANdqp04v6I8NqSgq3Pd3g1mL4+TWHC+Dza0YQcGYv+82hNXvTyBmB6SPneDg==
X-Received: by 2002:a05:600c:ad6:b0:3fc:7eb:1119 with SMTP id c22-20020a05600c0ad600b003fc07eb1119mr16666366wmr.15.1696968326929;
        Tue, 10 Oct 2023 13:05:26 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c219100b0040646a708dasm14926114wme.15.2023.10.10.13.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:05:26 -0700 (PDT)
Message-ID: <6525ae86.050a0220.827f2.c59d@mx.google.com>
X-Google-Original-Message-ID: <ZSWuhTM/O+fUI5fk@Ansuel-xps.>
Date:   Tue, 10 Oct 2023 22:05:25 +0200
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
 <e2d6c9c7-ff59-408f-94cf-81e66d291963@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2d6c9c7-ff59-408f-94cf-81e66d291963@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:55:26PM +0200, Konrad Dybcio wrote:
> 
> 
> On 9/30/23 12:21, Robert Marko wrote:
> > From: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
> > Use opp-supported-hw binding to correctly enable and disable the
> > frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
> > 1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
> > 1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes v4:
> > * Add OPP DTS patch for IPQ8064
> > 
> >   arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi | 30 +++++++++++
> >   arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 67 ++++++++++++++++++++++++
> >   arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi | 65 +++++++++++++++++++++++
> >   3 files changed, 162 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
> > index 5d3ebd3e2e51..72d9782c3d6f 100644
> > --- a/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
> > +++ b/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
> > @@ -6,3 +6,33 @@ / {
> >   	model = "Qualcomm Technologies, Inc. IPQ8062";
> >   	compatible = "qcom,ipq8062", "qcom,ipq8064";
> >   };
> > +
> > +&opp_table_cpu {
> > +	opp-384000000 {
> > +		opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
> > +		opp-microvolt-speed0-pvs1 = <925000 878750 971250>;
> > +		opp-microvolt-speed0-pvs2 = <875000 831250 918750>;
> > +		opp-microvolt-speed0-pvs3 = <800000 760000 840000>;
> We can just make use of opp-supported-hw and define opp-384...-0,
> opp-384..-1 etc. with a valid corresponding bitmask in opp-supported-hw
> 
> otherwise it's somewhat confusing to follow, I think..
>

Ehh should we really double the nodes for ipq8062 and ipq8065?
The idea here was to overwrite the one since the pvs always match and at
worst(ipq8065) have 7 pvs instead of 4. From the system it would be
easier to read since only one table is present in the final dts and not
2 and referring to the opp-supported-hw.

The original idea was to declare one opp table and reuse pvs version (by
faking it with hardcoded values) to put additional pvs for ipq8062 and
ipq8065, but Dmitry didn't like it and asked to move the opp in
different dtsi.

-- 
	Ansuel

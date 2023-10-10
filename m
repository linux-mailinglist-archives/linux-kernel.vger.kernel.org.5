Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BEC7BFEC4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjJJOIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjJJOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:08:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B87DA7;
        Tue, 10 Oct 2023 07:08:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3247cefa13aso5205661f8f.1;
        Tue, 10 Oct 2023 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696946910; x=1697551710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k2Very6RldBCzTfWE3kixTMSpP7cmdjStMj9exgkPjU=;
        b=Mm9LKzgi7b7on3KUTrVv0icEuH1SSqkAlKz4x3vMBzIwqRmwyyOkyzhES3J4Wu0CUU
         jOk+/w3jK48w4IFlTgbAQX4bS5m1fvjiJJCVvKV5j5xZ4ImbPwLEBgb7ayi+N+pSych4
         tAS9Lz/HL4QxVAZXND6Tg6bBPSeJBQqm+ezizyvto1NsffLskhR3reHJ6vf799hrhKPU
         v0ZvFTHQEBq3RgVZiZkJV6tp1HZ5SjPx1ARh4sjCWAW1HEDW6VraigYkxENWnt24zBXD
         zLGq05CdkFlpBlxipe90GcMIMu4z61z8o+x5W95YG08QrgmkW8FYV1Cy26TeFMJsdjTU
         bAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946910; x=1697551710;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2Very6RldBCzTfWE3kixTMSpP7cmdjStMj9exgkPjU=;
        b=gkjqLEYnbiYMR9SNGI4bCtowoCgEkMtNLkINfRdbWxlIdXxDKyXhoBqVWiSq2OzCrd
         zDmCkkmgkj7fBb7/en0ZxGozy5PfQ7CxHBQhCLg+qzrFG5oB4rksHL7HiiOhdjvsCXql
         Rp1KG7p8W9qIDiOwC9DyTVYUUAA0tfzNWAT0STgYH+euOYPYPxQFJpEi+2nIVOZZ6KK1
         5608MsjBMkj4xjCxCrtUjBAvCOYcd4hR2JAubDsj468vmMk58dyS0jkcSktiFL3K01vp
         qGM21poHliBLjkhEf5KTsf9m/O2QWYa5+50Ns7To0XpQaprUD5R6yQmnQtbHRPDjmsyL
         yk4g==
X-Gm-Message-State: AOJu0Yw0bE/faD5n/iZ37rvWQGMeTImH/9w3GKXZSz7oNrF9lsheFc6c
        J6dIOE3zxcIDmo+N2mtKz1c=
X-Google-Smtp-Source: AGHT+IGK8a/xY8dx9qijIprNgPtnjeeEi8L86iN5hElkw2DXb8x4UZqPCWmnz2E26uesS3W4ykeRVA==
X-Received: by 2002:a5d:6a4c:0:b0:31f:8a6d:e527 with SMTP id t12-20020a5d6a4c000000b0031f8a6de527mr16864437wrw.45.1696946910316;
        Tue, 10 Oct 2023 07:08:30 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id s13-20020adfeccd000000b003198a9d758dsm12801549wro.78.2023.10.10.07.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:08:29 -0700 (PDT)
Message-ID: <65255add.df0a0220.ff2f9.021d@mx.google.com>
X-Google-Original-Message-ID: <ZSVa3JfmUmLRBkda@Ansuel-xps.>
Date:   Tue, 10 Oct 2023 16:08:28 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 3/4] cpufreq: qcom-nvmem: add support for IPQ8064
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-3-robimarko@gmail.com>
 <5b57e0e0-490e-464d-bdc8-5823ad8da2d8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b57e0e0-490e-464d-bdc8-5823ad8da2d8@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:39:54PM +0200, Konrad Dybcio wrote:
> 
> 
> On 9/30/23 12:21, Robert Marko wrote:
> > From: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > IPQ8064 comes in 3 families:
> > * IPQ8062 up to 1.0GHz
> > * IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
> > * IPQ8065/IPQ8069 up to 1.7Ghz
> > 
> > So, in order to be able to support one OPP table, add support for
> > IPQ8064 family based of SMEM SoC ID-s and correctly set the version so
> > opp-supported-hw can be correctly used.
> > 
> > Bit are set with the following logic:
> > * IPQ8062 BIT 0
> > * IPQ8064/IPQ8066/IPQ8068 BIT 1
> > * IPQ8065/IPQ8069 BIT 2
> > 
> > speed is never fused, only pvs values are fused.
> > 
> > IPQ806x SoC doesn't have pvs_version so we drop and we use the new
> > pattern:
> > opp-microvolt-speed0-pvs<PSV_VALUE>
> > 
> > Example:
> > - for ipq8062 psv2
> >    opp-microvolt-speed0-pvs2 = < 925000 878750 971250>
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> [...]
> 
> > +{
> > +	int speed = 0, pvs = 0, pvs_ver = 0;
> > +	int msm_id, ret = 0;
> > +	u8 *speedbin;
> > +	size_t len;
> > +
> > +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> > +
> > +	if (IS_ERR(speedbin))
> The stray newline above this line triggers my OCD :D
> 
> > +		return PTR_ERR(speedbin);
> > +
> > +	if (len != 4) {
> > +		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
> > +		kfree(speedbin);
> > +		return -ENODEV;
> > +	}
> > +
> > +	get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver, speedbin);
> > +
> > +	ret = qcom_smem_get_soc_id(&msm_id);
> > +	if (ret)
> > +		return ret;
> speedbin leaks here
> 
> you can free it right after the get_krait.. call
> > +
> > +	switch (msm_id) {
> > +	case QCOM_ID_IPQ8062:
> > +		drv->versions = BIT(IPQ8062_VERSION);
> > +		break;
> > +	case QCOM_ID_IPQ8064:
> > +	case QCOM_ID_IPQ8066:
> > +	case QCOM_ID_IPQ8068:
> > +		drv->versions = BIT(IPQ8064_VERSION);
> > +		break;
> > +	case QCOM_ID_IPQ8065:
> > +	case QCOM_ID_IPQ8069:
> > +		drv->versions = BIT(IPQ8065_VERSION);
> > +		break;
> > +	default:
> > +		dev_err(cpu_dev,
> > +			"SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
> > +			msm_id);
> > +		drv->versions = BIT(IPQ8062_VERSION);
> > +		break;
> > +	}
> > +
> > +	/* IPQ8064 speed is never fused. Only pvs values are fused. */
> > +	snprintf(*pvs_name, sizeof("speedXX-pvsXX"), "speed%d-pvs%d",
> > +		 speed, pvs);
> Then drop the format for `speed` and just throw in a zero!
> 
> [...]
> 
> > -	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
> > +	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
> This change demands a Fixes tag, because you're essentially saying "the
> support for this SoC was supposedly there, but it could have never worked
> and was broken all along".
>

Mhhh actually no. We are just changing the opp binding and introducing
hardcoded versions. But the thing worked and actually it's what was used
before this change in openwrt. Also current ipq806x dtsi doesn't have
any opp definition so no regression there. (and also 99% downstream either
use openwrt or use qcom sdk where this implementation is not used at
all)

Given these thing should we still add a fixes tag referencing the commit
that introduced the compatible for qcom,ipq8064? It's quite problematic
as this depends on qcom_smem_get_soc_id().

-- 
	Ansuel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AA57895E7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjHZKTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjHZKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:18:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F51FC7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:18:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50078eba7afso2672600e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693045109; x=1693649909;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGiEVQaTK5hH8HErxp1WTRl58SjfEzq6XEE94mrt1pI=;
        b=RKRHKqzxZA3OdL4aGsozw5yEjQcmXI6GBbiFhOVgzgguJ2FYtk4i7o1CV2iDOint7x
         wAoe1UmUXqpcGT2TKuAd4PISvgZPhN1L5iEySb1Bjcx3/Qm13CqVWclcL7Rm4/daW30P
         bJmWBfVF0+t75CycA6Yihp9B36TUZF7fC/K8gqism5BZrxKpSl+wci94QV6SfIsx5b36
         yLImHpuEWQhldGxfY4CwtCJ8R0qZtYejdjZGbA/I9i8UYAgEeZJTolDw92hkkjJyHWFg
         n513avlvykfFAE8rvjQJSf/Bl3/51ejjpeky3XsrGoyFBZt0nONRZUwcAVOEWxbqiVfR
         bY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693045109; x=1693649909;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGiEVQaTK5hH8HErxp1WTRl58SjfEzq6XEE94mrt1pI=;
        b=EcSawN19+MkEShHMNTTxq88XX4PBNDeNanHuK3kmWIsH/bRla5eP09v1wWV+UbaJoT
         2ySG/XaBXmq11FXfaU5xmruQVEhoDhmdyLz10sE7QMWfO46FpTOQCuUmVwp6rb1F4uBr
         zAUjrRhXMjU5b7YFN+O9zpkBeS7GsEWHdHkUXvL4Kb7N16OMSThWpIiOnmmFlr/WKDBm
         AtsKGE3mf3DqWkA16+HoSMuGbCfY7IpEiFpjewpu3Wg75GTYXqX4WgL7CoHwg3f9bwcN
         yfBR4o8ONkRNaKtetF2f5sMLRWBAo2UjyOmsrzKkd9X38yECCS8BD1mkdDPok738HqG6
         tEVQ==
X-Gm-Message-State: AOJu0YzK0KwoM7huSyh8X9HMnqP6F/sHwpkQnFaCBtG4tTqK+sl2bjLD
        wE1rgjU63L8tT+nQbDFPNs0VTQ==
X-Google-Smtp-Source: AGHT+IEvHjX3zBUK+TusXfTyCn7D32D5o4R5tItoZvVUcOVfrL7jhPnjMHEOgcYfZWBQ5blST6LN/Q==
X-Received: by 2002:a05:6512:1145:b0:4fb:76a5:2325 with SMTP id m5-20020a056512114500b004fb76a52325mr12997493lfg.24.1693045108751;
        Sat, 26 Aug 2023 03:18:28 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id c23-20020a197617000000b004ff748f6f1fsm660930lff.69.2023.08.26.03.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 03:18:28 -0700 (PDT)
Message-ID: <4929aa72-a134-4eeb-850e-46d9255c011b@linaro.org>
Date:   Sat, 26 Aug 2023 12:18:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] media: qcom: camss: Comment CSID dt_id field
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-16-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230823104444.1954663-16-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.2023 12:44, Bryan O'Donoghue wrote:
> Digging into the documentation we find that the DT_ID bitfield is used to
> map the six bit DT to a two bit ID code. This value is concatenated to the
> VC bitfield to create a CID value. DT_ID is the two least significant bits
> of CID and VC the most significant bits.
> 
> Originally we set dt_id = vc * 4 in and then subsequently set dt_id = vc.
> 
> commit 3c4ed72a16bc ("media: camss: sm8250: Virtual channels for CSID")
> silently fixed the multiplication by four which would give a better
> value for the generated CID without mentioning what was being done or why.
> 
> Next up I haplessly changed the value back to "dt_id = vc * 4" since there
> didn't appear to be any logic behind it.
> 
> Hans asked what the change was for and I honestly couldn't remember the
> provenance of it, so I dug in.
> 
> Link: https://lore.kernel.org/linux-arm-msm/edd4bf9b-0e1b-883c-1a4d-50f4102c3924@xs4all.nl/
> 
> Add a comment so the next hapless programmer doesn't make this same
> mistake.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/camss-csid-gen2.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> index 6ba2b10326444..cee50fc87e9de 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> @@ -352,6 +352,11 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
>  		phy_sel = csid->phy.csiphy_id;
>  
>  	if (enable) {
> +		/*
> +		 * A value caled 'CID' gets generated internal to CAMSS logic
> +		 * which is a concatenation of [vc:6 | dt_id:2] hence we reuse
> +		 * the least significant two bits of the VC to 'stuff' the CID value.
> +		 */
>  		u8 dt_id = vc;
And where are you discarding the non-2-lsb?

Konrad

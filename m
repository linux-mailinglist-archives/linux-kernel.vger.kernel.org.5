Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841CE7D93E9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjJ0Jil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345679AbjJ0Jia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:38:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A64911F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:38:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so1086910f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698399507; x=1699004307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtVWzB92hc15cCGAVsJCr0D0zC/xe3ZPUDWinw+Lm68=;
        b=c2FHkwnqpDxk62/4XlprdDFtOLeDYKs4AefeP13nkaxNmU3TDhcDonMiiySNcRl41+
         8cEOnwzxzoJnAj5VfFC6FhY0rFIsSWBgWcHtCMqRq8qZ/M9MH2nsvvv6MHPuHuwdYxe/
         4nond/Ds7NwaEyQQLqHWm+X/z6CaCMREAPgoBbSaWswBccpXIGKGd5aY/wpetIW3GJ6n
         Wgyg9gRv+i7dgZG96H/a6OkKm19vtG4WP3pwdnfEY2zCo56XFHHP5+sNaLB5gRqByzWp
         Qj8u3YbP0GOllrCTLdEZ9bWsu7MXkY2Fe6nsYEDt8b3xj5xo1TukBT8wdgiVXu4Yg0mN
         hC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399507; x=1699004307;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtVWzB92hc15cCGAVsJCr0D0zC/xe3ZPUDWinw+Lm68=;
        b=fthGM2w+ifnsj2OmPn8d4StRMK5wuscDv7kQ/hEnnO48ANLZiNWs0oOteswRwyUvTO
         S4FFi/qKVs1MQScdjVNpMA/4/9Tb0b8X45qv+kw5oyulOTht2URPYI3MBVafza68pLl0
         rkXxBAYy2TQDyIy5NcqIqVNmnP3VbVHYEiy/N5RxN5vz3C1vVvLA3S/5EsSxsyHeH/s7
         YTvrcxXvgMZnI4/UdnsjW4wF4x/h1xU8LKKJjqfh+/k35wOmj8+Z7AlZ9dCq4xvIV958
         XuaRPV6jwG5CVN516awFsWOWCJ1HXDMeGijGA5pLCmWI3VMsXrzGJXMN2Zk4Wr46UdtA
         h/9A==
X-Gm-Message-State: AOJu0YxLwAJGW7tp1bPZC2cIRLL6hMx1OcHpLMNpeoB5AkmV7v6G3Tb3
        xXS3jiaH9ROGKwZFc2gDL1RG3w==
X-Google-Smtp-Source: AGHT+IFzn2Se5Sw9T/aX+BWqfplCCwsI6Pq5A4gTadr3MG4jAX2gDZ+1hPcrZ7yXgeAQHpfNC0uy1A==
X-Received: by 2002:a5d:6d03:0:b0:32d:8982:ff12 with SMTP id e3-20020a5d6d03000000b0032d8982ff12mr3081975wrq.7.1698399506780;
        Fri, 27 Oct 2023 02:38:26 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d564d000000b00327bf4f2f14sm1361488wrw.88.2023.10.27.02.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 02:38:26 -0700 (PDT)
Message-ID: <d62d65b8-da05-4dfb-bf38-1c102564a5a0@linaro.org>
Date:   Fri, 27 Oct 2023 10:38:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] media: qcom: camss: Convert to per-VFE pointer for
 power-domain linkages
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, rfoss@kernel.org,
        todor.too@gmail.com, andersson@kernel.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
 <20231026155042.551731-3-bryan.odonoghue@linaro.org>
 <8a36e61a-5397-4513-ae0d-eb68ccd8e584@linaro.org>
 <9fec3a90-b3dd-4b2e-bb7f-27890ad2b4e0@linaro.org>
In-Reply-To: <9fec3a90-b3dd-4b2e-bb7f-27890ad2b4e0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2023 10:10, Bryan O'Donoghue wrote:
> power-domains = <VFE_0>,
>                  <VFE_1>,
>                  <TITAN_TOP>; // the controller pd
> 
> vfe-set = <VFE_0>, // has its own PD vfe->id = 0
>            <VFE_1>, // has its own PD vfe->id = 1
>            <VFE_LITE_N>; // has no PD vfe->id = 2
> 
> The basic problem this series fixes is magic indexing.

So be a little clearer; this would be an invalid declaration in dtsi 
right now

power-domains = <TITAN_TOP>, // has to come last
                 <VFE_0>,
                 <VFE_1>; // the code would think this TOP

The TOP GDSC must come last.

Similarly this would an invalid declaration in our resource structure

vfe-set = <VFE_LITE_0>, //the code thinks this is a VFE
           <VFE_LITE_1>, //the code thinks this is a VFE
           <VFE_0>,
           <VFE_1>; // and that this is VFE Lite

vfe_num = 2;
vfe-id = {0..3}

// don't hook a PD for VFE Lite
if (vfe->id >= camss->res->vfe_num)
     return 0;

has_pd fixes checks like that. Eventually we will throw away has_pd when 
legacy indexing is dropped - in which case if vfe->id has a res->pd_name 
we hook it, if not, then not.

The order of declaration won't matter.

---
bod

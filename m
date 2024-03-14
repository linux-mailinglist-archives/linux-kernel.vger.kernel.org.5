Return-Path: <linux-kernel+bounces-103397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CED87BEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AD71F23BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7D270CA0;
	Thu, 14 Mar 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeD9Q1Vj"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400936FE3C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426550; cv=none; b=d6rqbdcNdLr/u7dvFHTFDMErA/UOG/TAN1Zbs8+vB0F/CdGiZIeTwEziK4hrULFCU+62tFhnFdPhSCLZ4uT68Sk42I43X2SzK7xLWACqOHxURHpfdE6jEvZDDGLuwMDtzB67i0sB2MSVP/6MySYJa027TVzM5Y9oSMKNl2F3JV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426550; c=relaxed/simple;
	bh=8onVvCRHALH8Z0t909CHM3Iguu/cKn1N8VI/tYUI8ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkMOSEru/lTbfrjUNTzHHKC1B+FYP1tKij/ZlhG2SR9Y1FJtHLCuEweBHzYECqlr6Zrdc8Pug2mxGsFJUzbTdgZEXCmS5BFGX+HEpRIOn4AP4FZ8ntw1/1SZLNVtw/2Molq2GGX9oJ3V1xQdAN/ZndG5XceIujvZWuh8a53HKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MeD9Q1Vj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e9ba0eadcso826383f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710426546; x=1711031346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbWbnFqFcxqkfsdDIzVbGRGYMN0ey69wKPUvvi1/HTk=;
        b=MeD9Q1VjIM3IH7FyeOYXQWhRPJL4NxVikBUrLA4J3mNW/2AbuZSk79EAhPccuvm4iF
         LZm08U2gBgnrPwWTehyTFeFJD8s0kPT7j/sSQflVPRdQLbCF1ihJG6PCKK8zrcFwu7eu
         ozjVT1DLV40eGH/vnG7pIYEpJU67Gl3ykw3g/sQgexnn2zx8Kk901lLuq+3ZA0yYq2+u
         Ec4/v05WT5yJdHXHrsZq8Y3iymtLdVVShGwZ+eUgubp6ApUK5+B/KNUHy+MN6oez0Fik
         L/Bezk/0KfAOkQ/6zc/c+396Yat9sS3o6XulcMcxGUmJmVv5xdZGcxAJwHEiT6NdXxi9
         b2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710426546; x=1711031346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbWbnFqFcxqkfsdDIzVbGRGYMN0ey69wKPUvvi1/HTk=;
        b=Fi6jg0W6Y5Pm3vlVWK55ZIRngdWGqUtVCiFW9iuz7z8912+jmMWLYvajd8HoDVJNnl
         Pca8NvIzbIXADUyON0s2bOrJ83IS0PlIyOimmqjcb9jAAJkvmHYnb/LjvoO67oDSYi7K
         hwkMbTwrrdJnk0JCHzRJldU8Dm5KECD9qXYrmVobbkg8tgm0Mxbo0x+3oiu5EHZd7cLD
         3QSqj0u+tiqo+Ho69QE8s/wYrn2XWLEl4KRCnmxjUm7YOGXAEONkv466OfDd4GhrBZ9r
         e0VRJ6gr91ITn6ANedQ/eVJcy8PaKOwdvGsoYDebeeJ9/I/MtYlyC0kDXNvID9ZnzZiq
         lGxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBPi44XFcipypjMrMGeE+MjptqeM1JL6DG+M3k3qSwtCyRMfZqp2JpAwlteQZGzg5OeltZJaE4jTMkF0dq0v9bvehMIQmUSe+KXoLk
X-Gm-Message-State: AOJu0Yx2OyQ/1tk6A3t2/WxfLqBPmny7nChG2ebQnYUkJMNp+9J4dwE6
	PWudaZPnQGKnkOV8Hpg45+EAS9rTHtfeRz+jN8//WUC706iOOtzR/ywXRcKBCLs=
X-Google-Smtp-Source: AGHT+IEFJC3eV05L1hTDs8HZhZF3XOgLBa8DjaxZxdayetOHeSCXloemj3z/yiRwlOTgnlYdqt77rQ==
X-Received: by 2002:adf:e7ca:0:b0:33e:c9bd:c965 with SMTP id e10-20020adfe7ca000000b0033ec9bdc965mr1089990wrn.35.1710426546553;
        Thu, 14 Mar 2024 07:29:06 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600000c200b0033dedd63382sm854067wrx.101.2024.03.14.07.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:29:06 -0700 (PDT)
Message-ID: <9fdd04e8-cc7b-41e7-a099-055f39b3b462@linaro.org>
Date: Thu, 14 Mar 2024 14:29:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Update Devicetree
 identifiers
Content-Language: en-US
To: Amrit Anand <quic_amrianan@quicinc.com>, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kernel@quicinc.com, peter.griffin@linaro.org,
 linux-riscv@lists.infradead.org, chrome-platform@lists.linux.dev,
 linux-mediatek@lists.infradead.org
References: <1710418312-6559-1-git-send-email-quic_amrianan@quicinc.com>
 <1710418312-6559-2-git-send-email-quic_amrianan@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <1710418312-6559-2-git-send-email-quic_amrianan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/03/2024 12:11, Amrit Anand wrote:
> Update existing documentation for qcom,msm-id (interchangeably:
> qcom,soc-id) and qcom,board-id. Add support for qcom,pmic-id, qcom,oem-id
> to support multi-DTB selection on Qualcomm's boards.
> 
> "qcom,soc-id", "qcom,board-id" and "qcom,pmic-id" are tuples of two 32-bit
> values. The "qcom,oem-id" is a tuple of one 32-bit value.
> Introduce macros to help generate SOC, board, PMIC and OEM identifiers.
> QCOM_SOC_ID and QCOM_SOC_REVISION can be used to generate qcom,msm-id.
> QCOM_BOARD_ID and QCOM_BOARD_SUBTYPE can be used to generate qcom,board-id.
> QCOM_PMIC_SID and QCOM_PMIC_MODEL can be used to generate qcom,pmic-id.
> QCOM_OEM_ID can be used to generate qcom,oem-id.
> 
> Add entries for different types of SoC, boards, DDR type, Boot device
> type which are currently used by Qualcomm based bootloader.
> 
> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
> ---
>  include/dt-bindings/arm/qcom,ids.h | 86 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 77 insertions(+), 9 deletions(-)
> 
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> index f724834..dc24151 100644
> --- a/include/dt-bindings/arm/qcom,ids.h
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -8,9 +8,14 @@
>  #define _DT_BINDINGS_ARM_QCOM_IDS_H
>  
>  /*
> - * The MSM chipset and hardware revision used by Qualcomm bootloaders, DTS for
> - * older chipsets (qcom,msm-id) and in socinfo driver:
> + * The MSM chipset ID (soc-id) used by Qualcomm bootloaders,
> + * and in socinfo driver:
> + * where, "a" indicates Qualcomm supported chipsets, example MSM8260, MSM8660 etc
>   */
> +
> +#define QCOM_SOC_ID(a)  ((QCOM_ID_##a) && 0xffff)

How is QCOM_SOC_ID(SC7280) ever better than QCOM_ID_SC7280? What does
this mask give you? It's going into a 32-bit field and not being OR'd
with anything else...
> +
> +
>  #define QCOM_ID_MSM8260			70
>  #define QCOM_ID_MSM8660			71
>  #define QCOM_ID_APQ8060			86
> @@ -266,16 +271,79 @@
>  #define QCOM_ID_IPQ5302			595
>  #define QCOM_ID_IPQ5300			624
>  
> + /* The SOC revision used by Qualcomm bootloaders (soc-revision) */
> +
> +#define QCOM_SOC_REVISION(a)		(a & 0xff)
> +
>  /*
> - * The board type and revision information, used by Qualcomm bootloaders and
> - * DTS for older chipsets (qcom,board-id):
> + * The board type and revision information (board-id), used by Qualcomm bootloaders
> + * where, "a" indicates board type which can be either MTP, QRD etc
>   */
> +
>  #define QCOM_BOARD_ID(a, major, minor) \
> -	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | QCOM_BOARD_ID_##a)
> +	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | ((QCOM_BOARD_ID_##a) & 0xff))
> +
> +#define QCOM_BOARD_ID_MTP		0x8
> +#define QCOM_BOARD_ID_LIQUID		0x9
> +#define QCOM_BOARD_ID_DRAGONBOARD	0xA
> +#define QCOM_BOARD_ID_QRD		0x11
This replaces the previous definition of QCOM_BOARD_ID_QRD which was
decimal 11, now you're defining it as hex 0x11? I'm guessing this was a
typo.
> +#define QCOM_BOARD_ID_ADP		0x19
> +#define QCOM_BOARD_ID_HDK		0x1F
> +#define QCOM_BOARD_ID_ATP		0x21
> +#define QCOM_BOARD_ID_IDP		0x22
> +#define QCOM_BOARD_ID_SBC		0x24
> +#define QCOM_BOARD_ID_QXR		0x26
> +#define QCOM_BOARD_ID_X100		0x26
> +#define QCOM_BOARD_ID_CRD		0x28
> +
> +/*
> + * The platform subtype is used by Qualcomm bootloaders and
> + * DTS (board-subtype)
> + * where, "a" indicates boot device type, it can be EMMC,
> + * UFS, NAND or OTHER (which can be used for default).
> + * "b" indicates DDR type which can be 128MB, 256MB,
> + * 512MB, 1024MB, 2048MB, 3072MB, 4096MB or ANY 
> + * (which can be used for default).
> + */
> +#define QCOM_BOARD_SUBTYPE(a, b, SUBTYPE) \
> +	(((QCOM_BOARD_BOOT_##a & 0xf) << 16) | ((QCOM_BOARD_DDRTYPE_##b & 0x7) << 8) | \
> +	(SUBTYPE & 0xff))
> +
> +/* Board DDR Type where each value indicates higher limit */
> +#define QCOM_BOARD_DDRTYPE_ANY		0x0
> +#define QCOM_BOARD_DDRTYPE_128M		0x1
> +#define QCOM_BOARD_DDRTYPE_256M		0x2
> +#define QCOM_BOARD_DDRTYPE_512M		0x3
> +#define QCOM_BOARD_DDRTYPE_1024M	0x4
> +#define QCOM_BOARD_DDRTYPE_2048M	0x5
> +#define QCOM_BOARD_DDRTYPE_3072M	0x6
> +#define QCOM_BOARD_DDRTYPE_4096M	0x7
>  
> -#define QCOM_BOARD_ID_MTP			8
> -#define QCOM_BOARD_ID_DRAGONBOARD		10
> -#define QCOM_BOARD_ID_QRD			11
> -#define QCOM_BOARD_ID_SBC			24
> +/* Board Boot Device Type */
> +#define QCOM_BOARD_BOOT_EMMC		0x0
> +#define QCOM_BOARD_BOOT_UFS		0x1
> +#define QCOM_BOARD_BOOT_NAND		0x2
> +#define QCOM_BOARD_BOOT_OTHER		0x3
> +
> +/*
> + * The PMIC slave id is used by Qualcomm bootloaders to
> + * indicates which PMIC is attached (pmic-sid)
> + */
> +
> +#define QCOM_PMIC_SID(a)		(a & 0xff)
> +
> +/*
> + * The PMIC ID is used by Qualcomm bootloaders to describe the ID
> + * of PMIC attached to bus described by SID (pmic-model)
> + */
> +
> +#define QCOM_PMIC_MODEL(ID, major, minor) \
> +	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | (ID & 0xff))
> +
> +/*
> + * The OEM ID consists of 32 bit value to support OEM boards where they
> + * have slight differences on top of Qualcomm's standard boards
> + */
> +#define QCOM_OEM_ID(a)		(a & 0xffffffff)
>  
>  #endif /* _DT_BINDINGS_ARM_QCOM_IDS_H */

-- 
// Caleb (they/them)


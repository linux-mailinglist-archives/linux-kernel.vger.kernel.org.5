Return-Path: <linux-kernel+bounces-74891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D967385DF87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FD71C23DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7F57CF02;
	Wed, 21 Feb 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXlQbSo2"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0ED7BB11
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525745; cv=none; b=FT9PF7isQnpVMrh/LBMu2kzUzp9Lnp22juGSW1pV39sZ2jPIX/Ph9fd3+Dml/TZFELwePT/AnsQJv9daI6t+aQLUNgy+WpRRBaiDhL9Cq6ZIkQYKE/TgF3o0Xv+adktMjBAkoktL0pjakmdUpbYp86UIT0bz9AWmD1YX3sC3BnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525745; c=relaxed/simple;
	bh=9VrGwqa0mBd4/4VMCG0ge/u1QOZYmBzth5XPonwUBIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQnUHR7x7LiAS3rVv4Ntg6tNaQ3aKinIpkTjf7jR/YCvccvFyAvg+bpGbCPnqCBSQXvsvIYA6CH1OcDtxFrESqgdtkn8ypsMpzjUelNLP8GLP931ZQYYEl69iG6hKNX02lWRHvvQtG2anLvgx+umL9r80ndqlc9YBobdu9tquBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXlQbSo2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e552eff09so344599866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708525742; x=1709130542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LdWGpQpRBwI6mSmQszBM6YwILTu0TShFcoufmUhOmjQ=;
        b=QXlQbSo2tU3EmIb1Kywbi9aH2rzuMjjLlky1mrVDjeNPxabUbeUOLbND3PUT9dndSQ
         ttTkj7GNo3sPDOg7CHf4ZzcX3mPWdDaenvVVOdaxAigJ2m9W5X8Q+HAO9x5/+hKGD7LX
         7JjCMwl60SE3KoMA+G2fGQJmnC96FFmG7CeCny8CG4VEhSRlcbTnTpC4FMRMU83PoaWg
         Ny1RdtAmrbFEoNeZE5Op8CBOiOxlG/13gkz7cyD0OEXNtsSMdsNgGTMtEr8Q8TgJn73R
         yNpWltudXsFxz07678jV9l0HnRmSbP3gHn5AU5/H/quTk49yizonIxI25vhzNeE/r8O0
         qRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525742; x=1709130542;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdWGpQpRBwI6mSmQszBM6YwILTu0TShFcoufmUhOmjQ=;
        b=DbfPz4gAicS75Tb/n3CbMvssy+w8ZRD3esW5N1WeArrHpFxWkey/aU7pCFANdlbtpV
         jTeE15uS1r50baXXq9n/RknuHOoRR0vfs8Szbdc7JqQB5llArnLiENOaaqDMTXF6jDFC
         c7vJ7TX3SytgBFyC7W01/e33PlvaJW0KMv1hm6VGDh8bD+auYzfOHFPzWrd8lGsCww4m
         xX7J7wrRn6sQXDqRhLAv4oeZHVBjl2WvqRXuIDQwL5ZCO4u3wqCgtCKFtplczLOGzkJL
         hNs8na8uYBTtWZNIiX2Vy5ClqmyHURC30Dz7YMmvMmDphhIB8sWbWsZWhxkvPINVNpxy
         lIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmVHJX8rGNqZubT1laTI5zJLEuZKEoCLiyqSoAcHjcrvnieDXB7RyMNqzZA4SLGx+2gMBRiXR+okTKBCBiMos2uNwf6WEpluHuqEXY
X-Gm-Message-State: AOJu0YwIOE1h5jixdwlQb/N7uJrLvMELTO09EWSLU1R43qypft5wtS7s
	08Mq+8XbaPpLrLw1BupD4+M8nA92Zy4tlEJzy1RCeG7Ol8xNwUC6/AAxR9j2pkA=
X-Google-Smtp-Source: AGHT+IHCJhgWk1BjZowj8gaYWXRYrNhdifX7cyQv18WJplRYyhAKxRNGoCdvBOwet1sH/f76v7+dcg==
X-Received: by 2002:a17:906:350d:b0:a3e:6c4f:44d5 with SMTP id r13-20020a170906350d00b00a3e6c4f44d5mr6228261eja.72.1708525741936;
        Wed, 21 Feb 2024 06:29:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090634cb00b00a3d7bcfb9a1sm5015112ejb.128.2024.02.21.06.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:29:01 -0800 (PST)
Message-ID: <08ca89da-d6a1-440c-8347-f2e31222bede@linaro.org>
Date: Wed, 21 Feb 2024 15:28:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: qcom: Add global irq support for
 SA8775p
Content-Language: en-US
To: root <root@hu-msarkar-hyd.qualcomm.com>, andersson@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, jingoohan1@gmail.com,
 gustavo.pimentel@synopsys.com, konrad.dybcio@linaro.org,
 manivannan.sadhasivam@linaro.org, conor+dt@kernel.org,
 quic_nitegupt@quicinc.com
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
 quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
 quic_vbadigan@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
 <20240221140405.28532-2-root@hu-msarkar-hyd.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240221140405.28532-2-root@hu-msarkar-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 15:04, root wrote:
> From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> 
> Add global interrupt support in dt-bindings for SA8775p RC platform.

What is this global interrupt? Why wasn't it there before?

> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 26 +++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a93ab3b54066..d86fb63a2d2c 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -63,7 +63,7 @@ properties:
>  
>    interrupt-names:
>      minItems: 1
> -    maxItems: 8
> +    maxItems: 9
>  
>    iommu-map:
>      minItems: 1
> @@ -873,8 +873,30 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - qcom,pcie-msm8996
>                - qcom,pcie-sa8775p
> +    then:
> +      oneOf:

No need, drop.

Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-55513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D9584BD98
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCDA2924AB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBF313FFB;
	Tue,  6 Feb 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/GBm2Oz"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE213FF0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245935; cv=none; b=Ohwmh5U7vG2vsVCxgC6Kix1Y+rkR35MgDgF92LjE03CQjRI7t7GLapkzrRUET5BMUMdZ/CCchzZo9CooHR+pcbwFBHValnAAp6L0KK17sqHlPT2ILY+3xBCKnPMt3+lBZ1q4XscYERVXUNBjtajF7bRlCRlBj3vIgWneQy6Mkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245935; c=relaxed/simple;
	bh=Qq3xKFGjIEfMfs8qVG/PR9UbUlr+y95P+DQqHobJq7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouuB6eNMoSwok7mfzzXP7oiPrJQnVhzw5jFLTe2AjgWPeROU76miJ1oGms4G+fPLlSvvBQ88UkF4MwugOOIzQO9QpNQkQWuo148joA3uEn+cu+SWznFvSdeNWyFwqTtBf9XhGmlnF/W5p4lbbC/k4ytduy5oRLs9ygvqLDBkmWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n/GBm2Oz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28a6cef709so820783366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707245931; x=1707850731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdAl2S1Pm6Ai0QntvJ25FTPqot82sSqL9vq3piBlzQs=;
        b=n/GBm2Ozx+to+mk1svXWmCZjkInl5IwC+NQIJPbRMli5xf5O9iTZm7TEsJWsgygqFh
         sxMl4gjDmAjIeRnrl7F+0ydU1gYsFYhSRMEMCidhKrCXgNR1zJdY9dDBRi72HNxJ7T+L
         IoVD44RS35APJWXUMU1tg/EeGAfU//cwHe2C2JXLDPCLR2AA7bTxlpII7JV0U5P9mK4x
         NgrMHyjBIwsK332q1mjoOCfISHB/uNeK1UDB3NFiwd/bnFJ0WyVCofKTnhpe0jbE//04
         v8TkyGNUVPxTxBe3kitwwsnNuJ6Y0EyzUDjiQSRKYVW5/ZXuw6QAvzSOilMO25YjHbPM
         L2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245931; x=1707850731;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdAl2S1Pm6Ai0QntvJ25FTPqot82sSqL9vq3piBlzQs=;
        b=SDhQG9gkJjTlJqgAaEwBRZ3hnDh67YMeHLdvrUhcE2Bx3w4Vwj/FruLf+r10kNjFcu
         hWp4EMqeAXqQw0V7Si9i86OFm25U2Yv82d4MuVm02Ac+wNi4mrycl21xedQ8MxLVQDRp
         8BFw9KvJF/qOIZSGZ+yefaEkmeEUVvVMCWsQBd5+egKD0SDCPcJQeCurW8qjKmit52l8
         3VfToCvg9vFK7oMAsW/bDqGBQmY+Cewr4MNNqQ90wgmT90VN0bkU7IkEeoCgEzITJx/b
         CjPFCkW+1mpZkdJYnGN45p2ASmtaUNR2RiGt7IA00e2Kg2J1IYmU9uLe3mKmbpvNByHr
         DcMQ==
X-Gm-Message-State: AOJu0YycMOOlt95nE2PFZ6OugftywVFn2St3Pq4vLmqVuFtqMjL4Gk2c
	dgSgFViclbEAMtROmmeaqwgAc5FMqHC0hsO/5G4mqWgNITN2F4rN4VeYk3Brsyk=
X-Google-Smtp-Source: AGHT+IHHdeSrMjTPU39iYfRnmM/7OI0WsvY4zV0WS8j+hlcW4T0f4Fz1WR//rDoY7veUgZG9STkXNQ==
X-Received: by 2002:a17:906:1b49:b0:a37:ebcf:f5dd with SMTP id p9-20020a1709061b4900b00a37ebcff5ddmr2755088ejg.11.1707245931519;
        Tue, 06 Feb 2024 10:58:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFATPKd7yatVpK1q443z0b9Fm8ua9iFEI32UBtHUxbp+Md68YBCbqPecuYVxWP1JqEZtJcjQpbsWHmbsnRr+xJkWDcHZCMORJv9t0vLhSe2NsSFHLx6/vI9kNvljHnj/w6lkhgeo2cWYTq7bXtGPP7NUDLZm5BtgqOAZkyao64eqV73M5MdUqgHKHx/bUMdm72/zLBzll9aH3XKeJs+iMRudYjKQU98hfgaS141M9oA3FQ8OzptdW8+dHNP+nrUG9nynELOrfZWQg5jeDqoMVGTOjH2akdrTsnF15mZjtxtpvkx0+zodsphV94xeDM2Coa0y/FbK9pCM1x0tQYc7a3ETQVbCmu57pis483tCcLYzHT/tmbDglZGIuuS7BRggGyrV/LIl7X+iMoSNV9qE7OYGpqm4p+oqE53ZB3h7WbiS6w3l1g8Oknwe6XpgPYLQ1iMisZxXv0oDX5J+Tmmn0MeXLqxxA+Rz7S4HJ/16/eyA==
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id y16-20020a170906071000b00a371eced193sm1465555ejb.49.2024.02.06.10.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 10:58:51 -0800 (PST)
Message-ID: <808bd239-6a61-4932-ab91-3dcbe10a7a05@linaro.org>
Date: Tue, 6 Feb 2024 19:58:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: msm8976: Declare and use SDC1
 pins
Content-Language: en-US
To: Marijn Suijten <marijn.suijten@somainline.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Luca Weiss <luca@z3ntu.xyz>, Adam Skladowski <a39.skl@gmail.com>,
 Martin Botka <martin.botka@somainline.org>,
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240121-msm8976-dt-v2-0-7b186a02dc72@somainline.org>
 <20240121-msm8976-dt-v2-4-7b186a02dc72@somainline.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240121-msm8976-dt-v2-4-7b186a02dc72@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.01.2024 23:33, Marijn Suijten wrote:
> Add the pinctrl states for SDC1 and use them on sdhc_1.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---

[...]


> @@ -840,6 +890,11 @@ sdhc_1: mmc@7824900 {
>  				 <&gcc GCC_SDCC1_APPS_CLK>,
>  				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>  			clock-names = "iface", "core", "xo";
> +
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&sdc1_on_state>;
> +			pinctrl-1 = <&sdc1_off_state>;

-names should go last

Konrad


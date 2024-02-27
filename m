Return-Path: <linux-kernel+bounces-83325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFFC8692A7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB0C1F2D4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F388913EFE9;
	Tue, 27 Feb 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGUhtyOl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A61D13B79F;
	Tue, 27 Feb 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041039; cv=none; b=P3l97krUudpeqsbFfdg4m1PWMSA5BsXOem/SCnPjRJmTeJTFHRDBjucRjJ5k0cMQJhy8oHDy+OjUVk41rNHx04nAh+zxdu+lA8gT7Rn7wT3k+y0NBu3DzQB8dWmisa5oeo1Rfgxk68ckya0GK0Hps3E8yXEQyQExV7f9mUgn06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041039; c=relaxed/simple;
	bh=H1c/bi5IfYB1iSUBfPU6PzkgJpun/PjAJmV416IBnMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4ffLRmMZJs/wTS27sJ7I28BQ8gTp9FtxwfMtn8dBNUFTELJjZj2sLNlZjzStt+w5zUBa+SXwpSuxkcu3SKW7ClWWyVWGGCT2tgIAPBZEHI0JnciD9VCEcxNasObYp0vJy+hoNjpND7bC7VwoqRtnKRqfkqtajvePhXgr8eAP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGUhtyOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AD9C433A6;
	Tue, 27 Feb 2024 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709041039;
	bh=H1c/bi5IfYB1iSUBfPU6PzkgJpun/PjAJmV416IBnMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oGUhtyOleFDlVprD+BHiw5msYy/xXs7n8MPnqXIQXA7gm9Hx35qZCdT4MhSOkx4hP
	 rz+kq2hfyJ9mFuFg2rQVbGqBXf+nptZOB8OM7UT6xaUH3iMMaxxSmajFqxPHBnzAR2
	 Z9GJJwS9G96S3zO0litfHxufug7uCe1lCZFFT56C87WkeQDL+I4v4QXuX8grK9DK9D
	 3pWJdu1qsuFeWnfa5CV7khEuxTM+E2w8PI8eWAJ2bCM15KQYtu69N3jg2cCT2OyII3
	 zJcPL97J4E6ztRARi9eXcpjCj5XiuknpZeMhbq6LZztKrzW9e2bfKWRYyIWLElKDeT
	 ca9EXgFPfgyVw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d299b4ad6aso6253751fa.1;
        Tue, 27 Feb 2024 05:37:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgNfEOMMgUcZ8yAb6NZ8shSj9KY9s0ABYFaEi7uD7kPospD1lnx4ZSNAefMnvc/t+sMkndaZp2/AoJmmm2KJ0CFN+0wTI2vxBcEo6UtaLioKehCGJMJZgBUrFp99G53tRc8SEQFbHCtuZnHdVOhmLQR7SeALudoOQn/MAX3gSdabBvhGrg4fveyM3Nn30+OVkJ67Se7Ej7AWcM0akpaBZDA0dH
X-Gm-Message-State: AOJu0YyXmFy4A9xiTp1WE9AbjH6NS0kh5XVFQejDAI9s4b/wZG3KzF+8
	xJsAiqytGo9z7N4s2VyOC7IsaO5dl8MZH3VdMe8pNgD0z7dykXzb+zRNShNb7Wzc3Ln9XLHU4lB
	iVkT9Xu7T68Vq8/JfhbOM7IzQIQ==
X-Google-Smtp-Source: AGHT+IG5QHJKq6z8x6+mL6APDMaMcHT+R6XCLzJCa5meAUVodTB8s4RdbL4+VxRoHLTrkZTvWB3wRm4Tes8nApxV0wo=
X-Received: by 2002:a05:6512:1317:b0:512:f4f6:9343 with SMTP id
 x23-20020a056512131700b00512f4f69343mr3796213lfu.26.1709041037258; Tue, 27
 Feb 2024 05:37:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129092512.23602-1-quic_tengfan@quicinc.com> <20240129092512.23602-2-quic_tengfan@quicinc.com>
In-Reply-To: <20240129092512.23602-2-quic_tengfan@quicinc.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 27 Feb 2024 07:37:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJfsWaj9OPkvc34rBvx7W_3v9+1kZqNu6QKDsA=iWAA4w@mail.gmail.com>
Message-ID: <CAL_JsqJfsWaj9OPkvc34rBvx7W_3v9+1kZqNu6QKDsA=iWAA4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: update compatible name
 for match with driver
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, linus.walleij@linaro.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 3:25=E2=80=AFAM Tengfei Fan <quic_tengfan@quicinc.c=
om> wrote:
>
> Use compatible name "qcom,sm4450-tlmm" instead of "qcom,sm4450-pinctrl"
> to match the compatible name in sm4450 pinctrl driver.
>
> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.y=
aml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> index bb08ca5a1509..bb675c8ec220 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
> @@ -17,7 +17,7 @@ allOf:
>
>  properties:
>    compatible:
> -    const: qcom,sm4450-pinctrl
> +    const: qcom,sm4450-tlmm

I think you forgot to update the example:

Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.example.dtb:
/example-0/pinctrl@f100000: failed to match any schema with
compatible: ['qcom,sm4450-tlmm']


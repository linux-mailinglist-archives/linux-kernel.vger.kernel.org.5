Return-Path: <linux-kernel+bounces-16779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C48243A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAB1282779
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028AE225D2;
	Thu,  4 Jan 2024 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfHpK3Om"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB9224D2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e3485f0e1so4382325e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704378134; x=1704982934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOIhKXF7biqxz+aA/XDTJ2jcGS5EMuYmWEXbjvsxFhY=;
        b=TfHpK3Om4QDogYBdE6MnE3msalOcbX+pIXqJiAeHDryTFddbbG7dstHJbWAriphTI8
         aozIdqm7uaFZ1kBfhATrLEHdVMWW5KGYXBtQfztF9f++TXRV3yEcUTR8ev/A5OK8lBei
         hmBvD+ItDq6yoT8ztiRdfav0nikyePx0kR4dAPbXZ53/0DGMhVH0LRIVnqamAMCQkbLs
         tblDrXoruVXyw+ocPTj0kEwqjZ3Q6FFc7fKg20q4Fm5WPrb/VRFhVC7nnHL5cFUqM34r
         I1XkJHF7DADnxG8uomP1K1h31vDUnIwCn+dAtrxLKicfR54Kj/6LAbIuaEJ0bvvJLxwp
         XWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704378134; x=1704982934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOIhKXF7biqxz+aA/XDTJ2jcGS5EMuYmWEXbjvsxFhY=;
        b=KDoCMJSGPA34A0DvwspHNbphtIk4R2ugJL38xidPV73i7CWTWplArnHw8f3Qlb93C7
         qNYYbTBKfwUdRWiFrbFvZWL7rGGxynzW77uEdG10vBtu8GD99y/ZXTxPgeuoevCPdSbE
         7AcraFNXQBPBPUFOCzEHHO1DpdtpmqmHFmRN8F4HrluaVflO863hccHcQVtITRJzgvf1
         PLTQ7k+TmdmR9Hn9z2uV79DDOqyeNghnj3KSpZcNW2rE6hklTIO0DrWRp4DZXw80Eklx
         qzeHR22yyFvljj/O1hWK7QB44P1sIp+OeUS9IIgWDq0bBEztNKnJ8ujj+U/uA5VuLOES
         9A9A==
X-Gm-Message-State: AOJu0Yy9AVspgWU/A3lzAFjOaae2eXwGgT7LU1rf568zGjONSJi3gF4T
	kGWHE9yViI8ErR19sagLjzUSJsBr4Qk6Yw==
X-Google-Smtp-Source: AGHT+IF5WicewklRFmMcWPw5W2zfn/1Y+Xf1MSh9HNXvJ0S8BzwdJIf9dtkChqe702hWNWojBcL1HQ==
X-Received: by 2002:a1c:4b08:0:b0:40d:628a:1230 with SMTP id y8-20020a1c4b08000000b0040d628a1230mr384503wma.61.1704378134059;
        Thu, 04 Jan 2024 06:22:14 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b0040d7c3d5454sm5933073wmf.3.2024.01.04.06.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 06:22:13 -0800 (PST)
Message-ID: <641e8800-4735-406b-8555-d4a80201f0b9@linaro.org>
Date: Thu, 4 Jan 2024 14:22:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240103-topic-845gdsc-v1-1-368efbe1a61d@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240103-topic-845gdsc-v1-1-368efbe1a61d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/01/2024 20:20, Konrad Dybcio wrote:
> SDM845 downstream uses non-default values for GDSC internal waits.
> Program them accordingly to avoid surprises.
> 
> Fixes: 81351776c9fb ("clk: qcom: Add display clock controller driver for SDM845")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

This doesn't break anything, but I'm not exactly sure what it fixes :P

Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 6
> ---
>  drivers/clk/qcom/dispcc-sdm845.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
> index 735adfefc379..e792e0b130d3 100644
> --- a/drivers/clk/qcom/dispcc-sdm845.c
> +++ b/drivers/clk/qcom/dispcc-sdm845.c
> @@ -759,6 +759,8 @@ static struct clk_branch disp_cc_mdss_vsync_clk = {
>  
>  static struct gdsc mdss_gdsc = {
>  	.gdscr = 0x3000,
> +	.en_few_wait_val = 0x6,
> +	.en_rest_wait_val = 0x5,
>  	.pd = {
>  		.name = "mdss_gdsc",
>  	},
> 
> ---
> base-commit: 0fef202ac2f8e6d9ad21aead648278f1226b9053
> change-id: 20240103-topic-845gdsc-bcd9d549f153
> 
> Best regards,

-- 
// Caleb (they/them)


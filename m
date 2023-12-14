Return-Path: <linux-kernel+bounces-17-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C2E813ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DACF283307
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B96697A4;
	Thu, 14 Dec 2023 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVWSEAR1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1B697AB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50bf26b677dso8337540e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702582309; x=1703187109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtamLk15uiLxGzhwsunKJdl02l1MlYN9ssm1S1ptW9s=;
        b=WVWSEAR1+XUM+0+vVEQXc/R5frlNfDGmBwZfh8G26nsMRWmdW/J4z9vYGO5F418dTQ
         Tw8IZ1jalvyk5JEp5VZI2rGz2A//64F/hWS8rMhS7gD7/Q/R5T7tK440ptSD8kLZtgXk
         vJwGFSyUDUvlenB7sdlC4Ye1UoC1UV+GziUmuK+9mU3JeQ0HICuP0nhvgNb5w14H079X
         abK5jSscETZdfQJfF95T2z949lSNfIdVNyp79+k+6lK/ewU/PvNKYKy+RrgRuqQUI8/x
         k2namhGRuPg4R/DBBazwjZWupGbhPA/cU04mqohnQV9zRznotYibQN4g8XdN2W/xaAR7
         p96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582309; x=1703187109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtamLk15uiLxGzhwsunKJdl02l1MlYN9ssm1S1ptW9s=;
        b=vbgiwrfFc6Ya7Vnx3Qy8JNwKj8xjB0DdfTryahnrSZDtL1mSxz7nU3ulWA2fjTv6gg
         PLA3lsN9y0zgBIZTxBgzXCiu7IfLXhdoMnC+IHQxN9JdC+dQnOdNI8qDtUUT6s59j0WS
         /pY7QTeS+sFtXoCMmY4qpRx2ECbB1kZuEIGBYn4wmSfgGmqr2JgWlo+WnaYdAGRxFE54
         Z+O+yYb/1TWyJ3gLuP3yl70PHCqAVxoMCmJLvh+4xiKnPdIZei38YWJaAJUXiW7j4eNr
         Xm/+/xVPv6G0KHQzmcIo9Ljzr6ukSmhBqunUooxg38juuf5fnqZoN7/FqRY2mhhWt+EC
         8o8Q==
X-Gm-Message-State: AOJu0YyuAh6CbymiBPsIQPegYYMc2j3JU+c5Qhkv0ddnJkNl9DWdgCy0
	c9iaMIwXmOCMQg7dNOvpXdsMkA==
X-Google-Smtp-Source: AGHT+IH5JM+njOSUVpJVz1U7SmBjrCyLvoh710QoZPAixUx/0/KVQdGX2+wsArj3SMVrpzuVNns6Iw==
X-Received: by 2002:a19:e003:0:b0:507:a04c:76e8 with SMTP id x3-20020a19e003000000b00507a04c76e8mr3167966lfg.46.1702582309365;
        Thu, 14 Dec 2023 11:31:49 -0800 (PST)
Received: from [172.30.205.72] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id m21-20020ac24255000000b0050bf4df12d6sm1935590lfl.168.2023.12.14.11.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 11:31:49 -0800 (PST)
Message-ID: <b578a34a-0e7f-4175-8051-3d2340861700@linaro.org>
Date: Thu, 14 Dec 2023 20:31:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-crd: Fix supplies for some
 LDOs in PM8550
To: Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231214-x1e80100-dts-fix-pm8550-regulators-supplies-v1-1-6b5830dc337e@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231214-x1e80100-dts-fix-pm8550-regulators-supplies-v1-1-6b5830dc337e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/14/23 20:24, Abel Vesa wrote:
> The LDOs 1, 4 and 10 from PM8550 share the same supply, the SMPS 4
> from PM8550ve. This needs to be done through shared supply approach
> otherwise the bindings check fails.
Not only that, but Linux also doesn't parse it :D
> 
> Fixes: bd50b1f5b6f3 ("arm64: dts: qcom: x1e80100: Add Compute Reference Device")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


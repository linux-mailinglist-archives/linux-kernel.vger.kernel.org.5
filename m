Return-Path: <linux-kernel+bounces-48751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4EE8460C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2653C1C23C3F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBB78527F;
	Thu,  1 Feb 2024 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5MbKPCK"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B80085269
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815001; cv=none; b=tcVnhB1F+xTqUw7ecJV63aku2iH2uFHep0pAlE6UHYvrkYh/4tHZOjzXHk1z1pK+yec+6YXHfwEb6wsXZaHstW8WB7WEPT983sqvnSRl97oGnIFpeV52AowINTx8RKfbN9hI+6Qh3ypiIF0m12i7PV4oIApbevptWxfYD5zJAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815001; c=relaxed/simple;
	bh=kCVD0saoCqvrEJIo4DNt3BTAT44dbOXhla37LPlqcr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geNt5jqv1invJB2ByipOxLlyd2aL6dDMX80hY1gR/po5/PrTcfQjeLn8zk6nsl1B5HCuQEgy6st5m1hXxsP/ovJ4SMw9X5LPSjlVBnacdK+j26+592KZrMwMbsOEiLqjeLM4OUdpnGtEuCnRq43eTQdVx/n1SlRd+21Sdxk9Ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P5MbKPCK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511207d62b6so2027364e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706814997; x=1707419797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hoIj9II25PNIZhnmzc7SonBXWyc/dj/iIiU1Yyw7lNg=;
        b=P5MbKPCKqp/XOeT9fUHeIG8w8Stm62lesgLH15AIL6SJLA91lObpfL3a7PRdFSOzeH
         WKcsz3LjxLSZWNy/bQATSZqjKOSrT0P670PtB7UyH5nFJx+Tw7Gob9RK6U8MofpBxa88
         qsFF9OHRaRVfGFC1BiIK7HbAK3VnfgUzLAC1e+5u3fxWGhzhu1aKkBNfG26EDcGdXIeW
         Tl//Mij44VaDQpTJD9RY3HfpTcehOopL9RVTKj28Hq2YTqcH5+5fajYA4FfiKATX68lF
         cZ/2s4QkrjKPxHY1JHL+Dj1V1vYII/oKHyrHFv5Vdj7ikiwvoyLm+f8Z28hZ4SDTrrce
         COwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814997; x=1707419797;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoIj9II25PNIZhnmzc7SonBXWyc/dj/iIiU1Yyw7lNg=;
        b=ipM5D+QUhGkUweAiH1cUp3ZGwIoraHAC7ThCmP5LcIkCTtX9vSOYOBvA7MkON0jssD
         QgaZgRvhrRLhL5fCaay+GFkv5R6OcoOocTOpML65h8l05iT21nqo1k3+QHOVRDWVCBls
         3zp/XM1YUFB9GMvxLeEs8c3yZWBvLg9m6DP4UEZAjvs0r53r+yHEHP6lFCHjCkzPCJFU
         tIgbx5vat9LAEnZ+TtdFd8iaA3CjTb28LxuAhYJiYHMbT6LDrh3GfbfjqLGgcqienSDE
         VcG9Xnt9/2sx/PkcsQHdRQ9Ukp3siT+0mWfkSGJDGWI/xa8p67M+2UplcHMxXFh1UTW1
         8Pzg==
X-Gm-Message-State: AOJu0YxSjB6HAlTTIv8v9xJgPig8yUmiw5RmXxqMcRdg/L6Avkotb2rn
	uxUgP9ojw86uaLuKUUWjsDAwtoc8mRLiVzcXO4PIiVSKNhL5R+lrbFpz1wtY68E=
X-Google-Smtp-Source: AGHT+IE0U9RFwXa9ogJKDBpgq0w+sUwlvmcEpk0KoM0FFUx9lGsGX5z4ghDUieUh5oipGaoF07To6g==
X-Received: by 2002:a05:6512:1143:b0:511:f41:dff7 with SMTP id m3-20020a056512114300b005110f41dff7mr2139593lfg.56.1706814997345;
        Thu, 01 Feb 2024 11:16:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX7jmPIWKpaz+qEeXcpuehLATCNsmJ943Q2ct/ectfJgLVmPtBuch2JIUSL/trV8bxg7LDYhQRzBRAfWXb7We/ajO3Kca7JJshUQEwY5EFAFx2xL65jn6dEAZMH1UTZ6psmZwEvzdeamDpSvFXSzF+8y4FUtI/7auQYxj6koyd32KsU4JzdOEQ1aQhPR+ACKVhq874oyh2TcxDyXCVOp7tyjKdHQd852702+r5DPUHCxRehnU6SzCFQRcqrheVd+u+EAvos8y/YHFp0m7dJpmYXhrjeBdtKMIAuxEoCV9q95U54l+AG2WSQSM1jjVXqkP3awKQfkhbuNN+JnW1ZEyDAFuE4AMPJikQ2rWuFprsKvajs19vfDwC2lxYJT4FY3pupz58nyvdhWfBAUKOg2qOB+oSrKYOTk8c1vnrt5jr42y3cVvi1vy6Acdh828NBtawpg0QRP+XT9Syhv/cLNtDqt8bMnE7bU4X3+9BfXkc4g7y4U/HtA8IXiAOLDAdh
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id vk8-20020a170907cbc800b00a36f8fdeb98sm23088ejc.59.2024.02.01.11.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 11:16:36 -0800 (PST)
Message-ID: <c7606dea-8b6b-4c9b-9ad0-3516d545a6e4@linaro.org>
Date: Thu, 1 Feb 2024 20:16:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/17] phy: qcom-qmp-ufs: Switch to
 devm_clk_bulk_get_all() API
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, quic_cang@quicinc.com
References: <20240131-ufs-phy-clock-v3-0-58a49d2f4605@linaro.org>
 <20240131-ufs-phy-clock-v3-2-58a49d2f4605@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240131-ufs-phy-clock-v3-2-58a49d2f4605@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31.01.2024 08:07, Manivannan Sadhasivam wrote:
> Device drivers should just rely on the clocks provided by the devicetree
> and enable/disable them based on the requirement. There is no need to
> validate the clocks provided by devicetree in the driver. That's the job
> of DT schema.
> 
> So let's switch to devm_clk_bulk_get_all() API that just gets the clocks
> provided by devicetree and remove hardcoded clocks info.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Amazing, thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad



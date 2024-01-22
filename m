Return-Path: <linux-kernel+bounces-33586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01A836CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C667B32D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D30F44383;
	Mon, 22 Jan 2024 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2b/kduM"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4841772
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937192; cv=none; b=loHD1VLN3cED6+N0C4yPjqsKGjeJJoH37wquDa70elKjJISIM0aijZwR+FDM8nUiuOVX/PFk/Nl090vbjra5t5HK+olSeAeWtsRxX+7v7eLMCkC4mg8lLX+vurEN73wtrszUQRU0ClFlyUFg2aGfBAEY6fJQ0ZDC1KzqgWQJs8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937192; c=relaxed/simple;
	bh=KLmdfWYDGVa0MGrW5xg1DDwnruZeNPwCPCY+n/p8dKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LGAwnzyz//d8/9c0FkXwVl5V1tcHGBup00IVKMUPY3MD2oTyD26dx3IMXTzUnvkdhED69ky9PscjunvSLZ13NJf3XT/kw++3cEFD8IsafyaZYJOhdXGmnbuYnIffDdYHxquOGXIyW4VhtrIWRYjQg2c3Em77BXHJqy/EzyA59BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x2b/kduM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28ab7ae504so264524366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705937188; x=1706541988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L2ssyj7QUsCONwfAWbtgWdWt1RvO5vwbDocJcWnwveQ=;
        b=x2b/kduMFiHVSYwIPGMMNLV5y8j44bECOjCxCHzpy/jCdJI1GpoKgEUvg+IRFbB5dH
         Te964RyQXA89envMITmacjRIzhUeCnQq9BRgDFzmT81WjmkScW1w5EDaLQ8uRLkeFsdb
         aEffUidkKdvBJONQsEnm+F2x8rqE40rp6v7dV1BGMu7RRoERCPHJYmqUuWJeyH+Tc2o2
         pDFRk2oFmqZpIme/47UmpWmkB6YOSIVlhGs97nUR4FnxQLK1oa8wFYo0MFYCJEHzSpuD
         f3FjS1p3UANwlLbZh7KtkT8jDokkKRGK/NVM8B1a/mpgT0To9BIvtBOV4t3J23xBcaSz
         ZTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705937188; x=1706541988;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2ssyj7QUsCONwfAWbtgWdWt1RvO5vwbDocJcWnwveQ=;
        b=J4GG8oM42BET/pQn/04zVz1mEprcg5NtvuRmmHcURrjPOb+5hG9BnWO1pVJSaVf+CI
         qONAgsnrgnLYKn5Z8v+O3RLCPDhCC8LFzfGz2ZU1zIxTQqNB2cEOgGIrAbb25Wrsn55D
         GZRUJfecHK7Py8fNzyu094ma9xtVuSMaBARuJi8G6fEWs7elyB+KqEWZH5fhZ4Z8VfgR
         2RnXNlhhCTkdtRRPS3Viqc3H97e9oLQ2kz2v1JMUsMo+ITgoAEHxn/wpPyRbcSDS2yAr
         TYO23TZymwEl+76kn1bTmYEWsVTkXNwRkrEryoRjDnmRTfRg6+zSofUWvguvonthInZ8
         prxA==
X-Gm-Message-State: AOJu0Yz25HHHVBocUjU2mpCiwm19CVI6k6dmN51PA6PBHRXCm2HcjCku
	98Run8+PT+IZ/ADXCFX7NqmW6CrjOHEmDjFKPt3wewx3VvEh/2Yzz+Rs8KxMqd4=
X-Google-Smtp-Source: AGHT+IEzdcu76uoeIojRSyt2U8jaGERGhWiOrHBkUFk7xxsf/jJ/WohyF5RC0zaSfO/NIbgnH4f9ww==
X-Received: by 2002:a17:907:8b95:b0:a2f:bbc2:8f49 with SMTP id tb21-20020a1709078b9500b00a2fbbc28f49mr2806301ejc.7.1705937188570;
        Mon, 22 Jan 2024 07:26:28 -0800 (PST)
Received: from [192.168.231.132] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id hu14-20020a170907a08e00b00a2f15b8cb76sm5302537ejc.184.2024.01.22.07.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 07:26:28 -0800 (PST)
Message-ID: <d7f406f1-fc27-45e6-90a0-a7ee108505a6@linaro.org>
Date: Mon, 22 Jan 2024 16:26:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [1/4] interconnect: qcom: icc-rpmh: Add QoS config support
Content-Language: en-US
To: Odelu Kukatla <quic_okukatla@quicinc.com>, georgi.djakov@linaro.org,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240122143030.11904-1-quic_okukatla@quicinc.com>
 <20240122143030.11904-2-quic_okukatla@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240122143030.11904-2-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.01.2024 15:30, Odelu Kukatla wrote:
> Introduce support to initialize QoS settings for QNOC platforms.
> 
> Change-Id: I068d49cbcfec5d34c01e5adc930eec72d306ed89
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---

[...]


> +
> +struct qcom_icc_qosbox {
> +	u32 prio;
> +	u32 urg_fwd;

Also, why is this field not a bool?

Everything in here could be const, btw

> +	bool prio_fwd_disable;
> +	u32 num_ports;
> +	u32 offsets[];
> +};
> +
>  #define MAX_LINKS		128
>  #define MAX_BCMS		64
>  #define MAX_BCM_PER_NODE	3
> @@ -58,6 +86,8 @@ struct bcm_db {
>   * @max_peak: current max aggregate value of all peak bw requests
>   * @bcms: list of bcms associated with this logical node
>   * @num_bcms: num of @bcms
> + * @regmap: used for QOS registers access
> + * @qosbox: qos config data associated with node
>   */
>  struct qcom_icc_node {
>  	const char *name;
> @@ -70,6 +100,8 @@ struct qcom_icc_node {
>  	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>  	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
>  	size_t num_bcms;
> +	struct regmap *regmap;
> +	struct qcom_icc_qosbox *qosbox;

this member here as well

Konrad


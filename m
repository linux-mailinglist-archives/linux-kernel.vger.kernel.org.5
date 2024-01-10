Return-Path: <linux-kernel+bounces-22017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55066829800
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DEC1F26799
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F272347780;
	Wed, 10 Jan 2024 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHMKf8Ik"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A741779
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e7c6e3c63so4113417e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704883772; x=1705488572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HAwidvb0e6ayLYLy7I8ixYSx1g7DRV+B9kcqw/hieg=;
        b=iHMKf8IkXh7fOSlSG15azryW47XKx238o+gr8RPX3CubNzw9MSfg9cLZ9P0dZTLjZt
         qmeG20Ey4S7kC8mKbEijqtUBLXkwRzN+ybH5XU/K0+t9Ru7Megl2TY1MaPD+SCdJAQKS
         IGd3JQrN99lewOzjhWMSjncpSBz4CgqIErtFFRypnzwtsHn31v/IQAWvdVRgzAxBT5ka
         vrBmYaTeibRwxfpsEwYyHJZoxw+GshaLKKOzXmuOxcfVKLFU1rutA56G9j9LMRPoiCmA
         mmBFu45NjfAvuyEODbI5zwIIIiblz6CTrxJHRVcT+ChkSOwrv4K/cLj7oZWwHbEaDyHU
         YTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883772; x=1705488572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HAwidvb0e6ayLYLy7I8ixYSx1g7DRV+B9kcqw/hieg=;
        b=lC1cxs5SJGzsnIWsJQY9y0AgXGv/FDhMQ83HzSXgErcSXZS7HNaqI2EuTyCeowuH1y
         9bFy+ODSRQS/kXOwFFnNtFWtPnbz5bsCKyYJ+jmVpxv5oajpRKVum2eWpzqA6NNMCQyu
         N1UtrGL8fB7lIw5X90uPCZUgJkm8Qo8wRrCGbQymVfket30iDSd6CqndMfnOVHNzJG4y
         ZVJCczakx0HYwpW27eyoHeaFoZq7pIt3uPhDvV41QBhSLCxcilB4yjnebD+pnhF9Iq4o
         k2IobCSuMJCyRMWWF6DWNYDkiynfbXvoZcqMIIYsd6SZajno9zW7CIBzAqNqAOAh4SQI
         PCPQ==
X-Gm-Message-State: AOJu0Yw7G5HgxitlmnA9eQPwBw0kOKCchQCdQFX0Ahdh8YebVXb0ESSo
	N8LOv1df8TFf8tCRYlBvd8sNP08DjsAYlw==
X-Google-Smtp-Source: AGHT+IGH4Qz7/5tf/bBFWTnAs92jT0yCKBWnsVfiMJH5KiWKl3BVTMjQvfanZ3xGGYxdJZu1ZO+YtQ==
X-Received: by 2002:a19:5f50:0:b0:50e:700:bdbb with SMTP id a16-20020a195f50000000b0050e0700bdbbmr145927lfj.21.1704883771729;
        Wed, 10 Jan 2024 02:49:31 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o5-20020ac24bc5000000b0050ecae41c51sm590120lfq.135.2024.01.10.02.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 02:49:31 -0800 (PST)
Message-ID: <45314345-36ba-4d85-9d3b-298de26eb069@linaro.org>
Date: Wed, 10 Jan 2024 11:49:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
 jsnitsel@redhat.com, quic_bjorande@quicinc.com, mani@kernel.org,
 quic_eberman@quicinc.com, robdclark@chromium.org,
 u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com,
 quic_pkondeti@quicinc.com, quic_molvera@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 qipl.kernel.upstream@quicinc.com
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-5-quic_bibekkum@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240109114220.30243-5-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/24 12:42, Bibek Kumar Patro wrote:
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
[...]

> +static const struct actlr_variant sm8550_actlr[] = {
> +	{ sm8550_apps_actlr_cfg, 0x15000000 },
> +	{ sm8550_gfx_actlr_cfg, 0x03da0000 },
> +	{},
> +};

Please use C99 designated initializers and put the address first.

Konrad


Return-Path: <linux-kernel+bounces-125587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C02B89290E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999221C2127B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304C47470;
	Sat, 30 Mar 2024 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeTXRXCR"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE78F56;
	Sat, 30 Mar 2024 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711770230; cv=none; b=mxqZpNWB4ouhaLXUr6GQXKLh0bSvOxxQ2G4SCBMy9IJmZv9opDmAD9w3NGAWQAvgSO2AQIYfdotrM3+tcJXUvPNXzDmaSH/eZDLtWro3xrxrfu3kIBBISNXV7vZ85UbFFz/+XAiAgeIshCZD3SJs1w7Nf60YoqrnZCt1dLrPtuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711770230; c=relaxed/simple;
	bh=D7mMkuUdsjit8GK67wQGgvUxXxod3DMssDyyaERKIr0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F5cQqR96wg7GjIZFxTalypxiKm6PsLqe3od02FGOU7XQovdamvin5RqgD5KcrXBw5KzYA9NIRtV2vaqTL3L4AxoWZTMJdMtUEyT5RMhSETWnV6im22Tj980QGVUQTFGIjBDe+Fg1NsX9c4q+FCh/+jxec92ZIKH2e57TOlgoUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeTXRXCR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a02c4dffd2so2075566a91.0;
        Fri, 29 Mar 2024 20:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711770228; x=1712375028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=42ieZrjF1YjhNDAdWni4JR62A5YZurmvhsPm9WcnCX8=;
        b=TeTXRXCRbh50eLMwcxGvUy9BQeV9t3cIF9K9tMx1tJYHVykA27lAcS/dSak8jcOEde
         UaFZiJBaxr+whLYO5+ecaFUjpNEwLpj7xX9psRnI7t0mzHQ9Uw8XjLv7Iz20oaYamMkQ
         6gy9ou78xFjloUZkpbNxxY9bdTupHwGYin68XZ8kZvRaV7GRxuD/CsXWfi9KqQnBr/84
         1Q8xZjt3hjsO3d+RT+ceZxAdaD7c62eEbqxahko1ifEcmiIyKAr03tfl5J0Pa0DfC6MI
         goK0W64JZqOSMQbsTUNp6tQF05L7YGQRRmQnhTo9KlE2lkEZYuLDL98hnXYMarodMrR0
         eZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711770228; x=1712375028;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42ieZrjF1YjhNDAdWni4JR62A5YZurmvhsPm9WcnCX8=;
        b=aPGNuecQhF16N88/s2NNb2fMbw5Uy9IcrBUIutPB/4SFosOwwZHmZ//WBTodkRqw6Q
         4jzjDfWazbx9NDyZAElCrO8FqI6tQ7qOJyhrIvCv3exUreoV7Ix8/eP1Yu8gs4t0ouVD
         5SOez9ZeaZFfKKupzMIIAlMv4p9oP6p7K0p+1z/ZSqIoKypKqBXaIgpC20d5XbyxD/8M
         CEyN9fz+uQ4fF7oDVg+OtLFAiEFWy4b70llZJYMmASQ5RosKtfwwMDlm06058tCjYlar
         jA4rv1reCaDacCwPTssLHd423sWpXLaZGE8CmTI2o/PSCaGrPl3IL2MX+PtcABx+MKLt
         QXFw==
X-Forwarded-Encrypted: i=1; AJvYcCX3LeREI0wGFNPVAqln3875edoe6T0ABnW/qxWO7fwgG+3kpgYvaHFc/NHbCA87FALZVkifDOYMIJR36A8kNMThV2Wyog1gHYKP/dmZ3cIVhrFbQ0QTOPhRLND4UwpUkmezGm5Ccatr
X-Gm-Message-State: AOJu0YyHm+hCP69vBFhZhPk6mQs0Nd07E3DGFZ//So5BMq2ImtByJKxH
	lsONq4cYNaPLfTaBfr0PWkUQj7YLQJlx3oCYit9ZG83Q7wyhi+it
X-Google-Smtp-Source: AGHT+IH/LQXeUC7pFtKeeRS2rtzMYDPJSU9Ax7XbndFCMl1XBzapzfLwdwcEsR0jw0ixf0VevaId3A==
X-Received: by 2002:a17:902:780d:b0:1e0:ac80:5709 with SMTP id p13-20020a170902780d00b001e0ac805709mr3855535pll.48.1711770228232;
        Fri, 29 Mar 2024 20:43:48 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:ba1:cc2b:c45f:1699:a1c3? ([2600:8802:b00:ba1:cc2b:c45f:1699:a1c3])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001e07fe2fc30sm4199380plg.272.2024.03.29.20.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 20:43:47 -0700 (PDT)
Message-ID: <46483d7d-f2ab-4a15-af78-4ce1fad151a2@gmail.com>
Date: Fri, 29 Mar 2024 20:43:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 3/5] clk: scmi: Add support for rate change restricted
 clocks
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com,
 vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com,
 quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
 mturquette@baylibre.com, sboyd@kernel.org
References: <20240325210025.1448717-1-cristian.marussi@arm.com>
 <20240325210025.1448717-4-cristian.marussi@arm.com>
Content-Language: en-US
In-Reply-To: <20240325210025.1448717-4-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/03/2024 14:00, Cristian Marussi wrote:
> Some exposed SCMI Clocks could be marked as non-supporting rate changes.
> Configure a clk_ops descriptors which does not provide the rate change
> callbacks for such clocks when registering with CLK framework.
> 
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


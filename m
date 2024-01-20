Return-Path: <linux-kernel+bounces-31641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE298331C7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA0D1B22856
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13380390;
	Sat, 20 Jan 2024 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMHtx0rT"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60F170
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705709938; cv=none; b=tQYlz0FYvm4Ue8xsQQeCRyDf+UhAfOz95mMR39FAkkyHq116+FAWibmM11eF53d59gE6kUpTnUEOHbBsoU6VvJJVjTlcoXDC/eOemZObgk1wW7pj989F4pvsRHlPUQNvBRoGJPv8U2TEAYD3BfrudubzDiQCT4xPmlINpSbdRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705709938; c=relaxed/simple;
	bh=LyeAI+qQE2IergPUXlijX21oItp+LcgeBLbUX2TWJPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0Yd53aHJX20N3/Vt6vMSuBjI1hzng1EBj4KQrHd/uUyGz5f/0aPXUtCR6dtxg0wUmlgYfGBDgTtKMa9o6XX52h+URsATJZmHZR80CcmdB+LWtk/K5V33Ue4jfc8Kx+TDmySKn2amy0OkkxWPkDl8hPaiMqgrvA1n1K2+b1qfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RMHtx0rT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2e0be86878so448122866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705709935; x=1706314735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHiaewmvGd192j7oLMrBdx9eLq1Ov4nHjJJFxgFP//4=;
        b=RMHtx0rTNC3j0/9U9ENM2WuUK94aWGZZ1T/NGreniGwKHfmBq8DvZOgm/fyRD8YO4T
         OuaTLNveFykEfDF76eyKl0n1cOq5eriJZH+flQJKHSHer9Bt+6XdiwdYMYLzGH9uRVx8
         nsor+OfZffsbzk5a3WNABRBlBrkVvGIvAn3BrAuehzOWSAnwf165qFWjvTkpeUTmfVnt
         +pYRjwfQjrHqsHSjZie+ha6ebVBcOQZ7dHKZKzG2xQXtInb4UH4ckzIgM2xbMemmfXxe
         WOtw4PTGr0VsafPY9HNRPeCGkKXq8ESKBU5wKoiQCPzGffKHj5C+Zby5BkKUaYguLggk
         UM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705709935; x=1706314735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHiaewmvGd192j7oLMrBdx9eLq1Ov4nHjJJFxgFP//4=;
        b=UY9SR7GX8ERbXDLq5lBG7JY1S1E+JptctveY8fDNWwYTjL7QFYH58NXbSdem16bknG
         A2oi/vh5QkmlHG+zuL7/kLNDdn39Vc7//Wvxc12KIPjIZPFbzNSImU/fiBqtKIrnLZ2n
         oZU5qDBltFCII4nE8+Jt8che7AD0BJKUXJgPr59igxsnqlTem63iKCOlIUT7yO75SG7K
         ToJyZHt3ga3pglItknBRJDTk+cftU/eSGAKGN90fEDFBwb2VmbFuMoRHo2GCEZpEyVzM
         0E2WtrMidSEj5sTtLQp3Gvfq6WSIOnB5FjFpxJIGE9cV66V3JJ4N5DmUYQL7LzAHR3NF
         V1jA==
X-Gm-Message-State: AOJu0YxVjgDyKTEZPdXi9uBoAlIYTwefdgImamdS1AV15vuFzZMqIuE2
	A6pO1pRWl4niSUF9thoU1fMkvry7mLcJlxWVhNtKq4K7UhLIuu9IwVctnfD/zwfxEzwpHK3nLkO
	0srg=
X-Google-Smtp-Source: AGHT+IE1M4vSretViXdLCVXDimwICLgLB6Qcy+gkth45GqmA9ZnkpDntz/gnxxeNf5+PLdRXCxQtlg==
X-Received: by 2002:a17:906:7ac6:b0:a2d:9b73:d81d with SMTP id k6-20020a1709067ac600b00a2d9b73d81dmr642512ejo.48.1705709934782;
        Fri, 19 Jan 2024 16:18:54 -0800 (PST)
Received: from [192.168.1.116] (abyl34.neoplus.adsl.tpnet.pl. [83.9.31.34])
        by smtp.gmail.com with ESMTPSA id q8-20020a170906360800b00a2bd52d2a84sm10809442ejb.200.2024.01.19.16.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 16:18:54 -0800 (PST)
Message-ID: <f25d6930-f5a7-4190-a5ee-b1edb0421290@linaro.org>
Date: Sat, 20 Jan 2024 01:18:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: rpmh-rsc: Enhance check for VREG in-flight
 request
To: Maulik Shah <quic_mkshah@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_eberman@quicinc.com, quic_collinsd@quicinc.com, quic_lsrao@quicinc.com
References: <20240119-rpmh-rsc-fixes-v2-1-e42c0a9e36f0@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240119-rpmh-rsc-fixes-v2-1-e42c0a9e36f0@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/19/24 09:26, Maulik Shah wrote:
> Each RPMh VREG accelerator resource has 3 or 4 contiguous 4-byte aligned
> addresses associated with it. These control voltage, enable state, mode,
> and in legacy targets, voltage headroom. The current in-flight request
> checking logic looks for exact address matches. Requests for different
> addresses of the same RPMh resource as thus not detected as in-flight.
> 
> Enhance the in-flight request check for VREG requests by ignoring the
> address offset. This ensures that only one request is allowed to be
> in-flight for a given VREG resource. This is needed to avoid scenarios
> where request commands are carried out by RPMh hardware out-of-order
> leading to LDO regulator over-current protection triggering.
> 
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

As others have pointed out, a fixes: would be in order.

If you're going to resend, please name the enum but no biggie

Konrad


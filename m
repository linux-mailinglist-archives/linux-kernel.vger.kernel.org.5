Return-Path: <linux-kernel+bounces-99693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D555878BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01CA2824D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717F3749C;
	Tue, 12 Mar 2024 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2uEYH5k"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1424613C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202519; cv=none; b=C9vrYvp65pLjFLvuLxR/SMFQ1J2EQ1PpWclQ4OLkz5thbHpxwz2FWI0GOkzvunqqDthw4kEwPsxEKTcsT73py9mHxU0IHNni4FtUzg1bz5Kn49d/0ffImq+SDy+umLSMi0YwLh7U6huc+l3uAn+3Ts6YDnXP8fdEEmD6EC0vZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202519; c=relaxed/simple;
	bh=rITI8OESR753/vefQ3L3VFR8tWQjBHYPqjT7mS4NSjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIzqqSamsaNbrX3ruH6EVS1rMGf0UODZXxubodthRcsfpFzxkNYWYQ9/P+RsiOKMS0liGFhlQRShKolsxirDseIYVMz3OzUxS2ZAlSlnafkJ+maKqkT6r2JPpIBtYE/z2u0NjXFm1WqsVbrFT+Ocxbsh6a6h1xw5N2ImrcYZlGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q2uEYH5k; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5135e8262e4so5472016e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710202516; x=1710807316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Qkp8yJOuOQf9llDA8dXhEpB/c4pbLigp+bR+rYBnmE=;
        b=q2uEYH5kE+xxF+eFoeiobBa7CWEtD57BSnYDvdKlsAivDV2uKbNiYybYmCN8ui0G1x
         0TJ3KfC6r+bk7MDutGtyVwMFPHMMvwrrak+n7yga0tHEaFUAR98hpnm64W8bAZDL7CmJ
         /JOghlnzWhZw8E+oHnya9FfLaJP2V6jyWueNMgrLhSISDjDfpqySeg4zNX+MV8njWueb
         /IRqhMyVmmLKHrXDWaVMEjXT2VraGSOkdbKxmbMLFFjQLY8YrK6yfptwW9ZpEckjwlPY
         5LD849BDHBj8VsJhMLUmNcRkDMwJDDf8JwUOgNcS/bfmsAXjONI1/0U4mMBuOsaHSt8X
         2QDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710202516; x=1710807316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Qkp8yJOuOQf9llDA8dXhEpB/c4pbLigp+bR+rYBnmE=;
        b=KQFA2ngNza826CtwXlH5KwEtdP64Wl6KomGqLtNX6NQJYUGjvL71pam3krRJ7lrc/y
         wPVuxy050qe/rv7QV5WNr5Qb04tEfpuLo7sDlT0U/DP86F/isdU77FKpQE4wvotv7PDQ
         kes1U4E1jbyiw7aEt99PW7TfsG2xv7R2mRhKX/lzdTMCciVL/nvano6ewBBrDJVb4wXG
         TmI3S12nwpSYRMlYsQfWk5bMKQk4YtSyhcCabFCOVM0+gKsP95BS3V2w1sY0nHnOBtlf
         mhBFMhzAxlj+1zAzMFu7u24kw4+HmTcHEHouPml8sh72w6/WMkcpe66q7tW/RTi+i/v5
         49RA==
X-Forwarded-Encrypted: i=1; AJvYcCU0JcpPFz5IxQubUaA2zG37tv7VCSUiDsIHNp6wKk8drB+5Sfa8RKdyTFWcAfQKC3gOi/2tTj2VxbCYrdAOd3xLslt1HSs9KIp9GEM/
X-Gm-Message-State: AOJu0YzXZSK+Ihp9jrLBF7yNsj/eKwjriS7MElxrqd4CUqaxBgoBkrGO
	FO9fnMzTkneOryHCfV9o8W9AmduI0ERxyYaBr2w88FtOscA/UnHvpIziPauMpCk=
X-Google-Smtp-Source: AGHT+IEomKQ5UiV5kQrHnD4DnrPNCZy0DNRdIj4/L9aS6kAWvKFL4YQPwyqHTl77dD2YfiSgXyy0jA==
X-Received: by 2002:a05:6512:3456:b0:512:da79:91a with SMTP id j22-20020a056512345600b00512da79091amr4367597lfr.46.1710202515734;
        Mon, 11 Mar 2024 17:15:15 -0700 (PDT)
Received: from [172.30.205.61] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t22-20020a195f16000000b00513a7962930sm807970lfb.89.2024.03.11.17.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 17:15:15 -0700 (PDT)
Message-ID: <6efba698-b9b7-41bf-84e3-849da99db45f@linaro.org>
Date: Tue, 12 Mar 2024 01:15:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] slimbus: qcom-ngd-ctrl: Reduce auto suspend delay
Content-Language: en-US
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andersson@kernel.org,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
 quic_anupkulk@quicinc.com, quic_cchiluve@quicinc.com
References: <20240308124129.7833-1-quic_vdadhani@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240308124129.7833-1-quic_vdadhani@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/8/24 13:41, Viken Dadhaniya wrote:
> Currently we have auto suspend delay of 1s which is
> very high and it takes long time to driver for runtime
> suspend after use case is done.
> 
> Hence to optimize runtime PM ops, reduce auto suspend
> delay to 100ms.
> 
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


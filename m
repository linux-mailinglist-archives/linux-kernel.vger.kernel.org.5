Return-Path: <linux-kernel+bounces-93853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1536F8735B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05F31F23291
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D1B7FBAC;
	Wed,  6 Mar 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJAmKDuE"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CF7F7E1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709725226; cv=none; b=IAH585j9HuGXVYxsPP2j9XIlEjE9AgjHtCKcEoG0ENO84dQcibhi03F15c8+CM3YmG4ZLr2GX7tArg+nKIa8vwuGKmsw0fLCFzxVYHXvYjCG3nDaR6skeS2vXIQdOd1UNptc/2NNLX3bmIgGUyh0aB0RdGbbbSj4CByeGc05B0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709725226; c=relaxed/simple;
	bh=MyDgk4afHvneJK/AGrdFnLoUjc8Ck2lGA49YcoT+rSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiGcIPlSUwRl+BZ5Sj92r2d3+PZnusdDc4LdWjjOdcQvhESE4SHWbNcAhPH1Ba8KMOxWKGPgRIqN4QBCIRW7hhzn8tenaWzgcaQl1vK9121kugWqk9E/v3ggWo3h5kVHjtYp0ZNhgsRI+9xgKQMAXe5gZe2DC/YgBIgmb4rfXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJAmKDuE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e570ef661so250096f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 03:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709725221; x=1710330021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHsDLu11BhsOOu7vOLh5O5SoeXOiXHoKRCejG9ZhGdU=;
        b=QJAmKDuERm1ib9JzNKOyPSUapuNp3s9GUwU9YQCqHSOXDu7EZHAUu+sckFQsE4dhfQ
         uvkoM0pQG9YHwMHeroF8pLutTQw4At3bHv/RRoas2NwEMIQzYhE1IWnvKB9asMA4BxML
         O3JLGql1Zs1riHUhK79LcfrMHbDs0/ryL1xMTUk1lLCW+GaBOkbyNEYJuK8ek36/y5fA
         LcQN5nRj731LQssULqeN0qHzFFvar2NKz9xTMkkn+lO7JAewe332+3BgSo3zpTU8WFff
         juvqxPigTkcuNEYCbOefSuKsS8lENM5N4cGcxyslkTSdt6wz2+OtktqXoEPxXq7mqMJo
         79yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709725221; x=1710330021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHsDLu11BhsOOu7vOLh5O5SoeXOiXHoKRCejG9ZhGdU=;
        b=bP2sQeqe9xtXAeEbw4HGWSt/D65OirUHCjVepJ9w1UvwwsdShde3EfTtPWl8Ud4Eis
         YwZ+UMKT9BgBuYgbdIzPsP9pxig2sysQR/k56MYMizxEMq454PEYAuxa1dCGwBjFW8mS
         HNVecC+wEwcvf8rTsV1w5riko2AHVWgl60p7QB4j1sLcQU9HzeYFu+lCMUBBV0vGe73A
         3QniHGQdhK0fIdGlhKvL0vwTVedkgrrsqPiyYUgLUmEwdAVuu0io2TnAmH7a1DLrCR+3
         flR2YitQWQnvYexjkIJWzlDIwoYScy5QlXIBSl+aDnRMFDrWwQRBxbuB6+HxxqRwHuWV
         RXlA==
X-Forwarded-Encrypted: i=1; AJvYcCW3/BSYuoBSi0w+URd4a5ZGwRh6aASu1v/ELQMg6GktSrwRg8QpMpAE8WwTREHQZmuAET3jtMY5R33TAxnzdRPT9+fbkXCGscryrjPz
X-Gm-Message-State: AOJu0YzlW1j8Zw8cy9ZP+1cyloMNvuMDnrVDAaZ+u8Uylg6uxKpmOMOp
	WWL44YYwvwLJL3yeF2i0entb2qzFlCMgEcekipfqJSlySKeGCf9jwN/baHVkIcA=
X-Google-Smtp-Source: AGHT+IGalMQM+1/5hflu9r2698/GCRP0X8SJOvsj+Y+8YnI4kUwo+Wi3TKvJOHm5HSN/ZO1xW0c84g==
X-Received: by 2002:adf:fb8c:0:b0:33e:24c7:78ba with SMTP id a12-20020adffb8c000000b0033e24c778bamr10175310wrr.62.1709725221439;
        Wed, 06 Mar 2024 03:40:21 -0800 (PST)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id bq26-20020a5d5a1a000000b0033e2777f313sm12519582wrb.72.2024.03.06.03.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 03:40:21 -0800 (PST)
Message-ID: <d63a573f-1ec5-4b4c-b3e0-29c46828381e@linaro.org>
Date: Wed, 6 Mar 2024 11:40:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: venus: avoid multiple core dumps
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1709704406-22501-1-git-send-email-quic_dikshita@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1709704406-22501-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2024 05:53, Dikshita Agarwal wrote:
> Core dump is generated whenever there is system error reported
> by firmware. Right now, multiple such dumps are generated if
> recovery fails in first attempt, since the sys error handler is
> invoked again for every failed recovery.
> To avoid it, add conditional check to generate core dump only
> once during every system error notification from firmware.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---

 From my non-filter mail addr

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>



Return-Path: <linux-kernel+bounces-60523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7275850610
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6E6B24068
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41315F56D;
	Sat, 10 Feb 2024 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Md2XEQjR"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A75F549
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707592295; cv=none; b=SdWfnq08RWN7Gl78/2R2Tbzvb9Mend4S9cAbaHH/nQk5fBDVwoH1i6GaWThMhPqq9VghaBo19ChDfy/FBCizN6dMAWXFoETuR7DcGUxaDJjxjB11Rwx/D6Ff3gQFHW/IBxybjMy9u9kAu3Bo4KNqtU+fnFBF+29Ht0ZfZ+3sVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707592295; c=relaxed/simple;
	bh=x1GVwGorkcxO3IafmVnsCPl7EfeQZAKgg116i67uWXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ck+M4TItzlYv0IysYTt9c0ChJmIpl4oTQplf+Iub1l1964pOUWQzKkJTxZ17Of0MQSPXD0X5hDzfCT4eEREqlXvsz1GbAivu+sJYK6Wh7hIzaKZMtytGN8L9uNQtiHPCdkMRBLO0GTPk5azAT8K96Yuw7YlUMjoGmeakqctHluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Md2XEQjR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3c3be8c988so48248666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707592290; x=1708197090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LEw2EnFXzQVU2p0mkCDlT1t0pyChlA/M+u/ewTeLVg8=;
        b=Md2XEQjRapgSam1RkndwtnhBIv3IzIxZbgnC0YMxB+jcEEFtTgf5TE0OMNTSI2JuJo
         racZVqE0L8xlygRZp24y7jq//YWoPoBPRaYJ+f5z5IxexF80XGsw221ofW335/mn03gU
         cXuzf4/pFgkZ+0MpKmW4Srtm/0VJgk6HEG+TQQEK+nthppjoEsczu+0xpoOvV7fea6I7
         VE795PiSP6a2tO/v+Cz9OvDcLlM8LEycyvnJW/phATcQhSIweORRYivp7ZiR/XCTTUnt
         NbkcRLzWO/pTRYo4WS7eHXUasK9bjnUsAukIMYE5BPa9z+9FRl+vcYAzThqt62a9Gqk2
         tOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707592290; x=1708197090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEw2EnFXzQVU2p0mkCDlT1t0pyChlA/M+u/ewTeLVg8=;
        b=XYbEY5kq8GZ3kf8wJffJGuSyktH39buSvL1QDYUTO6Fjr0Tc33bKljlvKCczbmE19J
         Rm1gr6/q8Km7Dv2W+teRtegpY4//c4umv9oRcLp+22wv+FoC1vY9FdPkQa1KWin5wg8F
         oRYrgmgnhtNTsfhaujiA5IzCsAD25qdVOwb8A/NYDuPQpphE8jP7SPjP3ChLJwIPcBrB
         i1q0aLtxfAK2jeVjW+mqZjsq2QL5MnE2JtgtCRSEpcjFCrBJ3uZCf3y3ESFekihxjMG6
         6ByBthgri+qS8exNL/+9CYHOKN1WOT8t4OlGuO9+9CVv4/b+GXTiPyUSDR4xFIqw1JCh
         96CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWV3qgxI10CS7GItQ/YeGGHZFWX1h0hOcSfbfaahcAwV8hMX9+ywTGOvEcVZwAqZ7WVrLscBTLdluNeorB7z0gs8uzHNkHXIzqzVJW
X-Gm-Message-State: AOJu0YyISdkOt3cq30uV5A8VW44kKoWWScBxJqus+nMbpv5MG0Xuit+Z
	X+IF7yRijSCj4ZdUHQ1RYIJfWSPxuwBNAi3V/G0mpo4iOH6BLn7LcyMSHZlX0Gg=
X-Google-Smtp-Source: AGHT+IFQ1p9zAgzQOUSwl5Ea/XO5538HhUhx2MIaN+c3CTo0bUpLvWYiCGb3EOZeubpmv7KdMb4Lpw==
X-Received: by 2002:a17:906:552:b0:a38:a174:1316 with SMTP id k18-20020a170906055200b00a38a1741316mr1910684eja.72.1707592289981;
        Sat, 10 Feb 2024 11:11:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiJrRAZbBqUDXJFWpkO0i+fsugtySrXkHVf/nkA66ymTNKN+pAUOFFjIqOwqSQrW4Oo/XrD4oJrk57DYMRjQC+gnbAQEvqZjIIveR9HzZw0qPE8I3EPPVIa2TT+7Di84fhT15I3NWIyknWFqblVVNW213nWW9x4j/KrKlhmx4QHbsMa+cYuiSnJB5MzR49nEC89AC1sIdBOROAko1SAoyG8tJdKkbW3njeLWpbPKKlAGYVsO0oesYed7a16kvV7/FPvplr8xO9Y+ud97ZONsUCfPNRnRcjpcfYiUi4QiDiKennm/kYxlyVZrPue9azFrCtZyn9pa9OsDe+oiu6TUf2nplRKErDDzCFzIKTUWCQJ6vl0vYg95nNyX3Sqb42puIfs6Kw6V6VQPFbf/wd11a54EwCpMGlM6dLQvxx
Received: from [192.168.1.116] (abyl12.neoplus.adsl.tpnet.pl. [83.9.31.12])
        by smtp.gmail.com with ESMTPSA id sf5-20020a1709078a8500b00a3bf0ab3f2bsm1789963ejc.21.2024.02.10.11.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 11:11:29 -0800 (PST)
Message-ID: <9e1d7e08-ed17-4876-91df-f05529184e58@linaro.org>
Date: Sat, 10 Feb 2024 20:11:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ARM: dts: qcom: msm8226: Sort and clean up nodes
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Matti_Lehtim=C3=A4ki?=
 <matti.lehtimaki@gmail.com>
References: <20240210-msm8226-cpu-v2-0-5d9cb4c35204@z3ntu.xyz>
 <20240210-msm8226-cpu-v2-2-5d9cb4c35204@z3ntu.xyz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240210-msm8226-cpu-v2-2-5d9cb4c35204@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/10/24 17:28, Luca Weiss wrote:
> From: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> 
> Quite a few nodes haven't been sorted correctly by reg, so let's do this
> now so that future nodes can be added at the correct place.
> 
> Also at the same time, move the status property last.
> 
> No functional change intended.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> [luca: add more text to commit message]
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Due to the nature of this change, it's hard to thoroughly review,
but nothing screams nuclear breakage, so:

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


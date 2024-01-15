Return-Path: <linux-kernel+bounces-26355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B2D82DEF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674C01C21FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CADF182AE;
	Mon, 15 Jan 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PoYl0srb"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C800182A1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55965fd00aeso879669a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705342636; x=1705947436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONrJRmAYGOIocV1TaXZm7gL7rutvMwXPfE4iqEwyFPc=;
        b=PoYl0srbD9EFyvr4gPlCs3zNyvhlcNPxSKQhHFDrOEBP9P1OKm/qtamajDO9M4E55G
         XkdWcoW2y3J/qKN0TJjc0Ce4IU0N1e09qA+EOlTQfMGVqlT8+PjiEUFuAgGvdetIKRCi
         tcmG3Bwcdr/1sSh1Fvu+Ny0a2ujKuDlikbqAN5Pj5oqdZr5dmQmLThCdPfTlGAMBrxSA
         wM2emdhDQujxF9lgDQWFigntUGCFtTT1e4WAA/m9XmeS+HShoBtwBAO1EZSMAQjk4oRf
         l2LzJpQuJskXy3OIiW4+rd+PgRL2n6swaazIHEn2BSyEIGq5LxX1Wn08BSkbUrIVIRMB
         EOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705342636; x=1705947436;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONrJRmAYGOIocV1TaXZm7gL7rutvMwXPfE4iqEwyFPc=;
        b=DdvImCcqnUSdxgjrFtbVRRm5PWU7TfMAjoGigAexL/JhfdqGoBDVlbCUhZeuTNr8Z0
         cQOI/YUsDBFoR2PZQvQpVIVx/wPoFjzJ89P7AnmNSSah5DaWeVZvaGpJCrjFAq7FMLLa
         yaOZRMwhb5mzzwJAOWg2AaW5BFw8FcgiBN4dvJLLzJdo51IVQ/CLsI59fiuKGC6icjws
         uiOvGm/oQbxlHjBl+ZlvTE2wBFFQglVz8mZFOH9eSoO+xRZIxDET3MZhv77wJhUeNXtD
         +fBU25+kW3SsS+snw0CnF2qTqD7s+xlwDrNsFJXlAxhZpxdH9OtdXpftSzfP3GcCtZCM
         0Jlw==
X-Gm-Message-State: AOJu0Yy8pVQVFNqewi5z+NyRkXRxpeZo1p3PMjWcOr15EVTzsQpiZGcw
	iaCTDO4AcJ10adXq4WXyA/SOyNEfSkSsVca/1Dh8wIvPLrw=
X-Google-Smtp-Source: AGHT+IHkcc7u1FWPuYceUCKz3DBIl/vUsuKPMumLJC1NjafJoIlnGoXR9vhME8swkxJukn0sQnu3PA==
X-Received: by 2002:aa7:c513:0:b0:557:fe5:a682 with SMTP id o19-20020aa7c513000000b005570fe5a682mr2767954edq.80.1705342636527;
        Mon, 15 Jan 2024 10:17:16 -0800 (PST)
Received: from [192.168.174.25] (178235179017.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.17])
        by smtp.gmail.com with ESMTPSA id es18-20020a056402381200b00554b1d1a934sm5708181edb.27.2024.01.15.10.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 10:17:16 -0800 (PST)
Message-ID: <93bc06a3-8af9-4d50-bfee-d54e04bade51@linaro.org>
Date: Mon, 15 Jan 2024 19:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: sm8450: Revert "interconnect: qcom:
 sm8450: Enable sync_state"
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240115153420.1525037-1-krzysztof.kozlowski@linaro.org>
 <201733c1-dc24-4d77-9967-f52c8e81d35b@kernel.org>
 <96928df4-75ca-4a55-829b-b8ab0583e3b5@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <96928df4-75ca-4a55-829b-b8ab0583e3b5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.01.2024 18:59, Krzysztof Kozlowski wrote:
> On 15/01/2024 17:44, Georgi Djakov wrote:
>> On 15.01.24 17:34, Krzysztof Kozlowski wrote:
>>> Revert commit 16862f1b2110 ("interconnect: qcom: sm8450: Enable
>>> sync_state"), because it causes serial console to corrupt, later freeze
>>> and become either entirely corrupted or only print without accepting any
>>> input.
>>
>> Sounds like some driver is not requesting bandwidth and is relying on
>> bandwidth requests made by other drivers. Maybe we are missing some
>> "interconnects" property in DT?
> 
> Yes, the debug UART (console) misses the interconnects. They could be
> added but it does not change the fact that console is broken since v6.6
> and this was probably never tested on actual hardware :/

This patch? I definitely tested it out on a headless remote board..

Konrad


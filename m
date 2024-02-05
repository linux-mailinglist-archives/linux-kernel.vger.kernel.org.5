Return-Path: <linux-kernel+bounces-52877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD05849DB7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29371C22BE5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE592C6AE;
	Mon,  5 Feb 2024 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwrnDPvR"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F02CCB3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145861; cv=none; b=kV69+Nh0iK44uIdUxoUY5wZMnBvnItVkGRAsjmwdQg2aE0YddNrY9wB1+YJsR1iXKjUM4DpGrepO/pliGnAiruZ4ATnjaxpevJkN1Ku5Ac8n2/526HelQ4Xbj84N6lkt4WmVplTZQMcMzpEjdldFqsBiyOOOUZ2hrUtgn26bpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145861; c=relaxed/simple;
	bh=ppafPnnOXTKF4WNgG23A3R+Hsm2QX9c+PaNn5OWONhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sf8H0Rp5rwN4qJGgozlU1pxxNj4+L4Z4rXAvtJBqmN6uLykPzRc42+eKkcR99KAGe2NYpwQ6yOib+qTkiZw9xtezqu9w2SLac6LoMOddOCiAO/C2cDs/0R+V/c6brqi6wRoE4tYcZuHtoSZRAvLwyQrJoW2uSsqqaOf4cFYDgyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kwrnDPvR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fc549ab9bso28635315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707145858; x=1707750658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppafPnnOXTKF4WNgG23A3R+Hsm2QX9c+PaNn5OWONhY=;
        b=kwrnDPvRLl4xf3uwUTL9AWYhawUlTBz2IV/vuEWvsEt27ftSmVnLExAEG7JhcIBBqE
         hGG759R/lQmdsjyp+nW16ODb1H2Lf0l3HCQKsq4PI6VEHIMnuuOoNbTXaZ/hOIDwpKMV
         6stZwvNvdpdM7CS2Xnmkz7RZYqdj6cy8djyz0GOvtfvro+KFjTCCP8dgaNsBBMt8Wxz7
         3MkJs0nir+EQQ6XZQWaXzZBCxgcMdyeuGg0BfKnIjWFUo4QESJJbu0k5O+/n6L4RQuNA
         nB2jLWqIMdvbdzlkKBBO+Es486qVj9pd5uOCkVEntDKbUae45OY/lsOvKY5AiiD2C2Xi
         Mesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707145858; x=1707750658;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppafPnnOXTKF4WNgG23A3R+Hsm2QX9c+PaNn5OWONhY=;
        b=FOZpoV0DguA1g1J2uXQ+6UAyLzH7r9m6aRr4bQD3T7HZoPAyoFfGMHYf+M1nqCmKVc
         81/ABP1+bjxABPjvUbYkhXaoFgPRF3Qz/PUdcY5+V/aJ6S0StEcisOTiyUJ3HgREjAHn
         Nt8+9/GVzfMisGBgJ9pttwkA3JzKH9UDDsAqGBCzQFFOItBRj0szGUbBHbhPGRxmwYwP
         h4fYBSbg/OwGzmSNwI1yZzEe1EtmjB/wUVHp1cq4wqyCJ8ngo1RARQ/1nyTzu8UzS4Qh
         tA/cLsPLB4jMIRno+sGJsC/4JIQzLAPTU+090ZU/XhGbrtA1FGBFr1wD+n0oYgzrbu8v
         Coyw==
X-Gm-Message-State: AOJu0YxPg2MajBHxjTUYwP++3bvkXdL/WxUMAI+l+MTxmWyBwd1oKh2h
	qAEEDTcxTsn9hPmOUGt3gKY+Oa/ADFMKJHiDWJ0E/Q3RfHanQX8VBqhOhKZFR34=
X-Google-Smtp-Source: AGHT+IFR+ntRNEzktx1JW9F/V8n1MZ93h5DpWrLgZe6VWC8JG8Vu7Bm8IYjFO4WiB8PFfnjYGSicoA==
X-Received: by 2002:a05:600c:4ed1:b0:40f:c36f:3ce5 with SMTP id g17-20020a05600c4ed100b0040fc36f3ce5mr60479wmq.16.1707145858025;
        Mon, 05 Feb 2024 07:10:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUL1DUFYJBq4oal4xFzD19ftjN794L0XENkmCFonim5378wWJaciEdig2mVQh4Ef9ondBL6uy2zu3zMc8dfGbyaMhPvtK3ppR/k5Xs6yEYVOp6NIm4auCu+m3uOUOwxI5qghzXIs0uL1unF5iJ63fzbMacrc/FBpejZMnR/iWqaFFvGgaXoc+Hhstw8kEpuT4yhFRZAEGgjgkxZiQrdwsNNQAqEQ9MkpVzGErrV9I4fLGnZGHNnI1soTWWJGrmuRAPWKAf0bw5QJO5ne0Dutxv+qNoJvzfsDLvh42zt+Q/KvNjs3yS+RfJb214/Jp1/tIb+A/RrSmNE+CehNIPpWlZa550JBQoQgpf7LLGv2oRtlaJJkNVO5LiVnsM4KP8AxuI0VLNnLtow
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b0040fb0193565sm8777767wmq.29.2024.02.05.07.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 07:10:57 -0800 (PST)
Message-ID: <e473937e-2d8e-47e3-bffd-025b87769335@linaro.org>
Date: Mon, 5 Feb 2024 16:10:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dt-bindings: interconnect: add clock property to
 configure QoS on SC7280
Content-Language: en-US
To: Odelu Kukatla <quic_okukatla@quicinc.com>, djakov@kernel.org
Cc: rafael@kernel.org, corbet@lwn.net, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_viveka@quicinc.com, peterz@infradead.org, quic_mdtipton@quicinc.com,
 linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org
References: <20240205145606.16936-1-quic_okukatla@quicinc.com>
 <20240205145606.16936-4-quic_okukatla@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240205145606.16936-4-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 15:56, Odelu Kukatla wrote:
> Added clock property to enable clocks required for accessing
> qos registers.

I have no idea how you came up with that CC list. It makes no sense.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline), work on fork of kernel
(don't, instead use mainline) or you ignore some maintainers (really
don't). Just use b4 and everything should be fine, although remember
about `b4 prep --auto-to-cc` if you added new patches to the patchset.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries. Tomorrow.

Best regards,
Krzysztof



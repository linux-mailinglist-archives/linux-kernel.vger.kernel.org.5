Return-Path: <linux-kernel+bounces-29176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D2B830A17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216A71F24C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509CC21A1A;
	Wed, 17 Jan 2024 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHiRt8Mb"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245CB22304
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506885; cv=none; b=BcOOXpnNK5NCLEISG+nKsmnAmw50gFw/IrbBOq4tdq9Wdf43IjqWV/XR3dlGxAbi7WJvbf8dLF1sBfc9OY4fZ2ssWR/VxRqmO+UvTkw5K9utglA8bv7P+sB6Ujby1J5tkAnfDFLLhxdLRnsNvVFs9SSjyUxJL8iS3BzI0+nVRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506885; c=relaxed/simple;
	bh=49vf+BpN/oETUapYPVcYitq7u/0YiGOHDP9V1nj0+yo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=qu/sba6ngPaAKhnUFlC5OP0leAAehOB/S+N64+tt5pYTip+QUo6brench/1FF4TGyZuOZMpwStM4z+vagGO9jXUOPZq77le/wxsbBbgrWIaJirGobi6cnZDvU5EYuwKdZ0x7FIOV68Pa7H9s0S6AuCMdT+nHwgUUHujffnbmqcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uHiRt8Mb; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-559b3ee02adso2311506a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705506882; x=1706111682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49vf+BpN/oETUapYPVcYitq7u/0YiGOHDP9V1nj0+yo=;
        b=uHiRt8MbYh8mhnsUxVrjOKlF2cY5eGgjmqLzvPT8hPOnETN2S3/7S+btFTsZmO3nH1
         6wwi4ceGW17K4ZhKIinIM/VvjH0vXMhCc8EljU5p2aQ0FziivJ+XCiW4VPFL65QR1dvx
         SHP1tp56XGtcUHYf/GJYgk9RfOpOEQPC9P07SuEkLrzDYukZ7Onz8sPjA+1UGDHLxZXn
         rug4DS9Y9jJa4APUWCkpSFoAOdmeacRz1Zu0TaStv/ocM6kvb72gHv42A84ppT4jwvbD
         RdJiGj66b9+Vd6G3i/L7z7+/KoaFRzoz58Uj2hdP6DBqS3RLuAsEetfDdz+fKGJT60Jg
         zcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705506882; x=1706111682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49vf+BpN/oETUapYPVcYitq7u/0YiGOHDP9V1nj0+yo=;
        b=QRHCRLH2JCt1jy0ehkxalpaIdHDC23ygwmU5zPlKpMQrwCJ3r/EBf/xHjmk/5wZjXu
         qAYbIdwB1izTj+eFi+wf2yZuW3mShARA3hMIvvKNQlxwsOf9Ji7+R+0Mwb7V2sNjtIH5
         E3wt+03IoNMJX3U5HPXKImcHYrEKxgJkLczE03PPMo/1o4Pc82fqUBJsAnofHd+E4p5j
         zGa5/kIZUYd53pgbgkQZx6iQFNsZjyK7WT8xca0AHNcamaiovLOeFv2oqguWoUnsYUZ1
         era3MHDgz1aVkcYLX/fgn9UThsPlfRzGYmOLD9KU+qK6pl/I5c/KFyL9NwGw7WZl6/mx
         0xdQ==
X-Gm-Message-State: AOJu0Yyo9nvWDfPR2TuJrXVxc8J8QrRY+d9pW3qZ2oq7pdVto1JN8mCZ
	b2mpZA4g1KRsFk30Yi3ZqnlF1JMmuE39dQ==
X-Google-Smtp-Source: AGHT+IGye7pbtQWvVfDwC7ZW36CQBQuuWLcxa1MEUgj6X5ZSj80Wvx9AMAf4VkoIMk+v2cfW+8ihVQ==
X-Received: by 2002:a05:6402:3134:b0:559:52a0:f5dc with SMTP id dd20-20020a056402313400b0055952a0f5dcmr1835531edb.69.1705506882411;
        Wed, 17 Jan 2024 07:54:42 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id ez6-20020a056402450600b0055803202e83sm8262579edb.67.2024.01.17.07.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 07:54:42 -0800 (PST)
Message-ID: <97c3579d-d6e3-475f-9f90-d4a2b3e25e86@linaro.org>
Date: Wed, 17 Jan 2024 15:54:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] tty: serial: samsung: make max_count unsigned int
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
 <20240110102102.61587-11-tudor.ambarus@linaro.org>
 <CAPLW+4=YYdUSaaLcsdEyPswC4s6onxuSh24vSfw4xys=sPZG_Q@mail.gmail.com>
 <b21a54a7-fe13-4a29-8e7e-6b653d5c24ef@linaro.org>
 <026bdf502c0af8260c67a7a851562633a6976031.camel@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <026bdf502c0af8260c67a7a851562633a6976031.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/17/24 15:38, André Draszik wrote:
>>>> +       unsigned int max_count = port->fifosize;
>>> What if port->fifosize is 0? Then this code below:
>>>
>>>     while (max_count-- > 0) {
>>>
>>> would cause int overflow, if max_count is unsigned?
>>>
>> good catch, Sam!
> Does it matter, though? As this is a post-decrement, the test is done first, and the
> decrement after. Therefore, it'll still bail out as expected.

Indeed, it doesn't. This reminds me of stop replying to emails at the
end of the day :)

Cheers Andre'!
ta


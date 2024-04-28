Return-Path: <linux-kernel+bounces-161519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062B38B4D1C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720B81F21330
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C57673186;
	Sun, 28 Apr 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwpYUXkH"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7F71B27;
	Sun, 28 Apr 2024 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714324733; cv=none; b=rrwXk4yMQUzKrGL1EruPaSgYiSA0fYZB14Z7A+65m+rY0g0bxrdNaY1U8b/7oD7WYzFVlEGsWOP2nY8YJr3olLjPQsKms0TXQFz78294rLrcZ9lM2fSTvYRk1bvMZ6ShYSiXIzPj59zloZdQkzJnoZo13rqWXYPr87ebnHrSjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714324733; c=relaxed/simple;
	bh=E8P+bkHbMEddRV8cYhQ7kw+Dd6Pw8xqpzDNAuID/0Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sivUvTJjT8a0EU58J+BtvvwLU56TYMf8xOrbp9a4yUFm6lbIlqIOHg0lMdCHwhj+ZfYEw4bxV4v2bPbu/oUBEYHW4+jVD7yZ3zNDDFvmp5gbL/i8l5/WuOHKY1XeeGJV0ecG2bokEAeCXhRMlm29W8Fcnzt+x5HB1yavbj2sCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwpYUXkH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so30452225ad.0;
        Sun, 28 Apr 2024 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714324731; x=1714929531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UHUba6V496I/K3cWcCSbioVSdP6oVYCTNJacSRr6P9s=;
        b=DwpYUXkH+FQnxJ5J0KFoXz4jS2PjE4sR29wCAjjTmes3bNqZf/aiIX3q4TvSPbab8J
         FWRlnpult2Kq0nwgiZh+5ZDaPSku/6QijHPt29Aao3h8ENgPCqrelrrLwWNq0Rl5HGnC
         P+s0yU9ZO3DdDN7IdSRCRs1dDyp6qSSWyR8dbvUMIg79AFdUg5aG1dPofVnlwx3fBGaz
         BlMkDi/xzhqCkMs7eLfTDrfONK3cMx8ruXdMa066AjG4ZZBjx4iiZwIiuMeLD5WDVJh4
         eDtwwAc87qJQeBj0fr/Lw50m+sPPtqIC3bNwEo8rz3nimhDXvMNovt520lC5bmCTAUei
         h8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714324731; x=1714929531;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHUba6V496I/K3cWcCSbioVSdP6oVYCTNJacSRr6P9s=;
        b=oMskvp3Kv3pe4ZkE1M7ScgVAcIrU7rdLtKrbw4jFcIPZyjy0d3ub4D4weeInFoQbr+
         7NbNu8K12eu47qp0y5wyeXYycMa1kVq2jRE1Bob3wl4fFX2wEZ31Q9fPy+iIBBzhdlzD
         QnXYn5H1yAdoe1k6uufIVjOOQMY/jEP5KTG+vqDT16zxzqqrqlX1vd/AW3Qc3sT3OkE3
         J22eNTysWQ6VLveiEJY8WD8jznYgL9wUbgopjLNLFhe1nZ1uoshD/Uz1ONsW8PLGXGxu
         KODJzqll2aB50ewDkRiCepEPLq8dzki/G+DKxthAmWp27u8DnswcYpVci+cc+lQY/+dG
         /FAw==
X-Forwarded-Encrypted: i=1; AJvYcCVbjLxJb13Q5CHYnPwSfOX6iSUrwzWJSK77bp6fd5JjXL73b46MCRJEB45jLxLjD4EPYAdWmrHQWaaY44snbwSCseP54kHW9BVFmDvyHTzbOWFpLmMe2Zok3MnQZ4krTPu+9NjYysO0qUM=
X-Gm-Message-State: AOJu0YzFOvTQA2Ci0AV7TCOQPAtbhJm+tindrGATebo81vdQoVRSlFY3
	N7X5/2Z7v9JzfnBKnx/uvzbH1CyPt0yTLDVMSj+NKml2PTgjS7rtZag5VA==
X-Google-Smtp-Source: AGHT+IF7gdqLf+Wjk7Q8MZ+9UI+wq9phmkO533KwX+aA2uSGs34GHyMqGT06FLC5GvzFBddmx1zFhQ==
X-Received: by 2002:a17:902:e549:b0:1e0:bc64:a37a with SMTP id n9-20020a170902e54900b001e0bc64a37amr7432859plf.8.1714324731195;
        Sun, 28 Apr 2024 10:18:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001dd82855d47sm18659041plq.265.2024.04.28.10.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 10:18:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6d779d5b-b622-4e20-9449-64307b9b9582@roeck-us.net>
Date: Sun, 28 Apr 2024 10:18:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hwmon (max6639): Use regmap
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de,
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <65607114-89f8-4f48-83fc-b89d87fee247@roeck-us.net>
 <CABqG17jveAdxN+tCcPq4hNqWDy1YCJ1z0+kLpM+ect0XEyqBcA@mail.gmail.com>
 <116aeea1-c648-4abe-9ab2-693bf64000fc@roeck-us.net>
 <CABqG17jHYymH02hAH0z-uqk2HjemL_-aLr9EyOUNR=uQ7U_wtA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABqG17jHYymH02hAH0z-uqk2HjemL_-aLr9EyOUNR=uQ7U_wtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/24 02:50, Naresh Solanki wrote:
..
> This driver has 27 regmap accesses. Except volatile registers, others are
> cached by regmap.
> Some function which only access volatile registers will not be able to take
> advantage of caching. This is also the case in various other drivers for similar
> devices.
> Also regmap offers bit handling which makes the code much cleaner.
> 

Maybe I need to make it explicit in documentation. I will not accept regmap
conversions unless local caching is dropped. Yes, that means that volatile
registers will not be cached. I consider that a positive.

Guenter



Return-Path: <linux-kernel+bounces-10574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9740681D662
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 20:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3726FB22033
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262A415EB2;
	Sat, 23 Dec 2023 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh2PnoYN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B891D681;
	Sat, 23 Dec 2023 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so3429942a12.1;
        Sat, 23 Dec 2023 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703360755; x=1703965555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ewT0As/HA/i0HnEBzeVFxgMh9tztpLDF7fJw+JJpgu0=;
        b=fh2PnoYNXfkptMSntRokuuDOlaw+DOkC4dI29CZMb0QQQmpWGMb+ZVY3ZQp54cZX2j
         Ub1rBFn0vab3EHWLsEm9AklpxsO4G6ePu+cIs2PSvUVF0uuFOUxe3n/ESIUINK4nDJr2
         LvQEbjjoBEIW64Sf9BtYlmxGWfxWP1xjJ57FGHvuZ0D6GbGz3hCDdAuzwlnuIkXNAoN8
         UZu5tFWRkbEwXCp1ZpWCJ6+30KFlybIu5vjaOcaVJRuJeMpEub6iVP+2KJq/Nf4lJ7ii
         gOXHhG+oRzKzJMW0TgwaEky9ciIu336R0LiLyTRmpYqDQ/sGZneGAA3Bix9wH/PgutgW
         utKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703360755; x=1703965555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewT0As/HA/i0HnEBzeVFxgMh9tztpLDF7fJw+JJpgu0=;
        b=qm+HDLqO8gybA9s7qf+MpYsSUpf/4nuI6XVgh72hGWc2hNaVfqW0bWfD7mWeN+SAxm
         6VrrwdklHH8KozJimjaqPS37sG7RdaiMbNWodZ2A+vOFtLpacsfpudjzGRGH6Om3qmnW
         2S/mYpbdrxVWHVWG58TAzE0s6YUY6CeUAYoelSlp8DKBH6reX2TQV9763eAQ/1HywMLW
         rFkpSEsNvC1CheL/5lFQ9/EENFzCOv3qliVTf4fAOQLjagFkSOfP0lqtmTi26EZsYIkq
         q7ev8m/Rh7Kp9QPHuEvnh986v3rWA7LBoYFAgkHaUTC/+Nsgs/deGdCacfX0cg1Q/LKK
         uxLg==
X-Gm-Message-State: AOJu0YzIs9cpfaJ4TRpOYobST4AOm09Xxie4xvudb5cK21mzNfqVAgLf
	GVIwWU/P+G2dTJxuNfPhfpP2/WB+Xri4Pq+q
X-Google-Smtp-Source: AGHT+IF9gINu0zxxgZrKaZXha0Tu6DEmSlckmmBloQ3zgkxWR+hGaL91LoCX+tkwIDcltSI6Mh5gNQ==
X-Received: by 2002:a05:6402:1603:b0:554:1431:a977 with SMTP id f3-20020a056402160300b005541431a977mr1810798edv.54.1703360755084;
        Sat, 23 Dec 2023 11:45:55 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:6545:dd3c:de03:74c? (2a02-8389-41cf-e200-6545-dd3c-de03-074c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6545:dd3c:de03:74c])
        by smtp.gmail.com with ESMTPSA id o21-20020aa7dd55000000b005548bed07b0sm1094688edw.47.2023.12.23.11.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 11:45:54 -0800 (PST)
Message-ID: <acb74002-31ee-4130-96e1-9ac497a15c2e@gmail.com>
Date: Sat, 23 Dec 2023 20:45:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: light: add support for AMS AS7331
To: Christian Eggers <ceggers@gmx.de>, Christian Eggers <ceggers@arri.de>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231220-as7331-v1-0-745b73c27703@gmail.com>
 <5750063.DvuYhMxLoT@zbook-studio-g3>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <5750063.DvuYhMxLoT@zbook-studio-g3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Christian,

On 23.12.23 13:18, Christian Eggers wrote:> I still use the original
AS73211, so I can offer testing with it. I am
> currently away, I'll do the tests on 2023-12-30 and report the result
> then.
> 
That would be great, thanks for your offer.

In principle my modifications should be transparent to the AS73211 and
only the code to retrieve the scales has suffered significant
modifications, which I could test with i2c tools.

But none of my tests can compare to yours with real hardware, so I am
looking forward to hearing from you again. Hopefully to hear that I did
not cause any regression :)

Best regards,
Javier Carrasco


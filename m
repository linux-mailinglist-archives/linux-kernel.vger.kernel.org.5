Return-Path: <linux-kernel+bounces-142208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D5C8A28DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4846E1F24C83
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A2A50A66;
	Fri, 12 Apr 2024 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ng4XNfXi"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7AD4F88A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909160; cv=none; b=Zkrw9l4xYihewOWxAKAlv4uaNYE0DTnE1XajKvAoKE4MikDsnuqQYAt4AZb7+3IOUvTzQJzSwkTJhzIdte6ug7RVmLMa4UOpB1eL2m+zZCTiwoQO3ZvORoIqHHdKnrtM6eASTCHLNVxuE00aO3KnqIfSxuddRyXUbxnuEnpwj4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909160; c=relaxed/simple;
	bh=Bs7Eyj2uTzbHU1FiuwjH7uFw6khjYQQxyh0Y/f7jfbk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=mKRArtJZwcuis4hTcRQxqVX77JdF7OBi/CZsO+7/Ogu6f5HiQAAxEDxgrX3HSxPwBaulpKp5y9gaQJ1Km7uJM/ULa9LaamjO/p/6MBJ9n6OepDcYsh8uBk4iSDXM/pGJVtpMkw49WxYL2KmPcTijQ5jjQyTs7zGEOiIijQAPaWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ng4XNfXi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d717603aa5so7083211fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712909156; x=1713513956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5lJHg5BKe+36ob4JtOUMC2azeL3dTZAz0hL3f6Nmw4=;
        b=Ng4XNfXixkPunlK3oLDv/So6iuwFPwDnrn/6ASrVcvWO5JSypJK81u7exIt9YeI7O4
         qbwMeJhiLCtSKJWdPtxxIZN40QSLE74i9u+HS1KdXIWQmVkAQh6zND+R4LtYDogeM3gV
         tLMIAQqOxmc9hOGsgBczIcxTmOP8ZY3oG1cLztrXlamchrd/2VX1G9BU5rejXzfAqKl0
         Qx/YhrfK/GXXDmq1orUQv+RDWEj23L10bUOwRvxPU1sGek1JAMSgoZcjg2QdWxQHSODW
         S/lWITq9LohcBwrLcRoL/4DgslKnexzcf062SX+CnVPw5PGxz7qFqhZx4zPRpOEDt/wE
         689g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712909156; x=1713513956;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q5lJHg5BKe+36ob4JtOUMC2azeL3dTZAz0hL3f6Nmw4=;
        b=TidaNYtv7AZDaZuZUVSdw4DhtwuV9IciWBC7vCnkiHBR2qvUp77JfFXGTSBdAmz0l+
         rZwmU5n5HcqEu/Q34vNp0+F9QtB+wqV+rMIhCRsvfPjn4vtj3j2JeCHJiUdw7biUYkrp
         p5mi37nkRt/xaSOl+1DO5KhUKTM8lxdK1swPuN7h2FtuzjhTeNbWr2FLE88TWKjf7ZKh
         rOSGQk/y3qpehnO8Vn7/Ha0Xt8fNNw+Od+YkvHTLPP9j5314FjxoQT5SObmCoH5m0W16
         sWV8OjLWmBGWtcgJOCI3XL45lMKwsMe3N3ek0hqigdf2UsNlWRo2mWTj9aeeYO7fhrxs
         ZoHA==
X-Forwarded-Encrypted: i=1; AJvYcCU/ciCZdglG9fijTYLWR2ctzTLNYKUNWVenEkpspL4+z32H+7uwTMvp0XzE+CnBt4j5uKx5T2A0S2P+I6lscUVfPxvPrEMQBR+mAaZZ
X-Gm-Message-State: AOJu0YwWQz/aw/4ARS9b5ufr/bzaPIOM8YmJthszV+5k4fdvW3iqXrjq
	/IGzemtrvZReQ6AXRad12eDgNBHL1ciwELUb1p7M3BC/y8C+piNp+R0BG41ektQ=
X-Google-Smtp-Source: AGHT+IGaqXXqQDMlRknVDn9Zctby8wWX5plji2zTKOgGcGEZKQWoEBs0sgqxhVWS467wRkUFWIzLbw==
X-Received: by 2002:a2e:87c7:0:b0:2d6:c672:b301 with SMTP id v7-20020a2e87c7000000b002d6c672b301mr1251197ljj.50.1712909155792;
        Fri, 12 Apr 2024 01:05:55 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b21a:2459:7056:47f0])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c348800b00417bc4820acsm4944675wmq.0.2024.04.12.01.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:05:55 -0700 (PDT)
References: <20240221151154.26452-1-jbrunet@baylibre.com>
 <b6jyherdfnehu3xrg6ulkxlcfknfej6ali2om27d7rjmwncwxz@3wrtx6sv4xm7>
 <1jsf18skat.fsf@starbuckisacylon.baylibre.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Neil
 Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
  Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, JunYi Zhao
 <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v5 0/5] pwm: meson: dt-bindings fixup
Date: Fri, 12 Apr 2024 10:04:22 +0200
In-reply-to: <1jsf18skat.fsf@starbuckisacylon.baylibre.com>
Message-ID: <1ja5lzovj1.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Sat 02 Mar 2024 at 16:50, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Sat 02 Mar 2024 at 11:04, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengu=
tronix.de> wrote:
>
>> [[PGP Signed Part:Undecided]]
>> Hello Jerome,
>>
>> On Wed, Feb 21, 2024 at 04:11:46PM +0100, Jerome Brunet wrote:
>>> Jerome Brunet (5):
>>>   dt-bindings: pwm: amlogic: fix s4 bindings
>>>   dt-bindings: pwm: amlogic: Add a new binding for meson8 pwm types
>>>   pwm: meson: generalize 4 inputs clock on meson8 pwm type
>>>   pwm: meson: don't carry internal clock elements around
>>>   pwm: meson: add generic compatible for meson8 to sm1
>>
>> I applied patches #1 to #3. This doesn't mean #4 and #5 are bad, just
>> that I need some more time for review.
>
> No worries. The change in those, especially #5, are pretty simple but
> the diff are indeed hard to read :/

Hello Uwe,

Introducing the s4 support depends on this series.
Is there any news ?

Thanks
Regards

>
>>
>> Best regards
>> Uwe


--=20
Jerome


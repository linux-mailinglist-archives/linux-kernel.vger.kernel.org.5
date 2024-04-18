Return-Path: <linux-kernel+bounces-150590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8706E8AA159
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427A2284A61
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEAE176FB1;
	Thu, 18 Apr 2024 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQVx2Iji"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C4D175564;
	Thu, 18 Apr 2024 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462523; cv=none; b=CVg1IW+nqGtuv6r+yVXfnvFBWN/1u855tjGOGA/mNgK3/Jrtbt0L9RRDUe/waACR/oRUFbH/P8Ti88zYRQPYIl2uhiQTy5KzwV7KsjBf7mXlEaVIMvi34CaKqp08ulBRFyrM+FMtvyifVuGz+u8tqDlyPhVEfBQvd55qflcPGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462523; c=relaxed/simple;
	bh=Y3ZdflAu0Ob9/HKHivhZRCDoMprpPAWFGSlHtfCLBBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnU20sO/oNS+ww7o+/W9QxD6hWdDlfHIXZC/mboy+oO+tpsCzScMoWgw/Luj3ftq4UkOymW1YSDEwRnKq66udOJeKk895niP0exVGm/nF51ofbyzzz3iIwyzb6nadf7l9BS3IHkyaVImfJGRVR2iXDhBIJRYAkuB9acNRBKT0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQVx2Iji; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51beae2f13so129430666b.1;
        Thu, 18 Apr 2024 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713462520; x=1714067320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3ZdflAu0Ob9/HKHivhZRCDoMprpPAWFGSlHtfCLBBE=;
        b=CQVx2Ijimil+Tzpa5kuUoLOuZRV9+brGnilt7RXRiiqujb4aLtDDRS7RsSQubln+7W
         +5v/kDCX6eIutMTtEuxzXJ0aZUaAAewSXMuFcZLYtI5MDtBaZXIzT5STKT3DOqORlKuW
         O3O/1xTmjnbiv7A5fbJGzFl1cjyeuqe5tOJifcVz2te7ej2mmsFavp0Y0GGbjVKOYwlE
         +bP2fpUKxqhydlsLt6MdQUZRKt/+n6TaO0Tw6d3qAzx0ew9nXbIjEhS06YRiS7NN7orV
         vhfyqunNvj//RWcF8PUXiJDtRfK5/0XOwWt/cTBQ0GjoWLVMjpcb+ElvXifpON1mpFuq
         HTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713462520; x=1714067320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3ZdflAu0Ob9/HKHivhZRCDoMprpPAWFGSlHtfCLBBE=;
        b=uSUEu1gVodbzqCTPsxma9H/SsFS4dx89SbUymPtEtBPXD1jehUCjZ1VV6uQ3BwdZn9
         6X4To/MMtA8cdheWqQZaf6lgyEJicLyojnmJ7aXA0ZfOgc4KUylv2QxFiCtIjuMVWJ6K
         vQA9fyIrvXrG74kqFVB/HDKAqW9ggQJ63mE5WkbtAUn8WF9L9IcmVwujX3B07F8sHNLl
         y0TXuzerf0YNDbJwPVux3LOIIxMo+mZPlTgMze/b76BnWJm7vrIe9lgrQ6C/4EARSt7O
         rTnF/zIYtIcQRajXDr29rLrJ31+ltXyg2SmZV7Gl2Fo7EqC3p8ptCnvfjYssZWEVhC8z
         sXxg==
X-Forwarded-Encrypted: i=1; AJvYcCU68BcyrQEpcXSmIZBTRZ4sag3/TPfCpaUswE7RVLc7eeu+HzFSSvrse50oEyRkyPu7/BxxFzxK+XwKlVDTrjxpqeZ3gGZC23QLzY9V9Fuw7HsVWqrgUPRdD6zEmrWsPdDHD7m/KviH4OiThVSdvMccskONx9BF+aIBJW274zpWWQ1iRNk=
X-Gm-Message-State: AOJu0Yx+m8s8LDyUwl+Pl3tRaTlkecHue5G7o34uKkmI/IpBEU3EGAO+
	f2Cilk1Wg86Y5fhVWE2tKzwTc/h11I9Ajq82sAx7nZYD0crO3V0=
X-Google-Smtp-Source: AGHT+IGrql4DRoEYWEVf0Y01BkNRtnQCtazPpJmoysmDk+TVKvk+4dGzYbR0/fAgoan3Y6zvVx4FeQ==
X-Received: by 2002:a17:906:2989:b0:a52:61b9:be48 with SMTP id x9-20020a170906298900b00a5261b9be48mr2321377eje.35.1713462520360;
        Thu, 18 Apr 2024 10:48:40 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:956c:b9da:b8bf:bdbc? ([2a02:810b:f40:4600:956c:b9da:b8bf:bdbc])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090653c800b00a51a259fa60sm1167494ejo.118.2024.04.18.10.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 10:48:40 -0700 (PDT)
Message-ID: <177ca573-db4a-4106-b7b2-5ef82df64e03@gmail.com>
Date: Thu, 18 Apr 2024 19:48:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] pinctrl: rk805: Add rk816 pinctrl support
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20240416161237.2500037-1-knaerzche@gmail.com>
 <20240416161237.2500037-4-knaerzche@gmail.com>
 <CACRpkdYMZ7bBxKCSPJ74QYhtEPHV8cPARioGrg5ySj9j7nPE1g@mail.gmail.com>
Content-Language: en-US, de-DE
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <CACRpkdYMZ7bBxKCSPJ74QYhtEPHV8cPARioGrg5ySj9j7nPE1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus

Am 17.04.24 um 10:57 schrieb Linus Walleij:
> On Tue, Apr 16, 2024 at 6:12 PM Alex Bee <knaerzche@gmail.com> wrote:
>
>> This adds support for RK816 to the exising rk805 pinctrl driver
>>
>> It has a single pin which can be configured as input from a thermistor (for
>> instance in an attached battery) or as a gpio.
>>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> Looks good to me, is this patch something I can just merge
> once the maintainers have reviewed it?
This patch depends on the mfd patch as it includes some definitions which
are used here. Same is true for the regulator patch. So I guess this whole
series has to go via the mfd tree and it would be probably the best if the
other subsystem maintainers could ack/review the other patches.

Regards,
Alex

>
> Yours,
> Linus Walleij


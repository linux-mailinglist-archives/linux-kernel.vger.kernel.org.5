Return-Path: <linux-kernel+bounces-63982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B7D853795
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D738AB2860A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF05FF0D;
	Tue, 13 Feb 2024 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ24iwdj"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A15FF0E;
	Tue, 13 Feb 2024 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845217; cv=none; b=Fu4MslixfC5g3ZhsoJ/l4u/Wu9pMmIeEHIViBbtWZV8X+I1l7moKalsbPTFbB3CBxNNTxMSBrPQ+tW+yt+wGfhDmmD/tRj5BwpnmY3lsFIWepDuZ9UYfBJMK8hPq4KfnI9SGaql0jsH3GKxESnHcehZVsYaW6ugT6/KQ//RcY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845217; c=relaxed/simple;
	bh=cXAiw2/ErygoIn+3eefIlRIrjT9PezbE5l1VLyyKrLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ivx/SpYB7m/hgL+JOSrJMWUSvr5wRH/Mb2Zmok6aNaqFsgvk1QKmUAqiTkS1m4nUcdutFrFBRxkfNMQdoqM7N8O03y7kFibWooaQOwXizCcY+RQwp+DyJ/Tx0dgkYUsWypVm19LAtCH4fm4aumhHY/KFj03ZN6s2kWPHwBqRBkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ24iwdj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0f9bcdcc2so615357b3a.1;
        Tue, 13 Feb 2024 09:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707845215; x=1708450015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ur/fikUr2Th+pgU1bKll5nq0sy1jOzuFD3bGp+B8a28=;
        b=dZ24iwdjHsMB6+f95y/yyLmf4cChtfDpIRK3gYeoiJZjWKKccBy1Wg/DJpuodrW7mF
         4Y4nZJIwu9NKQH0s2crw5ZiBVFdFeVTY6fhv4B0q5WIM2Dc53qHBztUPMrAutHPiIGRR
         kp6EiCu8aH+rmCWyfs6KZf01/EvZ+EszWG7V6tGU37DDcVA7xhu957KcYebvGjVqzTQj
         gJERmpjUh7YkIjs4dPVaM1shxRno33SpANpoaUVkmt6j+0EoMLqpxgighab0vAYY3kL5
         pQxtncJhGWvSin9iawhHjeGJbIdwivDX3hNaxZNUpzViu/Ny3wSwkNNpTbGD+8jE73g3
         Jd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845215; x=1708450015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ur/fikUr2Th+pgU1bKll5nq0sy1jOzuFD3bGp+B8a28=;
        b=HMPA2Qfr0XqYgqTJ/+qOybkzQNglBnyCkv0sHtr/J4gENo56Qzpgbqct+BFmfouzAB
         gJKoYZ19Ovix0aKQ3iHuaBCfuYOZvQOoyLhiKksdus+Uw/9ZIVmUgU1zn9OR+7dW+dUZ
         /AkNSF3A5pbOlelPuyOxF2KFdeZAElvvzpn42E7UATVorJMCphRqmlUtg3xrH0AhxYbU
         pSavFyy3ZTMlKJJiDp5770pHI4eW6kdpZOOkL3Kr4eW0kqguRCuQbVwodWfCoSdTNPTR
         oCULtQKT1JYuETUmMdx9adyKQhNBb8M2VVfkbIEG+Awa3AGHw2rOz06q1UcSbZR8I/ML
         JRag==
X-Forwarded-Encrypted: i=1; AJvYcCXP1PYdYEj2CdrXd50X8GhZvmWfB5rmX6JG/qrVZumsVNRgiJxEmwTDjhAN83m+gcDvuqvuLg3ohSqw9xy3h7A9sVmwcVx2qEXopk+MY4f3g/ejX0RW3Ql0W+Y0eBauOPY6ryUv
X-Gm-Message-State: AOJu0YzoYpGg8RSLZwuWT3PSm1Gc42EeAweHkSd6Sq0LrRZdLaxrxlUK
	OE8EWM1J+4XSV+y4CWPAghPfNKijlaQGue2NHY2drPOVN94ljlpU
X-Google-Smtp-Source: AGHT+IGLkrGX+GDNIrDIKUcQTw2faJG15C2F4UP4Ra5/Rxcu7VpskBw32dXIF3UehOfAfAyTm2qTgQ==
X-Received: by 2002:a05:6a20:9f08:b0:19e:3709:f3f9 with SMTP id mk8-20020a056a209f0800b0019e3709f3f9mr355256pzb.2.1707845215134;
        Tue, 13 Feb 2024 09:26:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuNkxsDVZLSwhX7WpOQ/oeBkyqkgqrUbKFd9XNTP8uLtCVXGHukF76N3+Kahxdpwgo9z7nZaipU6uq7P8ZXeqBDN0nAL25hwWMtU1s9FfE15mnxuXWjsc6cMM4KMfBTbiliJ/D47fLzGcWxqDv8UySkkNlyhjJDhKSQ0EgXa55V8oTTE8ETORBOU2XtMejJcbVqUwcLk6nZg7G6kPif3icIOi3UKqA1K8pkFnTpqdRhFIThoKN7LPYGkjaByWPotIURgTAvxOwglNYKKATt3sLSlNcfEmXkE4oXl/mzn/B7iB1jZPHixM3gyWGJcR6libMcxJcYrh72U4YzL2WO6SeAqJespSMWn5o9Nwa4SxCpiqp0JTUqWIGLsheWsPRB6iTT28HzG9qquygWdVw2I46vC9+7drQFMDCoSi+UiWvdmFOyEEs0bNsVv0Hz3hcwScl7Y3G8QR/BoCHyNOE3Nz27ONbL+KT5FnEjiRAVzfqkX2Eu5j9Ri2t7G93vTeSwSvNNkF06yRdnOMBP1PnW9gIGN1itZbQunW/guSbMM3xdPcrHmkpa1SkAMVs8dTMVor52kU=
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m63-20020a633f42000000b005d7b18bb7e2sm2643192pga.45.2024.02.13.09.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 09:26:54 -0800 (PST)
Message-ID: <5476743f-3648-4038-97f8-a9df22c0f507@gmail.com>
Date: Tue, 13 Feb 2024 09:26:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: sparx5: Add spinlock for frame transmission
 from CPU
Content-Language: en-US
To: Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com
Cc: u.kleine-koenig@pengutronix.de, rmk+kernel@armlinux.org.uk,
 vladimir.oltean@nxp.com, jacob.e.keller@intel.com, yuehaibing@huawei.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240213121705.4070598-1-horatiu.vultur@microchip.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240213121705.4070598-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 04:17, Horatiu Vultur wrote:
> Both registers used when doing manual injection or fdma injection are
> shared between all the net devices of the switch. It was noticed that
> when having two process which each of them trying to inject frames on
> different ethernet ports, that the HW started to behave strange, by
> sending out more frames then expected. When doing fdma injection it is
> required to set the frame in the DCB and then make sure that the next
> pointer of the last DCB is invalid. But because there is no locks for
> this, then easily this pointer between the DCB can be broken and then it
> would create a loop of DCBs. And that means that the HW will
> continuously transmit these frames in a loop. Until the SW will break
> this loop.
> Therefore to fix this issue, add a spin lock for when accessing the
> registers for manual or fdma injection.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Any reason you targeted 'net-next' rather than 'net', as this appears to 
be clearly a bug fix here?
-- 
Florian



Return-Path: <linux-kernel+bounces-105383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49DB87DD23
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 13:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E621F21248
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDF31BDC4;
	Sun, 17 Mar 2024 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuqaPIwd"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923401B7E9;
	Sun, 17 Mar 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710677904; cv=none; b=eooMrw6z6B9140tyhhdsQPxmpVm9gF+zjDiNZN9vQDBZEBnF3HCnO9dK29mJVogC/DgeKnKluyhrINNPNffkY/blHWXzP9AmKTLa+pDG5jMFkevoH1cGhs/ebNczAAvO7DRdzZ9oltw4cEV/2k4Y+9Ri4oiGEJkwFyH7TOyZtX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710677904; c=relaxed/simple;
	bh=eoUX5ow+3C+/zgtIqy7nF/N9uBFFU5sFHI2z9migN3c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=usnpIEvFutLFCIVyWlmZlO5sKNnRQ3Qd/3XgPilyr6Qig/Lu0/dLdz1AOkocE50uLEZvYrS9f33oTn1B/hVkZIjDCaAqeC6zLvpC3e6RtcsJqGWX69y7aolMTf9qL/WOAETnSye4PX9shLc/d5b//k/M8bACckn753ik41/wPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuqaPIwd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513d23be0b6so3455411e87.0;
        Sun, 17 Mar 2024 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710677899; x=1711282699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhDUfnD6jhndJUK8KTDqkeCeoMfn6ZnAs+c0KRbmtc0=;
        b=GuqaPIwdnOaCw5qQTuxzli+TpFffCuL5WYSQ7+vquVT9AgeGxwcGnQOiDCoEME1tVH
         iCQZ68S2bopcL2mgLj2jgKTezXtlz/X02dnA4e8hYv6wxAlZpVw9G+NtRLZfs+cx/qLz
         rh0UuUUgtzVrfPKSf1tNRwl+jfeN7jv+hgGOJfUBgR9VNxo+XMs6/ukxM9P0TTOgc9Ao
         Wmr7KJvUVVcy+tCmL/EHYCmen8jfmAZMewPQWFww1gmyDFKZPurn8dHgWxko0HZHJ+9N
         8RnvfxDWnb2UHyRDKUAR7nFAwvLIdhFf6SfqvXpjdJSZiFwLdE5Z0a1UPOs4UTJGHD0J
         r4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710677899; x=1711282699;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhDUfnD6jhndJUK8KTDqkeCeoMfn6ZnAs+c0KRbmtc0=;
        b=d+kMfvo7rbybWQJCkLxCYSvJOBEpLR7ENeu68mVhe1FmmwwLPQmKJK1Ev8OhP/yiUO
         jitnNibQI9oiA3GNAazMleAHmo87C8yMv/JY1pTlMrugsxk4BjXBSjt2a/yLNG2e6HAn
         Nc0+xHljZ+QWpbcm8fx3X/CT19C7MedsVAP64KFiWa5FN9fWIXH62qxTaoMIO0jP5RjJ
         qzvh5Pe4CVVyt77lC+eM32bXhRlVmLTez2qxCnCDfrb7//Mk6kzd+POLch2KUgWXD0+2
         BTbbYYFGjCDqCAAc7FWyoPQc54cNtfaje66tZ55LVSVph0mDVUVm+X1gYG80GwRJDBK7
         zrJw==
X-Forwarded-Encrypted: i=1; AJvYcCWvXaBqLRDswjvWNqE+Re3YXc/eDas11FxiGzzqPzO0c+Etom9V436w6CyWg0wBq7fI97Y41Oaq6CtEx3D7eU6e8YOWZ/+c7Zn7X8iZT8f+KaRpGtARWlG87Kosb9S1hFOrjJhtp6UCO1s+Qvk3B8bfowurk5lTXZOpZv+FWn2WLUF1uiKH6uBokmyhhP/vF/V0wsKiPLiMbDoPW5YoDA==
X-Gm-Message-State: AOJu0YxCo8uXSdfG95x683SyFhpDn8YM4hwFH7deiI2VI6DdDbl0aHal
	f0SnrQq5s4cnjGVMmj3bmENsnQSCelkdWV5SPN1i+TtcRl2Se9UOqdEtarh4
X-Google-Smtp-Source: AGHT+IHtyGHn/hPRpeLBJ9CG4gmpZoe+TIR3oxz3H3IJtfVbpmTBJwJGBzaKCrvmEm+khwdC/47XhA==
X-Received: by 2002:ac2:5bce:0:b0:513:b90d:aa5e with SMTP id u14-20020ac25bce000000b00513b90daa5emr7293415lfn.8.1710677899355;
        Sun, 17 Mar 2024 05:18:19 -0700 (PDT)
Received: from [192.168.1.105] ([178.176.72.130])
        by smtp.gmail.com with ESMTPSA id n5-20020a05651203e500b00513ad31a00csm1237787lfq.69.2024.03.17.05.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 05:18:18 -0700 (PDT)
Subject: Re: [PATCH v5 3/5] usb: gadget: udc: add Renesas RZ/N1 USBF
 controller support
To: Herve Codina <herve.codina@bootlin.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Gareth Williams <gareth.williams.jx@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <20230105152257.310642-1-herve.codina@bootlin.com>
 <20230105152257.310642-4-herve.codina@bootlin.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <260e0089-0817-cf12-dfcd-c28263808518@gmail.com>
Date: Sun, 17 Mar 2024 15:18:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230105152257.310642-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 1/5/23 6:22 PM, Herve Codina wrote:

> Add support for the Renesas USBF controller.
> This controller is an USB2.0 UDC controller available in the
> Renesas r9a06g032 SoC (RZ/N1 family).

   I think I've done the NEC EC-4255 USBF driver for Robert Bosch
Car Multimedia, too bad it's never hit upstream... :-)

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

[...]

MBR, Sergey


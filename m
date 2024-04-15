Return-Path: <linux-kernel+bounces-145908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F36D8A5CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF35D28291A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA3915696E;
	Mon, 15 Apr 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy8h3WNJ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE749823CE;
	Mon, 15 Apr 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215275; cv=none; b=i44X/z13TR+4KEzX1zL8NomWid4C1iI8NMJDIBxKkVuS59uKouQgLNk4Aw4+EOSEMHz8YUdbfB27FEkdiIHpjO+4s0zLENfcuWlcMoIfUaWLxihJZfRXt8YEkAhNRZRStqrmaH6OuzlaZV8jfsF6pcaf3KaXhUw7EjyQLiKBd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215275; c=relaxed/simple;
	bh=dZGyHYW2YHPRCCg2XTiPDm+RfQJLoDRhsLPv4FfLvfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2ttbpbYZZWzLSybJNj7tgMJC6q128a5zwvqfT9+POMLXBEX6wA3ajLjMgJHSXwovZRTrZYB7wqLkSKnKVb1f5cW8oMadJWJLewvvotUOP6bZP6NzVxZ3DyH/n67+O9GcTaH9WIIW/OzvVZu1FtZv0dEjVHvnxvt+j3Gi61MQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy8h3WNJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2dac79e350cso1401271fa.2;
        Mon, 15 Apr 2024 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713215272; x=1713820072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZGyHYW2YHPRCCg2XTiPDm+RfQJLoDRhsLPv4FfLvfc=;
        b=Gy8h3WNJXAL/ZrOnZ/+bJlI5uylosvOjCidl+opQOJN/ZHTjJbl5rLfhjfX1F4IyX0
         7vUKWGbZ2TnRnHdIW+jBhVhWr5Y5tACr4Ap5VGLySW6RrRaXTqJhAxosSLBHYzc1R6C3
         eZZgtUWUvB5pf6DKQ6eiQfst3TY+/FlFnJ+RMj/GrulBGdjMtHMHw6gs2HwaUTgO0cAN
         42iGxUK+n5JOcXwH0Aj/8WBMT2KYnWvh7OomU+pjlrvZq1jBjV6dnl6RQRZ3Q9/yHL/g
         FsjY79qd7BBsu2y5yV7a4dH2ihZN4pkbuOMj2wuNwjDcXo6YiThruQBrU5Cf40MbqBhB
         vMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713215272; x=1713820072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZGyHYW2YHPRCCg2XTiPDm+RfQJLoDRhsLPv4FfLvfc=;
        b=l9/HwAXSE6QVyOTZgQ6CCjIIYoePa9yi4Tfos/p0Z4RLmadDQf4DJHILtFUplcAwEa
         sEs+AL9clGgYlwE56fupV9LwX0wzoCdymgGIDcS00jWFVIKfi5T5UdhYqMZm/51mnCF1
         SatN3a9eqEWBm+uXCIVpIvJHNTCeWxDrGOMC+47s38j7hOSwlIIpYWBTs+k9romT+JLJ
         WHpHd+5/BtNt4ScGwWHbtHlydRcQqnoj4sI66qKVtWJrLzOmJjCXkCkH4w7INczgr1lh
         ydGSvY9tKWsM0jnF5OQ/6sHpSG2oa7RGLJJtSp+YHSEPlQ9oFIY+1UOg7eLcr2zNglV+
         ZocA==
X-Forwarded-Encrypted: i=1; AJvYcCXdaB5zj2ntMQKYis4NkpGOcpMfGOqIJ4TSK9qG6Rl5jVjwDR1lLpbXC9dtYNOR9x3vD3zpFgPMq+RwH9oYQBl6TNLylZHLeEpztg==
X-Gm-Message-State: AOJu0Ywuw4I/VnJWFrg7n0e53xc8afsFWvd380uz0NgWK/rWkUfIW5gb
	cv+5J8/DHvXq41EZbL8319NBI2/tuwXvNhaiUCsIEFaRCaqL6qbC7TfLh7GT
X-Google-Smtp-Source: AGHT+IErQ/YHbW+POwBNnVs+xxSRp19T+6PTSAH/8LvETVMHLcYYh9s7DrvZ4rEKVLjZxM4vADHwAg==
X-Received: by 2002:a2e:b94e:0:b0:2d5:9703:263f with SMTP id 14-20020a2eb94e000000b002d59703263fmr5617484ljs.44.1713215271826;
        Mon, 15 Apr 2024 14:07:51 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b0041668162b45sm20796813wms.26.2024.04.15.14.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:07:51 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Aren Moynihan <aren@peacevolution.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Chen-Yu Tsai <wens@csie.org>, Pavel Machek <pavel@ucw.cz>,
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Miles Alan <m@milesalan.com>, Samuel Holland <samuel@sholland.org>,
 linux-arm-kernel@lists.infradead.org, Ondrej Jirman <megi@xff.cz>,
 Aren Moynihan <aren@peacevolution.org>
Subject:
 Re: [PATCH v3 2/2] arm64: dts: allwinner: pinephone: add multicolor LED node
Date: Mon, 15 Apr 2024 23:07:50 +0200
Message-ID: <3289584.44csPzL39Z@jernej-laptop>
In-Reply-To: <3796126.kQq0lBPeGt@jernej-laptop>
References:
 <20240317004116.1473967-1-aren@peacevolution.org>
 <20240317004116.1473967-2-aren@peacevolution.org>
 <3796126.kQq0lBPeGt@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 26. marec 2024 ob 23:44:39 GMT +2 je Jernej =C5=A0krabec napisal=
(a):
> Dne nedelja, 17. marec 2024 ob 01:39:29 CET je Aren Moynihan napisal(a):
> > The red, green, and blue LEDs currently in the device tree represent a
> > single RGB LED on the front of the PinePhone.
> >=20
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
>=20
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied both, thanks!

Best regards,
Jernej






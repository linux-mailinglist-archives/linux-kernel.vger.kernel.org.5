Return-Path: <linux-kernel+bounces-64509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269BD853FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2FF1F24E51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3577E62A02;
	Tue, 13 Feb 2024 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuTXopDN"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2AD6281F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865670; cv=none; b=MhULNXLel4nyVWPfsDYITpwTlStk8+27PH+8zABulncuavJLEqSrtX0Ib8nrd2IQuyszqTWJk1DazfoFDHvUmnmClVP0MYwi4bQdSNvqwCFCiF1hnhcYjGsTLkgArQBYhlY4nv/F/N7nQOEcbNUFN4MaxpXuk1HxjZ2NGMs9G5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865670; c=relaxed/simple;
	bh=5r8mGWxqCI6vEgqZTBMkzo4gQvTRqNCArj72zBif0wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7J3tjBPhDBxJj2TbjK/yAgmv3BRqQAfWcNLALSor91IY2mG9AkgDG5bq4regCLA/AVbb2m5WY1GCXW5e2JH6Dlb9yn1xmOzA2CXYpdsErnxhi0ud0NWEsOLbRktzhkfzK2puCWHCHEqOXvTw1Uv/YIYhTcb7etlPDs83T/SrJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AuTXopDN; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbed179f0faso196777276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707865667; x=1708470467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r8mGWxqCI6vEgqZTBMkzo4gQvTRqNCArj72zBif0wU=;
        b=AuTXopDNGeir0vPOFVniMlL+Q3IgzlP4aI3edBaceQW/nNs/uf1Aphs3mW8BNRSa5e
         0uq1pD1eOU04WZ8xeXHqw/XOWrifg5f02yzAvI7mqne0zlJLOxKfXCZUa/JR39MRpaaz
         mYhhzylAU4FQgYgYRjlYbMDQeQ8yiqffqa12BKHQKaJlP3vgDq0tSg16vClgS4IK0MYD
         p20ZVeD+cQQqALkg+CfO/Z0YKynf8YsJs4zuYrbcebPKEMmV8II2e28czbloIfGu/9Si
         uyqDY6jmwA4wLqMkGByrKnCXtfeRYCJj8YCm63JdU+hqUmq/0EbUNLe7CnAKFPzDa5+X
         F6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865667; x=1708470467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5r8mGWxqCI6vEgqZTBMkzo4gQvTRqNCArj72zBif0wU=;
        b=UudfSsnj9MoB/K7kfzxG/pLzvZOL/OJKzcsCALHEyq8nGvYZDSedEpLLssxu0Nm2WO
         FKK/sVSFeDi1e4gWtaazg+dWZxVWbMcGONkWohTloF1mcsJKNm622a6l6ed7fWgnsZ2V
         +RRVo0dwjrgU3sjsxQpaj8AQHTeLBbph77p2yrWFeawP6FuX8Iys78OdjetIrEcfziTF
         Qxbzly+fFLWURhir1PFJaFybNzPnlJMcWr2p9Zgd2zJBs91RjyVzFyol0+/qkHYdykjL
         Rhjswua8k4m0ZzFy6dqHgSdYEIhD9hPpDf4yZJvR+mQMUKhL4hmhkV6/tK976NzbPw0l
         3A3w==
X-Forwarded-Encrypted: i=1; AJvYcCW7DC5OvJrGofxM+ZcsK137pajHbqf5p6a1s6RfBNKJuhJNIoq5y/j8ysz5G3QY0bc0VRoBGTp25Krj1PoyWBCzeQpPwLXfV5Cdt1Eu
X-Gm-Message-State: AOJu0Yyr3/gFWfh8Z31CfkkQGLPk46LrQYb2lZWPEX6t9KvXaO9qRBxG
	Oivh//CslqMblN5pkSfge2IU6VDTCS//kr/gCnJb5FzM5cSlz9t8GGuZ7uuvkROTiGWkAb/H7Zw
	H8TQsBc+GmYz1VDkwCMl27n896NYVuK8nUdZR6w==
X-Google-Smtp-Source: AGHT+IED3UnYNv3qZy3wS1gN4YzhWWLxmuPdKWXeZ+oYphZhStOOlt00/JsSZJX3g5VssxQqQbR1ikxzXAYLLUPneCU=
X-Received: by 2002:a25:be54:0:b0:dc2:2d55:4179 with SMTP id
 d20-20020a25be54000000b00dc22d554179mr265190ybm.17.1707865667723; Tue, 13 Feb
 2024 15:07:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220331.239031-1-paweldembicki@gmail.com> <20240213220331.239031-4-paweldembicki@gmail.com>
In-Reply-To: <20240213220331.239031-4-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Feb 2024 00:07:36 +0100
Message-ID: <CACRpkdYxf-4PGyAcA3146_V==u3q9QYwiN25cRCt-wZrh9xocA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 03/15] net: dsa: vsc73xx: use macros for rgmii recognition
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:05=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:

> It's preparation for future use. At this moment, the RGMII port is used
> only for a connection to the MAC interface, but in the future, someone
> could connect a PHY to it. Using the "phy_interface_mode_is_rgmii" macro
> allows for the proper recognition of all RGMII modes.
>
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


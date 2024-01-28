Return-Path: <linux-kernel+bounces-41512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1C583F302
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D81283081
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7B14689;
	Sun, 28 Jan 2024 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9zDthaQ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363117F0;
	Sun, 28 Jan 2024 02:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706408628; cv=none; b=p40iWhYsFLoJXyuLbEXd4F4Nkq1KKr54yVbtYPVpDQxW82uI/VCDGGOWpff6nrLJRiqnveyn3etNsoYQ6Gpisa+UG5QuqVhVg2QuQUYKF0jSGS1VTA47TvJ+zCOl7wclMFdBl/zz7Ixf6vVb5+prTfOjy7FEsIDxSrc5vdYwGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706408628; c=relaxed/simple;
	bh=CrRIOE1zmtc0oXJTTaUqY3R34UowiSippGjW7wy2c/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mv8yHzBNPcCXhBQ1xiL0z6hYo/IqUQebkQJ2OwGKzemyBvULTj9cVUghoKYAtjabD2HiV8WbVxeBgUCdY842bOgQ8MTHehx7mdpu9ncBFKMnNe07Q6Qbe//4QRHJt39QHuLaz0g056xPVy53oNWsxBgv17SmvL+Rj/NOnpOjAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9zDthaQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eac018059so1921246e87.0;
        Sat, 27 Jan 2024 18:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706408625; x=1707013425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrRIOE1zmtc0oXJTTaUqY3R34UowiSippGjW7wy2c/s=;
        b=k9zDthaQZYqDHml5L7X1FbvR1vmHNcVrWBDlI/l7jaiTqG6tsSL1/eWWz6+nQNXCSq
         pehDYoM7+rGLHbLE2oETom02sQ1NPEFTsUNHBYhykf1e8hQvqO8Hb8g0MjU5MuxPwndj
         giHJ/wM0307MlRnhiYnv+1nv18LeP+xiH9OvlsRVvZLOxdIDW7DFzJxEokd7KGfQpmNH
         x3FT8wQdzsSF6MNSJyGiXHzofRBLbsVchrrwXF89jFpAzpAOU4bITu1epd0THvyvFxTC
         77v0fwnSFuJdqZEtr6YtRPHNcIvaQ/DtBZS1k1q5e/oyXv37TwuvBpbV4vSBBKq1WZ/Y
         4xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706408625; x=1707013425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrRIOE1zmtc0oXJTTaUqY3R34UowiSippGjW7wy2c/s=;
        b=PeEgboDD3/D03xxfIXehlJRWR3QqQE8Hh1oF7wBQtCrfuce8/qZhAWHe+sJM8X+JLO
         Ee42SDHi7A/5EihOK6/KXPWxFmCOVe2kWBRwD6Qb8zzImwjhMMCwx/15rLIpS/riNzar
         rpyIPlyme5OkX+Q8jM/DkfNsVP0oE90X5fEMKOsanDK56wiFEbXCLl18Y44CM6fTda1l
         0AzPY94SwM3xUD5GpMgZk3HCcx2eo7HRVrUcX1R+LLUvM0RZmFfLx3P1fRPVf9nFy9Ol
         94MrAynzUZKqq8uqkxtKDbH/kH+NDhmMu9b5p6k6hiYFNA+P04FqJvWK7T3rAk2OHnRw
         AimQ==
X-Gm-Message-State: AOJu0YwXFIscsNHCAaCExyL2+QDaWIYG48BaTm/Ferliv/mRJbTYcJn8
	ptGLr0f41pQwhPcuPFshzcryTrdsuREXjEYDbIHmADsf3L4uAiW0BPjXw1eL+RQIo2qP8qbcMEC
	DvP0XoAp9D/+TL2VS2zo9QIwvwgzmJzb2qdQ=
X-Google-Smtp-Source: AGHT+IGHicqtjyBFw5/TlDl9SSy3tvB0TL7ekq7w6eNdaYMI8tczxsS1McZDw/bF/Of/o9Vs5WMa4L8ip194L6+mpWw=
X-Received: by 2002:a05:6512:2002:b0:50e:9eaf:98ec with SMTP id
 a2-20020a056512200200b0050e9eaf98ecmr1407561lfb.54.1706408624505; Sat, 27 Jan
 2024 18:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122053348.6589-1-arinc.unal@arinc9.com> <20240123154431.gwhufnatxjppnm64@skbuf>
 <d32d17ed-87b5-4032-b310-f387cea72837@arinc9.com>
In-Reply-To: <d32d17ed-87b5-4032-b310-f387cea72837@arinc9.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 27 Jan 2024 23:23:33 -0300
Message-ID: <CAJq09z6pidHvtv=3F_yKHDdY89kzYSF+xh89pzg1raAiQPMyMg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: remove OF-based MDIO bus registration
 from DSA core
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > IIUC, Luiz made the original patch for the realtek switches. Shouldn't
> > we wait until realtek registers ds->user_mii_bus on its own, before
> > reverting? Otherwise, you're basically saying that Luiz made the DSA
> > core patch without needing it.
>
> My findings point to that. Luiz made the patch to optionally register the
> MDIO bus of the MDIO controlled Realtek switches OF-based. So it's not
> necessary to wait.

Back in the time when I wrote that code, with the phy_read/write in
dsa_switch_ops, the OF node was only required to associate IRQ to each
port. Until my patch to register its own mdiobus driver lands (I hope
that happens before the next version), the port status will fall back
to polling. I don't think it is a critical feature but I'll let the
maintainers decide. ACK for me.

Regards,

Luiz


Return-Path: <linux-kernel+bounces-61564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358FF8513B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67BB281107
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F71339FF8;
	Mon, 12 Feb 2024 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4nWb9ck"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071C39AFE;
	Mon, 12 Feb 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741846; cv=none; b=Uh2C0D1+UKEGvmFrdg0JThKspcy66+EPQYMRgFCU6FvhZ5wQ0VHyQWz6IvnCnFXwWb7CVEIfWinv+VAdyaf8+yL/yfg5ra27XsnoOJfu343V7vuEVdmtZHn/KIxlrE7y8PehUOaQdYldpByOck8X2UFcMc2oZTcczaieccfvvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741846; c=relaxed/simple;
	bh=ruErS7MH3sscYYbtYh+Mjix6NN8rg0ANIaQIqBK3AoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQrKvbO4LWCc57Gd8GkrFZ3SK+wnrwFP9jG75iT1mAouJkiDkLYtgBYogXftmNPMgJqt5qW2cfsWwe9Dh6icp3XRrv6JJr0SDxGehuEU+0OC5guLugcjaiJBJBeCwndjhrR11kzTQriJb/c3bL4xR5qotIfs9nu1t7844Gc7q/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4nWb9ck; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d09d90fa11so42864361fa.3;
        Mon, 12 Feb 2024 04:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707741843; x=1708346643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ruErS7MH3sscYYbtYh+Mjix6NN8rg0ANIaQIqBK3AoQ=;
        b=k4nWb9ckulGQw65RWq1kELq9Na7Lzw3nKZocfN0fDhy+Wv2KnmQfJuCsT8IkDov0Fs
         kucr+tucfOmJ3dxIRY4WwY0JFGtAMxge5BrU9LbsFsPLxHWpFkgQBYT9vDfOnkMtYRym
         xuWCjURRBpMPFLoRU05rkTQ1gxDRmOdirKkV83Mt68o+fmQkk5gsezg439cYBfm4GKNi
         9ekK7nc5wXL2IrvOX/QBOiu5i2c6+ScRYOWyxdjmtpAPK+h/rmdexgMQRTWqBKhGhxmM
         JG8Cr2ANAtCmqSbgYaCiYxwWWo/4MKf+GdtNoOYVZ3JK7I+9k8t638k/K9dWa9a+jyzQ
         dRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707741843; x=1708346643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruErS7MH3sscYYbtYh+Mjix6NN8rg0ANIaQIqBK3AoQ=;
        b=ORcE1nn643s0L/w1XfMlg37yholgPuB6284jZXEw6Ccn32S8GqRuJLps5BJGLNt1ls
         nUZpi37Xo0y3KQ+duw7CP+cJDOxxT1Qfdnug1rX/gB0+oOjf9NFcvtBYSjw6xds7JLJV
         /KD4kC4vgpHlbYdCoW8KmiA03sobxorb65pCSOKHx975T/pl1DRSRBQ2nY5JYX+EASmr
         2aPTOGjbPk0G+jPHOCOxzww3r9fZfxGnq7adUB5LDFdtQibTl5FenuCW0vnCKMp8DYTg
         kypzJ7KQi546E9HIjtQae+h431LPtMH9EVRoG4RuKMcqm2LXa565TZrDPUAbArouN7tk
         dfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWKLLYbIQxBaRi47SXDe15JS/M6LgePkz+Snjsq6Bt7r7LjMpTHsBCDDt0Cx7zU5mBb76Cp0UWqVI7GAgVEb2/4pgSU9/Fus8my9NpHbx2KgKhzlM+AMlOWZJw2sbZ6AEZ4G5t
X-Gm-Message-State: AOJu0Ywl54PTvMDZgHyKX0F6nqBRZkPv0PC8fiZKxXs+Zg3Rwq7ayrgx
	RQGTcRc6g5RU4ECwTUe0Ay/T+Jsh7hGAX+qzlQwSc6Kpy7p+Gf0Kzn5vujdBnGpjRmRIsEyIqWL
	0pqWC66XFSB/uANqX3YZvxI1DyX0=
X-Google-Smtp-Source: AGHT+IG2cr3CdhuVwGdq9xVHEiJ5L/PgJRmWJGqroCVmLpHIFMIMIRBURSGCKtvjTevp1PO+m84qN2XWnxzrI3qoKcY=
X-Received: by 2002:a05:651c:198f:b0:2d0:f87f:d7f8 with SMTP id
 bx15-20020a05651c198f00b002d0f87fd7f8mr2433272ljb.3.1707741842794; Mon, 12
 Feb 2024 04:44:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <CACRpkdbw+mJsGb=6iu6f+mGoi+vouu6TPztaD5SyuG+n8Staew@mail.gmail.com>
In-Reply-To: <CACRpkdbw+mJsGb=6iu6f+mGoi+vouu6TPztaD5SyuG+n8Staew@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 12 Feb 2024 09:43:51 -0300
Message-ID: <CAJq09z7OK4LyOfEhx4Rp=EdhNBDcdvQ6EFu+_gY0SN8dTmB1=Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/11] net: dsa: realtek: variants to drivers,
 interfaces to a common module
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

> Tested on my RTL8366RB on a D-Link DIR-685 as well, works like a
> charm:

Thanks, Linus. An independent test is always welcome.

> Tested-by: Linus Walleij <linus.walleij@linaro.org>


Regards,

Luiz


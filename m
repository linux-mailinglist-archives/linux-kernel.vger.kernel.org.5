Return-Path: <linux-kernel+bounces-83119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D3868EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AE81F2613F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D2113958B;
	Tue, 27 Feb 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+pUcC5Y"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94C2A8C1;
	Tue, 27 Feb 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032956; cv=none; b=RqMMaGC8UaPaEhLaEKtYnNkJTOZYh89nf1WcFAXwzn0ibuPrxq2Ev5E2BYrKi0sfiMUxf6bQfydsgctuMANqcJDyVZZ6f0yPuYA1ZFTJz5VP8s/wchXokbRBbVbTu9TiW5hDm0ETzto7n4//nEQTqyFWDlp7dxMxGpYpzwq3Wcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032956; c=relaxed/simple;
	bh=IA1lSmgvPcPf1O82N4BVyuUG9fsFGD8+tdxMugtfybY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1ltH30cttCESx599rlF53LGoXrj76aHZAEGgMfkwQX8r7afGyRGI57t+vKOeJv8FXz+kHt8/8YETc0gbc3hotE/PSzGpmairJys6s5HXWPTU3G2SxD1CMxs6PMpDDS88gSsTm0sCZNjandR3bbrme1wfnr0/8xt39HBe5Jjjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+pUcC5Y; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dcc0d163a1so598275ad.0;
        Tue, 27 Feb 2024 03:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709032955; x=1709637755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IA1lSmgvPcPf1O82N4BVyuUG9fsFGD8+tdxMugtfybY=;
        b=L+pUcC5YjwQq7A2iKbAXgeWhvrwmy82P9GNi5ZRY0IBfO0xJQGJfoLxkWad6qZqKyU
         w1Yws7wRb3QNFlmTSz01u3plRV3bti3QaiIrvd99lHoN8SIPaYsxIs6BSPHs8L+j2jiP
         0jYZHFkEPegPcOFIZAahkbSYVkFiyzvkl7lquUHaddqx5QTyQBi2RwSJcOtA1h890OD2
         cVzgFYtygcgdMeRWyImBF+I31BW7VDb5MP1JHGxMLKXTwK41vTUXIswFjYtluxL4BNby
         cUnOd/B9Pz9tD9B5PWGL//1XtNr7B5SjDiyzGMJ1nLoREwWNx48LiUzVykKIqU7gfcmF
         PNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709032955; x=1709637755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IA1lSmgvPcPf1O82N4BVyuUG9fsFGD8+tdxMugtfybY=;
        b=pMmdck2CGzcvsXdvH2WRV3krWX6RWkorgHGJ+VCkwrsMCGh+Qb8f51SLSHr3iOLobZ
         XUWfOrfdUQ0P/r/cNzu4GW6KIhQb3Unc+eQXiz4thHPMWJzyfj/yqEe0/kid9ElSBokj
         0rUWkwDJik7ZQfEHOs9U761tMPUOGIoT+mG+hKAtuYLNkZTr7o+nM7hEQXoEIn6TiLxd
         MLACREcvDbr4kHniQdDp8UQ+7OVEsX0leNBxzYgLGZx364+GGPYuCWy+Ueggy+VEtLh3
         FNHqzuFUNrizOOUkG+QGub/yAKqq7waxHZhBuv2e9KR0duqNKRRXLK6H22K49BGALLH1
         NjNg==
X-Forwarded-Encrypted: i=1; AJvYcCWSC9Qd4aV2vJgT4gEe+JLLnaTAL416yUXOOnVyclKwVenUWpK+zjuuIPFB6WG2xoIumm0ckZyftUJneWEJbFaSGr5YODt6I9RuiucbqaYkf/daeWvlwFAXTaA+mJWgZxPFaZkG
X-Gm-Message-State: AOJu0Yw8/ihiQTMJAatUQlq91CHKAxVWS+b7J5b7Liazfnblip/3uwwi
	RVk0sZ7/689haEC8/hmQxWQGmt6lw9MDxvooMWpg/ChSPsYxSjRt2Dg+J2GQsGBPZpSNSFZaiPM
	euymeny2Wg40Se8NhoYPZ7GPEQNA=
X-Google-Smtp-Source: AGHT+IHI65Hxyux7ywykxHVgOGWzjTFbXZNpy2u5Ozi7UybM0SnyzCYVa+264uxmh9FVFdiTPAONlir4BUX88TFodfg=
X-Received: by 2002:a17:90a:98a:b0:299:1ae1:51ae with SMTP id
 10-20020a17090a098a00b002991ae151aemr7859382pjo.3.1709032955035; Tue, 27 Feb
 2024 03:22:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226091325.53986-1-steffen@innosonix.de>
In-Reply-To: <20240226091325.53986-1-steffen@innosonix.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Feb 2024 08:22:23 -0300
Message-ID: <CAOMZO5Avrw7L-JxD2wfYUVH24POrJC93Zh+VReZbJDhmO6PCqg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: dsa: mv88e6xxx: fix marvell 6320/21 switch probing
To: =?UTF-8?Q?Steffen_B=C3=A4tz?= <steffen@innosonix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steffen,

On Mon, Feb 26, 2024 at 6:15=E2=80=AFAM Steffen B=C3=A4tz <steffen@innosoni=
x.de> wrote:
>
> As of commit de5c9bf40c45 ("net: phylink: require supported_interfaces to
> be filled")
> Marvell 88e6320/21 switches fail to be probed:
>
> ...
> mv88e6085 30be0000.ethernet-1:00: phylink: error: empty supported_interfa=
ces
> error creating PHYLINK: -22
> ...
>
> The problem stems from the use of mv88e6185_phylink_get_caps() to get
> the device capabilities. Create a new dedicated phylink_get_caps for the
> 6320 and 6321 to properly support their set of capabilities.
>
> Fixes: de5c9bf40c45 ("net: phylink: require supported_interfaces to be fi=
lled")
> Signed-off-by: Steffen B=C3=A4tz <steffen@innosonix.de>

Thanks for the fix.

Reviewed-by: Fabio Estevam <festevam@gmail.com>


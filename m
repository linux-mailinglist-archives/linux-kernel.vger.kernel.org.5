Return-Path: <linux-kernel+bounces-29550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06475831017
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FA11C213BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1E525620;
	Wed, 17 Jan 2024 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d01rPZHI"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856111E514;
	Wed, 17 Jan 2024 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705534059; cv=none; b=NXE9BfdLxrbjIPzE00bT2PwezBuW+Ll2EDw18tyOjm397dcdYvQGVIBuXPMQnTqaNUdEfiRvWkRzi+gVEasrgTMSO9XPl5T+U6aY3XFewAPPViPrONoIU73uiuq99p2Ntx+QGTMxrwaE/IzQAAF9U6Diuezysg8krlQLU+vLQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705534059; c=relaxed/simple;
	bh=/4/gLoSYPUwQ1YGTf27kQVo5Bc/iWPqA07P0h96ehbc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=m0tqN14JsHVo6gp6CONTQx6kmfpMkCBjqMZN4yVHfoGF+J2XQ1FGX1Ho/3CpJECO3G4e6JxSXwWeazn4QUBAN2zQhQOvNrG4ZJOYoW31Cg4hxz235GjJWpDfembtdIUu9Vhv0DTkC0X1zwUNyqEKLdw/G1y9AWCDIWGOiPaBEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d01rPZHI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28a6cef709so1282494366b.1;
        Wed, 17 Jan 2024 15:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705534056; x=1706138856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUohJlOy6R93P5OLBTaOhjkvOS/ftc1KCXk9CZsmQlM=;
        b=d01rPZHIGHZuyX8OY+M2KQBoOXbCKmdQSvhhU24xsYrJqa0aUOni4S5SHIpVy/vtp5
         MoZhx9VvwZcs8Bj4OJ2yFTwvxK6Lj4g8cTYU+u49fo/7Y/6PSlzm2Zy2P0b/5+3MY9wv
         uudygoJw1RxExgP+PgQh2cL5TkG9rWDK1Ix9tbuwEWK2TXTX5nO020SuCGvLoUPaOHuI
         4VJUGJkIVYcjWp38pY+0Rt/VYNzVfatMggYWCC97Sl8tdPjM7gbqGjhlLOE0L1z0rH3p
         15MbE3/ZYwPvNpWJbdM8WsYP6q8yNB2qh/PYjaBE2xw3WSru2NoY+ERnLUEzXREogdwM
         Spsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705534056; x=1706138856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUohJlOy6R93P5OLBTaOhjkvOS/ftc1KCXk9CZsmQlM=;
        b=q260HZnlzeX2HMC36jeDEfEgaFqJnisl/PQDCMdHzA4DJBDp1CZA811ceVKXMP84C8
         elBqogD3LtaGxse/8IiV0VzJ0Ai9JNJwuJIRcmqCGrReWgFTJ5UTa6M3WwhRBbPX5ecv
         o0tvrJEbyFP2LbNyKpDiNz1cL0vxseyXfzbFkVBwwTcBjsvGwN1Eo1AU1iU12n6lgI4U
         XsxLUXXj/rnntF5vdty4dggI3jxtAQJedHU85ayuNs9cAeoy1o0ISg2LRmN/QS56+B1/
         tS6hemVz8XRUs2OAzQPf3mKleXDCwKdo8OSckbKgxIeVtTiY5H6P4fVuB31UXMY4wu7O
         BHug==
X-Gm-Message-State: AOJu0YxVJJfK5PvcO39W/pr4ayE3aufEFErt5s3+LnaX9iazG1r2Do0Q
	vcUnjlnxZZPiTupAmrwa/z1Gyw6veX5WfrQUCxc=
X-Google-Smtp-Source: AGHT+IHQqOZsodL2tvGE6EQtCWtZXtMpzi5Qc1FfkgZ0rBhi+uYT7IGJntEZDpe04fYp6t4/Hsit3ufZ7Q9ZLVYGX5o=
X-Received: by 2002:a17:907:31c6:b0:a28:93cb:19a6 with SMTP id
 xf6-20020a17090731c600b00a2893cb19a6mr5718639ejb.61.1705534055452; Wed, 17
 Jan 2024 15:27:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117223856.2303475-1-hugo@hugovil.com>
In-Reply-To: <20240117223856.2303475-1-hugo@hugovil.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 18 Jan 2024 01:26:59 +0200
Message-ID: <CAHp75VdxP4pZGEP0drhXvpgATH8q96OEWieBuMb2+-aGKprUzQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] serial: max310x: cleanups and improvements
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	cosmin.tanislav@analog.com, shc_work@mail.ru, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 12:39=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Hello,
> this patch series brings a few clean-ups and improvements to the max310x
> driver.
>
> Some of these changes are based on suggestions for the sc16is7xx driver b=
y
> Andy Shevchenko following this dicussion:

discussion

> Link: https://lore.kernel.org/all/CAHp75VebCZckUrNraYQj9k=3DMrn2kbYs1Lx26=
f5-8rKJ3RXeh-w@mail.gmail.com/

Perhaps you may add Suggested-by to the related changes.

> The changes have been tested on a custom board using a max14830 in SPI
> mode, with an external oscillator (not crystal). Tests included a simple
> communication test with a GPS connected to UART0.
>
> They also have been tested by using i2c-stub to simulate the four ports o=
n a
> virtual I2C max14830 device, but with obvious limitations as this cannot
> simulate all the hardware functions.

..

LGTM, except this one (I have commented individually)
>   serial: max310x: replace ENOTSUPP with preferred EOPNOTSUPP
>     (checkpatch)

So, for the rest
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko


Return-Path: <linux-kernel+bounces-80404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81BA86681D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483B51F216CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03E9EAE5;
	Mon, 26 Feb 2024 02:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RThGUQnS"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F13233;
	Mon, 26 Feb 2024 02:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708914235; cv=none; b=JLBkdl+/a4PIMaN6BrbqkxK5gMPbhDwrGhRb2JcbT4C/5sAOLQ6REX0x0OCtJWWTTKJ/wihNGzaZn4Yy4Lj1sYPllaA2M2pOceXDL/EYyT1rVaTR2k3SiZxvKvV/GgoPlnGfcaZWLBz5WmVsoFFy3BDydxhm+pyTm3kJyOiveLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708914235; c=relaxed/simple;
	bh=WRNR2Yde+eM1MDT0PjmQe6YBmq8+6bOG11aatMwggeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9BOI7ddKJrTgqwTeWCCoHucgmgWStdQOF4kcipC1C6nDc6f5n5qDsv0511Se8STWFbOyPqk+hClQBkFjRgztxiNmvtoWptnjpCuT4gHvzUYY/38CA28UKue5tu88of45OItldzPylH0+SWKZQP8cBR+gQiQdQPISqWgMpSUJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RThGUQnS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26fa294e56so445380266b.0;
        Sun, 25 Feb 2024 18:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708914232; x=1709519032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRNR2Yde+eM1MDT0PjmQe6YBmq8+6bOG11aatMwggeQ=;
        b=RThGUQnSObw1HgwnOAT1PXWlnJk1QN9XPg2tIwZIPwWykwgUd68tHIHP2plpa0tE7B
         7WZe1cpoGsRXzt+eQtJQZBrV5nGoAZR3YeRlEEfGZxKWF1c6vCDBXNSdYjDg88LougIT
         JFHbpA827r5S+3/GE/8YRRJGOzlI9Yfyh+uFhB/94GQJmlKBis5gzExneODuyND4WBd6
         JCrBjJa1y825JF25uTBqgkyVS6biyuzk+kJZPfA3s+x5Nlmzg450mg9yOqEny+WQ14vs
         VIeVWNpZ89vCvcquU3ZDyxTfT0iW/zvjzDg9q/5xUPjg3tSLzAuVgcfUUDv7w6oZ9373
         HHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708914232; x=1709519032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRNR2Yde+eM1MDT0PjmQe6YBmq8+6bOG11aatMwggeQ=;
        b=AZe/6uMlETpRmA1zMty43DpMwDVDn+MMY2AvF8pp6vnFxy75ev/ZbR47h7TW96/Eas
         5WCKvr3pihyxS+95yjM1G0jCQIx7aHb0/EUlnLXdTY5ItVN5ropSITxTca+E0sXNTWmo
         UvdvpNeYxAIphtQmGgELyW0tVuYitgG8FbrQdSJ1gKzv43MwccKjCIIZqTmy3xkdr4Hf
         tat1CiKpz4d4nHft/Nzr0IFidiLCeY1rUp/tdiIbtsf2+YeYBTGVcaLm2bQAwfWu75e8
         wlYR8mgdlRSGVABa2AZpvPiZN/Wab/AzOC8ZdOU1Haaf4h1kajqR1NAwCnpoaIDpxzdG
         QzFw==
X-Forwarded-Encrypted: i=1; AJvYcCUPbhhIb2ttt6UE0T/SUfJlGiXON8MD0KJqWIZOqfy/3zYvzRvIBtzKIH38fdKN0UCwRzCnTGQuDiFC2vVizbjvjj+OWL9lXFcD4tIXgeaUxL4QFUvJzvjHKSRJ/JCTqT7GJxBdcXs6qWXiAexAI8OE6H2mp/oqyCn8w9q8L3dYQsaBG5s=
X-Gm-Message-State: AOJu0Yy+wcDAKeCU5JQV/SAdQ/evKf61rHKU59PvZu0C7YMjVY0k5aq2
	SCM9cZAFPpNnLzdINR4hmWniaWDfXYGh4lcn4BzlvyqNqf6JVQYfvUzZ2qyIPLDa5CSTkgKtdWi
	BGmdb2SP+6W/Odz6FjXXcVMvlGb0=
X-Google-Smtp-Source: AGHT+IF1LO8GFispgremVVqbGf6oZjhb/+i4rsMZg2vxLPqRMyLjKiB/rkSWNNcmVULSYlt8LOTOEKMK167ekpSbAVo=
X-Received: by 2002:a17:906:688a:b0:a43:4ac2:f16b with SMTP id
 n10-20020a170906688a00b00a434ac2f16bmr895377ejr.13.1708914231478; Sun, 25 Feb
 2024 18:23:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2024 04:23:15 +0200
Message-ID: <CAHp75Vc9OBtxdKSmk9Uu9G3j+mfN8+9prTEVx3LyUcdBYFEqwg@mail.gmail.com>
Subject: Re: [PATCH 0/3] auxdisplay: 7 segment LED display
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: ojeda@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, geert@linux-m68k.org, pavel@ucw.cz, 
	lee@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 11:34=E2=80=AFPM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> This series adds a driver for a 7 segment LED display.
>
> I'd like to get some feedback on how this could be extended to support >1
> character. The driver as presented is sufficient for my hardware which on=
ly has
> a single character display but I can see that for this to be generically =
useful
> supporting more characters would be desireable.
>
> Earlier I posted an idea that the characters could be represended by
> sub-nodes[1] but there doesn't seem to be a way of having that and keepin=
g the
> convenience of using devm_gpiod_get_array() (unless I've missed something=
).

It seems you didn't know that the tree for auxdisplay has been changed.
Can you rebase your stuff on top of
https://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git/l=
og/?h=3Dfor-next?
It will reduce your code base by ~50%.

WRT subnodes, you can go with device_for_each_child_node() and
retrieve gpio array per digit. It means you will have an array of
arrays of GPIOs.

> [1] - https://lore.kernel.org/lkml/2a8d19ee-b18b-4b7c-869f-7d601cea30b6@a=
lliedtelesis.co.nz/



--=20
With Best Regards,
Andy Shevchenko


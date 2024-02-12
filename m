Return-Path: <linux-kernel+bounces-62353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BEB851ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7706D1C21D44
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6887482EB;
	Mon, 12 Feb 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkk5glm7"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEB843AA8;
	Mon, 12 Feb 2024 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770827; cv=none; b=mnrr6cT2A7gZsYenrbBHMk4A7Nl2jR2mrUwAljsNACZCyMlOcZuYgG2ZrPQcav3yCprnkjJpYoJZsjb5vUkVdxGvJ1HVzQHkhPUSzquJPbqS/hG7f+L/FePVm9D3eD/zYuAglMYc+t2Z1ZnoSnFaNzTAEuJETMjQYfGCoJjJ54A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770827; c=relaxed/simple;
	bh=fn/5FyBTMnahqzrbwfSbO2KeE7u5oVugq+iHM/NMsHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEKpRUvnNFhnFN1OzYBt8k5UnuNU+ao6M0kBXhnfPhvj4+PJ2AcFByawUCMXGbID2RaAQkmVHMOfLdZU21mlo9vkz2MnwqEzTLad0RD9ZNH+xk1Pncs4Ehn9ChU2YwFZV4jWcL24zuPtmJzJGgG1Hc8Z85vOh36OYhBn5sR2Sb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkk5glm7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4116650a345so6696205e9.1;
        Mon, 12 Feb 2024 12:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707770824; x=1708375624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Wilr3QrMZJFwg5LcPt9WBQXjwBqyBsWNwp0pkv/Cww=;
        b=mkk5glm7kVWofrzoL9fZ80s4eSr90UqMj4FeQZeNoV4fMg8OeFSpZSadN3h9ZOYYEw
         ExcA2Nu0JK/gfJY4S0U/7OErhyQiAXhJXtJKsE1UZk8PJStGOjIyEzdpisr3sIK49XcK
         SZQK1ex7/UhdV/28lNSoEPVWz3ozfax8OweZ4ojlfyGoDHvf+md7NWKFlLNKqPST5i8J
         jojcwh0wwHjNUcpDQvvGfvZm9zQdiycWFUk/3RcV0jfsKi42NqNyWnurKXMkgOTddjOt
         2YOMxFrlC9Qr+Ijzy/2BOIGSIxFOkD+ZSnOSmKcncy9W/F805MHmlIni6QXkHV2GNPNk
         6mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707770824; x=1708375624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Wilr3QrMZJFwg5LcPt9WBQXjwBqyBsWNwp0pkv/Cww=;
        b=n902BWQKnI7aO/rfn79v77fs6D0eRQdwM9DMD4sdEGVtYuxmfl1J4amMUSZIGRuxfB
         Lkwh1cFSvYjjuPm07G/x8sqmppKSS5SdtM8VQc1NPHAItb03zMxfle+x4AfHmyzqTVzX
         2Pr8lXO8Hz3B4yDPQLRZxkYcdgj2cIy71nzcXgjDkR1hTOZWomI/TIb93+F0oE52V9z2
         2hNlGv0RlNi1W+rqahNvQGtFhsDRS0ORr3Buuf3I18NDzE2RKi5R3HcHe1KoTHhCI6Oc
         DM8CQnH6s7lZ7/jHdRIQLiFnEM9loRpJw3jO2IIDwDHrkH2Ni9cjOIgGw7PewvAkJeU7
         UVhg==
X-Gm-Message-State: AOJu0YzpcgUL06yAUkZijo9gYAiLjRoDmy/D7QmxaK2utCjVqvHmpEJc
	GW7w6HpR7dQMHwOHMIrvC+trRgb0KVLXNX96ji7ZGbXKlR5RPui3
X-Google-Smtp-Source: AGHT+IHQl8C8lV6IrF9Twikea11MfjHKeNl0A2ayoFaUaUSjFQctY/JUdfxlgWGuijlnjz/l7OG8KQ==
X-Received: by 2002:adf:db4a:0:b0:33b:3bad:d3ee with SMTP id f10-20020adfdb4a000000b0033b3badd3eemr5329806wrj.43.1707770823491;
        Mon, 12 Feb 2024 12:47:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGijjUNoZKPS9rcc3LIBg6g+m0cUf2oDK2qWYWYsKjR9Uwl61nvvPEjrpEe288Kyrl6ndLcRoJagr7jkv9oJCmOkmMihcxAHmQ0g0HUsGlLSyPJT0G3mYCwMgl18CUvVeSQFDpTs9CeKbvG5QCXjBUnZbRMlReYQE8SblNakkPflYhHUUre/JRVTORIo9RmEwZdmRyP1aZRUHkUE5Kdi3trY36GZHoBn4X9YTwLxifE2D2gMWIXQLFATFB2zrvQHU434BpaBl0qv3jYMtwUFexVrlHDYJCTJi1KhMldp5NA9QXjmUcLbXcpbPpqwrVytsme8OOxv+Hv2crtoxmS1ftdyrKDl8l/yuupckBJNlAiW4SyOIoLdI=
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id bt25-20020a056000081900b0033b792ed609sm5526948wrb.91.2024.02.12.12.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:47:02 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>, Jisheng Zhang <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 2/2] arm64: dts: allwinner: h616: Add Sipeed Longan SoM 3H and
 Pi 3H board support
Date: Mon, 12 Feb 2024 21:47:01 +0100
Message-ID: <2596781.Lt9SDvczpP@jernej-laptop>
In-Reply-To: <20240211081739.395-3-jszhang@kernel.org>
References:
 <20240211081739.395-1-jszhang@kernel.org>
 <20240211081739.395-3-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne nedelja, 11. februar 2024 ob 09:17:39 CET je Jisheng Zhang napisal(a):
> The Sipeed Longan SoM 3H is a system on module based on the Allwinner
> H618 SoC. The SoM features:
> 
> - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
> - 2/4 GiB LPDDR4 DRAM SoMs
> - AXP313a PMIC
> - eMMC
> 
> The Sipeed Longan PI 3H is a development board based on the above SoM.
> The board features:
> - Longan SoM 3H
> - Raspberry-Pi-1 compatible GPIO header
> - 2 USB 2.0 host port
> - 1 USB 2.0 type C port (power supply + OTG)
> - MicroSD slot
> - 1Gbps Ethernet port (via RTL8211 PHY)
> - HDMI port
> - WiFi/BT chip
> 
> Add the devicetree file describing the currently supported features,
> namely PMIC, LEDs, UART, SD card, eMMC, USB and Ethernet.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




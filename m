Return-Path: <linux-kernel+bounces-125590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2EE892919
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7CE1C21098
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9468827;
	Sat, 30 Mar 2024 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="p0zHST5m"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7763CB;
	Sat, 30 Mar 2024 03:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711770753; cv=none; b=FL2iS3+1EAWXdEqMQi22NmS1zTT48fy3wJ1d4fYYtJDznSRjf6/ATi5zZj1s/VwUDHfJAw1ws/5grEYCZofa/AFTjU6gRgxlLcjK7JFbV3IWUGznkvr3yHsdx0R2gjnn4Xp+/waPtDO4dlX8EX0lmV18oZ7CC7H6LoEl1mBVzcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711770753; c=relaxed/simple;
	bh=pLFOE/nP5lpMYNG+2LK9dk+rrFBf+9iWpFWOlugIBMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bpuyr0RAyOPlVV2arxe7MsZ/pQnqJCjzSoM0Ik38UzUIyyQEGvN5wQ79UgJfL3gh8rZvD2HH2iKZv+toWho4afnQkQPHIm/19nfW8R3PQcfOV/+wEUNQUgDEQ89gD/mjyasTIcNZ2kbkn01lOGlcwEd4l6d3oblupfVI8xvlEiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=p0zHST5m; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4V63J85CkqzDqLd;
	Sat, 30 Mar 2024 03:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1711770745; bh=pLFOE/nP5lpMYNG+2LK9dk+rrFBf+9iWpFWOlugIBMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0zHST5mQjd11XNnhXY2VjNAX95Lo8K1cIjO+pqd49hYfjviptmaakSIZErj9eHyZ
	 nT/E+4X8l08PHWEz/rR1zj5NZJyhV9bKr2bRPQFsinhKumatshE94PR69su0YG0OM2
	 IyC2uYORVuFNHvU8T3FARBCdgAFSzb6Vzz4LekNU=
X-Riseup-User-ID: 1BA547B91BE34F02CC25BDFC23FFDB9B0F257A791B2954B3F508845C9EC61ECE
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4V63Hr5rJSzJrxj;
	Sat, 30 Mar 2024 03:52:08 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
To: linux-media@vger.kernel.org, git@luigi311.com
Cc: dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com,
 mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, sakari.ailus@linux.intel.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Luigi311 <git@luigi311.com>
Subject: Re: [PATCH 00/23] v2: imx258 improvement series
Date: Sat, 30 Mar 2024 03:51:55 +0000
Message-ID: <4599295.LvFx2qVVIh@melttower>
In-Reply-To: <20240327231710.53188-1-git@luigi311.com>
References: <20240327231710.53188-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, March 27, 2024 11:16:46=E2=80=AFPM UTC git@luigi311.com wrote:
> From: Luigi311 <git@luigi311.com>

The Linux kernel does not allow anonymous (or pseudonymous) contributions. =
You=20
should use your real first and last name.

See section 1.5 in "A guide to the Kernel Development Process":
https://www.kernel.org/doc/html/v6.8/process/1.Intro.html#licensing




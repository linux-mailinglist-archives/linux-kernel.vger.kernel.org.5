Return-Path: <linux-kernel+bounces-80055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7182F862A38
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CEA281C3F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228AE11702;
	Sun, 25 Feb 2024 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+L3wqwW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDF510949;
	Sun, 25 Feb 2024 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708862922; cv=none; b=iOboOxqtcenGVgFF4L89diiuOhuVecmu+nurnQY/kPgV6/ImwcV//orqrzMOJem35GPcNVS3i+Rj35hAbREkB7RCsiusiP0JK+WCZejhtKqQ/4sGWpug23eYjel+FC/sFIX0WEWIktppT7d7bdjwur69Z9bF7hPJkA+OXxu2sqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708862922; c=relaxed/simple;
	bh=eydAkpN3ARvz8HNfZbd4wFlBoDliT+NX7NKAijjvth0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwJrJqxAIRKMGbhiQWO/TRPQBSc44pMcEj9w5yRgYh14oPh2OU+Kru0S3U3CPVYsBBL2RLcrK7GBehU/07lM/tjgJcXZ4jVrDijSiQBjuS1zSuQ1xRRQQci6DJLvVKK3UtS39DgKpqti4B7SwO9zH3bpaVkXf/W/axYXK1Pj0Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+L3wqwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4EFC433C7;
	Sun, 25 Feb 2024 12:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708862922;
	bh=eydAkpN3ARvz8HNfZbd4wFlBoDliT+NX7NKAijjvth0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A+L3wqwW5kU6J1ew7Xy45XRrRdzax5touHVHzCU2p4MqE8B4OSMXHRbH0YN4cfBEn
	 o6EjskXbrNjdiUhT8kJ8qpWqn4kEohKIKk/j2+KRRctfBpYAbnqTbsd/dKsdqciNx0
	 VB0D+nCPnFxHkeEtl61I7uXjfH0pZNmxCxMeBcGButUY877TcNPbCbi1uwbWdaszqS
	 IwdH/elwQiDmPUeQ3PMf+A9Fyw+u+zgdQyYFLRLxlptyQgPnT9VcJk2JGSExDugtnY
	 7PDsDAq34WL4Y31fHB/byeQQim9YQj8pUVu95hwx/XyFsoKe7fediSyB5JHv8kqdPw
	 arYhAvRVJCWvA==
Date: Sun, 25 Feb 2024 12:08:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?T25kxZllag==?= Jirman <megi@xff.cz>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng
 <icenowy@aosc.io>, Dalton Durst <dalton@ubports.com>, Shoji Keita
 <awaittrot@shjk.jp>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <20240225120828.3ae2d16d@jic23-huawei>
In-Reply-To: <20240222011341.3232645-4-megi@xff.cz>
References: <20240222011341.3232645-1-megi@xff.cz>
	<20240222011341.3232645-4-megi@xff.cz>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 02:13:37 +0100
Ond=C5=99ej Jirman <megi@xff.cz> wrote:

> From: Icenowy Zheng <icenowy@aosc.io>
>=20
> AF8133J is a simple I2C-connected magnetometer, without interrupts.
>=20
> Add a simple IIO driver for it.
>=20
> Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Dalton Durst <dalton@ubports.com>
> Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

One additional tweak from my local build tests.

static

> +const struct dev_pm_ops af8133j_pm_ops =3D {
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +	RUNTIME_PM_OPS(af8133j_runtime_suspend, af8133j_runtime_resume, NULL)
> +};


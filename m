Return-Path: <linux-kernel+bounces-92315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E46871E55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1CA2846B1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B645915B;
	Tue,  5 Mar 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh+rhWON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99A5813A;
	Tue,  5 Mar 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639722; cv=none; b=N0aJJorenoHIx2GkGTrkaPKHt9IY/sBWCWeMoSfmlwb771Je+U5VQWvFYfMa/aWkGPZ+TBK2SY6cDw2TyfFvKAEg2NPuAGMRdcmlboHoJufFTUa0lyqC+s1hdUs/PgAMpXd/HhSxXRPlZseLGxS3wrKvCfGiTkUc14v0yuPabwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639722; c=relaxed/simple;
	bh=DU+RVLQVY3kNlvg7T9yLtYUPHL8M54pV5iwQQRUTv2A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JqI3VG1WNXmPxt9tL7J17klaZGDZh+yYWnIirpe+skPpgcCQ0JUk9F7RFMrNg8qaGx0TJ0citrPGxrhGXmWcl6OxEKD+k+lIn9NdQHpDG6XHd1S2OHT7GiwIL61VYSgQwdRSK6wVFJt+L3OCw4NqsDJwhkPVLmJPzEw40t4XUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh+rhWON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDE3C433C7;
	Tue,  5 Mar 2024 11:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709639721;
	bh=DU+RVLQVY3kNlvg7T9yLtYUPHL8M54pV5iwQQRUTv2A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gh+rhWONMTQ61lm9obb2xe7N6/fMegqws1Ga0EeYaZkpsa95HmEloLiohHseIeGQd
	 R9bfKKKNGxUKbJOrvSZvrvZYMfYonIXwYsIymTuS1ZN3WooEm9LMQn0k9yiNvPRKcR
	 H+7VbmBBhM75s7WqY/2T+kTpBneoikDhrka98QNarM6P6W8rRzOYLt+2VmL/za+Ynd
	 LGCiyuz5cKFXjwhl/nm8iqLvou+IEMKGhMadq50vXMRQ/5U4J+p4hy5nUjnchPuUFW
	 Xpktstm2f5QSrhdMF1YvAbEIA46KkwvIdHWNPYX5YAuYoiWjGwZxuc2kj6uoN8qAWc
	 40f0/s1GWLZaw==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alice Chen <alice_chen@richtek.com>, 
 Jacek Anaszewski <jacek.anaszewski@gmail.com>, 
 ChiYuan Huang <cy_huang@richtek.com>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
 Jean-Jacques Hiblot <jjhiblot@traphandler.com>, 
 ChiaEn Wu <chiaen_wu@richtek.com>, Abdel Alkuor <alkuor@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240305042049.1533279-2-alkuor@gmail.com>
References: <20240305042049.1533279-1-alkuor@gmail.com>
 <20240305042049.1533279-2-alkuor@gmail.com>
Subject: Re: (subset) [PATCH v3 2/2] leds: Add NCP5623 multi-led driver
Message-Id: <170963971860.120208.1620387581063400974.b4-ty@kernel.org>
Date: Tue, 05 Mar 2024 11:55:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 04 Mar 2024 23:20:29 -0500, Abdel Alkuor wrote:
> NCP5623 is DC-DC multi-LEDs driver which has three PWMs that can be
> programmed up to 32 steps giving 32768 colors hue.
> 
> NCP5623 driver supports gradual dimming upward/downward with programmable
> delays. Also, the driver supports driving a single LED or multi-LED
> like RGB.
> 
> [...]

Applied, thanks!

[2/2] leds: Add NCP5623 multi-led driver
      commit: 535a2262514d7d4016411707c9f8ac106062615f

--
Lee Jones [李琼斯]



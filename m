Return-Path: <linux-kernel+bounces-71037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8694859FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1611F20F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC78524A09;
	Mon, 19 Feb 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovNiocm6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F223763;
	Mon, 19 Feb 2024 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335386; cv=none; b=D+zwDXDQ4VoK9ohhe7rEGl5ome00AimJAb57tLYqhvylOQBON7ZdP+Mcp4kFJSJ9j37RmThddHt0AgXjhxNvKjcrJOSU7HWxIx3dEoiEX9qT//woP50ySrhu3158gTiWTHsgVH+QF03ooHaeleLB5MexrIE+1a/A1H5+S4F6gPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335386; c=relaxed/simple;
	bh=uIeslGUrMiIxBs3Hoekn0ZFqBZXLWeLXlSxJlmij2aA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fTiFhiNascDh5VaT3Cr4J+IAL7TWMT6PPG9UhtyvCFMKaMmcLsEI+u8eXm17m9UJsUOgPwfBBhrCcriubOf9Rtso1tVWSOogA44vJs2BOYiSjUb3fEez1C1pUksSn3Bx5c5amHBh4xpde1A+MrhOJahFeU44JhIJUMkrD7LI+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovNiocm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9F13C433F1;
	Mon, 19 Feb 2024 09:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708335385;
	bh=uIeslGUrMiIxBs3Hoekn0ZFqBZXLWeLXlSxJlmij2aA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ovNiocm6Kq7R4LaLhsLq/KTqT4WL9WMPEGi8i1KIRQzpN4KC97F9VRrR6CKQpmFF1
	 M1K4WeiK7phEk9O//9QpDA8p1u7FOhLt3RbEC6cRYGMQvdiLkHj1lbHUVLzHbjISWM
	 aW4abDBqPlzIJtbUCXhbkUyMaqq7MouHKrgp4w2+736lGAUzx1y00sHNZ1R6r/Yl2M
	 AN4fEhQDIRYKChx7GCzccAY2kLhM4WwCpjirYp1Op6wldbXA6Nk9Dn0dH3hG+BN72m
	 qaSKoHYXc78h4kgLma+Buk+yUN2F/v7RzEaugbM43UFKAhEfUAr/+kRNh+lZRFTIcO
	 8KXRTkAt5/R+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8373CC54764;
	Mon, 19 Feb 2024 09:36:25 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH 0/2] Add port@5 as CPU port on certain MT7622 and MT7986
 boards
Date: Mon, 19 Feb 2024 12:36:12 +0300
Message-Id: <20240219-for-mediatek-v1-0-7078f23eab82@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAwh02UC/x3MQQqAIBBA0avIrBNUJLCrRAvLsYZIY4wIpLsnL
 d/i/woFmbDAICow3lQopwbdCVg2n1aUFJrBKGOV0U7GzPLAQP7CXfbOea3UjMFZaMnJGOn5d+P
 0vh8YuMC9XgAAAA==
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: erkin.bozoglu@xeront.com, mithat.guner@xeront.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708335384; l=788;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=uIeslGUrMiIxBs3Hoekn0ZFqBZXLWeLXlSxJlmij2aA=;
 b=9uiTEjuJ0SLjCwgUYlLom+wD/ujYeEnWm/KJsVTE+Bh7pTohkdiTPePxKWgDoJVTjX+EIy7Z0
 bSBrioBNM6ZDlzzUI3u2/EnJYuC7kcnws6qJWI68ukjjY8GKNzaoiDn
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

Hi.

This patch series adds port@5 as CPU port on certain MT7622 and MT7986
boards.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Arınç ÜNAL (2):
      arm64: dts: mt7622: add port@5 as CPU port
      arm64: dts: mt7986: add port@5 as CPU port

 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  | 12 +++++++++++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       | 24 ++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts       | 24 ++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts       | 24 ++++++++++++++++++++++
 4 files changed, 84 insertions(+)
---
base-commit: 5b6df373ec95cf051264f655be0dbe1d6caa173c
change-id: 20240219-for-mediatek-699a100bed94

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



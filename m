Return-Path: <linux-kernel+bounces-125700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF3892AD3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736511C20E25
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3338C2D796;
	Sat, 30 Mar 2024 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="UPQkPCkM"
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48D2BB1E;
	Sat, 30 Mar 2024 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711798324; cv=none; b=mgDi4mrZZvCxNPVu1Zo9ecpZQhKz1zW3CJ4A3+DqZWlvnCoVC6F1YRW2cU8DjzRBdsjVUyarjmx9/zV4BfvL5JnYGtCfMaIQjJG0QhEC2MX1S/KuVmSD26kP5Qr9jTgFNGjNa+sAkzh+n+kOjvL1/6tBgVuIhc3UEPkXNtN1Kl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711798324; c=relaxed/simple;
	bh=k+xr2CdgZbDES1PB5EMb0dI+5hlK5uhxDTWonGxYilo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzcSJ+uidbNUJgQur6saJoA41y4za8ZI/ru+CY6ImIrt76fQA2r8+ruN3UvWtLIvNis2Ia1gsQ7lLNNYWy0FpUpE/Fyw0ZwLiP/rE1R6BvGZbnI6XpRnkvOHpEOWNf5i8ihpcIjRHsvNXF4GP9RGmnR9XtcLJ+b7TiwRh8rdq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net; spf=pass smtp.mailfrom=6tel.net; dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b=UPQkPCkM; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4619:0:640:d09:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 461EA60BBA;
	Sat, 30 Mar 2024 14:25:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2PN5co9OdCg0-dHeX0PRv;
	Sat, 30 Mar 2024 14:25:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1711797921; bh=k+xr2CdgZbDES1PB5EMb0dI+5hlK5uhxDTWonGxYilo=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=UPQkPCkMo7OuVDyefhG9qHvu8iT8D4vBlUHzNcUCcbfW8KNh6Q1TMjk3rt0gKJhm6
	 p62vKdOuLiyDOOOcRbzxeJEJtE0mCHMKSVrQW7fdkYU1cOvl/7QJ7c1LVDC0wg/Ldq
	 BwHPerOWEJm40sQuzOO6KS+g6+33jceNMCvOAf10=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From: efectn@6tel.net
To: heiko@sntech.de
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	efectn@protonmail.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh+dt@kernel.org,
	sebastian.reichel@collabora.com
Subject: [PATCH 1/9] arm64: dts: rockchip: Add cpu regulators and vcc5v0_sys to Khadas Edge 2
Date: Sat, 30 Mar 2024 14:25:02 +0300
Message-ID: <20240330112502.223828-1-efectn@6tel.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <5a7bd2cd8703e51382abfc11242de59d45286477.1708381247.git.efectn@protonmail.com>
References: <5a7bd2cd8703e51382abfc11242de59d45286477.1708381247.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Heiko,

Sorry if i bother you. Can you review the series? If there is a problem i will send the v2.


Return-Path: <linux-kernel+bounces-75995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36CA85F1B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF22281CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E5417752;
	Thu, 22 Feb 2024 07:04:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986BF9F5;
	Thu, 22 Feb 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585498; cv=none; b=O6gf+nKriZutIDAVlf9WxvyUUS0A6H0UCgCsU0QrvrIN8WB4vUbpVFPv/hYawpDg82PwGHMzm/CxBZGmg07Z71SP3QuEAx+F5mCRbJqd62X/HTlVJwl5vLiZbkTLq0rRkJere7LEw61SDwtwlDxTt+uNt6pX7YkGuKbNIgNjm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585498; c=relaxed/simple;
	bh=vFEysIADZ6GE8UhaNkGEGe+Ff6y1/73fPGkQXCac/G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/b351rQGKVtQaAMBSI/65H42US0CX9kv5AmDdmv1PBcQxndze1N2NF2Tq8+wnrM0X9LUAIZNloYJ7qtJ9SzWN8JG+nUJkMqeInBFALEWFgGgr5IMQagvhkGJMvV7nWIJFngZVvv1q44pztSUM3d3WcwksdnIqnWFg8wbXYDoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECC391007;
	Wed, 21 Feb 2024 23:05:29 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 810793F762;
	Wed, 21 Feb 2024 23:04:49 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	"Ole P. Orhagen" <ole.orhagen@northern.tech>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linus.walleij@linaro.org,
	ole@orhagen.no,
	kristian.amlie@northern.tech,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Shawn Guo <shawnguo@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: vexpress: Set stdout-path to serial0 in the chosen node
Date: Thu, 22 Feb 2024 07:04:43 +0000
Message-ID: <170858541139.105402.16635187273883858613.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240209112807.1345164-2-ole.orhagen@northern.tech>
References: <20240209112807.1345164-2-ole.orhagen@northern.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 09 Feb 2024 12:28:01 +0100, Ole P. Orhagen wrote:
> Specify v2m_serial0 as the device for boot console output through the
> stdout-path in the chosen node.

Applied to sudeep.holla/linux (for-next/vexpress/updates), thanks!

[1/1] ARM: dts: vexpress: Set stdout-path to serial0 in the chosen node
      https://git.kernel.org/sudeep.holla/c/bd2cb11fd765
--
Regards,
Sudeep



Return-Path: <linux-kernel+bounces-81189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015D38671CC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05682957E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDB14F883;
	Mon, 26 Feb 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a5WSTTU/"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F454EB4C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944244; cv=none; b=Ph2NAqA6UwKA6adv9vbAbPla6aimcWSp5hja/wtDUjxOrUNCFnQYfG4eHpEQaWTT5sOa+tsvuvXv7D9vqPPE8P+zFR/X7i9+DmLQ2lmNvSg6lHwDyRaNb7GsRoWqaTcyJTNWXMtzgxNiQPgg+m3m8gOMqypbU8phA1egI9aGoE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944244; c=relaxed/simple;
	bh=8hS2oAwhzHciJSXjZ4tMAqPI9L5dxVp0/oO90oFmkR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HvIz46IkYdRpMCjvWngyv9HU0S1y3EsQ8WqqyL6mLGqL2ayJI3/immjF2+N0eFzeEhLYSp7pa5wpsIKGBj58cEpJV83PBUMe65uZA29C+eRFcQB2qP/cWGmRO+0yiIjfbX5kFcJenn5LzYaqIm5eFQ0DRxWIUGTgYYOEAdBnbu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a5WSTTU/; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E152E000B;
	Mon, 26 Feb 2024 10:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cklK17Bwm5dwBiAf8H9FByFXeybvyyj8OaQ0L7tSqfc=;
	b=a5WSTTU//vOfhGJSrNKVRWhognBOZfXM5o6uMH5qd/xQ5QclC+cvGqrQKva2gxQqmNS5lK
	50ZLsTuBIvd9yN7EYOf/n5l+BEvOZdzdnNKec5jMLivZUih2Jzkht3qKi898KB8qTA3RAw
	6klNIii/oohf5a+6xA0eJeVKWE1zyUs/h3cXf0rHow/brugefKODt+XJqKXuh6mavqlzcQ
	rmhjzUfdaTMz0A1JrSMEmPdjhPsNURWEMWgBTZvuV5B6cMMrowaMZX+5hlLlv3dSpGunVa
	bVHjmkDQLF4Wb7lM57IwhrTeaLqEJWjmhJdo3RmrEAwKGOIZ5DSIUnyVpDXG/Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>,
	Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	David Regan <dregan@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v6 10/13] mtd: rawnand: brcmnand: Rename bcm63138 nand driver
Date: Mon, 26 Feb 2024 11:43:59 +0100
Message-Id: <20240226104359.489391-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223034758.13753-11-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2276ebe099cacb471ebff9a971f10ebd04edbd47'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 03:47:55 UTC, William Zhang wrote:
> In preparing to support multiple BCMBCA SoCs, rename bcm63138 to bcmbca
> in the driver code and driver file name.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel


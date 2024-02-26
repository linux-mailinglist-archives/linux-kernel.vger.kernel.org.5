Return-Path: <linux-kernel+bounces-81196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514E88671D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C210295A18
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804AA5339A;
	Mon, 26 Feb 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KPPulmTg"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601453377
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944274; cv=none; b=pxQ1P/o2orJO4Yb+EOUpQUPhrza4oluntALUh8psxV+cO0k0XacPyNSdvqBEL1s2WfkYb3q49a0GnnMuvkMz7KAgQmVwUt+PqhYgjyRfB2QGn6jBOVnswKamKWGvrFCuAqIM120PPIxlsyzGVf/631ccZDEjxYpkEgoYSuG0OLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944274; c=relaxed/simple;
	bh=wjwJKQDZmjUlj0f2bP8VH+jAxD1eAnt9l/c+fStLLGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oFdJtQI6kl+JEjPuefOYttysaE47mAviYSdSY6UKnmP+4GU0l7DZrngBSOXmdUXu6eyDf/R77i+7LU7fAYl5U3l8oHTsnP+UJufoMOnt3iJrDYv7HbOM8vub25vnSIxfEXHGmfxP7yIfc0qQ5Npv3rcKRVwtlq3j1kCtk4T4nSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KPPulmTg; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1750240013;
	Mon, 26 Feb 2024 10:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjjoQd67ueW9tUYehmx3lew+ekNl/RgJiOHf+uKawh4=;
	b=KPPulmTgjrIL8rQttjQzYXq/5WbvureAD6QpZbuHZsTmNCI9wJy5OFk6rDbjxOuvwexqkM
	VC3n0TSGNi0k2NFNOSs9wvcw/X+aLZyD6wbhDwALgbBR4nIcgyIb+aIqVaV856k+yexQOM
	5TR2tpIXfncqfmbHRZ8d6/FXpr5ee2BdORY0WiSZGiA2vMtnenMqUayllsBl38TyJ7iJIr
	BoyKopTFGn/w6nUyKo37WFdFRsSQbXSx3EoSwGRh4C7u8v7dZ6ToNr9/60V/R5aqSUX/p4
	8jikYP9qZxjVmMA+tfsuXV75heOWabZXfsdORQeGT4brmBuckuKJhDryKurGIQ==
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
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v6 03/13] mtd: rawnand: brcmnand: update log level messages
Date: Mon, 26 Feb 2024 11:44:30 +0100
Message-Id: <20240226104430.489749-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223034758.13753-4-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'5542164bbe4bc33f88e42edec1ff3164d1ea4086'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 03:47:48 UTC, William Zhang wrote:
> From: David Regan <dregan@broadcom.com>
> 
> Update log level messages so that more critical messages can be logged
> to console and help the troubleshooting with field devices.
> 
> Signed-off-by: David Regan <dregan@broadcom.com>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel


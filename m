Return-Path: <linux-kernel+bounces-95937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96107875522
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C840A1C20ED1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26C4130AE5;
	Thu,  7 Mar 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UGH/x9HL"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5112FF6B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832508; cv=none; b=PrSL2DOqG8sAIWqVAZWMSlwLx9N8pPLRsyP+uCPpNesPRF8CodzK1+7EZB2pA1fJQx3gThp2RWlS1gQ9dA1Odue6/+LK0pkVzcDP6SfCZ5+BxymRtNwFdtt/s9fdih1tjvTrpd9doABq9i29Uahb57+dlnkTaoLQTu6qTgo/5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832508; c=relaxed/simple;
	bh=8oG1PKe7KmsZ6ILQlNXfjtWe/AfImTSU72IAcUi7eMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/hmfjTWn25QdE1e4a3oYTuTjMuyepWyuX5jFAm8VSGnDzuLgkdz6l/4CA/GjcLpWLH/V7sbpeB6bl0WDUaZOlstp4JAmBbPy5drizlcev2CsB8SQy3UISyLKE+BlrmKBCY/75HRB9lpxQ3b8UJSCoxA/eAh80673SS+Si2VIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UGH/x9HL; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54553240004;
	Thu,  7 Mar 2024 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709832503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aL50skXyFcF8c9mQLCQNSVaw1NtE9pv6wXX96Vazqgs=;
	b=UGH/x9HL7Pnp0cOFXHeaGdwhzDvkGJcU7e3yAN+ndUAL2U4plzN+x+txxcgJDK95E2Wwde
	0xuMsbzjIvzyQajESPm2Z8ODBDsrY+JxEEFBatQAjF4KXrCDfNgCtjO7ppyzPFwom+9o16
	J5cRJQyMR6NiA5nq5vFHetoj6eMVBw+SuO07GNo/p5VcYtOzpUJlmK9hWQW7hahGvKauFx
	/Qfhg+5AxNqnVcXo3JySTOD9UR5xdrqzb/Npx10xlSvvGt/1HKNCfXYO7kwzvQjlt42mTi
	fMnMFcqBqi1WqxDvQUy+K/PEwj+xzQcih+xQ07P4wThem36JCpOH0CpOGlwJaw==
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
Subject: Re: [PATCH v8] mtd: rawnand: brcmnand: Add support for getting ecc setting from strap
Date: Thu,  7 Mar 2024 18:28:20 +0100
Message-Id: <20240307172820.3451477-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301173308.226004-1-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'42298b844fc49f09449c1a6e6809ba8b6d4dd952'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-03-01 at 17:33:07 UTC, William Zhang wrote:
> BCMBCA broadband SoC based board design does not specify ecc setting in
> dts but rather use the SoC NAND strap info to obtain the ecc strength
> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
> this purpose and update driver to support this option. However these two
> options can not be used at the same time.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel


Return-Path: <linux-kernel+bounces-81187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C19BD867339
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7DFB342D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3F84EB39;
	Mon, 26 Feb 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FqXHb+lo"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A04D9E2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944241; cv=none; b=pK0awY4L5OVrfqnLE/+6hk1ZZGQsyl4ZjRGw9d9X3dgQflZRKB1u9NT7Yp3qN2Cm/tc0cliCByWzs0qW9rXPoahSD0sdK0O73pmmW3I1WKICj6TYJaxCLPhDzN2dXvABHAN6C+ZIdwST3K06a6CePmV4WBWEc4Ghn5i99tQUcQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944241; c=relaxed/simple;
	bh=oTVCHT4qU7g4uJQlYnjS1KLLqa/CJkpTdvi9fjFBaug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k5wgvsBYzIXJezd6/6ql0czxaYX/YZyg7LUVA0+/iacdYWU9nW9C3ziZTy3lhNq2iTURpUInvyNH26sjM0Bo9KfWKe0FR31W+/SQmkIFmAWWz7HeV8+eckusaW67+TLaZm7G18DCtwp5Wmqg5uwYpgXry/Xjt2NfJHxDcjsKQ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FqXHb+lo; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1D01C0011;
	Mon, 26 Feb 2024 10:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdRawac68NsRIpkX0DLFTtmYohZyLK8/joeMPj7bLS8=;
	b=FqXHb+loYX2V8sz6qbAUAD5bKz9BUydI2jRFks41ReC53QA63ku8YMAtM1FZmQJ4Rzowe0
	RcvKGvQJQkaeFB92h+OYy8jbJXm/IAcEXBQdYC/S29WY/zVXq0DnbyOr6yuyhDBFSydb+E
	nEZGgDF3D79h9YMvHHbltEVD4/3Yo1cnxhysT5E27TX6DrGj71w76tKg+aKWayq/Fhcf45
	3Uz9MQzQm0djaUS7+zLlFPIRNEJY9GHSrIuGnOWW0uWz6Ttk5zVFyjpq7aYjxOT8JW+6GC
	XzIbemVaHXpUMxyukWfKmQ6w+EBcBdHy+6XXuqJD8nF17TPDnxkssMB5qDFmjQ==
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
	Florian Fainelli <florian.fainelli@broadcom.com>,
	David Regan <dregan@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v6 13/13] mtd: rawnand: brcmnand: Support write protection setting from dts
Date: Mon, 26 Feb 2024 11:43:48 +0100
Message-Id: <20240226104348.489295-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223034758.13753-14-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'07bd260f0ee819be566a479d703a00452eb2cc7b'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 03:47:58 UTC, William Zhang wrote:
> The write protection feature is controlled by the module parameter wp_on
> with default set to enabled. But not all the board use this feature
> especially in BCMBCA broadband board. And module parameter is not
> sufficient as different board can have different option.  Add a device
> tree property and allow this feature to be configured through the board
> dts on per board basis.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Kamal Dasu <kamal.dasu@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel


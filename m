Return-Path: <linux-kernel+bounces-144885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E268A4C29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D13F1F22875
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639FF4AEEC;
	Mon, 15 Apr 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WdZH/YOI"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF650A78;
	Mon, 15 Apr 2024 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175629; cv=none; b=eLOQ1KGfPGzCrYE45YlqQmUcfL/VRhAdKm3QlDjlqnHpghAz3Jy+D8AsBFmT31A5b9Hb8KXxxcEXIMcsoumo9tyfqnt4AwbpPVyI240xLvx+Mv7MBXlf+dJLXpTmRrl2tdxhElvpP975I5b+lJzsfhkDvTxzuVqD+TK4rIJy0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175629; c=relaxed/simple;
	bh=FnLUTeHzWMiRBs/xI6qC9ARGS8xGisjzcM2cza2/DN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHnV78ZIKdQd3Zi8yl8Y6TtuP2un0Stu/EK5zAgu6lxF9KQQdhOqE7VWFfmKr9jtd966h9ZzP4JsMYEBVFVkWTFXc23NMAD+ytYOz5e5d48S8qW4zyAqKgYjNuwmiDeOBWp/IYpU4J+trYwIc4PGEuZnhkAyDP0oOzWkAuR4YrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WdZH/YOI; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E93DFFF807;
	Mon, 15 Apr 2024 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713175620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5QLmDLe7bTBJ0+9ot2S2z1GTRFgNDrJEqWQ4tSiw9M=;
	b=WdZH/YOIxbzPqd9V1i0OXiHiO+KJ3JLh/SY9hmxmROpoq4nqPlR0ecLlQqP4y17L6ppZfE
	J16t1EOO2ixBAFZp7QXfJBxDOoLyzoH1tptJVKNgpB/WeDwSJnsHTFfOShHcSLnxwlR6eD
	6neDQ32dxdiszoSx4zkvi7nyrvqY8czeyFhO3JiXArWNUvzeYLGSfTF4YwYiFdt4diB7bF
	x2bJ3MNu9VNsPQaOaYW5Uu5ISJNVjU5DFLeVz0ZMVSnSJB3eOZWIIFTYb2jvtMMOo+0KtM
	xxiGqj1fBQXP+9Pf97WBy/BUQgQODkM8kiseLNo6HUZ0WO9m3xuJGsBE0zfS9w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>,
	devicetree@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	U-Boot Mailing List <u-boot@lists.denx.de>,
	Michael Walle <mwalle@kernel.org>,
	Tom Rini <trini@konsulko.com>,
	linux-mtd@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/2] dt-bindings: mtd: fixed-partition: Add binman compatibles
Date: Mon, 15 Apr 2024 12:06:57 +0200
Message-Id: <20240415100657.32087-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240412153249.100787-2-sjg@chromium.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f48d2d6ebd3bde515f4725a88e53953cd6eccc29'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-04-12 at 15:32:49 UTC, Simon Glass wrote:
> Add two compatibles for binman entries, as a starting point for the
> schema.
> 
> Note that, after discussion on v2, we decided to keep the existing
> meaning of label so as not to require changes to existing userspace
> software when moving to use binman nodes to specify the firmware
> layout.
> 
> Note also that, after discussion on v6, we decided to use the same
> 'fixed-partition' schema for the binman features, so this version
> adds a new 'binman.yaml' file providing the new compatibles to the
> existing partition.yaml binding.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel


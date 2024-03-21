Return-Path: <linux-kernel+bounces-109719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1519D881CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A861C2127D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4739F524B8;
	Thu, 21 Mar 2024 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TVFKWnd1"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3F3A1DE;
	Thu, 21 Mar 2024 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005248; cv=none; b=LMtbgHxEcLx2iZmOnTPvjFXwBJI72EtRJ/p1jaOqdWc2MMo1U/xZ3HBIcOBJpBNqSy0PsBLrgUN5aYfZxy/Cm1VR5PotlkO+WJsYnzbXMa4RUtbgZqBya8gTlUbu0fmzXOygdM+2YH72o0h0AFiAhfOalMPZKqFRA4A4hAZPI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005248; c=relaxed/simple;
	bh=KgoN7d/huuivjXDa9NWFgxIMNU+AtxtDserTx7cspME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edmafqZWgqMX+Zbx0K4dcNuaDafgI+4K67yHdGfNrwNxsmPHcOCSApfnf2suy9lg/hm0UM+QDP66Qbaf/mnuUf6OewvRNX3aZwq/mzvmZB37gKrBrfwJZ8e6AgtIYVzpBOEcl+LHaV70dMUYggnqhjlXr/P2iwxqD/cJ+tVkIPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TVFKWnd1; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00415C0003;
	Thu, 21 Mar 2024 07:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711005238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KgoN7d/huuivjXDa9NWFgxIMNU+AtxtDserTx7cspME=;
	b=TVFKWnd1TH6TXiXnZb40Wffd3GJaz3Q7DDa77DS11yaBXk73a67W0xt5bpKjsUthHgzbsB
	ifvpBb+PSwvEzGF2BgVwNhI7iBl2VZadMbCwuRX+IPmDcr0dDLjG9aJBLSOA+WSLonnFoO
	DI/R+x59kVDFCSDUB/lyIrufT+FS1KlskbgSkwnDFuzzOZPnkSEKuU1+fEMtcyB5Uxw7dC
	ab3fE5gOyrxFOxTe0uJz4FVORrT/B0WcjWW0RxInlwtOa9cmVvgMDQWE6W9JiGcSZ7WDEF
	1gk9+2FWN+Nmb+7Isjs7GhsJSumfqEDuaecWv927RDSn2Y0WsQLb4q091BDKIw==
Date: Thu, 21 Mar 2024 08:13:56 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: armada: simplify name sanitization
Message-ID: <20240321081356.7c08fce1@xps-13>
In-Reply-To: <20240320104940.65031-1-linux@rasmusvillemoes.dk>
References: <20240320104940.65031-1-linux@rasmusvillemoes.dk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Rasmus,

linux@rasmusvillemoes.dk wrote on Wed, 20 Mar 2024 11:49:39 +0100:

> Simplify the code by using the helper we have for doing exactly this.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miqu=C3=A8l


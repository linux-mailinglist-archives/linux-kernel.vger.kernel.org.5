Return-Path: <linux-kernel+bounces-20523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAAD82801F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF0A1C2139C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6613224A16;
	Tue,  9 Jan 2024 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PKD6vNYD"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC722063;
	Tue,  9 Jan 2024 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41022240002;
	Tue,  9 Jan 2024 08:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704787827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsnJZM8mE/E1TbZzElehXy7zAO8n/tIH97gjvK7JStQ=;
	b=PKD6vNYD/FbOVrUM3CYaa+zlkv7q4fQjwQ4CYAGkUu9dbRT/gSc9SMnDfXX6QArEjRa3dv
	YYWiXEh4wfbE9gkVcLCaIjIexTO0perzPNa/rCUBpP7HSJVEq2oWDDU5uc9pfj/gk5H96z
	m8C1vNj4qP1x8f71peSujRM26olrEq5PX3+nEBIlE8PnD3RdVFpm0gms2jkyt/YqHpYd16
	2FSRphA573USMrXhtNtpZdKzJ1JJg9/a3rEqnmcIc3C4QeUY8HhZctRi3rU8ZUyoKxo0K1
	Oi3wyrABs+N+EyQohINnOEYD6z5OWHGhk+ehyiuPxerrZ8RUw9EwldBraT1tpg==
Date: Tue, 9 Jan 2024 09:10:24 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, conor.culhane@silvaco.com, imx@lists.linux.dev,
 joe@perches.com, linux-i3c@lists.infradead.org,
 zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH 1/1] i3c: master: fix kernel-doc check warning
Message-ID: <20240109091024.40fd1dfb@xps-13>
In-Reply-To: <20240109052548.2128133-1-Frank.Li@nxp.com>
References: <20240109052548.2128133-1-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frank,

Frank.Li@nxp.com wrote on Tue,  9 Jan 2024 00:25:48 -0500:

> Fix warning found by
> 	'scripts/kernel-doc -v -none include/linux/i3c/master.h'
>=20
> include/linux/i3c/master.h:457: warning: Function parameter or member 'en=
able_hotjoin' not described in 'i3c_master_controller_ops'
> include/linux/i3c/master.h:457: warning: Function parameter or member 'di=
sable_hotjoin' not described in 'i3c_master_controller_ops'
> include/linux/i3c/master.h:499: warning: Function parameter or member 'ho=
tjoin' not described in 'i3c_master_controller'
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l


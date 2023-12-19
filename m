Return-Path: <linux-kernel+bounces-5218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D223B818816
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C09BB24FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF49118EBC;
	Tue, 19 Dec 2023 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zzn1AVGg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B7F18E36
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B05331C0002;
	Tue, 19 Dec 2023 12:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702990575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfihV3HBWwPmuo9TrablG1cbbK4ITqKhYvZMqM/qu5U=;
	b=Zzn1AVGguZ3meU4seI1CzCwf2MQp2aupVvxMymiPTRC4z+QjszmSf7uJBr7aVjxNfLV+be
	/fk9reA8Bof/j0BGaeCImI/6gjEDWHFns5Y27/HJefdlDDv8dpSHe4bgK3H/UjAB6YLy5F
	U/oQ+Z3+GsOEYkhaysb8hztxdO/XtKt+38tpXKffPvcgrS+R1UAvPEZ+V4W7O+iFb3HfGo
	TVZyIW7dbdiXlqtMbCDuehuj8yH8/3hClf0t9LGNxXj46rcCrkeKFZZq9eI6DAAQX2ctvU
	TDEzgAuAxqAw4iMTvuNFxhBrF6wjQgHWw53yqCcKjI36LztsuYfEqfcebPh75A==
Date: Tue, 19 Dec 2023 13:56:14 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
Subject: Re: [PATCH v6.8 2/2] nvmem: drop nvmem_layout_get_match_data()
Message-ID: <20231219135614.57fd14f3@xps-13>
In-Reply-To: <20231219120104.3422-2-zajec5@gmail.com>
References: <20231219120104.3422-1-zajec5@gmail.com>
	<20231219120104.3422-2-zajec5@gmail.com>
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

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Tue, 19 Dec 2023 13:01:04 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> Thanks for layouts refactoring we now have "struct device" associated
> with layout. Also its OF pointer points directly to the "nvmem-layout"
> DT node.
>=20
> All it takes to get match data is a generic of_device_get_match_data().
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l


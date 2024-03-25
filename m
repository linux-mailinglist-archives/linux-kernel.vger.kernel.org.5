Return-Path: <linux-kernel+bounces-116643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D5088A226
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59185BC4869
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B121892A7;
	Mon, 25 Mar 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oQULipp7"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851D158DB5;
	Mon, 25 Mar 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358383; cv=none; b=oyjUZisAAlDGuZupBIFGKEJYV3eOTkKrhUvTYTk/+sWZVawDY4tRTThGU1WycQ4bslSXTMgiIkeX7BbulC9ptBMUQkILSD/zsy/FJWvGNmHZE4XX7qIfgnXmEGZzqEF1u251pQQyfmH7LToqYoV62IRFz7lN2mCZVitf9OgvNUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358383; c=relaxed/simple;
	bh=H3V7nr7fyekfvV8hDUpZrAFWcpoaN+qI3h65nywyXl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMdKo0dwOAa964Q/JPfaOuEPP5Go4pKnVYEE3nynCkMZASx4QlowBBkGfB2X+ueKl31J6GQVzcaYArSP/3navCZ0/Tbvebi6n36aGrBGQEdjK6GHpnPHI38CLeW3lyWkgfrDh9CmZ05AJ/Zb6TgUqkR9vEPh+JScc31B6TL+CGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oQULipp7; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2A8FC000E;
	Mon, 25 Mar 2024 09:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711358372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qU3idiONxQ8MOsIGn2G3Z38vry1Zi7EOzhSXkBaZx3c=;
	b=oQULipp7fpuoLENxFEYSzusTa1N+3RT+c29MLC61RSlUAX89wB4XuGe2h/91Is/HVsnDLe
	1JB5u38X7Yt6TEYS3+2WbV7uIBIBTYaaRoNGULhdRvDjj/qUh3KqiS1WjXWYJAJlnPuQba
	DvXrnZ1Ms9dX/jhDnqfFcCv8xtTg0ElkoUZEVRcittP8umfxjanofuuFPxuV3TyRlL8ANJ
	ASwAvZRvzp53EHJkUTgng/7li2TTo46X+0nj41A3KvDP3ppm9qda7+0QExcXYoy8AJLKhy
	2jj747yfAYmAv1ivg/v5IWzu2EsyLXRCXaQzGzOz9Q4BeZrEhKBQH6UIlHLPNA==
Date: Mon, 25 Mar 2024 10:19:30 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Sricharan
 Ramabadhran <quic_srichara@quicinc.com>, Md Sadre Alam
 <quic_mdalam@quicinc.com>, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: qcom: Fix broken misc_cmd_type in exec_op
Message-ID: <20240325101930.13ed914d@xps-13>
In-Reply-To: <20240322150510.GC3774@thinkpad>
References: <20240320001141.16560-1-ansuelsmth@gmail.com>
	<20240322150510.GC3774@thinkpad>
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

Hi,

manivannan.sadhasivam@linaro.org wrote on Fri, 22 Mar 2024 20:35:10
+0530:

> On Wed, Mar 20, 2024 at 01:11:39AM +0100, Christian Marangi wrote:
> > misc_cmd_type in exec_op have multiple problems. With commit a82990c8a4=
09
> > ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> > reworked and generalized but actually dropped the handling of the
> > RESET_DEVICE command.
> >=20
> > The rework itself was correct with supporting case where a single misc
> > command is handled, but became problematic by the addition of exiting
> > early if we didn't had an ERASE or an OP_PROGRAM_PAGE operation.
> >=20
> > Also additional logic was added without clear explaination causing the
> > erase command to be broken on testing it on a ipq806x nandc.
> >  =20
>=20
> Interesting. I believe Alam tested the rework on IPQ platforms and not su=
re how
> it got missed.
>=20
> > Add some additional logic to restore RESET_DEVICE command handling and
> > fix erase command.
> >  =20
>=20
> This sounds like two independent fixes, no? Please split them into separa=
te
> patches.

Might be split indeed. @Christian, do you plan on sending a v2?

Thanks,
Miqu=C3=A8l


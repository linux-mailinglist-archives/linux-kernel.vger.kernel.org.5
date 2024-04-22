Return-Path: <linux-kernel+bounces-153417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4678ACDE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E14DB2089E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91314F130;
	Mon, 22 Apr 2024 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a9YZkNlK"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3F145342;
	Mon, 22 Apr 2024 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791512; cv=none; b=TGAfSycbu041Dl01GocytjAjIS6in8laZhUmuD+LT7qoghkeWCTaioY0t53COX+AhMAXOnNGOMGOcHV/ZLOfC1z8U6RVSxNcD2A9n3pVP2Ym9NDERqK4L+KTPvQ9new1FR5S3zRxuiR760ypnUbTiU5kKHwxw4tfbDdt62yhQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791512; c=relaxed/simple;
	bh=b0OIR1zmVRRcfPpquWcVfHQRerazw8AgYLcFxkmJuc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlrTLbkqMd68Fwf7Pd/Vcxy5Y2cBtfxn9syaNIlQAioYdwYsYLSXneTz6D0CZu2MObY7j7DLpTGbRd67wzT/3XXGVEdU781++CuFLartBzWpwF+DtuLySU3F8KpZhaJxKoEHVZ2LHJzWg+UAAgoFzhe5jBKoSGapN65acnkz/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a9YZkNlK; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0114C000A;
	Mon, 22 Apr 2024 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713791502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0OIR1zmVRRcfPpquWcVfHQRerazw8AgYLcFxkmJuc0=;
	b=a9YZkNlK+WGya+h7GFWF9yG08NjACd3/1d3sB9esGhqipSJKJqtPwtNjAtsqE2yYC+71mb
	PdSgGs+jC5f8bBVRy+tBP1lpfPmV3IyLFWLJ9XvldKB4hGSO0leUVIr45zKHFeKdlFuwww
	1wwouix8aWrI+YEujfGdhTeZNcqjKMIfEQautrVk7igD7c594fzGgTjbtyMS45o9a8bSh0
	mApr0s/eUvMYJuN4v/0BEvQEV3mecJVKrFXv9dcm4Sc3cJURwEXtFLOS/380qUve/9w+TH
	WTDng2qK1Nc0pQmGrouN+5PtdAFupJSN87fiunTQuTmPv7zS12+SjlQKipA4RA==
Date: Mon, 22 Apr 2024 15:11:39 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH net-next 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240422151139.2e2f7bc5@kmaincent-XPS-13-7390>
In-Reply-To: <20240422150234.49d98b73@kmaincent-XPS-13-7390>
References: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
	<20240422150234.49d98b73@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 22 Apr 2024 15:02:34 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Mon, 22 Apr 2024 14:50:47 +0200
> "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com> wrote:
>=20
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > This patch series fix few issues in PSE net subsystem like Regulator
> > dependency, PSE regulator type and kernel Documentation.
> >=20
> > Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> Found out I had a git configuration that adds "Dent Project" to my sob. I
> don't want that, and will send a v2 without it.=20
> I will wait a week for review before the v2, so please do not merge this
> version.
> Sorry for the noise.

---
pw-bot: cr

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


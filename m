Return-Path: <linux-kernel+bounces-129165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20DD896652
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84187287EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6421058AA4;
	Wed,  3 Apr 2024 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NO1YjmOm"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC845BAC3;
	Wed,  3 Apr 2024 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129042; cv=none; b=UQpBu0LATLg6+D9gpQfHAFs5dLNtGqhGHKK+zzsaJvWQmN7ST/q3tAUB+9D+UZEXpaO0nB26cql5IIZlufknxQDMjhVa0OwTso5iH6XNNwACL4A++1ADvWkvG/3grs51xpIOUpYAI8tK3M6J7pICURSzptwU8MwYAlXlevtTGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129042; c=relaxed/simple;
	bh=B9cZH101MRCRvDHMjn71xmfUKTK2PzaYeQ+8AVc0k3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Viog5RQmyqXHPJ0todv9i8o82SbfiAIIOkbEhFeIN04PPbE0ps2uuSXpaFBuAcclJJr+bQQpdKgqX0repjXDHhFXI4Dmk5zv07MdghHUDmncc60qi8o/mNt1ce4bzFuQuZt/4edzP/wlki+12mcTkgcDY6g0nHPSanqoCSTRLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NO1YjmOm; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0155A60007;
	Wed,  3 Apr 2024 07:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712129037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwpvrR4xst+JurvZq9lJXg1ECrNmeKF2zXVGi9frShY=;
	b=NO1YjmOmNTSHopJhB1/cb1Uygh4/SetG1hQdoHDCCrB9+qhaRZTzGeS4k80NxAgazAPLV2
	X642w0kefoXUr+QXhfUkVpwg4DO0EH9hxGBbBW2xVDGYC9e3SmGA3C3sS/4VOWyKUJv6aI
	MKHcvWGcTcMLtvhMbIB2zJ0/ynweYnYl9cx30cuBYdFM32baQuyKS7OomicMXgJVjwg/ZT
	DV5Mr8RTyyqyQ/oU43mR5uoy8UyheGebmBV2KhL6V5J0rQ9qnXSboQ2SFE8MDos1MyDSXi
	o7NJ2+4wvBG0baY3fxhzp+kMCkHcq1kX5E3DsZXYKQPQNdvNcOOss81J3am+VQ==
Date: Wed, 3 Apr 2024 09:23:56 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Sricharan
 Ramabadhran <quic_srichara@quicinc.com>, Md Sadre Alam
 <quic_mdalam@quicinc.com>, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] mtd: rawnand: qcom: Fix broken misc_cmd_type in
 exec_op
Message-ID: <20240403092356.496e07ec@xps-13>
In-Reply-To: <20240403063008.GA25309@thinkpad>
References: <20240402214136.29237-1-ansuelsmth@gmail.com>
	<20240403063008.GA25309@thinkpad>
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

manivannan.sadhasivam@linaro.org wrote on Wed, 3 Apr 2024 12:00:08
+0530:

> On Tue, Apr 02, 2024 at 11:41:34PM +0200, Christian Marangi wrote:
> > misc_cmd_type in exec_op have multiple problems. With commit a82990c8a4=
09
> > ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> > reworked and generalized but actually dropped the handling of the
> > OP_RESET_DEVICE command.
> >=20
> > The rework itself was correct with supporting case where a single misc
> > command is handled, but became problematic by the addition of exiting
> > early if we didn't had an OP_BLOCK_ERASE or an OP_PROGRAM_PAGE operatio=
n.
> >=20
> > Also additional logic was added without clear explaination causing the
> > OP_RESET_DEVICE command to be broken on testing it on a ipq806x nandc.
> >=20
> > Add some additional logic to restore OP_RESET_DEVICE command handling
> > restoring original functionality.
> >  =20
>=20
> I'd like to reword the commit subject and description as below. But I hope
> Miquel can ammend it while applying:

I'm pretty busy, sending a v4 on which you both agree on would be
simpler to me :-)

Thanks,
Miqu=C3=A8l


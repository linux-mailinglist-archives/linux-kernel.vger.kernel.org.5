Return-Path: <linux-kernel+bounces-81326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F399867442
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0FD2908FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E755B210;
	Mon, 26 Feb 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mPbWIPfk"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234755B67A;
	Mon, 26 Feb 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949047; cv=none; b=ncM7R6RLgkY4DMe70mhtxk/oZTQC8Ot/75iL2dqlrQ2Rqt6uTwZt7L59YW/L2LG9KD9UAz3fk60N7UcT9px5AAFeQdv5bcZe1ckLUbokO3xgpwFLFSN3DVJdz4kT2tCN3tSFjGAlM024OgbG42SS6kVZWJ/ovO57lgNXtgkr5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949047; c=relaxed/simple;
	bh=bryulsiKq3ve8zKcjTqag/EYyIM+Iaohm5MG5leshDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORDDysv55F49S06l1WQKnBsJiWEfwxDiIhPPYeqKCna6/HpsKcjteMMTjSpl7Kt4/l530V0xDspjJSSgUs4POGOHuvY9e8hE2N5w9L5GQMarNOKaTqWZ3KPk8mmir6e1bG2w9eJjhetrQ5ShMztEqu0hRrUGbSqQZ83MjCnKixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mPbWIPfk; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C8880240006;
	Mon, 26 Feb 2024 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708949043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bryulsiKq3ve8zKcjTqag/EYyIM+Iaohm5MG5leshDI=;
	b=mPbWIPfknva1dRICGDzC5GN1JsKtBztxWr7Q4iSmzWegwLJRDa6bMg4CBajkbQcGJCBh5b
	cmkt7qOszyCrrpQgU3FQDkxCEcWhrlQcI/x52fEjaIyY7dlbJy82awsLLvXy+x6JKiuPP4
	ypQMLlUl7QHaHbKCfhbN4DbUFePGZEZ95drCYolQkigdsSG8R1BYixmLupzj1hfIkf7OXR
	3RbcuzQsKKxJOORmFLOTTs1MXqOOLt9ZuFY5gjEi1b0eNovR7DVTYt4frloptzoXEiQWxS
	qDSVLQYoxBlakIiRmmOjXNe24+Zm5QfB/3hEh6J2tfiqGidJ/O1XH66W1xxNaQ==
Date: Mon, 26 Feb 2024 13:04:01 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9?= Codina <herve.codina@bootlin.com>,
 kernel-team@android.com, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stable
 <stable@vger.kernel.org>
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
Message-ID: <20240226130401.7565f0da@booty>
In-Reply-To: <CAGETcx_m22xLSDz_kk9ovw5veKaij49+LdcRx0iyzEk8iEz_+A@mail.gmail.com>
References: <20240224052436.3552333-1-saravanak@google.com>
	<CAGETcx_m22xLSDz_kk9ovw5veKaij49+LdcRx0iyzEk8iEz_+A@mail.gmail.com>
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
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Greg, Saravana,

On Fri, 23 Feb 2024 21:28:18 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Fri, Feb 23, 2024 at 9:24=E2=80=AFPM Saravana Kannan <saravanak@google=
com> wrote:
> >
> > Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Improve
> > finding the supplier of a remote-endpoint property") due to a last minu=
te
> > incorrect edit of "index !=3D0" into "!index". This patch fixes it to be
> > "index > 0" to match the comment right next to it. =20
>=20
> Greg, this needs to land in the stable branches once Rob picks it up
> for the next 6.8-rc.
>=20
> -Saravana
>=20
> >
> > Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Link: https://lore.kernel.org/lkml/20240223171849.10f9901d@booty/
> > Fixes: 782bfd03c3ae ("of: property: Improve finding the supplier of a r=
emote-endpoint property")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> > Using Link: instead of Closes: because Luca reported two separate issue=
s.

As Saravana mentioned, this fixes only one bug in the original commit.

Unless there is a quick solution for the other bug, we are still left with
a regression since that got merged in 6.8-rc5.

So I propose to revert 782bfd03c3ae instead of applying this one, to
leave the needed time for a correct solution to be deviesd.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <linux-kernel+bounces-83978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CE586A0DE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F331C253CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABAE14DFE0;
	Tue, 27 Feb 2024 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf0SlyF7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFA8134B1;
	Tue, 27 Feb 2024 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709065916; cv=none; b=L8EqYndQNQw5/a2mP1L2pO7QvwUxEc52vaq4xkUMGZ5nyw4Xh2ctcx5KxR7+BbjMzh3/dm79XQWqT8sla+0kpG0+hagVSkwZveyH3QWrl8S7ic0h3JKlL054YD11BB/C3xC2pyeegxDc7EsYpwVwZmggO2C8NaakVvU+POlV+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709065916; c=relaxed/simple;
	bh=fnVlCrmOpBZf3giskThx7p/gnI8js0oR22HyRkAsQ+Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EvJ6fFrW3GrJljK/RvAtmovORokELqOf5xsNzi99J5se1cBYng7OcoQrluioJiwvYdc8ioHTeHEfeleTRWjs/G3Bq/1O67S55v9RXV5Bbfc5Suwdbzunr0d043ePGOS98o5Kr0+xJwvMCpSSZUAN3u0RyDXNLEx+WBP5MufObyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf0SlyF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81124C433F1;
	Tue, 27 Feb 2024 20:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709065915;
	bh=fnVlCrmOpBZf3giskThx7p/gnI8js0oR22HyRkAsQ+Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gf0SlyF7XhMTKfjg7swqje5YhC8369WV1Qx37qrq3VKAvDKFzvpwXkPat/8ebcl0i
	 RsOFY6L5Sm5msTqucaM8L1ihzJBXbOIdSEt3GJmEnKeJ5ySKBuuZ1+iELQWmUHXLG0
	 ZaHOjaDZHJpsx1rj57rLLLRSbekK8/C1vlAb5R3zUyVKedzGN7ZOeoDxnn+6S9yBQV
	 iz7QLGGNSQvaxUa5mam4P+oJ61wBZK0Y4NFYN0fY6PcF8uvLtAczLkh84Xz2loMQNU
	 INIJlvWAlRbPiM/h/kTpY9tMvZg0jbsrkTVtiJagxGNtET4FNRdW9Q8HwGV7RJzxHk
	 z1PbqNReHbAtA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 22:31:52 +0200
Message-Id: <CZG5AX6QHHQW.YPMIE23V9P2B@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add TPM DT bindings to TPM maintainers
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Rob Herring" <robh@kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.17.0
References: <20240130215917.2473250-1-robh@kernel.org>
 <CAL_JsqJetnzuBcKQMoswuL1X-uwi=meL1EaMOD2LVBg_T_Zn3A@mail.gmail.com>
In-Reply-To: <CAL_JsqJetnzuBcKQMoswuL1X-uwi=meL1EaMOD2LVBg_T_Zn3A@mail.gmail.com>

On Tue Feb 27, 2024 at 4:54 PM EET, Rob Herring wrote:
> On Tue, Jan 30, 2024 at 3:59=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > Bindings for a given device class generally go to the respective
> > subsystem maintainers. Add the TPM bindings to the TPM
> > maintainers entry.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
>
> Ping!
>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 97f51d5ec1cf..e5e3dd672018 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22040,6 +22040,7 @@ S:      Maintained
> >  W:     https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
> >  Q:     https://patchwork.kernel.org/project/linux-integrity/list/
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-=
tpmdd.git
> > +F:     Documentation/devicetree/bindings/tpm/
> >  F:     drivers/char/tpm/
> >
> >  TPS546D24 DRIVER
> > --
> > 2.43.0
> >

Somehow went out of my radar, sorry.

Thanks, it does make sense. I can pick the patches but it would be
good if you can check them still.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.ogr>

BR, Jarkko


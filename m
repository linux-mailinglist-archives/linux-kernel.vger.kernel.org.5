Return-Path: <linux-kernel+bounces-23759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC4A82B14B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8A11F277A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755F54BA8C;
	Thu, 11 Jan 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="LSfLUfNV"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE611F191;
	Thu, 11 Jan 2024 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id EAEEE28392C;
	Thu, 11 Jan 2024 16:05:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1704985540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJ3MP6ATmvee28CObuFouN18d3lCLkbJd16SrYyeonk=;
	b=LSfLUfNV6FS3rNsONNFy0FXSj3mOj2FBxr/EgsZ+iudAxmjFiq4Utko0tJmeXez/fWMtM0
	NJokRw/VcfHfibWYXOoakmWD0Tz3yYUaxulozEj3SqD2DuNUSsfZzBnCcdIuwBrqrOw26h
	jnW022+Yha8CbbFCL2nbtwGDRMX2Kys=
Received: from localhost (185-58-42-206.static.masterinter.net [185.58.42.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id A3EB8454CF6;
	Thu, 11 Jan 2024 16:05:40 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jan 2024 16:06:08 +0100
Message-Id: <CYBYXXCP3O1O.2M5YMCRW3SIMY@gimli.ms.mff.cuni.cz>
Cc: "Karel Balej" <balejk@matfyz.cz>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje.mihanovic@skole.hr>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] mfd: 88pm88x: differences with respect to the
 PMIC RFC series
To: "Lee Jones" <lee@kernel.org>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
 <20231228100208.2932-2-karelb@gimli.ms.mff.cuni.cz>
 <20240111105426.GA1678981@google.com>
In-Reply-To: <20240111105426.GA1678981@google.com>

Lee,

On Thu Jan 11, 2024 at 11:54 AM CET, Lee Jones wrote:
> The subject needs work.  Please tell us what the patches is doing.
>
> On Thu, 28 Dec 2023, Karel Balej wrote:
>
> > From: Karel Balej <balejk@matfyz.cz>
>
> A full an complete commit message is a must.

I have not provided a detailed description here because as I have noted
in the cover letter, this patch will be squashed into the MFD series. I
sent it only as a bridge between the two series, sorry for the
confusion.

> > diff --git a/include/linux/mfd/88pm88x.h b/include/linux/mfd/88pm88x.h
> > index a34c57447827..9a335f6b9c07 100644
> > --- a/include/linux/mfd/88pm88x.h
> > +++ b/include/linux/mfd/88pm88x.h
> > @@ -49,6 +49,8 @@ struct pm88x_data {
> >  	unsigned int whoami;
> >  	struct reg_sequence *presets;
> >  	unsigned int num_presets;
> > +	struct mfd_cell *devs;
> > +	unsigned int num_devs;
>
> Why are you adding extra abstraction?

Right, this is probably not necessary now since I'm only implementing
support for one of the chips - it's just that I keep thinking about it
as a driver for both of them and thus tend to write it a bit more
abstractly. Shall I then drop this and also the `presets` member which
is also chip-specific?

Thank you, best regards,
K. B.


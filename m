Return-Path: <linux-kernel+bounces-110549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CBA88606B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FFE1C22E99
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A84F13340B;
	Thu, 21 Mar 2024 18:16:32 +0000 (UTC)
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B884A28;
	Thu, 21 Mar 2024 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044991; cv=none; b=gVZesJB6/EhqrcblRoxFqbqPx57jBJV5YZAl3VFvRZKIxqXgwWrt8dKH7D8g382Gh/2r8V61FGtVy0Cxkf/O9g1Du6Z1O5RWVfmQz86hRj/frQX9f3pKF9e2RNpEduuckXaCVYb+K3dj+24xerv5CNV4ZpObnkblOLXw22sQr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044991; c=relaxed/simple;
	bh=kzF3PP5TBxeeyiFtNbxnHwiSOrORgk8U71rb5F3qK3Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=V3B9n3Md8F94dGWLpzOd/IimDlPU47tzEOzyHyZLsvQXV3AiuC8D22cupWWlwV0eceJisZTzBu2NCpjcHM7+Ki9y+Cx3Tcngq1u6UVQd2Zs7kxkhG92CNcLsyQn0dD45JTwCaP+PCZvlYueGOv95oHyv4CDioqjUDcOyXv8OZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
Received: from localhost (koleje-wifi-0015.koleje.cuni.cz [78.128.191.15])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42LIGAOn098122
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 19:16:12 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 19:16:43 +0100
Message-Id: <CZZMTZBZ5S7B.2HR8A6LEY08D4@matfyz.cz>
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley"
 <conor+dt@kernel.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Liam
 Girdwood" <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 2/5] mfd: add driver for Marvell 88PM886 PMIC
To: "Mark Brown" <broonie@kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
 <20240311160110.32185-3-karelb@gimli.ms.mff.cuni.cz>
 <20240321154211.GA13211@google.com> <CZZK759UU6G7.MFPYOI0HBB6I@matfyz.cz>
 <20240321162045.GC13211@google.com> <CZZL3MNOT0QG.2WDSNX9XD2RET@matfyz.cz>
 <879296b4-5186-4170-af3f-971787d28514@sirena.org.uk>
 <CZZLDK79D5VK.2VK3X59OHIY2Z@matfyz.cz>
 <45079e37-dde9-4310-a112-7af49f35ac77@sirena.org.uk>
 <CZZLVS3T3QIS.223XHI5OZ7UBG@matfyz.cz>
 <e9c7bd38-49cd-44c2-8842-292bc0b4205f@sirena.org.uk>
In-Reply-To: <e9c7bd38-49cd-44c2-8842-292bc0b4205f@sirena.org.uk>

Mark Brown, 2024-03-21T17:48:28+00:00:
> On Thu, Mar 21, 2024 at 06:32:03PM +0100, Karel Balej wrote:
> > Mark Brown, 2024-03-21T17:17:40+00:00:
>
> > > Do they both genuinely have the same maximum register?
>
> > They do according to the downstream driver which is my only reference.
> > In fact, there the driver defines the configs separately for each regma=
p
> > but with the same values.
>
> This is a downstream driver - are you sure it's got the best code
> quality?

No, that is why I have rewritten it and tried to improve on this. But
like I said, it is my only reference. Is there some other way to verify
this value (besides perhaps the datasheet)?

> I'm not seeing any references to registers with numbers as high as the
> maximum register that's there in your driver for example.

Indeed, I have performed the same check with the same findings. But that
doesn't necessarily mean that the maximum should be lower, no?

Do you have some specific modifications of my code in mind regarding
this?

Thank you,
K. B.


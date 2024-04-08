Return-Path: <linux-kernel+bounces-135953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 403B589CDCF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF02B22455
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0C214885F;
	Mon,  8 Apr 2024 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="LIQRiZQY"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878D11725;
	Mon,  8 Apr 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612877; cv=none; b=BeCaecC4+9+wwSU9dz57DETbX7/7NppxvWU8wFlwfdAc7lhw/Mbq3x4YxNnvxz99wEM+32n+knt5DKE85MNzVPSLQ8pzbumNqSwciScpI8Ey8OhysRUk3P3HSnv6yFuEe/xH8URopSiX6TaYB6ApNqTU+eqV3GNGRTtZLfZjh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612877; c=relaxed/simple;
	bh=KsMcGgnYpOkBnyUVNH0sXZj0vS5Ooyn1csyDsVRybZg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Cc:Subject:
	 References:In-Reply-To; b=Hu9dzJT2HmZNQe3sws7f4Jgd15Vwr3SAJiZPA/fhfxDdzJssEopJrq0aaKPrJIp1L+tyG4Tru0U7qDjMhNQCw6OdaRimYhuFQm1zmlXkvrFDTBrzBDZt1vgE47TjoclRvSrl5oKMi01iTRKCzl/F08GZT3lSerEt504IlzcOnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=LIQRiZQY; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1712612844; x=1713912844;
	bh=KsMcGgnYpOkBnyUVNH0sXZj0vS5Ooyn1csyDsVRybZg=; h=From;
	b=LIQRiZQY0V2qO9N/8l1U9ZH3YsE1FtxdEFFxBB+2O4pWV5kO2uHc6bSAxnrPNroif
	 k59n0J/+wulO+vjI51EpT3khxRxabkY346yeJpUI4w+fnVAyMD39mI99y/BOneXzKN
	 GWDhC+6mUmAhOeqFthzrnLcCJhekvRe/f99egXlxwqN7dzKcfwTDYdKe23g4s7iB6J
	 yR9E8qK8vEj2HZOiIpDS1iIjD1AWWDtarS8h7AEeoFgWLNfhMq3rQXs534WYk9Mc5i
	 1X1ttT7YYFLk3p4VdR4TVPhDx0iuZBuqOeqV76LZCMuAFTSTX2q+lGxFb1yx92s8yg
	 G+Vw1e8GTg9zQ==
Received: from localhost (koleje-wifi-0017.koleje.cuni.cz [78.128.191.17])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 438LlN06005664
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 23:47:24 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Apr 2024 23:47:57 +0200
Message-Id: <D0F2LIG40N4N.100NU783PULAH@matfyz.cz>
To: "Sasha Levin" <sashal@kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
Cc: "Markuss Broks" <markuss.broks@gmail.com>,
        "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, <duje.mihanovic@skole.hr>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 6.8 78/98] input/touchscreen: imagis: add
 support for IST3032C
References: <20240329123919.3087149-1-sashal@kernel.org>
 <20240329123919.3087149-78-sashal@kernel.org>
 <D06ZCKKYTQM5.3OJ6HCLHW3DZ9@matfyz.cz> <ZhMw3fwiSrbw9r6P@sashalap>
In-Reply-To: <ZhMw3fwiSrbw9r6P@sashalap>

Sasha Levin, 2024-04-07T19:48:45-04:00:
[...]
> >sorry if I'm missing something, but I don't see why this should be
> >backported: it doesn't fix anything, it's just adding support for new
> >hardware.
> >
> >I can see that adding a device ID is permitted for -stable [1], but I
> >thought it still has to bear some signs of a fix, such as maybe here
> >[2].
>
> It does not need to be a fix, it could just be plain device enablement.

OK, thank you, although I'm afraid I still don't follow the rationale
behind this, except maybe for some really trivial additions which do not
require any other changes.

I was also initially having a hard time understanding what your email
means -- I found no mention of AUTOSEL in the Documentation and was
unsure whether this is already the review cycle or not. Only later I
came across this article [1] which confirmed some of my suspicions and
made things slightly clearer.

If I were to add a few words to briefly mention AUTOSEL to the
stable-kernel-rules document according to my current understanding,
would you take such patch?

Alternatively, I suggest adding some sort of brief
description/explanation to these patches as is the case for patches from
the review cycle.

[1] https://lwn.net/Articles/825536/

Best regards,
K. B.


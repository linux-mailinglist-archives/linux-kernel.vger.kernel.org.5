Return-Path: <linux-kernel+bounces-127703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99D894FB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA47F1F220E7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FAF5A4CF;
	Tue,  2 Apr 2024 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="du3H3Kxj"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5F5811B;
	Tue,  2 Apr 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052883; cv=none; b=AzpgIloMm8f0bqkeRePb15/GF3JvaFcQR1qIUZd1jaHq9pWiDYOBpMVNCbAn+pr4N5Vb0DnBo1Mt9qpFA9Tk44gzm/jHJzG64B4QLzmYpwOjtN6iJzt2sKdfAqctVHFGyexKeEUjLq3TJ1RB433FmVGrEBXUcJ6/bHeX0G+9o80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052883; c=relaxed/simple;
	bh=hlUCPDyMrcMVJPOFhZIUAAzhQs7Ot/u9oKA1OiN5DsA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=vDTPSp53ccTma0ctR/LvoYEXyfMMeCeeUpw5F0F9hTdLLxcReXgfpW6khxgYJC0oGuHlfMngBMcQ6cbYLIwBtYHr2rrpug47rnk1MZ4nDaTrIjnB63JSJFwPD+rWyJ23k1ANcdbnV4Y0IeZChOp5DpEpG1Vw0KsYVpDdxiESnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=du3H3Kxj; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1712052842; x=1713352842;
	bh=hlUCPDyMrcMVJPOFhZIUAAzhQs7Ot/u9oKA1OiN5DsA=; h=From;
	b=du3H3KxjIpomuO6SxOG5G8zrXblGfU8e9B0rnTnrQQsBbtywtAnV4+MpWAaxgTOB0
	 PfdJByEHG8uaDZ/xXyTV1dxyj3XK4dFDadX4bQEr7EzAwNlMvd4uaghS9BI1nG21oc
	 M1OsWbg87VUSrslgmRRDYrAlrO81RLVGhFZPpZGTDWcFxJ1f9Q/+Y/A6lNpM538DlK
	 GP4i/+qRf8wJ8bEKGnYb094FBuMV4872J3AF2WNRn6SoasrmHuN0c06HgGybYgBSn1
	 h5sBfjrhnA+/qIbiTBJs3TcQ9FqDKw/751pmgGac5duLDqysvN5tL224qVZm2nwdUe
	 +g6pCwFk1mo3Q==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 432ADxkE089761
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 12:14:00 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Apr 2024 12:13:58 +0200
Message-Id: <D09K2WCTEKK9.2NJ2C8NVQXZ6D@matfyz.cz>
Cc: "Randy Dunlap" <rdunlap@infradead.org>,
        "Jonathan Corbet"
 <corbet@lwn.net>, <regressions@lists.linux.dev>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <workflows@vger.kernel.org>
Subject: Re: [PATCH 2/2] docs: handling-regressions.rst: clarify that
 "Closes:" tags work too
To: "Thorsten Leemhuis" <linux@leemhuis.info>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20240328194342.11760-1-balejk@matfyz.cz>
 <20240328194342.11760-3-balejk@matfyz.cz>
 <dfa22ac1-36e9-48da-a2a8-8d7818c09187@leemhuis.info>
 <b3b37454-df45-4826-ac5a-85c687f99d20@infradead.org>
 <5ea364e9-8a7d-4239-bf3b-1f4ae13f311b@leemhuis.info>
In-Reply-To: <5ea364e9-8a7d-4239-bf3b-1f4ae13f311b@leemhuis.info>

Thorsten,

thank you very much for your feedback.

Thorsten Leemhuis, 2024-04-02T11:27:57+02:00:
> On 01.04.24 17:19, Randy Dunlap wrote:
> > On 4/1/24 1:38 AM, Thorsten Leemhuis wrote:
> >> On 28.03.24 20:29, Karel Balej wrote:
> >>> The regressions handling manual claims that regzbot associates patche=
s
> >>> fixing an issue with the report based on the occurrence of the
> >>> appropriate "Link:" trailers. It reasons that this does not add any
> >>> burden on the maintainers/bug fix authors as this is already mandated=
 by
> >>> the "Submitting patches" guide. In fact however, the guide encourages
> >>> using "Link:" tags for related discussions or issues which the patch
> >>> fixes only partially, recommending "Closes:" for full resolutions.
> >>>
> >>> Despite it not being mentioned anywhere in the "Handling regressions"
> >>> guide, regzbot does in fact take the "Closes:" tags into account and
> >>> seems to in fact treat them fully equivalently to "Link:" tags.
> >>>
> >>> Clarify this in the regressions handling guide by always mentioning b=
oth
> >>> of the tags.
> >>
> >> Many thx for this and the other patch. I had planned to do something
> >> like this myself, but never got around to.
> >>
> >> There is just one thing that makes me slightly unhappy: this tells
> >> readers that they can use both, but leaves the question "what's the
> >> difference" respectively "in which situation should I use one or the
> >> other" unanswered.

I see your point and I agree. I have perceived something similar when
editing the document: I wondered whether it's really good to *always*
spell out both variants or whether it would perhaps be enough in some
places only.

I think the way that I ultimately did it counts on the reader being
familiar with the "Submitting patches" document and knowing the "true"
meanings of both Closes: and Link: and when to use each. So my goal was
only to mention it because the way it was written seemed to almost imply
to me that Closes: does *not* work and is thus not recommended which
seemed in conflict with the "Submitting patch" guide, which was even
more confusing since it literally referred to it.

In other words, it wasn't actually my goal to answer that question you
pose, because that is already answered in the other document.

I also didn't want to be too drastic with the changes because the
prevalence of Link: seemed so strong that I thought that I must be
missing something and that you have a good reason to write it like this.
So I wanted to stay safe :-)

Anyway, if you are OK with that, I can definitely change it to Closes:
everywhere and only mention Link: marginally, saying that it works too
and explaining the difference while referring the reader to "Submitting
patches" for more information (not that there would be too much more on
this subject).

> Just in the scope of the document and the sections where the tag is
> mentioned I think (but it would be good to recheck) it's always about
> a "resolving a reported regression", so Closes there makes more sense.

Exactly.

> Karel: if I'm asking too much here, I could pick up your patches and
> improve upon them to handle this. Or we simply wait until two other
> regzbot features are in place, then I could fix this as part of some
> other changes.

Not at all, I will be happy to make the changes, if you don't mind that
it might take me some time, but I would definitely get around to it
eventually.

Of course I wouldn't want to for example delay you so if you get around
to it sooner than I will then feel free to make the changes either as a
modification of this patch or just on its own.

Perhaps you could take the first patch already if you have no
reservations there and I will then just send v2 of this one?

> >> I also find the patch description a bit verbose; and it would be
> >> good to turn the text upside down: first outline what the patch,
> >> then maybe describe the "why".

I actually probably like it more this way. After all, the outline (or
"what") is the patch subject, everything that comes after it in the body
is usually meant to explain "why". But sure, I can swap it if you want
:-)

As for the verbosity, I will keep it in mind when working on v2,
although I also generally don't consider verbosity a bad thing. I might
have been too verbose, though, because as I have mentioned, I was
confused why it isn't like this already and wanted to offer my full
reasoning so that I could be shown where I err :-)

One more thing that I wanted but ultimately forgot to mention in the
cover letter: thank you very much for writing these guides in the first
place, I find them very instructive and useful.

Kind regards,
K. B.


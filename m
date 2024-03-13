Return-Path: <linux-kernel+bounces-102605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C97A087B47F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CBBDB20F92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448905C8EC;
	Wed, 13 Mar 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxiPxyz8"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA459B4B;
	Wed, 13 Mar 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369673; cv=none; b=mDwsu2WzuiNIZ0X8gXe/tG8EDQmuT4qaDsTJMAH4/aFziWzVvjj3EIRIy8c25sV1Xn5HXYvi9yCkt7RvP0kD7em7fDaeXs3V6gSK0tOxJafIW/pWpjYT0jrMTYeK/YD1UjdF2MIpzElmCFSdUYUTtIpRl5uxAN3FURfeurUqaIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369673; c=relaxed/simple;
	bh=0jL7KIMvDBg4emXkQf6LdByOLGy1PZ0pL0tPDWQUHoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmZqpAsQzNLau1l8F1QUxmAveqRvtU5B+OmMWBHA7AaL3dHL3AZ/pkjfVTcoYLpd7As6u7mRacrsP9G/fnWN3Ur7FX0Bo8Xx2VritUILlBP4njDzHbIHEg7lxYwaXZ7zrU4ojwmjnucHov7xP28Rp74aJqdnp7u/ZxhICjUPPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxiPxyz8; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a22d940ff4so140888eaf.1;
        Wed, 13 Mar 2024 15:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710369670; x=1710974470; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MBzirNfmo76QBr5qOvoXnZEVWevnRKqcoBk8cgRxYU=;
        b=DxiPxyz8OzLawTCiFtM+WLx50xUXT17+Ktua9IVrzupBSnkJjpZAcVmXc2KPCndPmh
         FjzO/1R1Qi8zlW8ODovLMoG6/QCyWujek+n5dI1FDSy7zTezELLW9bdIOmsGu1O1VyAI
         QaLnuvwe4i6gOVXDqSGX4xZgkdnTkoseWwN0hm+OrlpNJ6LJRVWnFtbYipJtUXHIOdAk
         4uxv1l8oZsN9JImtVentbAIGzNFadvxTwaT+636xVhBzFY43snOQ4Lyw2KLXUWw3+56e
         eLw0buIEqA5crW5HtIcbbBBO1j7dPtsFL4ZJt3/bFkhzdTlWJaOwtFNK8OIfk5XtQ9Pp
         SkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369670; x=1710974470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MBzirNfmo76QBr5qOvoXnZEVWevnRKqcoBk8cgRxYU=;
        b=d2OXkU1p5sbn5TGaeApc5U10DFvYZ244L28wb+kFdawxT/uk3wzPpNldtOm/v23vUV
         fvughlr1JsBSGRmcGsGqFWxfRyj2zspF+QGjvq4ONUtXpnVL8os8pbgR2/puxmiJQl9q
         pEwxFS0m6W6ZW/C+TG8eG6mwhXB1aiueLU0uhvdlfB6W5Y2jmY3ZMvhp/Bs70vCvXo0b
         LxYLgB3TSqgtg0Y65da9wnjIqw0vL2ymIx4Ogh3SymUZ+vg/DyEGheAFYXjN6xXKWgUn
         LzmVnec+V7ctwviTvRJXNFh9tSonFBYZ/W9HQvYch9ilPh0aJsc+i/SehnDCqHki+4H4
         dCag==
X-Forwarded-Encrypted: i=1; AJvYcCXRPUpwvcqv58Ccga04M59FiriBFO1xQIaJMCUYn14kxBPkyUyuGY5nCRyaujagaDn5SYLX4cNK/4gOSlL8P9bLh7im03wRKMm3aE9RViLviQV3OCfNmFnz2U7BtGSqbOTwBZOZuHae
X-Gm-Message-State: AOJu0YxoKzORGdHoSIGi/shD7eHLThvboGnpKVhksprRIcgPzEZrfl+Z
	Oizxbtb76dDzvoIS+qry76fXOn6coYXLRgatvpNU7hagF6KAqEmk
X-Google-Smtp-Source: AGHT+IEwvNLbh3af5pCHuOGkYTwhypXBkeRA2I1w9HnVOk7REW1MYNpEOwUf0zhcGTyMEtQD6ch59A==
X-Received: by 2002:a05:6358:7f83:b0:17c:1b9b:bf46 with SMTP id c3-20020a0563587f8300b0017c1b9bbf46mr332036rwo.13.1710369670230;
        Wed, 13 Mar 2024 15:41:10 -0700 (PDT)
Received: from gmail.com ([15.248.7.57])
        by smtp.gmail.com with ESMTPSA id p25-20020a635b19000000b005dc832ed816sm117883pgb.59.2024.03.13.15.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 15:41:09 -0700 (PDT)
Sender: Matt Wilson <mswilson@gmail.com>
Received: by gmail.com (sSMTP sendmail emulation); Wed, 13 Mar 2024 15:41:07 -0700
Date: Wed, 13 Mar 2024 15:41:06 -0700
From: Matt Wilson <msw@linux.com>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Matt Wilson <msw@linux.com>, Jonathan Corbet <corbet@lwn.net>,
	cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, security@kernel.org,
	Kees Cook <keescook@chromium.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@denx.de>, John Haxby <john.haxby@oracle.com>,
	Marcus Meissner <meissner@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roxana Bradescu <roxabee@chromium.org>,
	Solar Designer <solar@openwall.com>, Matt Wilson <msw@amazon.com>
Subject: Re: [RFC PATCH 2/2] doc: distros: new document about assessing
 security vulnerabilities
Message-ID: <20240313-goat-of-inescapable-prowess-4f22ad@carbon>
References: <20240311150054.2945210-1-vegard.nossum@oracle.com>
 <20240311150054.2945210-2-vegard.nossum@oracle.com>
 <Ze9GmrqiW18GMkU6@uba002e82b7465e.ant.amazon.com>
 <aa7b1a88-f554-42c1-a874-a742e6614712@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa7b1a88-f554-42c1-a874-a742e6614712@oracle.com>

On Wed, Mar 13, 2024 at 02:11:00PM +0100, Vegard Nossum wrote:
> 
> On 11/03/2024 18:59, Matt Wilson wrote:
> > There have been occurrences where a CVSSv3.1 score produced by a
> > vendor of software are ignored when the score in the NVD is higher
> > (often 9.8 due to NIST's standard practice in producing CVSS scores
> > from "Incomplete Data" [1]). I don't know that harmonizing the
> > practice of producing CVSSv3.1 base scores across Linux vendors will
> > address the problem unless scores that are made available in the NVD
> > match.
> 
> That link actually says they would use 10.0 for CVEs without enough
> detail provided by the filer/CNA (as I understood it).

Indeed, the web page says that it would be 10.0 in cases where there
is no detail about the weakness. In practice, the score tends to come
out as 9.8 because the base score vectors are more often
   CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H
and not
   CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:C/C:H/I:H/A:H
(which would be a 10.0 score)

What's the key difference between 9.8 and 10.0 in the CVSSv3.1 system?
Scope:Unchanged. In CVSSv4 such a weakness would likely be scored
   CVSS:4.0/AV:N/AC:L/AT:N/PR:N/UI:N/VC:H/VI:H/VA:H/SC:N/SI:N/SA:N

With a CVSS-B of 9.3 (Critical). What does any of this information
tell a practitioner about what actions are warranted in light of the
presence of a software weakness in their environment? Not much, from
my personal perspective.

> I wonder what their strategy would be for all of these new kernel CVEs
> -- should we expect to see 10.0 or 9.8 for all of them, do you know? I
> assume they do NOT have people to evaluate all these patches in detail.

At present, and since mid-February, NIST is not enriching new CVEs
that have been allocated with CVSS base scores or other additional
data. Their website displays the following banner text:

    NIST is currently working to establish a consortium to address
    challenges in the NVD program and develop improved tools and
    methods. You will temporarily see delays in analysis efforts
    during this transition. We apologize for the inconvenience and ask
    for your patience as we work to improve the NVD program.

I expect the path forward will be a topic of discussion among
attendees at the upcoming CVE/FIRST VulnCon 2024 & Annual CNA Summit [1].

> > If the guide has something to say about CVSS, I (speaking only for
> > myself) would like for it to call out the hazards that the system
> > presents. I am not convinced that CVSS can be applied effectively in
> > the context of the kernel, and would rather this section call out all
> > the reasons why it's a fool's errand to try.
> 
> I also heard this concern privately from somebody else.
> 
> I am considering replacing the CVSS part with something else. To be
> honest, the part that really matters to reduce duplicated work for
> distros is the reachability analysis (including the necessary conditions
> to trigger the bug) and the potential outcomes of triggering the bug.
> Once you have those, scoring for impact, risk, etc. can be done fairly
> easily (at least more easily) in different systems and taking
> distro-specific constraints (configuration, mitigations, etc.) into account.

Distros are not the only downstream consumer of Linux with this
need. Arguably the need is even greater for some consumer electronics
applications that may not have the same over-the-air update
capabilities as something like an Android phone. This is a frequently,
and increasingly, discussed topic in Embedded Linux conferences. See,
for example [2, 3].

I think that one coarse-grained "reachability" analysis is CONFIG_*
based matching [4, 5], and that's something that not necessarily
directly reusable across distros or other downstream users of Linux
(as their Kconfigs aren't necessarily the same). But perhaps some
community maintained tooling to automate that analysis would be
useful.

Many in the security community are rightly skeptical about
"reachability analysis" given the possibility of constructing "weird
machines" [6] from executable code that is present but not normally
reached. But if you can confidently attest that the weakness is not
present in a produced binary, you can safely say that the weakness is
not a factor, and poses no legitimate security risk.

Your current draft security assessment guide says:
> A distro may wish to start by checking whether the file(s) being
> patched are even compiled into their kernel; if not, congrats!
> You're not vulnerable and don't really need to carry out a more
> detailed analysis.

One research group [7] found that in a study of 127 router firmware
images 68% of all naïve version based CVE matches were false-positives
that could be filtered out, mainly through determining that the code
that contains a weakness was never compiled.

I think this low hanging fruit is ripe for picking, and deserves some
more content in a weakness assessment guide.

(P.S., "weakness" is an intentional word choice)

--msw

[1] https://www.first.org/conference/vulncon2024/
[2] https://elinux.org/images/0/0a/Open-Source-CVE-Monitoring-and-Management-V3.pdf
[3] https://www.timesys.com/security/evaluating-vulnerability-tools-embedded-linux-devices/
[4] https://ossjapan2022.sched.com/event/1D14m/config-based-cve-matching-for-linux-kernel-takuma-kawai-miraxia-edge-technology-corporation
[5] https://www.miraxia.com/en/engineers-blog/config-based-cve-matching-for-linux-kernel/
[6] https://ieeexplore.ieee.org/document/8226852
[7] https://arxiv.org/pdf/2209.05217.pdf


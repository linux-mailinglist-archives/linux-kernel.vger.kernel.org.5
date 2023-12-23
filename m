Return-Path: <linux-kernel+bounces-10155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C9181D0D9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD5DB22FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CCF814;
	Sat, 23 Dec 2023 00:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GANTk477"
X-Original-To: linux-kernel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25214644
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-111.bstnma.fios.verizon.net [173.48.113.111])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3BN0gZOb010465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 19:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1703292158; bh=JgjeiVIv4kKmgwVoMAv3ITugW5Gtk3YYC6cswFFGaeQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GANTk477egdU+ilGBt820HsBPsy9Eo4yqwJLHt53NUWLe5WATRczjKKTNgpG64Yre
	 w6agAHx95xYGZUR1vWLV+ofWtcGzikbTFHAOKsfNtoYptdsXh7953xT1xDoquDkv6R
	 GN1RHE8o8FfrnPvAJXVl4ZPgMM9Epjlh+mQIcW0PABXq0tKep5xoe8/xEGd0iuS6MV
	 no8CPuNQ9QfJ5GlyosySYPGI6UUxnxV1OZPzociY+9MfaoaCAezsAA/wWebw6kH6lG
	 zG1wbC2vW0vDo6Bu67+av0acEkf8HCj/9Ze+RXbEPebjFwrKZtkzbYlgyjddTQeAQY
	 gu/BirAfbHEvw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 15FD715C02E0; Fri, 22 Dec 2023 19:42:35 -0500 (EST)
Date: Fri, 22 Dec 2023 19:42:35 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>
Subject: Re: "Link in bio" instead of Link:/Closes: trailer
Message-ID: <20231223004235.GC325499@mit.edu>
References: <ZYQeZjN_3bPOdKKf@archie.me>
 <2023122112-rigging-january-7618@gregkh>
 <cc276c0e-99bb-4422-9771-d864db4287cb@gmail.com>
 <2023122129-twisty-mumble-c667@gregkh>
 <ZYRIDDD_XR5HdVJu@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYRIDDD_XR5HdVJu@archie.me>

On Thu, Dec 21, 2023 at 09:13:32PM +0700, Bagas Sanjaya wrote:
> I was scratching my itch whether common social media practices (such as that's
> being discussed here) can be applied to kernel development.

The real problem is that someone's soecial media profile (whether it's
Linkedin, or Facebook, or Threads, or Twitter) is not a stable, fixed
resource.  So at any time in the future, the bug report in the Social
media profile could get modified, or disappear when Elon Musk decides
to take a user's Twitter username[1] away so he can resell the highly
desireable account name to someone he likes better.  The git log is
forever.  So pointing to a transient resource from a permanent log is
a really, Really, REALLY bad idea.

[1] https://slate.com/technology/2023/08/x-twitter-usernames-music-take-away-interview.html

Common social media practices are often quite terrible, and this is a
great example about why they shouldn't be used for this purpose.  The
bug report should be sent to a linux kernel mailing list, so everyone
can see it, and then they can use a lore.kernel.org URL as the stable
resource.

If the bug report is in some other source where the people who run it
understand the importance of stable information at stable URL's ---
for example, bugzilla.kernel.org, bugzilla.redhat.com,
bugs.debian.org, etc. that's also fine.  But a social media profile,
which can be modified at the owner's whim (either of the social media
account, or the social media comapny, or someone who has $44 billion
dollars to carelessly throw around)?  That way lies madness.

Just because something might "common social media pracitce", doesn't
mean that it's a good idea.  In fact, some might argue that much of
what happens on social media has a negative value to society, but
that's a different debate....

Cheers,

					- Ted


Return-Path: <linux-kernel+bounces-150299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0B8A9D00
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D821F212C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5396D15FA66;
	Thu, 18 Apr 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="a54bZwdj"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A9C165FB6;
	Thu, 18 Apr 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450334; cv=none; b=QX8kmCs1Pk8nS3kJ97wC4Qt4zL3i76nGuXBKvIBvtKnk+9dKBU1pfP9Owvg2/YJwkwRd7D8k60o/qv/DCX1/q1WY/fvQnWfDD1tX7jCMAsgJWcZBFOxit3e7L5PRIXQgbeJ2GybfUQZBLHTO3YB07A/URr2E9CNoyS3fWsBkbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450334; c=relaxed/simple;
	bh=xKOoXd2m5g86klzLlV+Y20rOFjFNzLeMpDwIzLipyeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqIOQGSiHapLuBQ5WeKGyJwxmCXv50TCbIRGtNiK74y9wwhYjNp9UPPZ0JWHUN/r3kRXwROPolJjR1kkIicFpTTLn5kYwHKm3FiiSEWQxEcNYfufMZly01E+dj7q99njDHSQxjzPsMMs0Y5uoivwoqYsvyjLg6m2NbxjTRv/654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=a54bZwdj; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Zj6q68EGA4RlIzYy/XSYT8WM4sscbczTrgcDryITQrk=;
	t=1713450332; x=1713882332; b=a54bZwdjVmPGx6Bp1QZG6UhImC4InVF7GniPpFaR86VvgGp
	6CaUimQQITS+FXKoWJTTTUy1lxokl6U9RlmLq4dEoj32himcsPkjE3PzVhzjAeDhEikFSKBrOI181
	3I2sXYhFprrv602dq77ZvJRZgayCnTAzwIqNgD9oqpJ6sIaTmVh0QiE8g/JzENwABgs2TSnF8B5zs
	piwUfkDw/UuWOWWRrihiSANjh51N81SftxTYS4tTpzed8AlaiqmHcgtvPAjhDMq9mAMzxG2tAXNtS
	fFIpXg0cfwg23Dtuvn4ycfHL1LlRG/iFktC5mIXit85HvZLnyEApGwVVPlLdQ3QA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rxShb-0005cg-PE; Thu, 18 Apr 2024 16:25:27 +0200
Message-ID: <93766ae3-30d9-4dd3-ba01-870cc6387df4@leemhuis.info>
Date: Thu, 18 Apr 2024 16:25:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
To: Johannes Weiner <hannes@cmpxchg.org>,
 Christian Heusel <christian@heusel.eu>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Runge <dave@sleepmap.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Mark W <instruform@gmail.com>,
 regressions@lists.linux.dev, Yosry Ahmed <yosryahmed@google.com>
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
 <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com>
 <CAKEwX=NM1y-K1-Yw=CH3cM-8odER1PZBVoWo-rs7_OdjFG_puw@mail.gmail.com>
 <CAKEwX=MWPUf1NMGdn+1AkRdOUf25ifAbPyoP9zppPTx3U3Tv2Q@mail.gmail.com>
 <246c1f4d-af13-40fa-b968-fbaf36b8f91f@linux.dev>
 <20240417143324.GA1055428@cmpxchg.org>
 <4c3ppfjxnrqx6g52qvvhqzcc4pated2q5g4mi32l22nwtrkqfq@a4lk6s5zcwvb>
 <20240418124043.GC1055428@cmpxchg.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240418124043.GC1055428@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713450332;df5152e4;
X-HE-SMSGID: 1rxShb-0005cg-PE

On 18.04.24 14:40, Johannes Weiner wrote:
> On Wed, Apr 17, 2024 at 07:18:14PM +0200, Christian Heusel wrote:
>> On 24/04/17 10:33AM, Johannes Weiner wrote:
> Christian reports a NULL deref in zswap that he bisected down to the
> zswap shrinker. The issue also cropped up in the bug trackers of
> libguestfs [1] and the Red Hat bugzilla [2].
> 
> The problem is that when memcg is disabled with the boot time flag,
> the zswap shrinker might get called with sc->memcg == NULL. This is
> okay in many places, like the lruvec operations. But it crashes in
> memcg_page_state() - which is only used due to the non-node accounting
> of cgroup's the zswap memory to begin with.
> 
> Nhat spotted that the memcg can be NULL in the memcg-disabled case,
> and I was then able to reproduce the crash locally as well.

Thx for the fix. Nitpicking:

> [1] https://github.com/libguestfs/libguestfs/issues/139
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=2275252

FWIW, those should ideally look like this:

Link: https://github.com/libguestfs/libguestfs/issues/139 [1]
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2275252 [2]

> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Cc: stable@vger.kernel.org	[v6.8]
> Link: https://lkml.kernel.org/r/20240417143324.GA1055428@cmpxchg.org
> Reported-by: Christian Heusel <christian@heusel.eu>

And here checkpatch.pl should have complained that the above line should
ideally be followed by a Link or Closes tag to the report, e.g.:

Closes:
https://lore.kernel.org/all/3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2/

Which in this case would be nice, as I'm tracking this regression, hence
regzbot will then track the patch and consider the regression resolved
once the fix lands in mainline.

Ciao, Thorsten


Return-Path: <linux-kernel+bounces-139231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB6B8A0027
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D477C1C22982
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04E117F36A;
	Wed, 10 Apr 2024 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vNFlB0+y"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AC82E405
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775463; cv=none; b=S7fUv/y/oZrmpzXDIRN3vaAloxMsdxOv4ejX5a1OXmvZQLovKg0CRI3FzgNx5IdXrFRbLWjbJDfGk6+g688PN9SMmt5rYDD30tR/RTdFymNgNDcYPW2lokfW1acUoCuSXCGR+hrxaQFfRUk8qUresbmK/SjmnXaA+w/IhkKaEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775463; c=relaxed/simple;
	bh=T63WWSNwemtE5FUWed+rwjc2++XzqVd45sS/kU5+0WQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=qgAtop2RYzW898BIVdlUbuqWRbhnUQnRPcfWGf2M9idG/cUhx5fWtkOprcFJBF4lrPdj8+Zc09npujt6MbshBUh0qnd/NKVQZKf+NcOwlaAwABb+k3WfBpykBkk3a+5ekNcZTEZ1QOuzzPORE+Telhw8cqB2rrz8CKPPX1UCz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vNFlB0+y; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712775459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADESv9RkZIcja5wW8o1aMTUgcCG5wDttV7TT2gQQZ3w=;
	b=vNFlB0+y6Jsa9DH9o85ONcbM0LRX3VMjU81brB9OcJ0GhOjgM2Zrx3tQ60zNGCZ4Y/EsF5
	0UUJT+zItjlbmz7mG2sFIY4rU1RIXAH9U8Ra+Jf3tOKsAbkzhHD/CKomUafh+a4/y9AeZn
	8KUZjcPDt4I8b94mMZ2sOL9nHMuog5Y=
Date: Wed, 10 Apr 2024 18:57:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <e73a1e0c90ebce33c23f8f7746c23c1199f62a78@linux.dev>
TLS-Required: No
Subject: Re: [GIT PULL] fs/9p patches for 6.9 merge window
To: "Oleg Nesterov" <oleg@redhat.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 kent.overstreet@linux.dev
In-Reply-To: <74f117635037a82dc2fb2923993cf329b6939b7e@linux.dev>
References: <ZfRkyxUf8TIgsYjA@1149290c588b>
 <20240408141436.GA17022@redhat.com>
 <74f117635037a82dc2fb2923993cf329b6939b7e@linux.dev>
X-Migadu-Flow: FLOW_OUT

April 10, 2024 at 12:20 PM, "Eric Van Hensbergen" <eric.vanhensbergen@lin=
ux.dev> wrote:
> April 8, 2024 at 9:14 AM, "Oleg Nesterov" <oleg@redhat.com> wrote:
> > Hello,
> >  the commit 724a08450f74 ("fs/9p: simplify iget to remove unnecessary=
 paths")
> >  from this PR breaks my setup.
> >=20
>=20
> Thanks for the bisect and detailed reproduction instructions. I am look=
ing at this now and it seems to be related to another problem reported by=
 Kent Overstreet where he was seeing symlink loop reports that were disru=
pting his testing environment. Once I'm able to reproduce, I'll try and g=
et a patch out later today, if not I may revert the commit to keep from d=
isrupting folks' testing environments.
>=20

Okay,=20I think I understand this one, unfortunately it doesn't appear ob=
viously related to Kent's report if what I believe is correct.  I think I=
've reproduced the problem, fundamentally, since you have two mount point=
s you are exporting together. I believe we are getting an inode number co=
llision which was being hidden by the "always create a new inode on looku=
p" inefficiency in v9fs_vfs_lookup.  You could probably verify that for m=
e by stating the /home directory and the / directory on the server side o=
f your setup.  When I created two partitions and mounted one inside the o=
ther the "home" and the "root" both had inode 2 and I got -ELOOP when try=
ing to access.

The underlying cause in the patch series is that I was trying to maintain=
 inodes versus constantly creating and deleting them -- and I simplified =
the inode lookup to be based purely on inode number (versus checking agai=
nst times, type, i_generation, etc.) -- so collisions are much more likel=
y to happen.  If qemu detects that this is a possibility it usually print=
s something:=20
qemu-system-aarch64:=20warning: 9p: Multiple devices detected in same Vir=
tFS export, which might lead to file ID collisions and severe misbehaviou=
rs on guest! You should either use a separate export for each device shar=
ed from host or use virtfs option 'multidevs=3Dremap'!

I can confirm that multidevs=3Dremap in qemu does appear to avoid the pro=
blem, but this doesn't help the fact that we have a broader regression on=
 our hand that used to work.  It'd be useful to see if mutlidevs=3Dremap =
also deals with your problem @Kent, but while I think its the same underl=
ying problem, I don't think it may be the same solution.

I think I have to give up on relying on qid.path/inode-number as unique a=
nd maintain our own client view of those -- but this will cause problems =
with the way several parts of the code currently operate where we need to=
 lookup inode by a unique identifier from the server (which is currently =
conveyed by qids).

Now that I understand the problem, I think I can work thorugh a partial r=
evert which will go back to a more complex match in vfs_lookup (which exa=
mines several other fields from the server beyond qid.path) -- but maybe =
I can do it in such a way which will still avoid keeping duplicate inode =
structs around in memory.

This didn't show up in my regressions because I always export a single fi=
le system where the inodes are always unique.

Thanks for your patience while I work through this - now that i can repro=
duce the problem, I'm fairly certain I can get a patch together this week=
 to test to see if it solves the regressions.

     -eric


Return-Path: <linux-kernel+bounces-98023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 206818773C5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79DB9B20CBD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5134E1DA;
	Sat,  9 Mar 2024 19:47:20 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235B4A2A
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710013639; cv=none; b=uZ3HqbNBTNMLi3P/4PyrsEQUnQSNKwYnrmFbKsdCNL69M02Wpw46B55xz5JajNgF0ecYgEpBfK/CYIbUecPl2XeuXocoWsMqojCCK33e67qgeYEwLzm49nWUhdBvDkj9aWbwHEUgl1z1AUj9kl/ZeOaLIAmov1HcxmufZEaI9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710013639; c=relaxed/simple;
	bh=3R+0csDhG6gey7ea/bKNU4aS4ofQ2RaPOlBMidRGHHA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oFNOC8mYSgyA/e8VB3uhQhQtMS+6c0Bh/WumkrlmVUKigb30yw4OERXsEKxa9vivAj+PR7x9NFP9rCM1qaa1Yn9bW0JdFXucZYSaZgpE9ShkPnnMWItARxRnilW5xmyBcEVx6G8WHPJ8dB12exwYwf0OnezrFDRSGOfic1P2Gww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6354E1C0BB9;
	Sat,  9 Mar 2024 19:47:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 353472002C;
	Sat,  9 Mar 2024 19:47:14 +0000 (UTC)
Message-ID: <0967032faf79111417b2014ccb80077a804859ce.camel@perches.com>
Subject: Re: [RFC PATCH 1/1] checkpatch: Add warning for msleep with
 durations suitable for ssleep
From: Joe Perches <joe@perches.com>
To: Li Chen <me@linux.beauty>, Andy Whitcroft <apw@canonical.com>, Dwaipayan
	Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	linux-kernel@vger.kernel.org
Date: Sat, 09 Mar 2024 11:47:13 -0800
In-Reply-To: <87edcor88b.wl-me@linux.beauty>
References: <87frx4r8dt.wl-me@linux.beauty> <87edcor88b.wl-me@linux.beauty>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 353472002C
X-Rspamd-Server: rspamout08
X-Stat-Signature: 43smzccc34rwso3e84mezkqz9xayf3tp
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+zL9aLh8ZMUMRHmeimmRNlejVVDWsQ0/E=
X-HE-Tag: 1710013634-412339
X-HE-Meta: U2FsdGVkX1+3g0pWzUlTTrDnDU7o/Tyy/55R5S1irzy2eQdJQJuX3OUgBaQdg+PAi0iDAoKsB/5UTRSr9tp9KLB81i2/guDBSV8riiYSBVdUCES2Pws/6k+CK2MK8BNckAh3mFhwJMeXRLYGqHAf5m6wHRp5TYt8lv6YYXwUAawGdF3kkqU5relw+vmvP/xQVkpEXK+HINxUo28cAfBs/RQoNNHgPK4x4SK+7tK9LXF0vKIwmJmuAvLqIp9WJhlDE/uvzID0CFD2SMeyfb+76IXFjlfbLgEFDa8RMvLttCtJNFipNZduo1QnF5WWGYj6

On Tue, 2024-03-05 at 23:47 +0800, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
[]
> Warn when msleep(x000); can be replaced with ssleep(x);

While I don't really see the point as msleep is trivial
to read and ssleep is just msleep * 1000 and there are
already 3:1 more msleep(n*1000) uses than there are ssleep(n)

$ git grep -P '\bmsleep\s*\(\s*\d+000\s*\)' | wc -l
267
$ git grep -P '\bssleep\s*\(\s*\d+\s*\)' | wc -l
89

And about the patch itself:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6599,6 +6599,16 @@ sub process {
>  			}
>  		}
> =20
> +# warn about msleep() calls with durations that should use ssleep()
> +if ($line =3D~ /\bmsleep\s*\((\d+)\);/) {

This indentation is incorrect.
And this would be more sensible using
		if ($line =3D~ /\bmsleep\s*\(\s*(\d+)000\s*\)/) {

to avoid the extra tests below

> +    my $ms_duration =3D $1;
> +    if ($ms_duration >=3D 1000 && ($ms_duration % 1000) =3D=3D 0) {
> +        my $ss_duration =3D $ms_duration / 1000;
> +        WARN("SSLEEP",
> +             "Prefer ssleep($ss_duration) over msleep($ms_duration);\n" =
 $herecurr);

And please add a $fix to this so:

		if ($line =3D~ /\bmsleep\s*\(\s*(\d+)000\s*\)/) {
			$secs =3D $1;
			if (WARN("SSLEEP",
				 "Prefer ssleep($secs) over msleep(${secs}000\n") &&
			    $fix) {
				$fixed[$fixlinenr] =3D~ s/\bmsleep\s*\(\s*${secs}000\s*\)/ssleep($secs)=
/;
			}



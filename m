Return-Path: <linux-kernel+bounces-53175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900B284A1B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A151C21A4C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2B47F72;
	Mon,  5 Feb 2024 18:02:26 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283A47F52
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156145; cv=none; b=VUvC+hREQynd767NXfnIQy30yuRTslUM6XZiF8uHmgd+QSQgvCwS47gM5AO8DG90t8ymm/Jp/gkw3uPD06mY4f4CyJl7j9Cl4mFlPrFdt+1xze+56baT6cvZgpleNyXct/QAS9NrA1Xdhulj7dLpeWnHLVWjWZ9AA9dLqFfIP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156145; c=relaxed/simple;
	bh=MEgkn3kS9wmnBK1kZmclDSzAwGej1edbQU1uzSoS1WY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lvho7eWoO8F0x9N6/B+NvHFawu2wtOqyuN6EnmbK8l+MyQvJjjCwqdzXtVE1ekVswUb6BtjkArxqrk5hHo5FI05Q0QaXYnAQ5we8SREfnM7mkoodTG115x6VrJl8b27Lxtm7nrsdAdrhkGxv89hVltGbVHP3Ly3NlCQMzor9LD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 5E05B120AD4;
	Mon,  5 Feb 2024 18:02:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id D9F9720032;
	Mon,  5 Feb 2024 18:02:14 +0000 (UTC)
Message-ID: <5cfbdb015154919d24967aec4cec5890760c1dd5.camel@perches.com>
Subject: Re: [PATCH 1/2] checkpatch: tolerate long lines w/o spaces
From: Joe Perches <joe@perches.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, 
	akpm@linuxfoundation.org
Date: Mon, 05 Feb 2024 10:02:13 -0800
In-Reply-To: <20240203195527.212505-2-jim.cromie@gmail.com>
References: <20240203195527.212505-1-jim.cromie@gmail.com>
	 <20240203195527.212505-2-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D9F9720032
X-Rspamd-Server: rspamout02
X-Stat-Signature: em6gsp99854f5844maohmrcf7fj6eopd
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+ah2cifQ+mITEdb3dZhWnaRHHL6UTyEPk=
X-HE-Tag: 1707156134-865143
X-HE-Meta: U2FsdGVkX1+NsYntiXl6O/UfeU80rLKPhvPAHnKH0xLMFxuH+rLNoX8oaBFEk05mGt/aqvRSyyfomvB3J8WSxjcUVav9sI+tUxSYAqVs5cmHJaykZTxO5hNQwoLYcQjzYj8OU9DjqfY3qV5Z6+FfY4EW86b96tl1Jn5DDd5JwBYc08/tGqiTdo940aFkaxo7SCO8IYTNQ0hHUuquU4HtlY6z+dbimYR52TIuvX9lvOQ5X1KUBbfLAEambFzPg/vIHVRp/5Yl10DEjfAav+o9XlcjQ6yg0w//i1X/FEu4ZprL8TnI5a897Gh6aod5qfY9341Ul9LtYUnRWKLBzF0PLS9rLAYDhSvu3A2p077FxFuIddeRh/zjOe6HJAqkSa9ktTieVfeyjl9huzWxT78C4aQTPaT1bY0DPZMKd78Q7ftRk+GznHGtokysHvpwJ/mgy1+V20knfQN4gloUf6m7uw==

On Sat, 2024-02-03 at 12:55 -0700, Jim Cromie wrote:
> checkpatch complains about long lines (>75 chars), but allows a few
> exceptions:
>=20
>  file delta changes
>  filename then :
>  A Fixes:, link or signature tag line
>=20
> Add another exception, to allow a long "word" without whitespace.  The
> regex allows spaces in 1st 10 chars, so it allows the following [1],
> which current checkpatch carps about.
>=20
> [1] https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurc=
h@axis.com
>=20
> Dummy-tag: test-generic-tag-format-with-url-length-bla-bla-jeez-dont-give=
-up-now-there.
>=20
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  scripts/checkpatch.pl | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9c4c4a61bc83..dc17c6da3af2 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3271,6 +3271,8 @@ sub process {
>  					# filename then :
>  		      $line =3D~ /^\s*(?:Fixes:|$link_tags_search|$signature_tags)/i |=
|
>  					# A Fixes:, link or signature tag line
> +		      $line =3D~ /^.{10}\S+$/ ||
> +					# a long single "word" without whitespace

Perhaps better would be
		      $line =3D! /^(?:\S+\s+)?\S+$/ ||

=09
>  		      $commit_log_possible_stack_dump)) {
>  			WARN("COMMIT_LOG_LONG_LINE",
>  			     "Prefer a maximum 75 chars per line (possible unwrapped commit d=
escription?)\n" . $herecurr);



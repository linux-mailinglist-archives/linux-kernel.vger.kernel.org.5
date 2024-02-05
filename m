Return-Path: <linux-kernel+bounces-53131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F9684A10C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1144C1C22782
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D4644C8A;
	Mon,  5 Feb 2024 17:38:33 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CE847794
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154712; cv=none; b=nd2TqZMwJTVNEzBxZUWgwF7pyab9hrKJVY+5WCSriKARNvv1MZTAKTk8ZaO4HjB660VCXHBU7jrtiSQW1OF2YGbP6M2HjgU9JHeMI5aQR5YU4SUQO22MlJFi8K4E3i6by9c9LuE6iG8VSmWSJvY7cIf4kUk0gXhVlZCNuCgtxmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154712; c=relaxed/simple;
	bh=+63XEcuL9/gnnYBEnW0AUIQGWHH7s4ALuOwLU+Fi/PQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKz8h8fpDCgFlnTnmISpHj8d0kK0rpN372JzwQ+hb7JS8rWtDM/wVC+nPbAKOAVtTic/DbtmRWfBWjRqRuWuQb4ILVaJAHQ3TD5AhfE1lJhoXSoTEBS5Pgygo4sohsat3UuoCTXjiBE8rzgqbh/1ikyYyp1o5vKoa5Y4k9YjgV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id CD6321A0AFF;
	Mon,  5 Feb 2024 17:38:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 6914C1B;
	Mon,  5 Feb 2024 17:38:27 +0000 (UTC)
Message-ID: <cea9bc906796cdbfdd85a8c36ea5eb11a25979a7.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: minor whitespace changes for readability
From: Joe Perches <joe@perches.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, 
	akpm@linuxfoundation.org
Date: Mon, 05 Feb 2024 09:38:25 -0800
In-Reply-To: <20240203195527.212505-3-jim.cromie@gmail.com>
References: <20240203195527.212505-1-jim.cromie@gmail.com>
	 <20240203195527.212505-3-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6914C1B
X-Stat-Signature: f4ofds1wqg3uyyaqbmxjd5cej5r6oh7y
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/VrpeVGTuinPBkeQ4nkXS5lR4SUuqwcoM=
X-HE-Tag: 1707154707-834100
X-HE-Meta: U2FsdGVkX1+ex1aeBuOSLw9+pIvy/RzSUFLIu1atr6hkCgeRmVeF84Vh0NytG/14i8Pzmr2dNytpU7U3C4trfv7VibxvOjOQrTa4S0PhEOCthCW7NBDUo12Vld7ZooTBMZKSqAU0kzyNyEbCcVs0/W/GQaTfyAFP0sP99porpoOj4XmtZ/AZhKeZDqENG+QU3lxZ3IIgDxJDrWJlPWpb0if/aw7WGmKVK8JzvvIe4fn9ZM+Ww3DP+xXlMlHGk+CyJAIfZgLzkNedwf0RXJE4DuiLPbgoDFgTlnc6pyFe3podaM4uvjFqt+e7o4Wt/4M2dtyviuhP1on2MNlcB1tZ3OZrSI4rl1F9

On Sat, 2024-02-03 at 12:55 -0700, Jim Cromie wrote:
> Change the per-patch report format slightly, so its more paragraphic,
> and easier to peruse/scan.
>=20
> OLD FORM:
>=20
> 0001-checkpatch-report last line, looks part of 0002 has no ...
> --------------------------------------------------------------
> 0002-checkpatch-minor-whitespace-changes-for-readability.patch
> --------------------------------------------------------------
> total: 0 errors, 0 warnings, 15 lines checked
>=20
> 0002-checkpatch-minor-whitespace-changes-for-readability.patch has no ...
> --------------------------------------------------------------
>=20
> NEW FORM:
>=20
> --------------------------------------------------------------
> 0002-checkpatch-minor-whitespace-changes-for-readability.patch
> --------------------------------------------------------------
> total: 0 errors, 0 warnings, 15 lines checked
> 0002-checkpatch-minor-whitespace-changes-for-readability.patch
>  has no obvious style problems and is ready for submission.
>=20
> --------------------------------------------------------------
>=20
> For the optimum (warning free) patchset, the new report format is a
> series of single paragraphs (with the --- banners), one for each patch
> in the series.  This is trivial to scan/peruse, and is also more
> visually distinct from warning/error reports.
>=20
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  scripts/checkpatch.pl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index dc17c6da3af2..cd249ae9abdd 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7796,12 +7796,12 @@ EOM
>  	}
> =20
>  	if ($quiet =3D=3D 0) {
> -		print "\n";
>  		if ($clean =3D=3D 1) {
> -			print "$vname has no obvious style problems and is ready for submissi=
on.\n";
> +			print "$vname \n has no obvious style problems and is ready for submi=
ssion.\n";

Space after filename / $vname isn't necessary.

>  		} else {
> -			print "$vname has style problems, please review.\n";
> +			print "$vname \n has style problems, please review.\n";

here too.

>  		}
> +		print "\n";
>  	}
>  	return $clean;
>  }



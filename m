Return-Path: <linux-kernel+bounces-146607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A181A8A67FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7AF1F21CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB55126F2F;
	Tue, 16 Apr 2024 10:14:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8860126F0F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262484; cv=none; b=Q7MH8gq3iFbwCSbHqFG/lb6Q79zlpznPoPySSwO1D/L3P6Yxrca4IrMYlh4dPqm2a9heLDPjLkEp42KVmqf90BoyIJzDoQX0ZA11wcdTzwFMnLH/3T8m0jDUR0s0Ydh64NnuF8Cu415IZrI49QBa6/9EYRKTuEOwUDxJwbd2SFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262484; c=relaxed/simple;
	bh=I+0+BTbsmwoTIEEVNzepNEL2Vxzt2tzpP8xjp+mA12A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r3uOzx69dqlN8O3kMn/b2mIEhizJ0lNyAhDap4mhUjeP6KbbNF+NI+sht9fIdW5mB3r5zV8UrLbQ6pWhvWAvAC3iAmq5PNLdIc6SQElP9cYLpSJF84YIbF6q7ahArRVH1ggrkL07ipp6jClAXp33C2EGWIJVcJU8a6TEneW28CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 08CE7C098E;
	Tue, 16 Apr 2024 09:55:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id A4C191A;
	Tue, 16 Apr 2024 09:55:12 +0000 (UTC)
Message-ID: <a582c379f1bc2bc0d16b46ece9211bac40b4b7cf.camel@perches.com>
Subject: Re: [PATCH] checkpatch: error if file terminates without a new-line
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Greg KH
	 <gregkh@linuxfoundation.org>
Cc: Prasad Pandit <pj.pandit@yahoo.in>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Andy Whitcroft <apw@canonical.com>
Date: Tue, 16 Apr 2024 02:55:11 -0700
In-Reply-To: <edf23b1b-303a-46eb-b455-8c766c84ddf1@moroto.mountain>
References: <20240330033858.3272184-1-ppandit@redhat.com>
	 <1568855168.5949322.1713251087824@mail.yahoo.com>
	 <2024041627-overgrown-ripping-2348@gregkh>
	 <edf23b1b-303a-46eb-b455-8c766c84ddf1@moroto.mountain>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A4C191A
X-Stat-Signature: bw3duwewrot44jmugjm99o7jnzywb1xn
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/vYlRzHUsKRvWlK7CBLxcaHWmex+J4wIo=
X-HE-Tag: 1713261312-25940
X-HE-Meta: U2FsdGVkX1+Ajd9m6OJpXDsmwkHfDTckIPUDxgOwxTvB9mmWT0H1YjV6KUfAmV7JKPzeiNsQ3nW+/p5Ur9DWBpSkCuWa4IMjOs8J9QWsrFZUenXSz6PdoPOi7yBV9qNlz4RBmDIOO4nJjXmz2wMmgwxd9OHWIogcyJhydy4S1vWHM8fqlIl0Y9vbUthHqFcy8988+qsHEEWsfrI44tQbmZR4QlT0Cwu9MS+J7oOfCdX4KPiUY77oRRpkyCT5mhvYThFKa4sQStqyOS7pv71Pm99zJ5E70tMfLf877PZfNIDdtVTyfI9hrMQGNw+JCfMd

On Tue, 2024-04-16 at 11:59 +0300, Dan Carpenter wrote:
> On Tue, Apr 16, 2024 at 10:48:27AM +0200, Greg KH wrote:
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 9c4c4a61bc83..df34c0709410 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -2795,6 +2795,13 @@ sub process {
> > > =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 $is_patch =3D 1;
> > > =A0=A0=A0 =A0=A0=A0 }
> > >=20
> > > +# check if patch terminates file without a new line (\n)
> > > +=A0 =A0 =A0 =A0 if ($line =3D~ /^\\ No newline at end of file$/
> > > +=A0 =A0 =A0 =A0 =A0 =A0 and $rawlines[$linenr - 2] =3D~ /^\+.*$/) {
> > > +=A0 =A0 =A0 =A0 =A0 =A0 ERROR("NOEOL_FILE",
> > > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "patch terminates file without a=
 new line (\\n).");
> > > +=A0 =A0 =A0 =A0 }
> >=20
> > Why is this a problem?  files without a new line should not cause
> > problems with a compiler, right?  You don't have a justification for wh=
y
> > this change needs to be checked for anywhere.
> >=20
>=20
> I gave him such a good reason too...  It breaks `cat file.c`.  Plus, it
> looks weird in `git log -p` because it has a "No newline at the end of
> file" comment.
>=20
> regards,
> dan carpenter
>=20
> diff --git a/test.c b/test.c
> new file mode 100644
> index 000000000000..d808cac2d962
> --- /dev/null
> +++ b/test.c
> @@ -0,0 +1,12 @@
> +#include <stdio.h>
> +#include <stdbool.h>
> +#include "check_debug.h"
> +
> +void kfree(int *p);
> +
> +int *p;
> +int main(void)
> +{
> +       kfree(p);
> +       *p =3D 1;
> +}
> \ No newline at end of file
>=20
> commit f4a997924122d0094675c897a220371f0a129d90
>=20

There's an existing check for this.
I believe it at least used to work.
Fix that instead.

# check for adding lines without a newline.
		if ($line =3D~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =3D~ /=
^\\ No newline at end of file/) {
			if (WARN("MISSING_EOF_NEWLINE",
			         "adding a line without newline at end of file\n" . $herecurr) &=
&
			    $fix) {
				fix_delete_line($fixlinenr+1, "No newline at end of file");
			}
		}



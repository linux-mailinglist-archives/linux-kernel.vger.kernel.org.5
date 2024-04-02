Return-Path: <linux-kernel+bounces-127259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D68948D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80042B22C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E5AD2E6;
	Tue,  2 Apr 2024 01:39:27 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB48F55;
	Tue,  2 Apr 2024 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021966; cv=none; b=h1ZjuVmN3wbwRflz3CP11vtWE/6+EV2D1l6lj4vUg0WHdZeWAfr3Nhn7pV1TNjZMXrYxECc/gg9z0HikDTGPD54Jr7UL1X4BOFu4MILbpo1OJXNSV3/rurA4kpSZMfHnlC18DldCJNuDqIGj2qqS6YRzycqlwRmTNPImroWiAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021966; c=relaxed/simple;
	bh=vlhqz5KpBRf9749xRgTPKFO8TUdZ9RYNixw9VsfSU0M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qnMwttw9Yr11DDtNAz7RPbb9+TnlAUzTCbPAtfbCxbdlO6I6PLGqeMpXedlNanjvTpfV7QTymw1sHWSXHnjPWy5Zs6HPuEPBiT6iXhvQb/j8rQvLXvA/aHh8XTtKwnOgGqG/LJC+Qkrb+qLn8qWQUdT79ypPjjx7iLRWHJuAI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 85479140199;
	Tue,  2 Apr 2024 01:39:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 85F292000D;
	Tue,  2 Apr 2024 01:39:17 +0000 (UTC)
Message-ID: <3ea68e8fc46332d45e2af0d8de938628445b6691.camel@perches.com>
Subject: Re: [PATCH v5 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
From: Joe Perches <joe@perches.com>
To: Mac Xu <mac.xxn@outlook.com>, Barry Song <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org"
	 <akpm@linux-foundation.org>, "linux-doc@vger.kernel.org"
	 <linux-doc@vger.kernel.org>, "workflows@vger.kernel.org"
	 <workflows@vger.kernel.org>
Cc: "apw@canonical.com" <apw@canonical.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "chenhuacai@loongson.cn" <chenhuacai@loongson.cn>, 
 "chris@zankel.net" <chris@zankel.net>, "corbet@lwn.net" <corbet@lwn.net>, 
 "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>,  "lukas.bulwahn@gmail.com"
 <lukas.bulwahn@gmail.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, 
 "v-songbaohua@oppo.com" <v-songbaohua@oppo.com>, Max Filippov
 <jcmvbkbc@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, Charlemagne
 Lasse <charlemagnelasse@gmail.com>
Date: Mon, 01 Apr 2024 18:39:16 -0700
In-Reply-To: <MN0PR20MB471708D419907FFAF1DB0FC2F33E2@MN0PR20MB4717.namprd20.prod.outlook.com>
References: <20240401012120.6052-1-21cnbao@gmail.com>
	 <20240401012120.6052-3-21cnbao@gmail.com>
	 <f5bb12d8602a03d28b2a8aeaffd8f74f001d692d.camel@perches.com>
	 <MN0PR20MB471708D419907FFAF1DB0FC2F33E2@MN0PR20MB4717.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 85F292000D
X-Stat-Signature: 6ho5883h6gxd6usjtzscbx6e9uwzjpqi
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+vZ9mjWctkustVm6kw5YX3rWfz+BrXOao=
X-HE-Tag: 1712021957-318462
X-HE-Meta: U2FsdGVkX19ry6l9vQgZxv4Fb9Eb1aW7B+/HBhqXrlUOtlGQpxhNk8JdNQPrzJlak/pEzw0ZctqTBkStewNT8t4wXgswG8fAlqHmVOOMznK3hHXt6zv7YzxntmCnUSvmH59KTIkggyLMfjS2fChexa9S4528beBDHer9bpgp1DNkIQsOzWrGarR3tynjCgvlkmgTvTPaPJEzoEe5BQLVdnzH1isDxYupWV8pZ/kmntVtP3VG4uoCZ2EnGLMi11xe62pq4Zqed2rkH7ybMmV3wmK7XsOcTSP9R44dX+VPMikUFcx0Q8ZUeGRRYSPE7npRXm06LmQOsVCj052nPWHB+If09YfnORDWb7BK0BgaO5ahOzgALKVEOqfpIXNFyHywnHfdHi76BYEmwM3E4WIoFOEloEAweDtqO0AHxNn92Riu0YoLtne0CTjWE1zLvvHsf2dINtsOWJ4=

On Tue, 2024-04-02 at 00:16 +0000, Mac Xu wrote:
> > On Mon, 2024-04-01 at 14:21 +1300, Barry Song wrote:
> > > From: Xining Xu <mac.xxn@outlook.com>
> > >=20
> > > If function-like macros do not utilize a parameter, it might result i=
n a
> > > build warning.  In our coding style guidelines, we advocate for utili=
zing
> > > static inline functions to replace such macros.  This patch verifies
> > > compliance with the new rule.
> > >=20
> > > For a macro such as the one below,
> > >=20
> > > =A0#define test(a) do { } while (0)
> > >=20
> > > The test result is as follows.
> > >=20
> > > =A0ERROR: Parameter 'a' is not used in function-like macro, please us=
e static
> > > =A0inline instead
> > > =A0#21: FILE: mm/init-mm.c:20:
> > > =A0+#define test(a) do { } while (0)
> >=20
> > This is no longer true.
> > Please update the ERROR->WARN and message as below
> >=20
> > Ideally, this would have an update to
> > Documentation/dev-tools/checkpatch.rst
> >=20
> > to describe the new --verbose message type
>=20
> Hi Joe,
>=20
> Thank you for the comments, here's the code:
>=20
> +# check if this is an unused argument
> +if ($define_stmt !~ /\b$arg\b/) {
> +	WARN("MACRO_ARG_UNUSED",
> +		"Argument '$arg' is not used in function-like macro\n" . "$herectx");
> +}
>=20
> and here's the document for it which is inserted into the "Macros, Attrib=
utes and
> Symbols" section of checkpatch.rst starting from line 909:
> +
> +  **MACRO_ARG_UNUSED**
> +    If function-like macros do not utilize a parameter, it might result
> +    in a build warning. We advocate for utilizing static inline function=
s
> +    to replace such macros.
> +    For example, for a macro as below::
> +
> +      #define test(a) do { } while (0)
> +
> +    there would be a warning as below::
> +
> +      WARNING: Parameter 'a' is not used in function-like macro, please =
use
> +      static inline instead.
>=20
> Please let me know if the document needs further re-wording to make it he=
lpful enough
> to the readers.

Hi again Xining.

Thanks.

That looks good but it doesn't match the script output
which doesn't use ", please use static inline instead."
(and I believe the script should not output that too)

Another good thing would be to add a line like:

	See: https://www.kernel.org/doc/html/latest/process/coding-style.html#macr=
os-enums-and-rtl

For example, from: checkpatch.rst

  **ALLOC_SIZEOF_STRUCT**
    The allocation style is bad.  In general for family of
    allocation functions using sizeof() to get memory size,
    constructs like::

      p =3D alloc(sizeof(struct foo), ...)

    should be::

      p =3D alloc(sizeof(*p), ...)

    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#a=
llocating-memory



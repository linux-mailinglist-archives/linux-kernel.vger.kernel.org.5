Return-Path: <linux-kernel+bounces-126416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2D489377F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528B6281735
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 02:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C446107;
	Mon,  1 Apr 2024 02:45:23 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA144A3E;
	Mon,  1 Apr 2024 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711939523; cv=none; b=RhzSso8I/1USRUDdD/VPOurOjXvLJ5TsvNH11KJZiCa0IBDXWLAc9bbbokuVUJge3AhB4+vxxzixG13cM8uQaDYca7qefpbNRtRIpv+5KtCEB+SZRQ9bN8QE5BI2gosBn4IAgRAatM9b3jLsfGEkWjPViEMOOXOVzFRJNNQQ6b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711939523; c=relaxed/simple;
	bh=/ikhAY81eL2sCha6HmZfwOSjv2FnyUPw0qvgAVX+Pm0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kWRpAGgmT2ZCJNPpqylEfGa7J5FsSyTwY1b/X3ZraR4Qoi1mKhiW5rjn4l3BAISdbuzTtIRCjXMktWWxK5L+cbIVJk9KXDfEM7Y1ZQDgq9eZK9I0wEn4oleKiD9lGo1QQNW2410RiW8nBmUzhcFXAmgJQLyBqoFA3pLSeawNTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id E5F9B140163;
	Mon,  1 Apr 2024 02:37:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 94F752F;
	Mon,  1 Apr 2024 02:37:10 +0000 (UTC)
Message-ID: <f5bb12d8602a03d28b2a8aeaffd8f74f001d692d.camel@perches.com>
Subject: Re: [PATCH v5 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
From: Joe Perches <joe@perches.com>
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-doc@vger.kernel.org, workflows@vger.kernel.org
Cc: apw@canonical.com, broonie@kernel.org, chenhuacai@loongson.cn, 
 chris@zankel.net, corbet@lwn.net, dwaipayanray1@gmail.com, 
 herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 linux@roeck-us.net,  lukas.bulwahn@gmail.com, mac.xxn@outlook.com,
 sfr@canb.auug.org.au,  v-songbaohua@oppo.com, Max Filippov
 <jcmvbkbc@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, Charlemagne
 Lasse <charlemagnelasse@gmail.com>
Date: Sun, 31 Mar 2024 19:37:09 -0700
In-Reply-To: <20240401012120.6052-3-21cnbao@gmail.com>
References: <20240401012120.6052-1-21cnbao@gmail.com>
	 <20240401012120.6052-3-21cnbao@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 94F752F
X-Rspamd-Server: rspamout08
X-Stat-Signature: a64u7rec3zbcz9m6awd8n83w4n8owb8p
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18vTDvEamRn37xuX0ppkjF8TUYGi2CltWY=
X-HE-Tag: 1711939030-101202
X-HE-Meta: U2FsdGVkX1+Dx54Uuqrd53Q4Vep/KFkwhvXqJk6K+2fTwbRYgQygoOfSJsYBJDw84ZBamvcQYhupnfrLn9ldNQLAGJrWEj60xTLfSMsyleKhi+/p0qWgdGoJZqMSe3Zz76le2WPoWvML+QMTcLEbO6OKVuncThXxfrNnF7TxLynxHvalOcCJkIbvmpMSjdGtIcAvARlWuSxHJHXBIT5Kz8ZnBmmRdi2hFRwBL4KiWABcewafY6N2K4ALoAvk4roy7Kc+RUcymqg513RXQzkbUxY4qOKha6WrqQgUXIeJhuU7UsF7BacG7m/oo5yCsHL3vqxp7tjU6T6r7x0Te8gtdCUullfxBDA/

On Mon, 2024-04-01 at 14:21 +1300, Barry Song wrote:
> From: Xining Xu <mac.xxn@outlook.com>
>=20
> If function-like macros do not utilize a parameter, it might result in a
> build warning.  In our coding style guidelines, we advocate for utilizing
> static inline functions to replace such macros.  This patch verifies
> compliance with the new rule.
>=20
> For a macro such as the one below,
>=20
>  #define test(a) do { } while (0)
>=20
> The test result is as follows.
>=20
>  ERROR: Parameter 'a' is not used in function-like macro, please use stat=
ic
>  inline instead
>  #21: FILE: mm/init-mm.c:20:
>  +#define test(a) do { } while (0)

This is no longer true.
Please update the ERROR->WARN and message as below

Ideally, this would have an update to
Documentation/dev-tools/checkpatch.rst

to describe the new --verbose message type

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6040,6 +6040,12 @@ sub process {
>  					CHK("MACRO_ARG_PRECEDENCE",
>  					    "Macro argument '$arg' may be better as '($arg)' to avoid prece=
dence issues\n" . "$herectx");
>  				}
> +
> +# check if this is an unused argument
> +				if ($define_stmt !~ /\b$arg\b/) {
> +					WARN("MACRO_ARG_UNUSED",
> +						"Argument '$arg' is not used in function-like macro\n" . "$herectx=
");
> +				}



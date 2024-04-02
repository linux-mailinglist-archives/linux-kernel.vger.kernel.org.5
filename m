Return-Path: <linux-kernel+bounces-128753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867E4895EFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D57A283E31
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C930915E80C;
	Tue,  2 Apr 2024 21:54:50 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1715E218;
	Tue,  2 Apr 2024 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094890; cv=none; b=RMOKeBv13RBCoA8m7Exvh7HlT4X8vKz+zUQfzs9xTTi3PkJZXu2Y5dCQrLQ6G7NINDX2uCD8mXph33e/RY0/aDH2MNBo9dyTFbB2V73V1ajtYomwrZor7ky5F79uP4oR0MIHP8DYipPmWwBYVkNZgW1K3niqB8p/7yOfXKfoSPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094890; c=relaxed/simple;
	bh=2ufKch91pZRGc/uveyk4fgGSgZJjJ2GajcZWww18nV8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KQ/yx9WB6nMM0t5tqwVnN1GaxdjGI3DChqOQzUOJY4OYINmjLK2a+JCHJ9eYaf09r3Rxi+hXD155Dwoi5cH9u3t0H06Js3WUvSoWNxC5dJnr82DM8agNaLh3bkQvA7+Q40I5p3YaNESPhnJ0RYxvcRPS77hY8BK5WB/feK4I+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 86C3340AE7;
	Tue,  2 Apr 2024 21:54:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 1A9DE1B;
	Tue,  2 Apr 2024 21:54:34 +0000 (UTC)
Message-ID: <69ee112aadc8ef8ed7d819308f02dc58e56bb0a6.camel@perches.com>
Subject: Re: [PATCH v5 1/2] Documentation: coding-style: ask function-like
 macros to evaluate parameters
From: Joe Perches <joe@perches.com>
To: Barry Song <21cnbao@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: akpm@linux-foundation.org, linux-doc@vger.kernel.org, 
 workflows@vger.kernel.org, apw@canonical.com, broonie@kernel.org, 
 chenhuacai@loongson.cn, chris@zankel.net, dwaipayanray1@gmail.com, 
 herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 linux@roeck-us.net,  lukas.bulwahn@gmail.com, mac.xxn@outlook.com,
 sfr@canb.auug.org.au,  v-songbaohua@oppo.com, Max Filippov
 <jcmvbkbc@gmail.com>
Date: Tue, 02 Apr 2024 14:54:34 -0700
In-Reply-To: <CAGsJ_4x=YaGotZwRxjaRhELi=ExVcQ+euEkSiZ2GkAoLFwhMVw@mail.gmail.com>
References: <20240401012120.6052-1-21cnbao@gmail.com>
	 <20240401012120.6052-2-21cnbao@gmail.com> <87msqbvj3g.fsf@meer.lwn.net>
	 <CAGsJ_4x=YaGotZwRxjaRhELi=ExVcQ+euEkSiZ2GkAoLFwhMVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1A9DE1B
X-Stat-Signature: ewe43ggpsk1eq3kr1ik7u891ttmytcj5
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX197/gDa8PCJkfXgwl9wMf5X49Ghan30t2c=
X-HE-Tag: 1712094874-864766
X-HE-Meta: U2FsdGVkX1///woF/qoeUKg5SwLWdaK6ZP0tsWoKYOrZ/rhYZn8rvznQEH5x+crJVi7BzKWQ+ATaHwXcyxybuEKP6eRrN/U3jOUePTyvgoYQnn/G1iU1aYnAQAGvoD1Vv+KDrwMTXQwEvhlYKTuKUWL8fR6/xEnU456bB4oWGsUC9enSgLgNd+YrcekCATQv9cJtE3/qJGzk3kHeRsBlOPZWsEwm4xrWezmExAawWt0Ay61vlQIB6OesQxpfc1T/g/fHGa9x+Nd3v20eXTBIXKhhzmUxRgi0dYUcXSH3UHkA7iZb2hx1mplnEkTTilZDcJyF9LPQ2XbmdZlUcFnUK/mPPC+azjPrLlacM4OGWK6moXQzkuPE4K0/1ap1yAEMKgdBS3Y9pZ84BVU4TBcT6Qlt2ZJeEL1qQ01DMOJbFOe6+q9aImKt+7o2QM1HETob

On Wed, 2024-04-03 at 10:21 +1300, Barry Song wrote:
> On Wed, Apr 3, 2024 at 5:13=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> w=
rote:
> >=20
> > So I'm not sure what your desired path for getting this upstream is.  I
> > can take it, but I'm generally quite leery of taking coding-style
> > changes without some serious acks on them - nobody elected me as the
> > arbiter of proper coding style.

I believe it is generally appropriate for macros that take
arguments to use static inlines where feasible, so:

Acked-by: Joe Perches <joe@perches.com>

And yes, mm is the usual path for upstreaming at least this
sort of checkpatch change.


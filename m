Return-Path: <linux-kernel+bounces-163302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C558B68D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E55A2814BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E7B14286;
	Tue, 30 Apr 2024 03:32:07 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A8101C4;
	Tue, 30 Apr 2024 03:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447927; cv=none; b=TB4uosCfiTTUtBWucCLb4fQkXXRzvzExtNEpGaQBNo6zU0sdX6Gm9xQjiSiWygZqEAUYQcQSYmRrMEjMMKMgKcAsaX593TdpKE6vlGDd0vs3EWEDA0C8Tk+vNFXCNr36nDT+lEoI/V2Qn4rQCtcKXxf5KDmOOpz3gXhm6nZXVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447927; c=relaxed/simple;
	bh=yFxV8IAL/FhTPWHJslqDdQyTJdimCkoRX51HT2h/SaE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FjLZMFAEvHr23gv8ArdghudiyPczvonUx4J5W9WaV98LH8f/8jUtQldBOLBJD7hoJH8IINOdgxJnJ9PPLiTX7zROBd1RstWVBNIw4+uHvKMsz8AQ/gF3OQcZxLi1Rza1KwsiqioofXKr9OhofQ8LglKRPlold90VELNpfIxota8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A572B160447;
	Tue, 30 Apr 2024 03:21:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 0D09320025;
	Tue, 30 Apr 2024 03:21:50 +0000 (UTC)
Message-ID: <aacd7c3a5ad5bb4df71ec5dd107ef12b6ebf4079.camel@perches.com>
Subject: Re: [PATCH v6] checkpatch: add check for snprintf to scnprintf
From: Joe Perches <joe@perches.com>
To: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>,  Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 linux-hardening@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
Date: Mon, 29 Apr 2024 20:21:49 -0700
In-Reply-To: <202404291249.078D924@keescook>
References: <20240429-snprintf-checkpatch-v6-1-354c62c88290@google.com>
	 <202404291249.078D924@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0D09320025
X-Rspamd-Server: rspamout08
X-Stat-Signature: g4rtr57ict5i64t7bifcqsccwbpei8by
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/11DngRJQirq2hq9jlQZ0nlQjZJQ0C1o8=
X-HE-Tag: 1714447310-562688
X-HE-Meta: U2FsdGVkX19VkOaOkTZywdAdJmmPdqSae8cbGjpk4uNn3d20yEfKvhS5J1o91bK7gYO6EY6HnhIqW/ZDtisg4IhGhOfiaJFkywBivrkbrygz5gwAPqx7ksErpiIAAYxbLebjzAaCphQdnYaCjpyr3xYHXqEh5avOrlLccsYN7KP/+2wT+xFatkYcUpPhZFYTHk2dCBgCJHtvs5sI4FKqVKup/zj3mJnaamWCvBWCdOWPZo8OAVLKLDPFf8UUdiHp4eCaQiSWBJc/6rzVGX7yT+SoNd2fSVaDFxrE3qJ1CUKHPYZpmJEfkGLHFund3fVXNFUOgWCYYE1FFXQd31aLWloy9x4ENKmY4btEORRz1X40ojL7CNSR6QpOdzQMl5BovDitnRcXbhKWuXu7ILjyonK86NFh30LzvYp8TOPpVlWtXynTGdNXiXj6F+D+bBi/iljj2FqQAEi/C/ZdY52W9g==

On Mon, 2024-04-29 at 12:49 -0700, Kees Cook wrote:
> On Mon, Apr 29, 2024 at 06:39:28PM +0000, Justin Stitt wrote:
> > I am going to quote Lee Jones who has been doing some snprintf ->
> > scnprintf refactorings:
> >=20
> > "There is a general misunderstanding amongst engineers that
> > {v}snprintf() returns the length of the data *actually* encoded into th=
e
> > destination array.  However, as per the C99 standard {v}snprintf()
> > really returns the length of the data that *would have been* written if
> > there were enough space for it.  This misunderstanding has led to
> > buffer-overruns in the past.  It's generally considered safer to use th=
e
> > {v}scnprintf() variants in their place (or even sprintf() in simple
> > cases).  So let's do that."
> >=20
> > To help prevent new instances of snprintf() from popping up, let's add =
a
> > check to checkpatch.pl.
> >=20
> > Suggested-by: Finn Thain <fthain@linux-m68k.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>=20
> Thanks!
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
>=20

$ git grep -P '\b((v|)snprintf)\s*\(' | wc -l
7745
$ git grep -P '(?:return\s+|=3D\s*)\b((v|)snprintf)\s*\(' | wc -l
1626

Given there are ~5000 uses of these that don't care
whether or not it's snprintf or scnprintf, I think this
is not great.

I'd much rather make sure the return value of the call
is used before suggesting an alternative.

$ git grep  -P '\b((v|)snprintf)\s*\(.*PAGE_SIZE' | wc -l
515

And about 1/3 of these snprintf calls are for sysfs style
output that ideally would be converted to sysfs_emit or
sysfs_emit_at instead.



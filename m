Return-Path: <linux-kernel+bounces-60573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D70B8506E7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA43B237CF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD575FEF0;
	Sat, 10 Feb 2024 22:56:36 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C58259B;
	Sat, 10 Feb 2024 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707605796; cv=none; b=UnVXa71eSoT7x6TWMi4OaJLPB0ZYg0ZwXpAl66WO5eRINHj77gGz89Bs+KmkixK6iObaqLtg5rNyQKaKuiU2+a/ZKpQRHEaG20v9nEYK3PMNjDgwbGlV/m0femZrYJ/LE9QQnHJ9DB8DMNO6zMR8Z4mqGLzTnm3xCubuu+YmCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707605796; c=relaxed/simple;
	bh=8tKZK6z3KddJFqAvQqo359iHqAsAGCKcJW+oBIFlSvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O5qKPsSZu1q+pMKglW3EUoEE2c1+n+7EetY0cYhsCc6X4lTWw7LvgUJGUDkZNKBzwIgAjgdF97Gak3W6EpfrdcuU3578PNURZ75F54wVWJO1My40xodm3CkTdb9qvzDiCGR4+04ec1o28ouEVFg5mHESI4W+3noYluXKy+egHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id A21071A0663;
	Sat, 10 Feb 2024 22:56:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 4593A2000F;
	Sat, 10 Feb 2024 22:56:22 +0000 (UTC)
Message-ID: <beff7f4411586efd8f08d7b3d94b0ca235375790.camel@perches.com>
Subject: Re: .mailmap support for removals (was Re: [PATCH 00/10] scsi:
 Replace {v}snprintf() variants with safer alternatives)
From: Joe Perches <joe@perches.com>
To: Kees Cook <keescook@chromium.org>, tools@kernel.org
Cc: Lee Jones <lee@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Sat, 10 Feb 2024 14:56:21 -0800
In-Reply-To: <202402092252.0A0A59A@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
	 <c9129b08-50fb-4371-aa05-6f6c7cd7acfa@acm.org>
	 <20240208174912.GZ689448@google.com> <202402092252.0A0A59A@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4593A2000F
X-Stat-Signature: bwbccfhzcjhn6x9rfoppaay1kuycw7fn
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18XdaBtlCF0Uon/g9L1Z+Hs0qwOLAsaqXA=
X-HE-Tag: 1707605782-769569
X-HE-Meta: U2FsdGVkX18RorYUsbIJWjdQMGidD7ifUMhZwGLP+HKmvn48l+vAsuV+JlhC6OZhTOHQDRvrFvLFk3kVmNjMYKT3KrgHmlQYrO9+IASqY9foKvNs4KfanWAesXOmAMTgS5uSkQ6ik/f5Cco+Syj7RHgHCmdTKu90Jtk7srjS8TZd37qluqy8UGDhgKaHltEYCBCl29pCAvlGc53VkNom+mUFtQZpW3ensQFjYHJaa0r5VK5Y3C3h0mhQRUPwBr+Ivy8+go9TGO33cZUoD+8s3tghZqbzBQ0LybuuWFm4r5+hqCRiF01oL7l8gcFcJJkG+VulL8vcEWI4e+H/DCt8vdtX56tVV43fAPazTRWCfdq7OK2avqXHVJUYqXTskUwryylnqNquWqUJ9d0bAa0pH09UL7MwpB7suoQxWqYaOQH2BnUsokr6wbudeZERrULu3z5eMJG+Imz+OTxJwlu73cyoQxNEC2DSRtwtAxrUmjnOLYJ1LH6Y/73Uyakp9sKADdOmPssjE7k=

On Fri, 2024-02-09 at 22:56 -0800, Kees Cook wrote:
> On Thu, Feb 08, 2024 at 05:49:12PM +0000, Lee Jones wrote:
> > On Thu, 08 Feb 2024, Bart Van Assche wrote:
> >=20
> > > On 2/8/24 00:44, Lee Jones wrote:
> > > > Cc: Andre Hedrick <andre@suse.com>
> > >=20
> > > Please take a look at https://lwn.net/Articles/508222/.
> >=20
> > get_maintainer.pl pulled it from here:
> >=20
> > https://github.com/torvalds/linux/blob/master/drivers/scsi/3w-xxxx.c#L1=
1
>=20
> Oh. Hm. It seems "git check-mailmap" (and get_maintainers.pl) don't
> support a way to remove an email address -- only redirect it.
>=20
> It seems we may want to support "don't use this email address" for more
> than just the currently observed rationale. I don't have any good
> suggestions for what the format should look like? Perhaps:
>=20
> "" <address-to-remove@example.com>

/dev/null ?




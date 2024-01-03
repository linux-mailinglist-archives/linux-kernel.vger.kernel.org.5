Return-Path: <linux-kernel+bounces-16023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A8E823719
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074A1287CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9F61D6AA;
	Wed,  3 Jan 2024 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="F4PN/eEx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4650E1DA20;
	Wed,  3 Jan 2024 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 87AF61C33;
	Wed,  3 Jan 2024 21:27:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 87AF61C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704317230; bh=3W8UqnHAc/h8Xu2UTTAw555zswzyECYPtDW6YdDGYSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F4PN/eExkBrUFEoSL3VOgvTN4dt8OQELYbbbAGHGEP3ij3fYsNJcH3QSI/47Vf78w
	 3tTqvo1SxGTq3XQGKAMwsFPBVPdbLFsXtHXh+iY4x8UE5oVnBfd2E6GU+WMshWdXFs
	 sh8uN4ysZqwRaITppw8GQ3lWUBl7YWIiy6RT0mBfHa/RyFMPEXUx5ASBSMGIh2VW46
	 As03rElxs+AiQ9zmUujKGUuXjt0ENR8+nkCKFvKbq2OKFwAUmQ/GUL3sX2zNW0zt0y
	 xS9lAjqZw9i1ZNYZ5457iJhhgIuYK/QNesE8Sr56G3+pvsHlBNTVvncAlO+IzXOlEr
	 oy1uu0FgMlsMQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Subject: Re: [PATCH] Docs: remove mentions of fdformat from util-linux
In-Reply-To: <20231220-docs-fdformat-v1-1-0d05279e5d83@weissschuh.net>
References: <20231220-docs-fdformat-v1-1-0d05279e5d83@weissschuh.net>
Date: Wed, 03 Jan 2024 14:27:09 -0700
Message-ID: <87zfxm6rbm.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:

> Since util-linux commit 13b26e3c36d1
> ("fdformat: remove command from default build")
> the fdformat tool is not built anymore by default.
> As a result it is not packaged anymore by distributions and therefore
> not usable by users.
>
> Instead mention the "mount" command as more likely to be present
> alternative.
>
> Also drop the reference to fdformat from the list of features of new
> versions of util-linux.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  Documentation/process/changes.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Amusingly, my F39 system still has fdformat...but this change makes
sense, applied, thanks.

jon


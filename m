Return-Path: <linux-kernel+bounces-98843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5A87802C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106C91C2160D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C43CF7E;
	Mon, 11 Mar 2024 12:56:35 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7B22064;
	Mon, 11 Mar 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161795; cv=none; b=CLYmfL7+YqX8LNxQJTfiNJ8JPedlrttOBKlFp/tWW64Ea7raQap+DNgxlR5WUiW128rdu2afSY1MDZn0HLzdR97E2f4vKcoGm8+MYiwl8NKkpcdZcDq2EtTIHXXMQLflzchfNC3nXeeHSyjwsBqhrhPYSXIbRmBi/jQLGTQkbJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161795; c=relaxed/simple;
	bh=YOWPvJ1PovYucPG7scHldyK0kJUpjkmbzRBUpiky0aA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ea4MaOVx2Z/bXUy9nJIr2Jumxsm9GWX4HYjU82fSu+mKn8+3/UVHkd05C/DYUTPaPsInDqUMdoYtZSKxwFBM1OJB+j479WPC8ChYCkrygG6JnLy7rQoebE5cZXf61nvlYNeuFF33yofMwP8CKfRnxt+Sw1RCKefZIetWrMUoBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CEA126450941;
	Mon, 11 Mar 2024 13:56:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PXZWRRISZQ8B; Mon, 11 Mar 2024 13:56:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1F4376450948;
	Mon, 11 Mar 2024 13:56:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aRa4meSvKNMG; Mon, 11 Mar 2024 13:56:28 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id EB0836450941;
	Mon, 11 Mar 2024 13:56:27 +0100 (CET)
Date: Mon, 11 Mar 2024 13:56:27 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Christian Heusel <christian@heusel.eu>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	kernel-janitors <kernel-janitors@vger.kernel.org>
Message-ID: <1349276201.40757.1710161787719.JavaMail.zimbra@nod.at>
In-Reply-To: <b4oa6jak7f4hiaqcqpmasclaylqdhdzgne75a6nol6z33d4o7z@3soexkn4smz4>
References: <20240211003907.167891-1-christian@heusel.eu> <b4oa6jak7f4hiaqcqpmasclaylqdhdzgne75a6nol6z33d4o7z@3soexkn4smz4>
Subject: Re: [PATCH] jffs2: print symbolic error name instead of error code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2: print symbolic error name instead of error code
Thread-Index: W9U2fKy9ORNwIjN+anjPvwswt4VI2w==

----- Urspr=C3=BCngliche Mail -----
> Von: "Christian Heusel" <christian@heusel.eu>
> An: "David Woodhouse" <dwmw2@infradead.org>, "richard" <richard@nod.at>, =
"linux-mtd" <linux-mtd@lists.infradead.org>,
> "linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "kernel-janitors" <kernel-janitors@vger.kernel.org>
> Gesendet: Montag, 11. M=C3=A4rz 2024 13:47:40
> Betreff: Re: [PATCH] jffs2: print symbolic error name instead of error co=
de

> On 24/02/11 01:39AM, Christian Heusel wrote:
>> Utilize the %pe print specifier to get the symbolic error name as a
>> string (i.e "-ENOMEM") in the log message instead of the error code to
>> increase its readablility.
>>=20
>> This change was suggested in
>> https://lore.kernel.org/all/92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.m=
ountain/
>>=20
>> Signed-off-by: Christian Heusel <christian@heusel.eu>
>> ---
>>  fs/jffs2/background.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/jffs2/background.c b/fs/jffs2/background.c
>> index 6da92ecaf66d..bb0ee1a59e71 100644
>> --- a/fs/jffs2/background.c
>> +++ b/fs/jffs2/background.c
>> @@ -44,8 +44,8 @@ int jffs2_start_garbage_collect_thread(struct jffs2_sb=
_info
>> *c)
>>=20
>>  =09tsk =3D kthread_run(jffs2_garbage_collect_thread, c, "jffs2_gcd_mtd%=
d",
>>  =09c->mtd->index);
>>  =09if (IS_ERR(tsk)) {
>> -=09=09pr_warn("fork failed for JFFS2 garbage collect thread: %ld\n",
>> -=09=09=09-PTR_ERR(tsk));
>> +=09=09pr_warn("fork failed for JFFS2 garbage collect thread: %pe\n",
>> +=09=09=09tsk);
>>  =09=09complete(&c->gc_thread_exit);
>>  =09=09ret =3D PTR_ERR(tsk);
>>  =09} else {
>> --
>> 2.43.1
>=20
> Friendly ping on the above patch, since it's now a month after sending
> it :)

Thanks for the ping. Your patch looks good. I'll queue it.

Thanks,
//richard


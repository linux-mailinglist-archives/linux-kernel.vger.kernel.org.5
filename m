Return-Path: <linux-kernel+bounces-2113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA76815806
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45353286133
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1F12E45;
	Sat, 16 Dec 2023 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh1M5133"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D468B134A0;
	Sat, 16 Dec 2023 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso1624845e87.2;
        Fri, 15 Dec 2023 22:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702707875; x=1703312675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mvcews0bkmGQtLzZZHQH60WBefpCX2Y0ajeJT2rs0tM=;
        b=Rh1M5133cgcYKdFfFa0QWrQD4RGNESY9vcUA71iJm4fDXkkcQQOPWUZb9rKg35DnvJ
         7d6jBPikoYvYg65JyoBjVwrIlDwCevc/zj3WkNZndCZwc3C+jWWUINb5xVjyAg50s8lh
         +EkZqYd78E+DaPUMH4CZxZ3eARB6GUwhKK4jnskN7zPGTEVkl52coapbXOxIXhiioUZ0
         6FfEOwvyQtMR24oJ7eGfI0ie1rttk2KcCHa2vmY/lmcZE5Dmv3iPf7oyW6FXoxKpDjdh
         PD2Ysq8uG1tnIE2ogbr8CkuECPpoCUk7xUSf5jtq4TlWh1hclwHGbZ0v9MgE2C0PNKbo
         0Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702707875; x=1703312675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mvcews0bkmGQtLzZZHQH60WBefpCX2Y0ajeJT2rs0tM=;
        b=B7wf48NSeyEatDFI1Xf6eGQtuzkxDWSG/WwFbbqLDFxG4U6WtotDGvBWfhM8ZBcB3x
         NPkHVd8i3Lfvjlx0+dKPjMB0nGKx56Oxhn61TcTnET56m0LepHA+DjAJK/Glgx1YTvnU
         gSBumef8xFEGa8dV4jiRR2xeswXRXT8OTZFPKu/3b+Hf7fjsGFv6yIOKa89IZtYykZJq
         2QQa3c9yVLYnlkHY5RxFZwoJwWBajDUcZyxsPCH8Y5aQMgNhLfR/VUW0T/S4fPah36Gy
         Pv/hubDbu/9pxiqSNlQ2M4kjrWuNQsR06lK8DQUoirf+6r1XqAibsGZy4H0mmJlB8Ydb
         pgkg==
X-Gm-Message-State: AOJu0Yy14SqOoY7eQplPOQqhWQmTW8/mulgmyZVbtqCMtA1FjpZKURTo
	nor8RAbP5YcEKlsk5MwWsgpyDYqy9fUBYysYZD0=
X-Google-Smtp-Source: AGHT+IEU+xkKFg0E+T6i/v3ERxAOMcBYihZu1g9d3EVY1uSowY/sGag61JVIbppmfj3YPgO72hLie5JjxdRU/vKqU2M=
X-Received: by 2002:a05:6512:2829:b0:50b:f08f:8e8d with SMTP id
 cf41-20020a056512282900b0050bf08f8e8dmr3119231lfb.184.1702707874640; Fri, 15
 Dec 2023 22:24:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213022353.2983979-1-wozizhi@huawei.com>
In-Reply-To: <20231213022353.2983979-1-wozizhi@huawei.com>
From: Steve French <smfrench@gmail.com>
Date: Sat, 16 Dec 2023 00:24:23 -0600
Message-ID: <CAH2r5mvzuiYAT56SCx21A2dv-2+MfsaSRpX1fWWnMUnn9RtROg@mail.gmail.com>
Subject: Re: [PATCH -next] fs: cifs: Fix atime update check
To: Zizhi Wo <wozizhi@huawei.com>
Cc: stfrench@microsoft.com, lsahlber@redhat.com, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	yangerkun@huawei.com, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to cifs-2.6.git for-next (and added Cc: stable) pending additional te=
sting

Adding @Christian Brauner  and @Jeff Layton  since this overlaps a
recent change of theirs.


On Tue, Dec 12, 2023 at 8:25=E2=80=AFPM Zizhi Wo <wozizhi@huawei.com> wrote=
:
>
> Commit 9b9c5bea0b96 ("cifs: do not return atime less than mtime") indicat=
es
> that in cifs, if atime is less than mtime, some apps will break.
> Therefore, it introduce a function to compare this two variables in two
> places where atime is updated. If atime is less than mtime, update it to
> mtime.
>
> However, the patch was handled incorrectly, resulting in atime and mtime
> being exactly equal. A previous commit 69738cfdfa70 ("fs: cifs: Fix atime
> update check vs mtime") fixed one place and forgot to fix another. Fix it=
.
>
> Fixes: 9b9c5bea0b96 ("cifs: do not return atime less than mtime")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>  fs/smb/client/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index cf17e3dd703e..32a8525415d9 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -4671,7 +4671,7 @@ static int cifs_readpage_worker(struct file *file, =
struct page *page,
>         /* we do not want atime to be less than mtime, it broke some apps=
 */
>         atime =3D inode_set_atime_to_ts(inode, current_time(inode));
>         mtime =3D inode_get_mtime(inode);
> -       if (timespec64_compare(&atime, &mtime))
> +       if (timespec64_compare(&atime, &mtime) < 0)
>                 inode_set_atime_to_ts(inode, inode_get_mtime(inode));
>
>         if (PAGE_SIZE > rc)
> --
> 2.39.2
>
>


--
Thanks,

Steve


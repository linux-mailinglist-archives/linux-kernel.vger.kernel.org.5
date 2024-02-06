Return-Path: <linux-kernel+bounces-54857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7099584B489
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF6C1F26D22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BA21339AC;
	Tue,  6 Feb 2024 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="FhIMWAl3"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9814013398A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221140; cv=none; b=m1j9OyU8lZ6jslg6ZIlqT2JXg6is7E0WBtUF70AlVWS8ZjLMJ7GT5emMJ78kXHWnJlSwkZPlEBGJs4pOItg6cKLsEXV554HxN+TBYe6S6Q25PmS9CEvXAzPSQn3n/n+JFVpW4+nf3BCKy+554mD/pITVk4Dy/q3wks7+gmfzYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221140; c=relaxed/simple;
	bh=kCxpyhCIkD8sI2H48EGdcEy1zXvmczzB34iTUOyHnfY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aV8mP5FkT6nUT6PrMUFimoWPe67yz/OBmKEtktsYgF0j3B7jSDa/sloPBrwU3ta/dpMCCjyrHt/mydMH4on8tGVF91n+t4oziSPrQZVAmrOAKt+HJm1qThspvublaKxBfh56n6uk1zWxMTpC2OU1tDItEK4bcXiARfIqqxhigQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=FhIMWAl3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5114b1e8819so3384949e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 04:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1707221135; x=1707825935; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCxpyhCIkD8sI2H48EGdcEy1zXvmczzB34iTUOyHnfY=;
        b=FhIMWAl3DYnhLV6GE8jMWNGmvrUx/AcOpr+TnbnusqGH56PYJ82tTO6IbB92BoR3lD
         i1zvxBNO4Mffdn70AzED+NbZbTnq30WE+vs90FqbylUa9gzr1vymk8VEWJoH2PePFono
         thJ9auu627HPWr8HZTgUeHnipJtWG+myxPFnhefbz+fMrVfJiHd8nxBCtpOseT7ObjVM
         8VvU+FwtEjWFYUmISW2Mzqb4I8R12bofWoJm9uy3oGbLLRH3yKTW8GfSYP6WaneRYH98
         QZ700EPtng23bdABgwbDj+h6R5MLhTWsvcVvg0fRmM7EVk41M+numFB4vfC+5F9eeYRj
         Me8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707221135; x=1707825935;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCxpyhCIkD8sI2H48EGdcEy1zXvmczzB34iTUOyHnfY=;
        b=nEiiS9SUno5SvF2K9K/KPFTat0HjICRo0HegZqNZpm+Zf9o4yKXXiE0UZV2VvBlDmM
         LLDqaSnYjRTuu17bC+LOxrS7e0mybveRyDx4YUeCiBaLKjEQF9uCVOJZfkAMnvyq9A4a
         GeAc4P6sJn1EO7jt5lEelXuNdyVym7SR00S72QlCl6sm/lBQ6tv23UHEoo0DIJaZMFhr
         2pyJc7qXbKTGopxeFdGnkmVVo1PswOe+HX7wTk+G7JG2c+g545Fop3mnPYyDdIjFPB7P
         TO3ZdBg+d8S8yzrv3JaKBmMRR10jBGXZbw2ey6Vr7YgfpcYue/yM/G9wVz8j9FsxtdGG
         R8hg==
X-Gm-Message-State: AOJu0Yz2rMqFxjlAhDzOrGIjpR8Z6+GLyPgmnmRZ/cw2b28kyJDpYl+p
	fhlU2b20s7OnfuecthW0u+w37QSwgyIP9GMELIWc69QXvxQV9YIurPCBRtH+xjw=
X-Google-Smtp-Source: AGHT+IFmL3jA0tK/pJj8zV+Wyl+gyHDkeuKtYcNliLU2onyBUgZDD4rxe34/DE/kwouC8oaHAhnLow==
X-Received: by 2002:a05:6512:31ce:b0:511:619b:7257 with SMTP id j14-20020a05651231ce00b00511619b7257mr297187lfe.53.1707221135306;
        Tue, 06 Feb 2024 04:05:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVygO5oyq7Iwnz00Lw7fjp1Zgsn7nN6wAE5TM1uuRrrGbjb4y+nYgmngiuRaDuLm+I4B5r+GUeiTrPOehppMgaqmSCZaUbTxaJbv8GAjVlHkdwwy1/11/N/kogLDVhWrdHryI9DvRVmHx63+VlKnRM2YbO3DJ1/smlNyGBC1VfXGzk4UaZkWPYaA+sEiA==
Received: from smtpclient.apple ([84.252.147.254])
        by smtp.gmail.com with ESMTPSA id s26-20020a056512203a00b0051152b46a8csm225374lfs.190.2024.02.06.04.05.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 04:05:34 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH next] hfsplus: fix oob in hfsplus_bnode_read_key
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <tencent_164AB8743976ED67863C2F375496E236B009@qq.com>
Date: Tue, 6 Feb 2024 15:05:23 +0300
Cc: syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9DB6A341-5689-4E4A-B485-A798810751F8@dubeyko.com>
References: <000000000000c37a740610762e55@google.com>
 <tencent_164AB8743976ED67863C2F375496E236B009@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
X-Mailer: Apple Mail (2.3774.400.31)



> On 4 Feb 2024, at 14:51, Edward Adam Davis <eadavis@qq.com> wrote:
>=20
> In hfs_brec_insert(), if data has not been moved to "data_off + size", =
the size
> should not be added when reading search_key from node->page.
>=20
> Reported-and-tested-by: =
syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> fs/hfsplus/brec.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> index 1918544a7871..9e0e0c1f15a5 100644
> --- a/fs/hfsplus/brec.c
> +++ b/fs/hfsplus/brec.c
> @@ -138,7 +138,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void =
*entry, int entry_len)
> * at the start of the node and it is not the new node
> */
> if (!rec && new_node !=3D node) {
> - hfs_bnode_read_key(node, fd->search_key, data_off + size);

As far as I can see, likewise pattern 'data_off + size=E2=80=99 is used =
multiple times in hfs_brec_insert().
It=E2=80=99s real source of potential bugs, for my taste. Could we =
introduce a special variable (like offset)
that can keep calculated value?

> + hfs_bnode_read_key(node, fd->search_key, data_off +=20
> + (idx_rec_off =3D=3D data_rec_off ? 0 : size));

I believe the code of hfs_brec_insert() is complicated enough.
It will be great to rework this code and to add comments with
reasonable explanation of the essence of modification. It=E2=80=99s not =
so easy
to follow how moving is related to read the key operation.

What do you think?

Thanks,
Slava.

> hfs_brec_update_parent(fd);
> }
>=20
> --=20
> 2.43.0
>=20
>=20



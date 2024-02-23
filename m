Return-Path: <linux-kernel+bounces-77711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C67E860953
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48734B24358
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FFFD533;
	Fri, 23 Feb 2024 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="mlsOYNF4"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012DAC8DE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658456; cv=none; b=DP/bmll5QBp3wew/wzhJzQI/xnG1mnuwOThJPISS+V9BX+pjXwhSpcvq4yCYH5wihApceZhGrit4jZuA8uuuxcgI/tZsmNsuPiri9mTLoMiItWgbxA4eeQPrQ9uYg8eXzeUjac1pKqqHHv/1UHK5dqktLgromz/kJZmjAYwo2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658456; c=relaxed/simple;
	bh=1jVuDccX6c53Z5TPHBrUqUB5hgIDnadIovqzOPyZsRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcbIWQTjCVOhJbgqRyw07goi0jj7au00pvm+5Dcdh7QsFdxGPDtt8QvS7YsyRu8jf4SqFArqDoaVQenEio4CZCaSSd8L0AJa71Cmp7717091XJUA9TkMK6/nY4AE9fr09org3NrxiT0iSpuizobnGjnkFsdZniogXS469uWfx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=mlsOYNF4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d22fa5c822so5858961fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708658452; x=1709263252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz9/y1+Xczqmn0vzWbn4vSoN0rultOqiJeV+pU2vDP8=;
        b=mlsOYNF4ZX9GlCAQV+O1mwDa7JWjeWZxKVwaVUwiScj+wS+ir0XZfNW8oU0nWxfMm8
         lsnPSOUjQX56ci+T7k6dNdD9irGm9wrMb15zvDfABroydLK8WrQK9+N/qgPdaGMAHvcY
         XYwtk9Hm1Py3dTmPYD8QxREZqpe7X7M13vEkCb8ywOiePaCrxePmkyCFD74/Ye0wdAdo
         6H9iqBRnXLBJcw05pd5mK7davxdttRn0O4PIa5g0wEUbjHzQeQ9WleVR3EHR4aZKolrm
         qGdzy2c4ElD3IMz1yrlIbzQ4sxM5OH3KXwMvaFz0Fn9feLHMvd2oiyYoqdTxqU9KlKW0
         1ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658452; x=1709263252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gz9/y1+Xczqmn0vzWbn4vSoN0rultOqiJeV+pU2vDP8=;
        b=Wqyi1+yYncASbswjJWz8iw1AlBEy1NASaWp+9LIs+sucUHv4uzlwSAG3Gz15G6mICw
         nCsvqlyXUrEV9PYfLfaKkuDXugy0m/Qy89K49T3svvSJGW9gSHth3otEo4sGpsZznbMA
         WfNcMuukq2v4uaRQ5X+GkJmxQyJfY9buIeuLk068NU4WA54g2LItra2f2d8DbLyYZ8ey
         cIqiLQoFASb6i4oW70fDHYlyuCYzwkcjPcZVZuPfkuij/e+sH3zN30izlalT0lGzMYwU
         8Xpv5xdn6jV8OZJpwFC9p7PnEMBMeekvsKKvNKC3IQRlntm6xpuvifptMNVlNpDQBPsf
         zZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKc4yJBZh/CMwFpAn7XDDgNVobzKrFul/hvGDQ8Ef4FmRC5ukQEbMvzBjKQinVk/B31FBQCClhSv6jzDxU549mouekxTux9Jec98Jy
X-Gm-Message-State: AOJu0Yx1PSsnXbOEibFhNU9SMY8hXaWN/7eewKT66IGUe8yPtvgpeAdh
	G//UHAH9tZkr6YVVRi4+FD/wcM6mewhhb+jeFBtSq1u8X3uBdCAYbhovINIKZ9ULX7cgAgwqDk0
	14bTjQbx6sKv5tjqiPbLcP8a/BbIkP/JWgBeBiA==
X-Google-Smtp-Source: AGHT+IH/UzfMZ/ZV7LvEuilyk6pyGE5mVQdDN03YeHUUqvWVzTNugLcvFy/MOotbFW/bWyPy34qjlVo7J6Mgor6aabE=
X-Received: by 2002:a2e:9602:0:b0:2d2:4589:b7ba with SMTP id
 v2-20020a2e9602000000b002d24589b7bamr421076ljh.51.1708658451177; Thu, 22 Feb
 2024 19:20:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>
 <77a58302766cb6c8fac45682ede63569df80cd5d.camel@hammerspace.com> <1179779e2f74e3e5cb2be30cf89e6362aaab706d.camel@kernel.org>
In-Reply-To: <1179779e2f74e3e5cb2be30cf89e6362aaab706d.camel@kernel.org>
From: Zhitao Li <zhitao.li@smartx.com>
Date: Fri, 23 Feb 2024 11:20:37 +0800
Message-ID: <CAPKjjnrir1C8YYhhW10Nj6bAOTiz_YwWUOynEwXbjetMAuA1UA@mail.gmail.com>
Subject: Re: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "tom@talpey.com" <tom@talpey.com>, 
	"anna@kernel.org" <anna@kernel.org>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, "neilb@suse.de" <neilb@suse.de>, 
	"kolga@netapp.com" <kolga@netapp.com>, "huangping@smartx.com" <huangping@smartx.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for Jeff's reply.

I did see  ERESTARTSYS in userland. As described in the above
"Reproduction" chapter, "dd" fails with "dd: error writing
'/mnt/test1/1G': Unknown error 512".

After strace "dd", it turns out that syscall WRITE fails with:
write(1, "4\303\31\211\316\237\333\r-\275g\370\233\374X\277\374Tb\202\24\36=
5\220\320\16\27o3\331q\344\364"...,
1048576) =3D ? ERESTARTSYS (To be restarted if SA_RESTART is set)

In fact, other syscalls related to file systems can also fail with
ERESTARTSYS in our cases, for example: mount, open, read, write and so
on.

Maybe the reason is that on forced unmount, rpc_killall_tasks() in
net/sunrpc/clnt.c will set all inflight IO with ERESTARTSYS, while no
signal gets involved. So ERESTARTSYS is not handled before entering
userspace.

Best regards,
Zhitao Li at SmartX.

On Thu, Feb 22, 2024 at 7:05=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2024-02-21 at 13:48 +0000, Trond Myklebust wrote:
> > On Wed, 2024-02-21 at 16:20 +0800, Zhitao Li wrote:
> > > [You don't often get email from zhitao.li@smartx.com. Learn why this
> > > is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > Hi, everyone,
> > >
> > > - Facts:
> > > I have a remote NFS export and I mount the same export on two
> > > different directories in my OS with the same options. There is an
> > > inflight IO under one mounted directory. And then I unmount another
> > > mounted directory with force. The inflight IO ends up with "Unknown
> > > error 512", which is ERESTARTSYS.
> > >
> >
> > All of the above is well known. That's because forced umount affects
> > the entire filesystem. Why are you using it here in the first place? It
> > is not intended for casual use.
> >
>
> While I agree Trond's above statement, the kernel is not supposed to
> leak error codes that high into userland. Are you seeing ERESTARTSYS
> being returned to system calls? If so, which ones?
> --
> Jeff Layton <jlayton@kernel.org>


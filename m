Return-Path: <linux-kernel+bounces-150266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3678A9C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7F81C2404E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91016C423;
	Thu, 18 Apr 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvMN2+ym"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C63B16ABEE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449771; cv=none; b=MosWlEFwTF7vUrIf8u8TOBdAEqjbrdG2Z9o2ldyhi5jIKvM0LkJ6K9AKqsKrNBpoEAxW8QF+LdaYm5hULW5odCm7d2tiEgL3+dkVxR/mdAwaoBEC4wdQJTT3LAcd8b8f6/6s99ww6GQzkqDBfpvhmhaUcJpXHf2bMiXX3oHuP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449771; c=relaxed/simple;
	bh=K4KLZyB4pjOZHxyDBkfWN3vq6dPZje/ZZGT4mFX1CFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMgI+71zuXQyD0jjcoWrWsKBl7we2LmE97CIP18COUghaAcynKCh10DvbPCdAs62m2pgHsFFy/c0/qo+ikxlk+nfU53PlaQaEh3wqBxA4MxW0MRbfH3wSg1hI+sXGDbDJz+kKoy041lbQAkGhrWMv8P49IfUKEcv85EO6wjZqNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvMN2+ym; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5f034b4dcecso629122a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713449766; x=1714054566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moo2/Q0I4e+0pVWR8KV3lFeGCDDdXA9IltM3T9wFqic=;
        b=IvMN2+ympjiXjfiw5HnHS2SOf+iqdYEOX/sTw7UOJ3zYZeYxcuFIRffWqnrjTKgHBI
         KXJu/qKrssbNBdsUtka+Hsb1om5m2Y+0nfYTv/dhIKTdxPGnYfRWiM0FideAKSRw7MOM
         IOvZGv4L2OGN84OAVboy9WhojjGLq4A/hCY839sETHz5Ts9uARTw8rqgy+aJWaYVw3Jm
         Py2g55KSzKTW3/gWE/Mm1xuhwXBc6shtiLyP08qx812T7lEctiZKlFKrJhyIhI5yeE12
         sm+zr2NFyc2IapLqyGuVvTPVEOXMoHyp+W0amkYX1JrGte50DqfjLtz1ggczd0lM2w00
         5O5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449766; x=1714054566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moo2/Q0I4e+0pVWR8KV3lFeGCDDdXA9IltM3T9wFqic=;
        b=rtM4PLiimEWr8zkltvtT6tluIYDMhspGZrGYVzMqZZjOQ5yXRUOZVsJjtk+aYLjnvO
         f7cpzZes1jaMrNa90ieRQQ4jYgmMqmvuLJVmxrpDRFccExEF9pUwnpr8HDUrVDmk1u1J
         z9D6SumsRVt33lg7WeoGzmEB9OibCtz5a0E1fnK3stUq4Uvgm2eHoqG29zQ87+gDjoUM
         SOK0QZHiwnvKmgaA0zUGFSK8C3hJkV1Yn03zsT5cwkEfP8boWM2RzN0/G3CzBqlDAgc/
         Ru6Bi+YwqAFlP+IFV5xyV9fU2MvZxSMtdpAIkiBnh4jIIIymGjYwRVdlPEP5wYyk3EeU
         mu1g==
X-Forwarded-Encrypted: i=1; AJvYcCWixe/hjijjc8IEszW4XsMG9W6DpVH2duNK8FvQXm58fucLxB0a/xmwMwONGJT4jVG/Ccic7FMED4Gyr78+jBsX6nUVQjhDdunDzNWi
X-Gm-Message-State: AOJu0YxgZnDuVymejBbckHPLGnOPLa3a4gJVCyW9c5UDBV8j07KZauj6
	vBmSAOfIM61Hqqn0AEyGeL+gP2mZLHogKQ2Y+qtNREh5ZohkVXz23acP89ASPX8voMPrIdhsSMF
	xrAVsASwwO9hEc6H0TSdDBO50JOE=
X-Google-Smtp-Source: AGHT+IEdyd0JATd51DcGbv6THoQN/0K3QOYQ7h6+Uta4jclpsLKEG8cNeixgOGO2GEKCzQBJTjF5GXxvDkfsBPD0c2s=
X-Received: by 2002:a17:90b:1090:b0:2aa:c389:c9f0 with SMTP id
 gj16-20020a17090b109000b002aac389c9f0mr3770698pjb.12.1713449766156; Thu, 18
 Apr 2024 07:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416035240.2450127-1-wangzhu9@huawei.com> <2024041658-imagines-unlatch-a9b6@gregkh>
 <036c3371d3a64ef8881260197ce37dbc@huawei.com> <CADnq5_NML_BiqQx2UmwH86d3qv57D3tFRL--dro1qA99r0Qr5w@mail.gmail.com>
 <b9ab29ad37f94dfa81da3aa88c6456c2@huawei.com>
In-Reply-To: <b9ab29ad37f94dfa81da3aa88c6456c2@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Apr 2024 10:15:53 -0400
Message-ID: <CADnq5_PF=hynw-Fdt6JGxULXjBSCh1bM8dOgSbpeR4nAjh1pUw@mail.gmail.com>
Subject: Re: [PATCH v6.6] drm/amd/display: Wake DMCUB before executing GPINT commands
To: wangzhu <wangzhu9@huawei.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	"harry.wentland@amd.com" <harry.wentland@amd.com>, "sunpeng.li@amd.com" <sunpeng.li@amd.com>, 
	"Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>, 
	"alexander.deucher@amd.com" <alexander.deucher@amd.com>, 
	"christian.koenig@amd.com" <christian.koenig@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, 
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "qingqing.zhuo@amd.com" <qingqing.zhuo@amd.com>, 
	"stylon.wang@amd.com" <stylon.wang@amd.com>, "Josip.Pavic@amd.com" <Josip.Pavic@amd.com>, 
	"trix@redhat.com" <trix@redhat.com>, "cruise.hung@amd.com" <cruise.hung@amd.com>, 
	"Eric.Yang2@amd.com" <Eric.Yang2@amd.com>, 
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>, "alvin.lee2@amd.com" <alvin.lee2@amd.com>, 
	"jun.lei@amd.com" <jun.lei@amd.com>, "austin.zheng@amd.com" <austin.zheng@amd.com>, 
	"sunglee@amd.com" <sunglee@amd.com>, "paul.hsieh@amd.com" <paul.hsieh@amd.com>, 
	"hanghong.ma@amd.com" <hanghong.ma@amd.com>, "JinZe.Xu@amd.com" <JinZe.Xu@amd.com>, 
	"lewis.huang@amd.com" <lewis.huang@amd.com>, "alex.hung@amd.com" <alex.hung@amd.com>, 
	"syed.hassan@amd.com" <syed.hassan@amd.com>, "wayne.lin@amd.com" <wayne.lin@amd.com>, 
	"nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>, 
	"chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>, 
	"aurabindo.pillai@amd.com" <aurabindo.pillai@amd.com>, "aric.cyr@amd.com" <aric.cyr@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 11:14=E2=80=AFPM wangzhu <wangzhu9@huawei.com> wrot=
e:
>
> The CVE-2023-52624 is fixed in linux-6.7 stable, while it is not fixed in=
 6.6, this commit is presented to fix it in linux-6.6 stable.

Why is there a CVE in the first place?  Is this actually an issue you
have seen?  It seems like you just picked a random patch and opened a
CVE.

Alex


>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher [mailto:alexdeucher@gmail.com]
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B44=E6=9C=8818=E6=97=A5 =
9:58
> =E6=94=B6=E4=BB=B6=E4=BA=BA: wangzhu <wangzhu9@huawei.com>
> =E6=8A=84=E9=80=81: Greg KH <gregkh@linuxfoundation.org>; harry.wentland@=
amd.com; sunpeng.li@amd.com; Rodrigo.Siqueira@amd.com; alexander.deucher@am=
d.com; christian.koenig@amd.com; airlied@linux.ie; daniel@ffwll.ch; qingqin=
g.zhuo@amd.com; stylon.wang@amd.com; Josip.Pavic@amd.com; trix@redhat.com; =
cruise.hung@amd.com; Eric.Yang2@amd.com; mario.limonciello@amd.com; alvin.l=
ee2@amd.com; jun.lei@amd.com; austin.zheng@amd.com; sunglee@amd.com; paul.h=
sieh@amd.com; hanghong.ma@amd.com; JinZe.Xu@amd.com; lewis.huang@amd.com; Z=
hengzengkai <zhengzengkai@huawei.com>; alex.hung@amd.com; syed.hassan@amd.c=
om; wayne.lin@amd.com; nicholas.kazlauskas@amd.com; chiahsuan.chung@amd.com=
; aurabindo.pillai@amd.com; aric.cyr@amd.com; amd-gfx@lists.freedesktop.org=
; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> =E4=B8=BB=E9=A2=98: Re: [PATCH v6.6] drm/amd/display: Wake DMCUB before e=
xecuting GPINT commands
>
> On Wed, Apr 17, 2024 at 9:51=E2=80=AFPM wangzhu <wangzhu9@huawei.com> wro=
te:
> >
> > Hi Greg, thanks for your reply. Since there is no patch to fix CVE-2023=
-52624 in linux-5.10, there is a patch in the linux-6.7 branch, its commit =
is 2ef98c6d753a744e333b7e34b9cf687040fba57d ("drm/amd/display: Wake DMCUB b=
efore executing GPINT commands"). When we apply this patch to linux-5.10, t=
here are lots of conflicts, and we found there are lots of dependent patche=
s, and lots of patches are not proposed to fix the cve, they are presented =
to add new functions of the kernel.
> >
>
> Why is there a CVE?  Have you uncovered some specific issue?
>
> Alex
>
> > My commit comes from nearly 20 patches. For each patch, not all of its =
content is meant to fix the cve, so I just get the part which is helpful to=
 fix. It is why I don't present the patches one by one instead of merging t=
hem into one big patch.
> >
> >
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Greg KH [mailto:gregkh@linuxfoundation.org=
]
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B44=E6=9C=8816=E6=97=
=A5 12:54
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: wangzhu <wangzhu9@huawei.com>
> > =E6=8A=84=E9=80=81: harry.wentland@amd.com; sunpeng.li@amd.com;
> > Rodrigo.Siqueira@amd.com; alexander.deucher@amd.com;
> > christian.koenig@amd.com; airlied@linux.ie; daniel@ffwll.ch;
> > qingqing.zhuo@amd.com; stylon.wang@amd.com; Josip.Pavic@amd.com;
> > trix@redhat.com; cruise.hung@amd.com; Eric.Yang2@amd.com;
> > mario.limonciello@amd.com; alvin.lee2@amd.com; jun.lei@amd.com;
> > austin.zheng@amd.com; sunglee@amd.com; paul.hsieh@amd.com;
> > hanghong.ma@amd.com; JinZe.Xu@amd.com; lewis.huang@amd.com;
> > Zhengzengkai <zhengzengkai@huawei.com>; alex.hung@amd.com;
> > syed.hassan@amd.com; wayne.lin@amd.com; nicholas.kazlauskas@amd.com;
> > chiahsuan.chung@amd.com; aurabindo.pillai@amd.com; aric.cyr@amd.com;
> > amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org;
> > linux-kernel@vger.kernel.org
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v6.6] drm/amd/display: Wake DMCUB before=
 executing
> > GPINT commands
> >
> > On Tue, Apr 16, 2024 at 03:52:40AM +0000, Zhu Wang wrote:
> > > From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > >
> > > stable inclusion
> > > from stable-v6.7.3
> > > commit 2ef98c6d753a744e333b7e34b9cf687040fba57d
> > > category: bugfix
> > > bugzilla: https://gitee.com/src-openeuler/kernel/issues/I9BV4C
> > > CVE: CVE-2023-52624
> > >
> > > Reference:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c
> > > om mit/?id=3D2ef98c6d753a744e333b7e34b9cf687040fba57d
> > >
> > > --------------------------------
> > >
> > > [ Upstream commit e5ffd1263dd5b44929c676171802e7b6af483f21 ]
> > >
> > > [Why]
> > > DMCUB can be in idle when we attempt to interface with the HW
> > > through the GPINT mailbox resulting in a system hang.
> > >
> > > [How]
> > > Add dc_wake_and_execute_gpint() to wrap the wake, execute, sleep
> > > sequence.
> > >
> > > If the GPINT executes successfully then DMCUB will be put back into
> > > sleep after the optional response is returned.
> > >
> > > It functions similar to the inbox command interface.
> > >
> > > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
> > > Acked-by: Wayne Lin <wayne.lin@amd.com>
> > > Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > > Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > >
> > > This commit comes from following commits:
> > >
> > >  8774029f76b9 ("drm/amd/display: Add DCN35 CLK_MGR")  65138eb72e1f
> > > ("drm/amd/display: Add DCN35 DMUB")  dc01c4b79bfe ("drm/amd/display:
> > > Update driver and IPS interop")
> > >  820c3870c491 ("drm/amd/display: Refactor DMCUB enter/exit idle
> > > interface")  2ef98c6d753a ("drm/amd/display: Wake DMCUB before
> > > executing GPINT commands")
> >
> > Why are you putting multiple commits together and not just submitting t=
he individual ones?  And what is this for?
> >
> > confused,
> >
> > greg k-h


Return-Path: <linux-kernel+bounces-149419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B688A90E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499EA1C209AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDFE39AF2;
	Thu, 18 Apr 2024 01:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkwbhITQ"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3193839D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713405515; cv=none; b=AbxNJfd0bPA76Rr25g+8AsPjfBQE7ETfTSqWl1oNOaivp8prw0tqajdNHzFsDfLVXfPbngaefH2UmwtbArvWm9gx3g4cLNpDdHPh8N0TsoPpoUGD20pXxnM0JTtpcpDzxGOpueyYsqnzYiJXDXaQh0XRtBRlumn8JIUEanNgp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713405515; c=relaxed/simple;
	bh=sagcvCQ/8asQ8FmznG/Ng5l9RekV/0z1w8WlqrsiHEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phZviaIaNfP0Z7q35An/Z8yO0JhpIxgzMiGH9feWkrHs9Ef4e34/o4XiNCv+3wkY1ehSLLyehxW1QCM519LqAnWxbX6zsRKVxYNOP43udRy5cJp13kr2Zh2LNgOCWtBrPgMqKiFDkvWMf4IU8TdBoaaV1Y6ARyuv+W68KHZbpEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkwbhITQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a475bdd4a6so277467a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713405513; x=1714010313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BQbZH8V6AkArNU8C8n3UT3FZgYZm8SuVNBisdoq2hc=;
        b=QkwbhITQUjc4sBJMit8t5S4d4u3QnJ0YzuU2txu80iD5d6AxHD+shGNyh+jpWn2PGn
         Vk8L7N4/h6pnBdYZ/9zQ6vr8QwHHXLlTFUJDRLHraT40BdbHMqJXG+hPV6nBnMikD7//
         X6cWgZKWOgGoMgxCBVDa2o0dv8YzK2/k/zaRK7KXvu/hgmfMex5jrLQS/yLslTTaRqye
         9LrRBzHAJp2Qm+BOWqgVqDeWCk+Kz5McLZ+kdkdjwNBFV6xNWJcNmsy49GQmr2ldPolS
         IXaxg7adkEVedVrXF27ko0njOjrl69uEyq232LeaTA5jRqt5+Wir6zP/Mx/jhqYSoWlA
         +m1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713405513; x=1714010313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BQbZH8V6AkArNU8C8n3UT3FZgYZm8SuVNBisdoq2hc=;
        b=n3LeKEmmov5W7wOZbCUES2WvFpnpHZx0wMuH5krpgj7kEPFGUaRc7rEmbFpPJA2sbF
         k54LEYuJbDYxNj+vPD5WGbHcY7MPhYmL6/FW/AZoxAwHjuBesVKZIeztP5CpcI5YqfSb
         jqQeQQyoZdnsyZ4k2dig9FUP19XQpq/aTPrcRvdL4iqZvQ5qMcu3On5RDM9Nan5K3N4e
         zyzkyMpr7Zlq8y+GTpXc2FqBFAp7nIxxgmMEFhgH33IbHI+6vZXhFpW4yr+c/r8oQ/p0
         9Dt3SmOYhMru59cc8GpNHzaNBgAGQ339Lj1XuIkDoWS1UB1uZ8aKku90F93Ybk3M9Jr2
         OR2g==
X-Forwarded-Encrypted: i=1; AJvYcCWfiKM84qFjjzOgiGDvQHBKOMkSKfy8SHke3HsuhD2Ez9W7z/zMy7XYRVKPAft1+SRBRgk0DZjfKmz9MNXJ4PlmqQdacTAe2lKxDuU/
X-Gm-Message-State: AOJu0Yxwg3Su13O+bBmvrZ0fKqOsmtlVwFsl4C/DiK21tcBd5KZWDDlq
	7soapbRIQJnAgvZmyAFEO+HUwf4Sir0Ungf8j7g2IRJwfr0RTBuuPRreDiDZacwbeOZpOxH1yHv
	xVdD2IJAIN36niVT1HIBaZBKgb0c=
X-Google-Smtp-Source: AGHT+IEc8km59dil+ryu0/tDjq9YKqCypfeAJvhe0wIcQMkHNXop508QC5grarMl1sc9xlttfoS7xQUePdznnHJVMSo=
X-Received: by 2002:a17:90a:f40f:b0:2a5:d0cf:43b with SMTP id
 ch15-20020a17090af40f00b002a5d0cf043bmr1286536pjb.21.1713405513517; Wed, 17
 Apr 2024 18:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416035240.2450127-1-wangzhu9@huawei.com> <2024041658-imagines-unlatch-a9b6@gregkh>
 <036c3371d3a64ef8881260197ce37dbc@huawei.com>
In-Reply-To: <036c3371d3a64ef8881260197ce37dbc@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Apr 2024 21:58:20 -0400
Message-ID: <CADnq5_NML_BiqQx2UmwH86d3qv57D3tFRL--dro1qA99r0Qr5w@mail.gmail.com>
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
	"lewis.huang@amd.com" <lewis.huang@amd.com>, Zhengzengkai <zhengzengkai@huawei.com>, 
	"alex.hung@amd.com" <alex.hung@amd.com>, "syed.hassan@amd.com" <syed.hassan@amd.com>, 
	"wayne.lin@amd.com" <wayne.lin@amd.com>, 
	"nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>, 
	"chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>, 
	"aurabindo.pillai@amd.com" <aurabindo.pillai@amd.com>, "aric.cyr@amd.com" <aric.cyr@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 9:51=E2=80=AFPM wangzhu <wangzhu9@huawei.com> wrote=
:
>
> Hi Greg, thanks for your reply. Since there is no patch to fix CVE-2023-5=
2624 in linux-5.10, there is a patch in the linux-6.7 branch, its commit is=
 2ef98c6d753a744e333b7e34b9cf687040fba57d ("drm/amd/display: Wake DMCUB bef=
ore executing GPINT commands"). When we apply this patch to linux-5.10, the=
re are lots of conflicts, and we found there are lots of dependent patches,=
 and lots of patches are not proposed to fix the cve, they are presented to=
 add new functions of the kernel.
>

Why is there a CVE?  Have you uncovered some specific issue?

Alex

> My commit comes from nearly 20 patches. For each patch, not all of its co=
ntent is meant to fix the cve, so I just get the part which is helpful to f=
ix. It is why I don't present the patches one by one instead of merging the=
m into one big patch.
>
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Greg KH [mailto:gregkh@linuxfoundation.org]
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B44=E6=9C=8816=E6=97=A5 =
12:54
> =E6=94=B6=E4=BB=B6=E4=BA=BA: wangzhu <wangzhu9@huawei.com>
> =E6=8A=84=E9=80=81: harry.wentland@amd.com; sunpeng.li@amd.com; Rodrigo.S=
iqueira@amd.com; alexander.deucher@amd.com; christian.koenig@amd.com; airli=
ed@linux.ie; daniel@ffwll.ch; qingqing.zhuo@amd.com; stylon.wang@amd.com; J=
osip.Pavic@amd.com; trix@redhat.com; cruise.hung@amd.com; Eric.Yang2@amd.co=
m; mario.limonciello@amd.com; alvin.lee2@amd.com; jun.lei@amd.com; austin.z=
heng@amd.com; sunglee@amd.com; paul.hsieh@amd.com; hanghong.ma@amd.com; Jin=
Ze.Xu@amd.com; lewis.huang@amd.com; Zhengzengkai <zhengzengkai@huawei.com>;=
 alex.hung@amd.com; syed.hassan@amd.com; wayne.lin@amd.com; nicholas.kazlau=
skas@amd.com; chiahsuan.chung@amd.com; aurabindo.pillai@amd.com; aric.cyr@a=
md.com; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; lin=
ux-kernel@vger.kernel.org
> =E4=B8=BB=E9=A2=98: Re: [PATCH v6.6] drm/amd/display: Wake DMCUB before e=
xecuting GPINT commands
>
> On Tue, Apr 16, 2024 at 03:52:40AM +0000, Zhu Wang wrote:
> > From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> >
> > stable inclusion
> > from stable-v6.7.3
> > commit 2ef98c6d753a744e333b7e34b9cf687040fba57d
> > category: bugfix
> > bugzilla: https://gitee.com/src-openeuler/kernel/issues/I9BV4C
> > CVE: CVE-2023-52624
> >
> > Reference:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com
> > mit/?id=3D2ef98c6d753a744e333b7e34b9cf687040fba57d
> >
> > --------------------------------
> >
> > [ Upstream commit e5ffd1263dd5b44929c676171802e7b6af483f21 ]
> >
> > [Why]
> > DMCUB can be in idle when we attempt to interface with the HW through
> > the GPINT mailbox resulting in a system hang.
> >
> > [How]
> > Add dc_wake_and_execute_gpint() to wrap the wake, execute, sleep
> > sequence.
> >
> > If the GPINT executes successfully then DMCUB will be put back into
> > sleep after the optional response is returned.
> >
> > It functions similar to the inbox command interface.
> >
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
> > Acked-by: Wayne Lin <wayne.lin@amd.com>
> > Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > This commit comes from following commits:
> >
> >  8774029f76b9 ("drm/amd/display: Add DCN35 CLK_MGR")  65138eb72e1f
> > ("drm/amd/display: Add DCN35 DMUB")  dc01c4b79bfe ("drm/amd/display:
> > Update driver and IPS interop")
> >  820c3870c491 ("drm/amd/display: Refactor DMCUB enter/exit idle
> > interface")  2ef98c6d753a ("drm/amd/display: Wake DMCUB before
> > executing GPINT commands")
>
> Why are you putting multiple commits together and not just submitting the=
 individual ones?  And what is this for?
>
> confused,
>
> greg k-h


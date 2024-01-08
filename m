Return-Path: <linux-kernel+bounces-20109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE84827971
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395C81F21D84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E364F55C23;
	Mon,  8 Jan 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ferdQ/19"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A755787
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704747099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UkyxvZQ5pYouZXCc0oPIjClMUAkVOY8Na3esy8fS2w=;
	b=ferdQ/19XsRuDo2yl/uNftdc6KZBZNlS55w8m7Zva3OYJKP13qQe3x3nNswLOvoO1s5aHP
	EReLY8JnYh1Fzz/zoyhEu8PYex7au+LJ04iorxNXrzO1gZWb6u5Tn7JXJ87N/mXfxkN0mq
	I6rQ75wEJjoyzM320hthcNUfRSENIwQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-qZSLA9TtMUa2RnXi4VLf0A-1; Mon, 08 Jan 2024 15:51:38 -0500
X-MC-Unique: qZSLA9TtMUa2RnXi4VLf0A-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dbe868fdc33so2501331276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 12:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747097; x=1705351897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UkyxvZQ5pYouZXCc0oPIjClMUAkVOY8Na3esy8fS2w=;
        b=oRfvopK8xhKbzisw3yhKgbMtudJNWYOjIj1j6bIGxuTK60vZBila70yWssNx679Saq
         smKgznBkuqPk7Tz8sP3D8AToIf8om5sGlNYA2rILLOfFj2djW2ntpytvOSbOaZ2YwSjA
         Z/F3D336eAQIQeLv33OEEYC+zWL4rQZ8q19pUkkUq/kIDzWWq5s+4zhTFtNZzT5muM7i
         YRa9nvO/YXnCmeT7DIAT+6AtJU4f/L/bRwvn1kCGkbaJOnA6tvfqyU2IrfWDPK25nzr/
         rGb6PZBQw3jy7iFsDOTk/P+/IX/2va4+dwMgF/N51eZkDjCEVUij1SnGfStdi94LKtSt
         N/ZQ==
X-Gm-Message-State: AOJu0YwETVPvg5ltHaCrKPwSZZO4cIEltoGAWA48TSq3bCGW/VpBCJHm
	BdPo+IGVz5U/SSVd17AwoB/CiyLkOKBrFXkU6vwhvFxuVkHNA6yKHIAC2XHI/T60ma4zlgJAcQW
	tYjdCTkyrtJLvpb9GeeIBYvMHs3GSfx17+goqePz/d6Hmoybe
X-Received: by 2002:a25:7391:0:b0:db7:dacf:ed65 with SMTP id o139-20020a257391000000b00db7dacfed65mr1729930ybc.70.1704747097757;
        Mon, 08 Jan 2024 12:51:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE32OTXBZZ4AqcenfCZ/npf5vs1T3rzedd0Tz3UXzGyBKTZfzreJp+V6uBk9p0wYuShiMc+Z+KKDA0CtYQxSY=
X-Received: by 2002:a25:7391:0:b0:db7:dacf:ed65 with SMTP id
 o139-20020a257391000000b00db7dacfed65mr1729902ybc.70.1704747097086; Mon, 08
 Jan 2024 12:51:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108122823.2090312-1-sashal@kernel.org> <20240108122823.2090312-5-sashal@kernel.org>
In-Reply-To: <20240108122823.2090312-5-sashal@kernel.org>
From: David Airlie <airlied@redhat.com>
Date: Tue, 9 Jan 2024 06:51:25 +1000
Message-ID: <CAMwc25rAm1ndSiofWMMmQ1BeB0XxBvsHpcvaDKXUwEZp72iwEA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 5/5] nouveau: fix disp disabling with GSP
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Dave Airlie <airlied@gmail.com>, kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com, 
	daniel@ffwll.ch, bskeggs@redhat.com, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

NAK for backporting this to anything, it is just a fix for 6.7


On Mon, Jan 8, 2024 at 10:28=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Dave Airlie <airlied@gmail.com>
>
> [ Upstream commit 7854ea0e408d7f2e8faaada1773f3ddf9cb538f5 ]
>
> This func ptr here is normally static allocation, but gsp r535
> uses a dynamic pointer, so we need to handle that better.
>
> This fixes a crash with GSP when you use config=3Ddisp=3D0 to avoid
> disp problems.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20231222043308.309008=
9-4-airlied@gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c b/drivers/gp=
u/drm/nouveau/nvkm/engine/disp/base.c
> index 65c99d948b686..ae47eabd5d0bd 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
> @@ -359,7 +359,7 @@ nvkm_disp_oneinit(struct nvkm_engine *engine)
>         if (ret)
>                 return ret;
>
> -       if (disp->func->oneinit) {
> +       if (disp->func && disp->func->oneinit) {
>                 ret =3D disp->func->oneinit(disp);
>                 if (ret)
>                         return ret;
> @@ -461,8 +461,10 @@ nvkm_disp_new_(const struct nvkm_disp_func *func, st=
ruct nvkm_device *device,
>         spin_lock_init(&disp->client.lock);
>
>         ret =3D nvkm_engine_ctor(&nvkm_disp, device, type, inst, true, &d=
isp->engine);
> -       if (ret)
> +       if (ret) {
> +               disp->func =3D NULL;
>                 return ret;
> +       }
>
>         if (func->super) {
>                 disp->super.wq =3D create_singlethread_workqueue("nvkm-di=
sp");
> --
> 2.43.0
>



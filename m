Return-Path: <linux-kernel+bounces-30060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BBD83188E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFDB1F25E97
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBEB2420E;
	Thu, 18 Jan 2024 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaQbvfru"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39860241FB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577911; cv=none; b=Z2uEhJ2/jr2vnLGNwIRFv1blhc7hYKkoDl05n5s54EOzEooxGD7/l/NyUnAdmjfkw7VLAxxxt5VicurTJ3uENJlrtpjHOefbxtAdwcvQ3BnwfMQizBl/yxi6YmmLlKBIsxbBfSJ1K/uTbGHsTUR3d2+hpSJXVX3tza1zNWTeSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577911; c=relaxed/simple;
	bh=JzXspu+B6FBrN8pCVJrEuM4Ry5P/lCfwFyfAEVzd/mE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=kgTD76birYM1LN3MOfK5X9mVY4B6e1ZXC0DUSucFwwVYijukMw7+tD2f7VZEn60C9OSF1GHibYVvZCryk+XVfx1ogSEsGMsz1TM6wavJ+F0vyX+QB9bx5nna5/J6+lW45F/cRLe7hV5gIbMLNcl/Wm/aS4mGas91Pr0OFXX4Frc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaQbvfru; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e72e3d435so11776010e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705577908; x=1706182708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVdU1A74qUHSIDgwEfJ6kfyoxaDoAPC8NwCrvfgSTKE=;
        b=RaQbvfrui5GJ6GvvcAeOx7RXaTo8vDSIsGX90rIK8M6uEQYPS/RlUIruUHLI9QUJwB
         ErbklyuGapsZXpsT/ap2tbVdpDWromlyJDPaM08K7py8y70ipe+5cegIPC6kIRIOxHwa
         MD9EkRQMqCPCojmjYW7MUdQEN1VCVBnaSygTZQ46RLxz0sYi5BDgZn9aBfLynOXvcecS
         W8hqXpe/LNJNgJjFHD1Y4kHlLVDtcMcKlmULwKOmE2d0rTn0J+0QS0p6P1QEtwUZEOei
         nKxBbpaYRVhlI48ZOS8oxptoftJqLzXCJbW4uLE/AHaLZeN3bqza2BfrqNk7fzWIVm/K
         XKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705577908; x=1706182708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVdU1A74qUHSIDgwEfJ6kfyoxaDoAPC8NwCrvfgSTKE=;
        b=BovILzEh+xNVa8gReTWUeT8l6jSHVkmf0jhm9FXEMgIkmMYSDUssUJafuEOmML42Ul
         qXnvFp3wEvDt9XQAfB5LVb4UBkXgp5642oyuWeFgYFCGdlh/6KNg0dag+Gu+07yOZwid
         OMJy/sIsyw+cghptNCXYrgjCjln341yqWr8rVyrZFHA6LiGQBTMGZPHrCzwPKo+tF2jt
         8LAPE/6SbJJ3oDDeFptSZQrqqCGRp0R39Fyl8nMTAkDm1lwXri3mJujCJ1CBSup2skHP
         GPCYVs9Z7EBWpl+y4Wbf9pTbG5P9MPtefU+kOUzbyNnvZ0jECSPqNO39miEvL0XuljEF
         zzWA==
X-Gm-Message-State: AOJu0Yxo5UHPjn9UahmYH9TH2EwM9nugXZ86ewWlhgg/TM4EI45y4hzS
	3n/7HjsXjA/nNbVDav4xt4l0hIfpHz41kiOgr67ac1IlA1x59zlNgXNPkgze7CJ9DgrrsnrNd39
	K0ulNSDUmjLaMF/Hy/FRhOjhuflU=
X-Google-Smtp-Source: AGHT+IHsLB7D3zC7yf0/PqxZZOADB/N4A+vAqZ64vtrz7tqCewkjZsXZAU9Z3RINJC6ixlMaoyiy2Fw1PmN1O1VR344=
X-Received: by 2002:ac2:5de8:0:b0:50e:aac2:b88d with SMTP id
 z8-20020ac25de8000000b0050eaac2b88dmr261576lfq.94.1705577907999; Thu, 18 Jan
 2024 03:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
 <20240117031212.1104034-5-nunes.erico@gmail.com> <CAKGbVbsYJ7dusKREwpMVsxi+ryh+1ieshhwfJ72XVQ8b3x5OaA@mail.gmail.com>
In-Reply-To: <CAKGbVbsYJ7dusKREwpMVsxi+ryh+1ieshhwfJ72XVQ8b3x5OaA@mail.gmail.com>
From: Erico Nunes <nunes.erico@gmail.com>
Date: Thu, 18 Jan 2024 12:38:15 +0100
Message-ID: <CAK4VdL20-9LPKJeWKB1hduNyE_TxSviKOaEnHJv3gEtZasFqYA@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] drm/lima: handle spurious timeouts due to high irq latency
To: Qiang Yu <yuq825@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org, 
	anarsoul@gmail.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:46=E2=80=AFAM Qiang Yu <yuq825@gmail.com> wrote:
>
> On Wed, Jan 17, 2024 at 11:12=E2=80=AFAM Erico Nunes <nunes.erico@gmail.c=
om> wrote:
> > diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/l=
ima_sched.h
> > index 6a11764d87b3..34050facb110 100644
> > --- a/drivers/gpu/drm/lima/lima_sched.h
> > +++ b/drivers/gpu/drm/lima/lima_sched.h
> > @@ -29,6 +29,8 @@ struct lima_sched_task {
> >         bool recoverable;
> >         struct lima_bo *heap;
> >
> > +       struct dma_fence *done_fence;
> This is same as the following fence, do we really need a duplicated one?

Checking again now, I think we can reuse the existing one.


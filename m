Return-Path: <linux-kernel+bounces-12856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 569A181FB3F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8884C1C22003
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0A3107BB;
	Thu, 28 Dec 2023 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZOO2s9w0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA79107AB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-427b1bf1896so43870131cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703796661; x=1704401461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6AAWinozqvqRPJJJy9/95oMBpoLUYKoADUfceo9DTA=;
        b=ZOO2s9w016us9/zqSzu6ouMitNSrHYm90kxaxvCWxAYSFRdMYWcYB4DMjUvbyoinA3
         WKF6lSV1AOukHl5kxu+MDqCSkaSgf6ZRfF+9L+BXVT8PrNf6kAgJLo6KGC1F//I7js2j
         HKI1miOMmH+SaY287fZ3ta5lPKAxYLJMRfG64/3MliliPrdlUua+kaFEpLyPSkMHH4g7
         tlpyK8NHZKw+dLCrlQVwoPyRTmszFAySlopJiUNhIwaNW/RUEH3Kx0T9WRC4r3DJxb2q
         7USmXYkTII1TGPsvDgURwXcCD+y4OwFstnsa022AEP1ExkXdZrcmORm0997tjFw+e3Lu
         r/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703796661; x=1704401461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6AAWinozqvqRPJJJy9/95oMBpoLUYKoADUfceo9DTA=;
        b=jRIXRf6jL4+11VbULY+8jr+qHOQIyVH6GG8pb9IrCs4X+J4SW/mvGEWew6Z7lUNTs0
         PTeVMVWzcaDRHhbNYVqJmWLYuVmbN+mT/i1MnCJzHSdccpoPsElL+RRTAFegDBETN0KB
         i8HTbmKDePEN+afD5CYUwXbwr6UWSdAcHPzJOr1xGaJJ5T6yaT314SErPHf1llbubLJ5
         Xehyv61UCSTeisXBPRHIr9+XG1d9JpiZfOMh4m1LsQ7pCzLkYKf7EH71txiQWgJ+/ZJT
         BhPHVmmJos9bG88nXQ5cq8MQjl+iyi/rOkjjjCgp7ovugixdOnrgb6uWLOaSykY4SZ3y
         KDjg==
X-Gm-Message-State: AOJu0YzuxyhOxxejT76rWkgje7M8lFr82WdikbcmIzWjZzTA7RFxtqE9
	evxD0R4lAB22XQr/UyNPmx9BB/INDLWetalXabHNBSe5TBXQTw==
X-Google-Smtp-Source: AGHT+IFpM6FSJnu/fT7MUo3kvAgcqckDw2HVcb4L+wg/qq6S8e2uST/Lil7U8asRT24B/JXhj0d+Dr0vAnZygi7KTec=
X-Received: by 2002:a05:622a:55:b0:425:8a26:9798 with SMTP id
 y21-20020a05622a005500b004258a269798mr14518555qtw.73.1703796661591; Thu, 28
 Dec 2023 12:51:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com>
 <3d415ab4-e8c7-7e72-0379-952370612bdd@google.com> <CA+CK2bA2vZp3e+HHfB-sdLsPUYghMxvKcWURktDtNjwPL79Csw@mail.gmail.com>
 <b1049bfa-68c4-e237-30a9-1514a378c7f1@google.com> <CA+CK2bBxbvO-osm5XKk4VkaXYgfZXkDAtfayaYJ-vXo=QFqGPA@mail.gmail.com>
 <13e5fbd4-d84d-faba-47f1-d0024d2c572d@google.com> <20231227104244.824b0977ae6d4bb6b37f6f79@linux-foundation.org>
 <CA+CK2bAARPNHwZB9tkd6miKr8GWrZ_L6h1oiUM0qWu6pJqh3Wg@mail.gmail.com> <c2b73ac2-c271-d11c-6d06-3e0ab74a29a6@google.com>
In-Reply-To: <c2b73ac2-c271-d11c-6d06-3e0ab74a29a6@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 28 Dec 2023 15:50:24 -0500
Message-ID: <CA+CK2bB2=raEP8W5GDW_JY7TDvwtSCbkQjvn=SvbjUjPETXZow@mail.gmail.com>
Subject: Re: Sysfs one-value-per-file (was Re: [PATCH] vmstat: don't auto
 expand the sysfs files)
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, surenb@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, souravpanda@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 3:43=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Thu, 28 Dec 2023, Pasha Tatashin wrote:
>
> > > > But for existing files and conventions, I think we should settle it=
 as
> > > > "keep doing what you've been doing for 13+ years" and don't force t=
his
> > > > argument every time a kernel developer wants to just add one more s=
tat.
> > >
> > > Absolutely.  Let's do what makes most sense.  For new things, one val=
ue
> > > per file.  For stats which logically group with other existing stats,
> > > do whatever the existing other stats are currently doing.
> >
> > The intent of "[PATCH] vmstat: don't auto expand the sysfs files" is
> > to do exactly this: keep the current fields in
> > /sys/devices/system/node/node*/vmstat as-is, but prevent future fields
> > added to node_stat, numa_stat, zone_stat from showing in vmstat.
> >
>
> This is the opposite of what Andrew and I wrote above.  There should be n=
o
> need to start preventing future stats from being grouped together in
> vmstat if it logically makes sense.
>
> NAK.

Hm, I must have misunderstood what Andrew said.

I am ok with this patch being NAK, as long as the IOMMU observability
patch series and Per-Page Metadata patch can be merged upstream, and
extend vmstat without a NAK from GregKH for expanding a sysfs vmstat
file.

Pasha


Return-Path: <linux-kernel+bounces-5635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99712818D74
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96621C24743
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD83C3B783;
	Tue, 19 Dec 2023 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu7mxjtQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9937339AE2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-202ffc46e15so1555607fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005283; x=1703610083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A86hRA+Z/z0c3itpc9F8Zb+jzXF87R/S8fePRsyMfBI=;
        b=Iu7mxjtQpgW4v7ZvudAZL1x6VeFDcMD4ZaMsJHuqUk3PjVCUXK1iC3XxOoaMBTDoxw
         220koKZ6FmWsHT1SyEf8IO3rUMOJxykXSo1fLxutFOUloQW9uleqhFGpZxamvnkiqhNX
         zv6Vd4c+2nM7bh4wLjDm+oONtx17bn2bCUCpxaQGZVFJfKjpc+n0tjSKc+vQxzWGd4fV
         4BR1OwLsnesEBIKzard/HhbzC4ysIVEtEuXJ14Z49QTcl0+Co57EYd/PlMTEMd8IcbNx
         iKMf+RIjWdozTPqCxwbRNOXtZHg5hJfHRy/kPTo47IwdY4yKj7CWrSNpQeKj3wVa6R41
         TD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005283; x=1703610083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A86hRA+Z/z0c3itpc9F8Zb+jzXF87R/S8fePRsyMfBI=;
        b=CQ7aDLvdcCSHYN4KD99VEuyDNpw+U5WPnh0+LMQM8Obd0mOaRUFE7CbVKALgvf91AR
         1yHGmveHYpLDV7uiQj7k1FVu2TEWKVS6FkwmIMoeUnXXtNflgg7yZKQK7f4ccHYIld55
         zJNLE7Riq2cDuNnwOHCTDST5Vp50o9ZA6OfWCB0yx1Ce1KhFlHlJfFvGHfsAak5cv1tJ
         9Ajy5aSLIToswXW+3p7a/eb6Ab4bl6fprd0BhupErcbKIknjlTxX92mm6WUAFeJj1Zf7
         Nz0INuPulrKMopfH2eaqqZr/vZKv3UpEQh2s23GPL+iAE8ZyGQrPSPy8TaLKWy8DTXdP
         DyYw==
X-Gm-Message-State: AOJu0Yz5gyEMyxL6fnTUjAQ5B4+bvXYjO2+NzBn4sP3dnoE01LIm7EX+
	HdwVX/XOGIgjP4nqdpNGsvgiAAx9Rn4feVy/gjBfToR/
X-Google-Smtp-Source: AGHT+IGeUl1MbfNOrgjTYrpo1XVU9xDLT+jahGnrtMt7bHVd/782HmAf9UnjIXS2bvOujgh/sfDglT+PmJ4FtTz/qzI=
X-Received: by 2002:a05:6870:6ec7:b0:1fb:75b:2ba4 with SMTP id
 qv7-20020a0568706ec700b001fb075b2ba4mr10647440oab.96.1703005283322; Tue, 19
 Dec 2023 09:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <886c29fc-0b0c-4f7c-a2fa-f015a2b51fa3@amd.com> <CABXGCsNY2aR93pX0AtWUZ1v0QLj3ANoDmS13HCcdN-c4htHbtg@mail.gmail.com>
In-Reply-To: <CABXGCsNY2aR93pX0AtWUZ1v0QLj3ANoDmS13HCcdN-c4htHbtg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Dec 2023 12:01:11 -0500
Message-ID: <CADnq5_Nj3pP4MNnGz+WZZFOtWrXE5-jYQsbkHyCkxWYV-HJrCw@mail.gmail.com>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	daniel.wheeler@amd.com, hersenxs.wu@amd.com, alvin.lee2@amd.com, 
	"Deucher, Alexander" <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 1:31=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Fri, Dec 15, 2023 at 9:14=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.=
com> wrote:
> >
> > Can you try the following patch with old fw (version 0x07002100 should
> > be fine)?: https://patchwork.freedesktop.org/patch/572298/
> >
>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> on 7900XTX har=
dware.
>
> Can I ask?
> What does SubVP actually do?
> I read on Phoronix that this is new feature of DCN 3.2 hardware
> https://www.phoronix.com/news/AMDGPU-Linux-6.5-Improvements
> But I didn't notice that anything began to work better after enabling
> this feature.
> On the contrary, my kernel logs began to become overgrown with
> unpleasant errors.
> See here: https://gitlab.freedesktop.org/drm/amd/-/issues/2796
> I bisected this issue and bisect heads me to commit
> 299004271cbf0315da327c4bd67aec3e7041cb32 which enables SubVP high
> refresh rate.
> But without SubVP I also had 120Hz and 4K. So I ask again what is the
> profit of SubVP?

IIRC, SubVP is a power saving feature which allows us to dynamically
adjust the memory clocks in more cases with narrow blanking periods.

Alex


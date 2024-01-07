Return-Path: <linux-kernel+bounces-18889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863ED8264AC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224B01F21187
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126AD134C0;
	Sun,  7 Jan 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZwaUjfP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A48134BE
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b72377deb0so197870e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 07:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704641023; x=1705245823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KLyERKp0/3lO0ZRQHRx3SWIsFAYSuvRToRko0v2/HG0=;
        b=ZZwaUjfPTnKsm849RBcdHKigse5GvjYWPsGodWlicmfXNtJuArCBfxeAV1N/XZN8Z4
         i3X0Kwm/SGC6CnACYERwVQWVXLubhGvI1JZIdxD9t+YfpxcLcYR1EsUyCrxL19neQGw5
         b5KK9tXywSaQpu7+d3TbojaQag3mmtu//au2UZ0uKANs0de8GC5Kgj2a9P0mJYiJj+nz
         qcnFTb81z83kMSyKyHM1P5GzORbFfVSDrrxoQzE8os9o7FOqy8BkVRuKCcv/qu033CVY
         oUlmM9Q/OyIIbcD5vZbgOWwBYJg9nUEeK3vMrmoJmfPfHuTfWkqve7PMxaN+G1zEfMZ6
         6i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704641023; x=1705245823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLyERKp0/3lO0ZRQHRx3SWIsFAYSuvRToRko0v2/HG0=;
        b=ivZB71jY5Pp7GleK8UxJYTkvqKzXELzjpKBx5+MZxZPIBjln7NtGKA5z+ZqO8VV3r6
         OLFu8kxrAvl98iwEe6jNXLMt52adGsx5wkCLSs/4+/BHRyhmbdlddtaousjdAleV5uKc
         piZoLm2RfvF0OeeGV7jbqTAdIjRK8mW5WanhXD4uGte8mLFN1OX9mJMe6toLKAfBUXkV
         sDvjTK5ewPCuJtkkerZR7R1X6reMPCafl4z4NKI8xyDGQ6AnLuU5g1xm2Iyeq0VMXE3x
         CtR5mlPtGzuEog0fr313zA3otwAw1sOwA/rY9dvuvGZt7bpDrigz2cW6JAPixzZ0J/cn
         uK7A==
X-Gm-Message-State: AOJu0YwBzf+VVCDTD2ey9nesm73CXd30LG1YlTW5HsDTyeGbwdol/rQ7
	SABr8vIfwiLt6G2/DMFnMAGBeL+e36dotuKECkWEgnL6
X-Google-Smtp-Source: AGHT+IF4ueKln49lQtYXNbtushu9BWAu5UekR1Gbh3s9iJb+0hPt8cXh3qJ3v/cJIIKTF/YHt1uoJdMTZO420fC0SsY=
X-Received: by 2002:a05:6102:2c83:b0:467:a724:8c73 with SMTP id
 if3-20020a0561022c8300b00467a7248c73mr1071075vsb.28.1704641023380; Sun, 07
 Jan 2024 07:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105193331.1180331-1-xzou017@ucr.edu> <CAK+_RLm93haEd13Z0hVPSRqG4STsDHMHfu4FBdaBW1QP0m_c6w@mail.gmail.com>
 <ZZmh4rdZzj4YgrOG@cae.in-ulm.de>
In-Reply-To: <ZZmh4rdZzj4YgrOG@cae.in-ulm.de>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Sun, 7 Jan 2024 15:23:32 +0000
Message-ID: <CAK+_RL=C2u07fL+OS7nW5bx1KR=-_wTfECi0e8xBtvxoF_czpw@mail.gmail.com>
Subject: Re: [PATCH] fs/bfs: Null check to prevent null-ptr-deref bug
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: Xiaochen Zou <xzou017@ucr.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sat, 6 Jan 2024 at 18:54, Christian A. Ehrhardt <lk@c--e.de> wrote:
> > >         if (!bh)
> > >                 return -EIO;
> > >         new = sb_getblk(sb, to);
> > > +       if (unlikely(!new))
> > > +               return -ENOMEM;
>
> What's with the bh in this case? Wouldn't we need a brelse or something?

Oh sorry, mea culpa et senecta :) Since the data has been read into bh
then I suppose we need bforget(bh) rather than brelse(bh) before
returning -ENOMEM above.

Kind regards,
Tigran


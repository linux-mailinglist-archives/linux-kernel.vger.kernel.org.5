Return-Path: <linux-kernel+bounces-16276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5ED823C0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236411C24596
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B731D68E;
	Thu,  4 Jan 2024 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwb4AltP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C41BDDB;
	Thu,  4 Jan 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e78d948551so490247b3.0;
        Wed, 03 Jan 2024 22:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704348442; x=1704953242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzkM14bUvWBneJ4PcTPU9fRSFWTidhoVTGpxL68Hv+E=;
        b=Mwb4AltPbtDJv8IAl2VdmDvZRPXZAab3Qw7hMErmOOADJqVbce0x4GUlrqYxnKcOrh
         gGlt/zRRJ+I3JC/1h1Pyn0TqkCXAGNOxi1FtsC41S4rQZ6ZbYOnY6+48r6q8uKF6LRmP
         UxlSN334EjYxgZRUvlQqU3elWx9uvfHWEenRvE61/uKOyV4hdy1HPj0ZnAvLDR4LPBkN
         fICE6b3Y8IOV5gGKzs2G/gJllxqIZ3XNZQW821Gd8bAQLO8oyDDAFaI9fcR9P2UN3D34
         l2t/sPre8ErcKT11AyUdBsZCgUW2ttmemAtfYw4Rpw0xMgkfkB6kRlv0OMAdXBcsOfGU
         v2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704348442; x=1704953242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzkM14bUvWBneJ4PcTPU9fRSFWTidhoVTGpxL68Hv+E=;
        b=jfd8kWtWC58c5GF+ZvkSAWxSUqPci/mW4cMGjjr4ufsathYEnA1rKHwPAkX6hmE73G
         JsmHDx+QOHUf6zcEPIjvb1bYpx5IDpfiI1wggWflWmYCTaeTHf9iynQzmt1E3WFXXWP+
         CWPHFM5jPEe5juHLN496owIsLFojepMyAgYtLj4g+BEaqZCR8VS0cYJykstY1J3hy15R
         haSbv1D9zi7Z+IPwaq0/INPQhJNTimu7GLI3UuISIIHjd2yaloOmixnbv3KRkJ9zMPiL
         Fszd9lnd/FnZUlaEQ07npEfkYgLU361NXuNhKKrDXPghvgiVxl+SoAoaIudt7kj/Soax
         cxoQ==
X-Gm-Message-State: AOJu0YzhOjf5SkhrEgX3EZHPLLSIEAOmtuKacWwtGVis42fDNFw1Mb8R
	eMQq4l5OZ9hbCKoVjDIDm+EFB1+OF4vmrxJO8H8ZNhGJdYrPFQ==
X-Google-Smtp-Source: AGHT+IEuRWd8bUJ4hDCMKpB8/YiLxGplcsaMCBC8s/kTRyQm1TRMRvM52FuwmsUjfcOuaZs5BJ7Zoi+9mSvFTaN8Sww=
X-Received: by 2002:a25:d24d:0:b0:dbd:522c:32aa with SMTP id
 j74-20020a25d24d000000b00dbd522c32aamr140651ybg.5.1704348441758; Wed, 03 Jan
 2024 22:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
 <d4b227de-d609-aef2-888b-203dbcf06707@landley.net> <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
 <fb776d99-1956-4e1b-9afc-84f27ca40f46@linux.ibm.com> <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
 <e32077de-b159-4a7b-89a3-e1925239142f@linux.ibm.com> <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
In-Reply-To: <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Thu, 4 Jan 2024 09:06:45 +0300
Message-ID: <CAPnZJGAr8BfTHmn3QZnJ6dnVCQsUnUASmdH4tzz0-QMwHmZZLQ@mail.gmail.com>
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is given
To: Rob Landley <rob@landley.net>
Cc: Stefan Berger <stefanb@linux.ibm.com>, gregkh@linuxfoundation.org, 
	initramfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 8:01=E2=80=AFPM Rob Landley <rob@landley.net> wrote=
:
> I've been following the initramfs xattr support threads forever:

Here is my proposal: add to the kernel support for catar (
https://0pointer.net/blog/casync-a-tool-for-distributing-file-system-images=
.html
) in addition to cpio. catar has the following advantages:

- catar is simple and reproducible. For the same directory tree the
same bit-precise catar file is generated, which is good for
cryptographic signatures. As opposed to tar's monstrosity (
https://www.cyphar.com/blog/post/20190121-ociv2-images-i-tar )
- catar has support for xattr. It has support for nearly all types of
metainformation Linux offers (32 bit UIDs, nanosecond timestamps,
"disable CoW" flag and various other flags, selinux file labels, file
capabilities, etc). All this metainformation can be disabled if
needed. So, next time we will want to add some new type of
metainformation, there will be no need for lengthy discussions about
how it should be stored. All needed metainformation is already
supported

--
Askar Safin


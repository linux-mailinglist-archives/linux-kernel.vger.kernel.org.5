Return-Path: <linux-kernel+bounces-29436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E99830E35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A18284162
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517C2511E;
	Wed, 17 Jan 2024 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UykSHkW/"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C9241E0;
	Wed, 17 Jan 2024 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524664; cv=none; b=bg1b/A3Nm+dOxnCJ3vNB89aJvuK19j1cLFgAnIJXv/6oBJDlB8H9+aPSp+nsUg8tH+mSiiStTJ+pRfNxVzTszX/zRYRc6nUFKL+2F1ETXTaPvvV5pL3X1xGfnt3hamDJKXLy0vYTHKkjrR7sj/j+h1OULX+ECaXEakrnyIDrLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524664; c=relaxed/simple;
	bh=UnN6fT/sF7UnOxJfenZCORuYw2Y5HuwKRk5v/J97M/M=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=oT4/FsDA825vi8fhYU0xE71HE7qNuCIR0qcBYayLVlMMZ7UWIoS5BTEgsEueQ+VSqTACJhVhKJ1KSRM00+qvwXCwj7SlvH6dix0Ysf+I3lVId5jDzQSOWQMhnQC3U4urmNSgerGei1Vur5fMUthbEeH3FZZYJKYH0RYCRVosapw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UykSHkW/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2cad931c50so627032766b.1;
        Wed, 17 Jan 2024 12:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705524661; x=1706129461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnN6fT/sF7UnOxJfenZCORuYw2Y5HuwKRk5v/J97M/M=;
        b=UykSHkW/WxyNG/5O+9odr9uN1UkphSbK+FxumEcmoyqyKyjK0ps6r4XbO6L1d3WEfd
         5YMgNdjsYpnzYotG2j5BgbNVNazzmDjAeS1Kw5Imuohet3dz3P58apACs7CWpPzlCtrr
         V2XNkutq+PTVOT8DuzRD3/OjqL2GsviIfSZtwV2QZEUFqQ8dsyhoFCBltl4N3N9kvi69
         x42d4ouUaFlwack6ec2l0BzwnG4J/JF5QyFzYPxB7p6d/rFiSa/lsgRQmAKdWAatwfXj
         bDgjiltkMUQ7zQrh+dYhTvNxmZbnt5kAoaYvCsSn07T4L2cHZQjgWuNzK9j3MvhyZGrE
         08SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705524661; x=1706129461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnN6fT/sF7UnOxJfenZCORuYw2Y5HuwKRk5v/J97M/M=;
        b=JQeZfiuu0y/ctGWziRa4507dD8IHD+UCotpCYdeJ8KiyQLnWqcX32yEw82ipUmgYxj
         MP80jWokahb+iRe09CLfW/4z1U8131RpfJqG5S8c9s7SDn99Yl19f2pdM3mBnODa+8UM
         OxuCln2cLBVkg/bHUdMLyNj4mIeenWRG3HcpEZXzyJk4xyUo+Jr04e15caDsyVSLlI5N
         +vAq7suBaes+xNmK8TOSMPcGEMi0ySuEGWn3uD5fIyktt4pwO5lPaGIgsN4ajGwTKhP1
         eKXOpr2anJBAjctG2zN5gpFIc/uIg0NM28+VXY0vUV1F0Dsf+T6KBg3+VbTTpRbJHX3H
         n8NA==
X-Gm-Message-State: AOJu0YzKhX5jRI90RpUHo2wYgw3u8AfsXE+GLvWH6APL6wiRqJnVhkOl
	0+HaN2ep6TsMGSO/RI31MaxUmKKpZIXqlJQB+9I=
X-Google-Smtp-Source: AGHT+IHSUAXoOgfS+P0HmohOdzNc1b0RVZ58gA4Ucu3b5BABurbFkH9EcEFs/V94k3XB03dbbR2kXsdFk2BtDbTNTyw=
X-Received: by 2002:a17:907:1a56:b0:a27:f6aa:c7b0 with SMTP id
 mf22-20020a1709071a5600b00a27f6aac7b0mr3546463ejc.11.1705524661024; Wed, 17
 Jan 2024 12:51:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112083421.3728017-1-alexious@zju.edu.cn> <5dd12651-232d-41f2-afa4-2a3e5c127969@redhat.com>
 <CAHp75VfKj7sQ3HkNaqNe0CjVrRb0J=X3gPJf-rSLeU8RQ2hjFg@mail.gmail.com> <17d22c9e.4900.18d162090d8.Coremail.alexious@zju.edu.cn>
In-Reply-To: <17d22c9e.4900.18d162090d8.Coremail.alexious@zju.edu.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 17 Jan 2024 22:50:24 +0200
Message-ID: <CAHp75Vdz4FRF5=zFiKarOkA6ezOTP=CbwU2-_fpSCpuaZgb+VA@mail.gmail.com>
Subject: Re: [PATCH] media: atomisp: ssh_css: Fix a null-pointer dereference
 in load_video_binaries
To: alexious@zju.edu.cn
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Hsuan <hpa@redhat.com>, 
	Dan Carpenter <error27@gmail.com>, Brent Pappas <bpappas@pappasbrent.com>, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 8:34=E2=80=AFAM <alexious@zju.edu.cn> wrote:
> > On Fri, Jan 12, 2024 at 10:49=E2=80=AFAM Hans de Goede <hdegoede@redhat=
com> wrote:
> > > On 1/12/24 09:34, Zhipeng Lu wrote:

> > > > Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove drive=
r"")
> > Besides that, are you sure the Fixes refers to the correct commit?
>
> Well, I think I referred to the correct commit, which introduce the whole=
 module and leave this bug.
>
> If I did miss something please let me know.

Yes, the driver was before that commit in the kernel. Was it without
the bug? No, because you are referring to a clear revert. So, find the
real commit that had brought that into the kernel.

--=20
With Best Regards,
Andy Shevchenko


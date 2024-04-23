Return-Path: <linux-kernel+bounces-154535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702BF8ADD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12321C217D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6220C224E8;
	Tue, 23 Apr 2024 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eebz0GdN"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5406C18AED;
	Tue, 23 Apr 2024 06:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713852191; cv=none; b=I23E1irbQWQqyiXvMoKuzJbByENmJ13ikXZruTTo3E0w4L/G5xyi9PWxdHPVu77dEwToz0F/EsD7t6vuuT7+pOa8a3WDFn/AkbdirKI7+gUhBz7pJvgJ9go7vDYKfoMYb+lhHeSCc5NuMInXtxPv1fgeFMQaGtQg9/06XwMPV60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713852191; c=relaxed/simple;
	bh=S82bhgOPlnk2N9rL4GPcTmGEkacOA1o1OYddKmaFf2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPaRHNgwpooRDSyYRV0fGekinm40a37b1QKvDCuuUcsbeGXHFC80fYPChsZi08S+4D/+5XWuFpChmjErtrOpkkp5cbpRbFnSAnQCf/GXzFuy6Gn7E193ompFBdyotuxh2I6lZD6PKG88wLSn9obrAnga9d0hUJK6LpQZEyNZnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eebz0GdN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78edc3ad5fdso434400985a.0;
        Mon, 22 Apr 2024 23:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713852189; x=1714456989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S82bhgOPlnk2N9rL4GPcTmGEkacOA1o1OYddKmaFf2Q=;
        b=eebz0GdN3f9nxzyvEHVtxBSaOkb0ngvjpZAdV55iyqiFauAIkk3ctUIBgpLVIoCZRz
         4ozYQpOfFa40Bt1K64Y2ZUkswP3UOIWBDNDopsD+/bTepiYGNoQMv6Uu429E9Y2bgi4H
         Vj8n8ZHUPAoadlzjY5UVc2U+bUT91VRS2DCl/8Q6qn4NnsVgvu/bewj7COBSlbmhM5cw
         +7V7VQlQjHbt6u19ASSweb0b5vBwBsBygKxADR1MEVM0/eN6/YSTkjjwu4o72t87oMnD
         tH3/pTlt/IXm4+YwMXbpxTYFNyb3QBjedkadYjWTWK9+6NlqVdyMKmhEq/xft4arLc1I
         PKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713852189; x=1714456989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S82bhgOPlnk2N9rL4GPcTmGEkacOA1o1OYddKmaFf2Q=;
        b=amtED/OTqQuei0IkjQZuRskrtejdtNerBRoSKk8PqoVOK2yg/5QfddgCF4LJ7huDVE
         ES6vamEp4m+IPXNFKKF75gjctseV5qxX4FoYbRrwM/4UwPuk59sdVjfXrZe/IHLA90Ns
         xPr7Foln4OrVZ7EASpTkQiUoMwSRe3J/wSGRksQW9Dkv3waFiw2hkysf1WPUI+Kss5Sl
         O6t4oKql6U5wYcFMDcXf2fNX7Ygq5rD/vfPi3wUxn2XYk7cMqDiK4rSwyeS3WPr569c5
         wOXSWvd3dE2kOFAi3JDHrklRdf5z6dMKhnon1PqtTID16gtgYR+PVZl6VQhbeA2FFV6J
         AP0w==
X-Forwarded-Encrypted: i=1; AJvYcCUsucTX17h+MBgjMWHOPH4uirJeNBa91TKwRbv79pRj6CvvVlIZPTCXkFrYvju4pmkeG81nkCb2FVqXzCPnouqXTQlUyabFXJNhBPvfGo7KuX2ztr/1MWQyY7unJmtvR3L7xhCSWEKGiVjbaQ==
X-Gm-Message-State: AOJu0Yy5jUAWPtsVwJ++KJvepLyfc+ZjvX92Nfu0xI/Ep6r/v528iecC
	cwA0gvKjT1yY6xnn1AekwS6QDbi7qj3/H50N6u5FL5lotK9CUo/D5B7o351opWvIug5CxXwducw
	pbqj6bJkQJz+KiUmZN+t2xHK+vx4Dg02u
X-Google-Smtp-Source: AGHT+IH6mTafRKyle4oWcXPbSls9QQHFramdEUvZD2Zvk9flg0IWMdwpQ+TojhZslO2GM1HSfRYCOOcV0FFHM1EBDU4=
X-Received: by 2002:a05:620a:2a01:b0:790:84ef:a34c with SMTP id
 o1-20020a05620a2a0100b0079084efa34cmr862676qkp.33.1713852189156; Mon, 22 Apr
 2024 23:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422150651.2908169-1-stefanb@linux.ibm.com>
In-Reply-To: <20240422150651.2908169-1-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Apr 2024 09:02:58 +0300
Message-ID: <CAOQ4uxgvHjU-n56ryOp5yWQF=yKz0Cfo0ZieypWJhqsBV4g-2w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] ima: Fix detection of read/write violations on
 stacked filesystems
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	miklos@szeredi.hu, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 6:07=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
> This series fixes the detection of read/write violations on stacked
> filesystems. To be able to access the relevant dentries necessary to
> detect files opened for writing on a stacked filesystem a new d_real_type
> D_REAL_FILEDATA is introduced that allows callers to access all relevant
> files involved in a stacked filesystem while traversing the layers.
>

Stefan,

Both Miklos and myself objected to this solution:
https://lore.kernel.org/linux-unionfs/CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H=
8GHGW-0UyKfjgg@mail.gmail.com/

Not sure what you are hoping to achieve from re-posting the same solution.

I stopped counting how many times I already argued that *all* IMA/EVM
assertions,
including rw-ro violations should be enforced only on the real inode.
I know this does not work - so you should find out why it does not work and=
 fix
the problem.

Enforcing IMA/EVM on the overlayfs inode layer is just the wrong way IMO.
Not once have I heard an argument from IMA/EVM developers why it is really
needed to enforce IMA/EVM on the overlayfs inode layer and not on the
real inode.
I am sorry that we are failing to communicate on this matter, but I am not
sure how else I can help.

Thanks,
Amir.


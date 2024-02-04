Return-Path: <linux-kernel+bounces-51925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A86849106
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757611F2271A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654312C698;
	Sun,  4 Feb 2024 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw7ygMaE"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D592C689;
	Sun,  4 Feb 2024 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084520; cv=none; b=EfzfbV9w2vP1M8mBh2gM7je0IK7SZ9MQ6Mv173VCz+dvxUTm6LESb4BM4HlpYpO75ut1x11bRqwa7+1L4aXMbEp0V8ACe3npiF8nHS68HoxaKg6CwwQVHJc60+Vz/uUAyuPPmDWcsC4nuotz8gSnGLc6RTa+2L5hGj18uuV740g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084520; c=relaxed/simple;
	bh=wgpFqe/fBM7HORlCoeK+hmET6Zc0N9rZkwUKcFJn/Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecB9abwjlQePylaxl+43r1Ys8Hgebcyb8jxs5wem5olgZ4YZ/nU58n3sWrMqNOFWlqB8f0RrmYLi5cdT/Vmqh3+ZDIlF/Mp67O4GH8kEpwCoCbCnz4koe5/FiWmUhSIC++kCTd6dh5naWaZwnY5dcu9okvApjsxeYkfacru6qeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw7ygMaE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so4898047a12.1;
        Sun, 04 Feb 2024 14:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707084517; x=1707689317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgpFqe/fBM7HORlCoeK+hmET6Zc0N9rZkwUKcFJn/Pc=;
        b=Fw7ygMaEpzra7vGotuhGGKelixfLJnavm6wmzN4aiKdx1+ciJdvN39uUtbtrJPlGGK
         8v7HyEmm/fDFAhLosNblKCjDds9gZmAN/reoWsF8ujSRL6E9zq0KO3JA+e2uTLvtITVD
         7VnWgVNK3K8q/dnUK48rBEaEOsv0dZb2Ii09qbQNcKxyCDMVIEMI/Dvg9C3xUicIxpSp
         gEfUpAyPIk58hmuCNR5g+IfB4uQuglOGznAogd/+pIPciDnXkbeXXw2HPed0ZiwBy4WB
         IGT3MUxc9VH9K1wyAVBXrPsBochWdKq5poh2iiiOWfX7dTgREhYW/6DVfo/jwskC1F4n
         CMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707084517; x=1707689317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgpFqe/fBM7HORlCoeK+hmET6Zc0N9rZkwUKcFJn/Pc=;
        b=jBp+nAN7jFXHhimfR1jMzptE1zolnIVDetmfoAxufmsh5IWh8TxNdTgXE7XFnFH6d5
         8P4OMsA/WjyYnLDFgBegHg9ykywa6zTdoLB1BMlOI7XbEUmBuTNuuvRbBVGrIexNMzco
         2rmcB1lzswWN1b5yC5ITK20E2LRX9AFvHAr2l4dx4n5bJglpwn9mHWrQN0bAMUNwOmv6
         JWC4kHeec4O2DXY0Zwp+Kjj3zzm/kyQiUumK2OkQPpvPnK3qIcI6jDz7LalGawzwmhzE
         8fxT2xNioxeokk29MX4QCuXvfhB74WnJ99tQwdYpx26WNPuW89TDlZdZIrgI5Bk5XIW9
         qwNQ==
X-Gm-Message-State: AOJu0YxyfwNW6O5NlbWh059/T7HFHtNjdCYYsIYz+u6uLo3pq3/4f4Xj
	0JRNGt29Jsrip8jFg+gl3tkcGy93m/WrQ4EgRbKR+gqk/5ooDuER06JOwJVLTjmQQSk5+J9MmJd
	kvNozjV17ZTYV/8GWjxvfhhb39TqZni24KCxDXw==
X-Google-Smtp-Source: AGHT+IHOgjKQRrvdZJg5r1kSjzYKtRzWAuaaY6MgMt3WAev3FajVGabOmjfwk+8Eld7iiwY5MkS49XNLXhfByxv9F4g=
X-Received: by 2002:a50:aa9b:0:b0:560:1652:e7cb with SMTP id
 q27-20020a50aa9b000000b005601652e7cbmr3143370edc.16.1707084517189; Sun, 04
 Feb 2024 14:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com>
 <2024020410-bungee-number-f643@gregkh> <CAH37n11rbpaxzmt03FXQpC0Ue=_J4W4eG12PxvF3ung+uLv8Qg@mail.gmail.com>
 <2024020427-trio-clubbed-37b2@gregkh>
In-Reply-To: <2024020427-trio-clubbed-37b2@gregkh>
From: =?UTF-8?B?0KHRgtCw0YEg0J3QuNGH0LjQv9C+0YDQvtCy0LjRhw==?= <stasn77@gmail.com>
Date: Mon, 5 Feb 2024 01:08:47 +0300
Message-ID: <CAH37n11Tr9_2A=nFG7N8gi9DoC0ZdEQBGH3herTuP+C-s+3isg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I meant that there is no place for the patch in the stable branch
until fix. In 6.6.15 there is no issue.

=D0=B2=D1=81, 4 =D1=84=D0=B5=D0=B2=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 17:14=
, Greg KH <gregkh@linuxfoundation.org>:
>
> On Sun, Feb 04, 2024 at 04:15:43PM +0300, =D0=A1=D1=82=D0=B0=D1=81 =D0=9D=
=D0=B8=D1=87=D0=B8=D0=BF=D0=BE=D1=80=D0=BE=D0=B2=D0=B8=D1=87 wrote:
> > this issue also in 6.8-rc3 and 6.7.4-rc2 (
>
> Oh good (well good in that this isn't unique to this tree.)
>
> Please work with the networking developers to get this resolved.
>
> thanks,
>
> greg k-h


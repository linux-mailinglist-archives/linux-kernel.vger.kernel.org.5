Return-Path: <linux-kernel+bounces-75156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A89585E3F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0E11C22646
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C370083A1C;
	Wed, 21 Feb 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuRaEwv1"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902B80C03
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535046; cv=none; b=f77f5A6AhEiZLqGJYh0jYhYlaVbjgyToJZCKtZqUVev4s1RwFpgDDzZcBeFC3Xgbpo01JxMLQ398feC9qJwZUqLmWjmGPziVbb4eIRdPOmNU1XLDRqT9QyP7Y94JX9lOgNqlqOQZk9SjXwM17F8xJMBmATiXNi6+ktALhBPoPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535046; c=relaxed/simple;
	bh=O8FE/F+rSA9EV6mq4TzcPhvENWy4EYHiHP1MMkkubGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDb+LosSmq48EvKswMfvvGbAfvDxStRsH02fNjPPYZ+v8C2cm/o8r9oh7wXwLLij7YrZf1pDUOYx7jLi6x/PecQa37w/C1xsJJa5chlqNO4J/vW9F8BXsWkZORl1pUINdL/7gZwfhiYlQgoABJW7wnd0Xm3ziSGCbMmVKaEUOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuRaEwv1; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c15d1bd5b1so2487857b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708535044; x=1709139844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8FE/F+rSA9EV6mq4TzcPhvENWy4EYHiHP1MMkkubGI=;
        b=AuRaEwv1FV2+Zji9y4nWp6oQ1GfOwBoYB8H0cb8ONj93B0hWtT4MomxJj74LiLek8l
         odDl7OCkUig8Ra2L0A+rW56rfmsBFOzz+cgvDupfSTBzZjVdpsRU2e8p2vqUjtMckRE9
         ZtmCxhs7x7OEFpyrxDEDe564iZUjhSaEXcYEU5PGvqNSIZU96QxPjvcAaI6XnLXFHAbG
         ye4aHukW0Zzjak8t6LxKP4k/axm0BtJnFiBH3qaXIOOla067wbonjXB6avOclOoRjSZG
         cWhlKLME5UuTqMdhR0RfmaKzcecFo5GoT/xA5X40jz2IpgZWzbRn2Tp572DocCUsBsq/
         9utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708535044; x=1709139844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8FE/F+rSA9EV6mq4TzcPhvENWy4EYHiHP1MMkkubGI=;
        b=i3oYZLhszK7aOiEVZEdIca169CYFQCVCstCGqihwZn13KCq+yJDBF32NVYMivnP5LI
         z38f/OyTnVzFaaiAAmTmVrVHkRU7EP83n7zqEjrpkIaMIZmmrvYOG7JC+GccDDGBIl7j
         o4cCDQjt1Q08JCaATTkoAUArB5P9FG5atGUgZYePdvqVBqQxol2uLF9jugwIhI/f83Wj
         cDLSFlahZQ6XMBUnql84igQ94V5MKXDMKD4VPitVH79jKKpFtkls8OD4aPbR9iY30Tvc
         0BylOZnHr2+KjOvfb1lWkCirrf+Ga+LxYLN4dRpDmNBsXTvtTZZfBOsue0IHeoWccMoU
         ptTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMhZ2KcHED6OsD4F/jUgCv6f1+S5E+S11wbJn5InRSve5gF9zAKZDlU6D1OHRLi0ii28j//oK/5yFS8jOK58utyZLL4auYDO8/Hptq
X-Gm-Message-State: AOJu0Yze1gcMsQboDeVe3CPjLrw43e7MJ7zykAMtpmuFv6smcECH+6nq
	wYjqTB6QwjmvBkoKq8BJbeNC+2/uuIu3MJ/0SjphGUW69dZycPKkVpHSZR50TaVWr2jozroMKwV
	7n2quF7XrLQR4UAl4TO/4L76P580=
X-Google-Smtp-Source: AGHT+IFbzAHktEnL9NxophA1FVgUYvSQBeC3wV1iaSUJXkjh+gTRMGFv/oCURl0hwlqNSOXKirFb2XjsQRFVl8OzNaw=
X-Received: by 2002:a05:6808:191e:b0:3c0:43f4:6f34 with SMTP id
 bf30-20020a056808191e00b003c043f46f34mr24837265oib.46.1708535043729; Wed, 21
 Feb 2024 09:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216180559.208276-1-tj@kernel.org> <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
 <CAJhGHyC8Y7QU3TWDA1jz3D5VB3BDG9JcZ4XB_9rft1UiMF7uYw@mail.gmail.com> <ZdWMd2rHjCEUOfAp@slm.duckdns.org>
In-Reply-To: <ZdWMd2rHjCEUOfAp@slm.duckdns.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 21 Feb 2024 09:03:47 -0800
Message-ID: <CAOMdWS+7=qD9e=Q+Rv65rMXJ1uc_KPVN43uWrJ+xUdoXoV-D4Q@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.9,6.10] workqueue: Implement disable/enable_work()
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, torvalds@linux-foundation.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tejun,

> > For 0001-00010:
> >
> > Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
>
> Applied 0001-0010 to wq/for-6.9.
>
> Thanks.

I have rebased the conversion work based on

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v1

0001-dma-Convert-from-tasklet-to-BH-workqueue.patch
0002-IB-Convert-from-tasklet-to-BH-workqueue.patch
0003-USB-Convert-from-tasklet-to-BH-workqueue.patch
0004-mailbox-Convert-from-tasklet-to-BH-workqueue.patch
0005-ipmi-Convert-from-tasklet-to-BH-workqueue.patch
0006-s390-Convert-from-tasklet-to-BH-workqueue.patch
0007-drivers-media-Convert-from-tasklet-to-BH-workqueue.patch
0008-mmc-Convert-from-tasklet-to-BH-workqueue.patch

Patches: https://github.com/allenpais/for-6.9-bh-conversions
KSPP Issue: refactor all tasklet users into other APIs =C2=B7 Issue #94 =C2=
=B7
https://github.com/KSPP/linux/issues/94

I am working on drivers/crypto/* and drivers/net/*. This might a
day or two more. Please provide guidance on the types of testing I
should perform.

Thanks.


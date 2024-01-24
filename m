Return-Path: <linux-kernel+bounces-36851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B208E83A7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D31C2817F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED671B26E;
	Wed, 24 Jan 2024 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+f1d/8X"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649C1AAD0;
	Wed, 24 Jan 2024 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095382; cv=none; b=tYd8/4iIlMYMvHtQlWNTPZ1k6niwAfnZWmGlV90DF2JTYSvAJykYE+GFvwqYCPR3g0qwRdRo5ov3V/5SNw6mBGJjH3Q5WSWpmKqbD1WNwGGIcCYwKU7LCqPMEDfwTfRPc9FpFz76qFDtZB53uNXdZMyICUhwEszAwGXlw2M1va0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095382; c=relaxed/simple;
	bh=ZzIGwtAn2QzZ+2GpJ7X6yrHuHp8dp5kYFExvtnM8l2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8N4/nM5Odnbi1rZbP8kmEFBS6ngtlsQeavdmUKramz/VJBmEegI4MOb0y549sl0RuvMvmPAGSojube9kL4m0PJkQRtS0WOoXgE3kgCznHyDE3kUh7qfZn7gELhLUif21jH1sejijBY+3JyIKTD9L44Ba1NiS1MXDM1ItDSobzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+f1d/8X; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cf108d8dbeso20220061fa.3;
        Wed, 24 Jan 2024 03:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706095379; x=1706700179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlGnsP1Guq+73aimmzzt0YePXReMuB30joC9rhAKutI=;
        b=J+f1d/8XGutKJmZWOymV5cAHxEGsfaQfPN+r0jgwFabAScsHDJamR+NPnzKpxIf2Dv
         OahEM/yUYu6vt/QwbzZ1RjNGMFz76pnLKhQMtZVLqp7+f0B8tPvSDKLzenrPVw8JHkAR
         uYPN0PZiRNxxOXO4vtMyMSvOlvKKaDYenaBZ8IHAw/TeCiVjTFA1BROudaxsi4rHaUHJ
         D74w6uSS7GmzO9hsRoiAE/s9MPDTwcZiubTC96bPru8MDJ3FmzIyW96+1s5L3qLlCKxU
         uliMP03HV5MCpWj1bOuIpHjv4KYDTdHPQcwai/2HZ1fJ0h2CQ50xX8HNZAoRjDNx6UGX
         Vr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706095379; x=1706700179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlGnsP1Guq+73aimmzzt0YePXReMuB30joC9rhAKutI=;
        b=ZKSK/y/HEeUXW97Te8xkg+/zP9EpEk3ZjYYyORoXOsXHR7O+R4A9SL+c9B9FE6cFAi
         Pg10OTvQlrxAvYI0j6CexwmSBXeW3pJZkK+NxNJFN4O58EcA1x+++pWXXkUh7PjGqB7Z
         BWOq4nZS+A2X2cQAETt0Fcmnit4DOMIOVcEQCkxmRHB2poM/0ksdUK+AgZeS3peM3RRV
         HnSZ/06rwS/va/ixHvMoMbtSZFxYtffuTr1tp07w8whO5ZX8rzpyvuzljp+wsLdVe6kc
         9bkDKFuWxNU1SvKes4c1o0n+aUW9XKpA3wKLQXxpAxwFAl4sCRazZrTiFZIT7zfL6PFM
         m6CA==
X-Gm-Message-State: AOJu0Yx8Un1Qk7dGXHNezIqxOKlMToll6N5uKkFvm+wiNpvgDGs5XYfr
	ScsaH/TjqG98lLCH0TnDf/Mwv9FDMVsdgh/RPU98bem/n4elXRNeL6GPh1IP3Vt5JeQQ5/RrSi0
	jQmw2u8xpaN9X0IBZtUYaLreg2ns=
X-Google-Smtp-Source: AGHT+IEkb3Xpt+58vOiWxG6JhAbfK2iGy3KLOjaay+O2w7JwGWLv/HZUJ/QgwApQxLQVRQ6d1ibzMMIw8aMxLzlr/rQ=
X-Received: by 2002:a2e:bc25:0:b0:2cc:e51c:4d0c with SMTP id
 b37-20020a2ebc25000000b002cce51c4d0cmr974155ljf.66.1706095378493; Wed, 24 Jan
 2024 03:22:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122110722.690223-1-yi.sun@unisoc.com> <20240122110722.690223-2-yi.sun@unisoc.com>
 <ZbAQLRLNSx-IRRwM@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZbAQLRLNSx-IRRwM@kbusch-mbp.dhcp.thefacebook.com>
From: yi sun <sunyibuaa@gmail.com>
Date: Wed, 24 Jan 2024 19:22:21 +0800
Message-ID: <CALpufv1XRYX7bv-NAUMmRjWr0jhDC1xrd+d48XejJZPjZZLEYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_tagset_wait_request_completed()
To: Keith Busch <kbusch@kernel.org>
Cc: Yi Sun <yi.sun@unisoc.com>, axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In my case, I want all hw queues owned by this device to be clean.
Because in the virtio device, each hw queue corresponds to a virtqueue,
and all virtqueues will be deleted when vdev suspends.

The blk_mq_tagset_wait_request_completed() function can ensure that
the device has processed all in_flight requests , and these requests have
become the complete state. I don=E2=80=99t understand the blk_mq_freeze_que=
ue()
function very well. Can the function ensure that all requests have become
complete status? How should I use the function to achieve the same effect?

ps: requests become in_flight status in virtio_queue_rq() and become comple=
te
status in virtblk_done().

Yi

On Wed, Jan 24, 2024 at 3:14=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Jan 22, 2024 at 07:07:21PM +0800, Yi Sun wrote:
> > In some cases, it is necessary to wait for all requests to become compl=
ete
> > status before performing other operations. Otherwise, these requests wi=
ll never
> > be processed successfully.
> >
> > For example, when the virtio device is in hibernation, the virtqueues
> > will be deleted. It must be ensured that virtqueue is not in use before=
 being deleted.
> > Otherwise the requests in the virtqueue will be lost. This function can=
 ensure
> > that all requests have been taken out of the virtqueues.
> >
> > Prepare for fixing this kind of issue by introducing
> > blk_mq_tagset_wait_request_completed().
>
> Does blk_mq_freeze_queue() not work for your use case? I think that
> should work unless you have some driver specific requests entered that
> don't ever get released.
>
> > +static bool blk_mq_tagset_count_inflight_rqs(struct request *rq, void =
*data)
> > +{
> > +     unsigned int *count =3D data;
> > +
> > +     if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > +             (*count)++;
> > +     return true;
> > +}
> > +
> > +/**
> > + * blk_mq_tagset_wait_request_completed - Wait for all inflight reques=
ts
> > + * to become completed.
> > + *
> > + * Note: This function has to be run after all IO queues are shutdown.
> > + */
> > +void blk_mq_tagset_wait_request_completed(struct blk_mq_tag_set *tagse=
t)
> > +{
> > +     while (true) {
> > +             unsigned int count =3D 0;
> > +
> > +             blk_mq_tagset_busy_iter(tagset,
> > +                             blk_mq_tagset_count_inflight_rqs, &count)=
;
>
> If the tagset is shared, then one active user can prevent this from ever
> completing. It sounds like your use case cares about just one specific
> request_queue, not all of them.
>
> > +             if (!count)
> > +                     break;
> > +             msleep(20);
> > +     }
> > +}
> > +EXPORT_SYMBOL(blk_mq_tagset_wait_request_completed);


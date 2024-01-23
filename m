Return-Path: <linux-kernel+bounces-34675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFE18385FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FD71C23F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16EB185A;
	Tue, 23 Jan 2024 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c16XrNBA"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8FA47;
	Tue, 23 Jan 2024 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705980500; cv=none; b=D47dfTr5xYTXD4kLSB3nrH/32/fUbOFeCp4du2IqOKz/m9RcgToaL+drFcXwc1B+6kOpLkKwaXfPPj8Z4hfrVgAjyhrlc49NVTayCUs+p3/ado0vu2aD2A1NjklAsg0aBki1sa/TYTE1CdWRCrI/q9IJ0v0sCKHAnqKDCmbNark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705980500; c=relaxed/simple;
	bh=WYhT1KSTjcRFHQZ0dFY+HaX12W5Ope1cBkdGfWhmFm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pErhr9R7MUFLuevn3EIOOD9fi/Am54ZEJScUPiWIDHsP+mcEuUhj6/+B/KPcYkhsJO2rdlgaiqW35dAoFUzXE9+Ob0zUjekUrNt/7qJQsH30pFEj8RuThqMOk+Wl2kVaOvG6EbyM2rfcD+7pGV4rsQ6WoQD6aY1YnPRQjpt0ql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c16XrNBA; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e741123acso4431501e87.0;
        Mon, 22 Jan 2024 19:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705980497; x=1706585297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBJbKQX0OEBxeprRN+v16JluNv16fHJFSLP63KZqjwQ=;
        b=c16XrNBAHTxbbk2F6TzvQhKsQ7p91SuUQh3d9nHSS4DIp1TNR0lPEe9Kh4DGi8726Y
         WKfDT/ngsw9mbyg6TMKrf1urJsnYQylYY+Fo5PB4XeJHjoqgSu9w11zn0Wo3joA9idLr
         eENRZx9JxnYadHJVLUyfwKpe1lBdqgR8oil1xcXshcoSTFwrfuUqgfOBKEjHlYoO+fI1
         m/CvYBPB54iB/0BWxkFRGTPGQ44JpuHCChfzZzVyhiDm+mprp6dp84yHy5Z9iDkyHQ/M
         QGeb8UDIbaG/H6KppnJQG8KF5CNKpqC2lmuRettafpQ9Gve9Y2PXv6495tWUvf4TR40+
         CEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705980497; x=1706585297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBJbKQX0OEBxeprRN+v16JluNv16fHJFSLP63KZqjwQ=;
        b=B3LDRR96cc+KSrAFL1cLyzCPwdNU9Nw3Tn3WeprRUsOuOzNjGnv1RiumInbKfgJZl6
         izbb3OI6NMCgWVQuDTcLCFSooC2gQfwqwujh2rsNS+AmHPpNDQ1vUPAxjvcXtj5/1LgS
         Re0UKQuGWrGWa2dVhw+PpfrjqIgZ5RaJ/d1kUzUmNFz7tUOOauKaiEh1LueUS7dLgVlM
         rlFfudeWNBwnii4moplUscc3AxdxNPMyk/BH1Y/CVtbWAeaWVpdZ0jDBlVFzTs7zQMsc
         gJb0Jg1iV785uBB0jsZsDsQr/a5d+xQV64GGQC5mWX86WuM3m/LSUKNQC7RMPGK0k6xM
         FiaQ==
X-Gm-Message-State: AOJu0YysbZ+5L9Hw2kH5E88YFTgDQX19QSJ85V3O4vjLNG7LiZOhmya6
	EfkwK3GrbCRUiGU/BVwt4qlauwdXnJPE+XgMOyWpacyyhOfbDsBYMPgqNn2G5coP9v9igz7iHo2
	25dry+4SLw5GlxW4G5Z7CpZdc8ig=
X-Google-Smtp-Source: AGHT+IHzrHeX6AxgLJC298KaOYuxpbO5DUKstT5SH6IZswiIFSfK1NEzNpCYLrou/eJ6ElOxb9uC6K879m4tnEDH8H8=
X-Received: by 2002:a05:6512:6d3:b0:50e:e0af:4efb with SMTP id
 u19-20020a05651206d300b0050ee0af4efbmr2673823lff.104.1705980496515; Mon, 22
 Jan 2024 19:28:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122110722.690223-1-yi.sun@unisoc.com> <20240122110722.690223-3-yi.sun@unisoc.com>
 <20240122154255.GA389442@fedora>
In-Reply-To: <20240122154255.GA389442@fedora>
From: yi sun <sunyibuaa@gmail.com>
Date: Tue, 23 Jan 2024 11:27:40 +0800
Message-ID: <CALpufv0h-sQ4Qfp-Sxd7wME4onMNAMop_gi-np6Dk2R96sba0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-blk: Ensure no requests in virtqueues before
 deleting vqs.
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Yi Sun <yi.sun@unisoc.com>, axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:43=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Mon, Jan 22, 2024 at 07:07:22PM +0800, Yi Sun wrote:
> > Ensure no remaining requests in virtqueues before resetting vdev and
> > deleting virtqueues. Otherwise these requests will never be completed.
> > It may cause the system to become unresponsive. So it is better to plac=
e
> > blk_mq_quiesce_queue() in front of virtio_reset_device().
>
> QEMU's virtio-blk device implementation completes all requests during
> device reset. Most device implementations have to do the same to avoid
> leaving dangling requests in flight across device reset.
>
> Which device implementation are you using and why is it safe for the
> device is simply drop requests across device reset?
>
> Stefan

Virtio-blk device implementation completes all requests during device reset=
, but
this can only ensure that the device has finished using virtqueue. We shoul=
d
also consider the driver's use of virtqueue.

I caught such an example. Before del_vqs, the request had been processed by
the device, but it had not been processed by the driver. Although I am
using kernel5.4,
I think this problem may also occur with the latest version of kernel.

The debug code I added is as follows:
virtblk_freeze()
{
        vdev reset();
        quiesce queue();
        if (virtqueue->num_free !=3D 1024) //1024 is the init value.
                BUG_ON(1);
        vdev del_vqs();
}

BUG_ON triggered the dump, the analysis is as follows:

There is one request left in request_queue.
crash_arm64> struct request ffffff81f0560000 | grep -e state -e __data_len
  __data_len =3D 20480,
  state =3D MQ_RQ_IN_FLIGHT,

crash_arm64> vring_virtqueue.packed,last_used_idx,broken,vq 0xffffff8086f92=
900 |
grep -e num -e used_wrap_counter -e last_used_idx -e broken -e
num_free -e desc_state -e "desc =3D"
        num =3D 1024,
        desc =3D 0xffffff8085ff8000,
      used_wrap_counter =3D false,
      desc_state =3D 0xffffff8085610000,
  last_used_idx =3D 487,
  broken =3D false,
    num_free =3D 1017,

Find desc based on last_used_idx. Through flags, we can know that the reque=
st
has been processed by the device, but it is still in flight state
because it has not
had time to run virtblk_done().
crash_arm> vring_packed_desc ffffff8085ff9e70
struct vring_packed_desc {
  addr =3D 10474619192,
  len =3D 20481,
  id =3D 667,
  flags =3D 2
}

I'm using a closed source virtual machine, so I can't see the source
code for it,
but I'm guessing it's similar to qemu.

After the device completes the request, we must also ensure that the driver=
 can
complete the request in virtblk_done().


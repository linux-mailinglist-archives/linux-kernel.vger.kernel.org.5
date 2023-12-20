Return-Path: <linux-kernel+bounces-6962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB37819FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359561F22C12
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773AC34CD6;
	Wed, 20 Dec 2023 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fw/7IhDR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E00F2D634
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703079159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMzfUMpfCRySKV14r2ACq/M+O86IvQcMgWeUukBTaDE=;
	b=Fw/7IhDRA+57AMeTrk8LZo5kM3Rg7Lf/+v5HcPuYUrxY/HH5nFJn485jT+9qpo399TlduM
	nLHet7/U2fHlaXbz7vy0JjMaOT9attxDnyAuWzeRk3LkPywjopWt7oVRcGHlsSPYcezfEX
	3dAf5MKcvtnpxDRULIJ9tNim6yl+GyU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-A3SpkW-JN-qYItsCG6C8sQ-1; Wed, 20 Dec 2023 08:32:37 -0500
X-MC-Unique: A3SpkW-JN-qYItsCG6C8sQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5d12853cb89so76644367b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703079157; x=1703683957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMzfUMpfCRySKV14r2ACq/M+O86IvQcMgWeUukBTaDE=;
        b=CXUDf/N5VM6xnZjLWVS8JLLsSRaQl5se6UP60TqxfqWrw63POEY58DCzuI27MRHgzo
         jloKMHWzdfSBz4vd3rveCm1hqC+eCZRtmv2XlvhFDLMRTrqjnmwufuL7xkxsjbj1/b1Q
         vX3nO955VwjmMU+9nwoV9/brVgbeZibg1CRRlpy9KJuWTbbq/FfhSKtg69RFQQBYOYzb
         VNTvz+k7GTUbFVxo/zkUfTRAIZuO76uQz8A7PiPnbEfh9Q51cs45XytwEX++z0WYorHV
         VONVO/vau1oGhv5UFXrAn5PiDB2OAREKNLqDsQrmfIxR+8ZLUpVoKVj3S7BetRS4gpKC
         Pg2g==
X-Gm-Message-State: AOJu0Yxa5yZHS2R4MPNkmZM4zMj72b5G2Qs8sy4MCfcbyj83Wsdd6VAy
	nBivip64KJ1twOuDY7ffuUPGMpdkKlOJ/0x+PWjDh6cEI/XMS6v9+ec7vaKipESrz/9Zz6pqUnZ
	GEebTuVVCPZE3vH6xO4O8OBo0NZaWgBmPw4Z36KfA
X-Received: by 2002:a81:7104:0:b0:5d7:9515:6ae3 with SMTP id m4-20020a817104000000b005d795156ae3mr14296464ywc.33.1703079157225;
        Wed, 20 Dec 2023 05:32:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBizLEtuC1w25WSPAQRdmgfmzbhlgoBE+Ri28WemJThaBvVsn/cvQCI5dtZtYAosoVwA/ga7C8ipUzBYNV8OQ=
X-Received: by 2002:a81:7104:0:b0:5d7:9515:6ae3 with SMTP id
 m4-20020a817104000000b005d795156ae3mr14296452ywc.33.1703079157026; Wed, 20
 Dec 2023 05:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-3-dtatulea@nvidia.com>
 <CACGkMEv7xQkZYJAgAUK6C3oUrZ9vuUJdTKRzihXcNPb-iWdpJw@mail.gmail.com> <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com>
In-Reply-To: <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 14:32:01 +0100
Message-ID: <CAJaqyWdoaj8a7q1KrGqWmkYvAw_R_p0utcWvDvkyVm1nUOAxrA@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
 flag
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 5:06=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Dec 20, 2023 at 11:46=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> > >
> > > The virtio spec doesn't allow changing virtqueue addresses after
> > > DRIVER_OK. Some devices do support this operation when the device is
> > > suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND flag
> > > advertises this support as a backend features.
> >
> > There's an ongoing effort in virtio spec to introduce the suspend state=
.
> >
> > So I wonder if it's better to just allow such behaviour?
>
> Actually I mean, allow drivers to modify the parameters during suspend
> without a new feature.
>

That would be ideal, but how do userland checks if it can suspend +
change properties + resume?

The only way that comes to my mind is to make sure all parents return
error if userland tries to do it, and then fallback in userland. I'm
ok with that, but I'm not sure if the current master & previous kernel
has a coherent behavior. Do they return error? Or return success
without changing address / vq state?



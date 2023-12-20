Return-Path: <linux-kernel+bounces-6332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5687D819757
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C1E288415
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B491A208A2;
	Wed, 20 Dec 2023 03:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoVBXp1a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C41F60A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeRKaaUGMF/rV1Pw2tqp6lNgEKTL5KPcCr8EDMoKMeM=;
	b=BoVBXp1aSRuYG6C7ze3k3Yd3ctOJK2iBDudvgG7XHsgESZ+SRzWqki6ANfZuOSGlfdmjLQ
	MYSmgshA0XmnkBM7WA821on6m8z9qpLuUZXSZWilWv/jALwuctlZY5iUfp+PgmCfs8lIm1
	FWpZ5eviBUjrsI0bOU0IaVcUoKLPZWI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-LuOJU51RPbyuhVfnRcm59g-1; Tue, 19 Dec 2023 22:47:20 -0500
X-MC-Unique: LuOJU51RPbyuhVfnRcm59g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77fb91da85cso761788585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044040; x=1703648840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeRKaaUGMF/rV1Pw2tqp6lNgEKTL5KPcCr8EDMoKMeM=;
        b=XPC3+CgXCy9Ho8zF81/Yny/SG7p4pGewx9EFBryAJufx7C1HHC2gXPGARVnHGGgIZe
         Vy3jouBTk7EmEHJbtZ7SxUu525hDcQo83HcLg9lH7Moc4998PwVW9xZWwLqphThhAEuV
         8f+WfcUnJoeM9R8H1dxSbjulT3yDrGieE90nY6BE5aK2o1zje1Tbx+YfECdEj3f1XH8X
         SdpvQ4vfMBaf60SHKyV2+bXsjrW863P1Vl7VDcu38cundiLoqCy2/5abJpU7LRTKvnmY
         K8h6N46ZEHNzov9jEc0s8ZEJiT+SZiJ3UOt4E7wClfKuSBOaCpTfE0b3753ng6NOYyMQ
         gg6Q==
X-Gm-Message-State: AOJu0YzsDa7LTa5zE2PGehB8PcRLGZ+UxvufxcCKxveUbY9jkMQCW9Mh
	XORZb7wDqlQ8zqz5TWjFPHgM/DvQB2Kz0uyNVZ7vLACOcj5RB5AUDZLUZ55WzB3EX1KLbCBbyEz
	TR8UDEpJrAksDXFuQSnfoS1DZ12dt2qHx6QAaYgxp
X-Received: by 2002:a05:620a:1025:b0:781:2e4:a333 with SMTP id a5-20020a05620a102500b0078102e4a333mr1851792qkk.101.1703044040362;
        Tue, 19 Dec 2023 19:47:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2eu48vysOQiZNwVknIUUkOGzk8lLz1dfUfotvXOLhv6Vyvhvaja8sHuwdb2gwij5dOp0VLjJ8belHFZFJh4k=
X-Received: by 2002:a05:620a:1025:b0:781:2e4:a333 with SMTP id
 a5-20020a05620a102500b0078102e4a333mr1851780qkk.101.1703044040147; Tue, 19
 Dec 2023 19:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-15-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-15-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:47:08 +0800
Message-ID: <CACGkMEtMkjORddUC4x+O9JsDevQBpo0KiJu1XCcvxgKgqfXuGQ@mail.gmail.com>
Subject: Re: [PATCH vhost v4 14/15] vdpa/mlx5: Introduce reference counting to mrs
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 2:10=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Deleting the old mr during mr update (.set_map) and then modifying the
> vqs with the new mr is not a good flow for firmware. The firmware
> expects that mkeys are deleted after there are no more vqs referencing
> them.
>
> Introduce reference counting for mrs to fix this. It is the only way to
> make sure that mkeys are not in use by vqs.
>
> An mr reference is taken when the mr is associated to the mr asid table
> and when the mr is linked to the vq on create/modify. The reference is
> released when the mkey is unlinked from the vq (trough modify/destroy)
> and from the mr asid table.
>
> To make things consistent, get rid of mlx5_vdpa_destroy_mr and use
> get/put semantics everywhere.
>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



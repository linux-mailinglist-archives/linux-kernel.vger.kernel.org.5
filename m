Return-Path: <linux-kernel+bounces-23012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EDC82A656
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8786282AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90582903;
	Thu, 11 Jan 2024 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbcbfX5h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370A23C1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704942588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNYNKmM7NDZMIJrSd8d1C6clX1k5LUGTMeNK3m1Ci2g=;
	b=LbcbfX5h8hcQSsVE+gQJ3fsZfLEe4b9LL5KZ5Lvnk+XGSzTVJn4Y0Y8QucX58Vmk39q1F6
	WKJ3rLbCaj8YqySQ68xW12qXfTGzwQXadnz5rbBzVg4W+boUlkPhNcMbWpns9IBeaOPe7H
	3BEg1PdbIOZjms9w68FsSrKR7zBploU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-uiHHJGjUOZu1JdO8RRewhg-1; Wed, 10 Jan 2024 22:09:47 -0500
X-MC-Unique: uiHHJGjUOZu1JdO8RRewhg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bd393ae026so4179090b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704942586; x=1705547386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNYNKmM7NDZMIJrSd8d1C6clX1k5LUGTMeNK3m1Ci2g=;
        b=gXaixtc7MvjeD2zEEzh2JxMMTcdZYIt6e2/Abak+7ra4j+hEwtcskhGPQ6QTKS0OkU
         XJpSIZKC5q58FI0KqBFMwKRCIPKTTSFBBD4S3KzKEpYBNleV8LduF10jQnICcirQrS4Z
         s56mafK6FE/7ghd8CxwMRBYT7u4bZL3/HtsWzRaWnTg67iNWf4VilHwskYG5nDvONBLo
         AlvHQyn3ExUpANrWeDkjDO8PEQzeEMxxaBmrdlqmpODEhZC2gMFfFbsuza6j/wpmDnqJ
         mGvrvtxBa+tLf6ZqaAYz/g0ZomcqrtjcbtLO3thhWLNDQkQRf5ehB6mOZHVN4tLfLXhE
         gA/Q==
X-Gm-Message-State: AOJu0Ywq/fJHkOoC6E2lXmC+NE9DwHHBrqouyo9p7h8ongoZSXvdKRqn
	I124ti34tIYkfjanpgsybPnksodQ9sMgAp+fEt/dTXypjhZTK/0Z+STyuzbWUtEDTsRtW6x5uoe
	WQ7g4UNIaWRrwyf8jcxO9otf6fUV6sjJQjT6eqgHLoJ4xs6V7
X-Received: by 2002:a05:6808:1306:b0:3bb:ce08:87ce with SMTP id y6-20020a056808130600b003bbce0887cemr739596oiv.9.1704942586290;
        Wed, 10 Jan 2024 19:09:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkSF42Bz+C27pa2iZq0sSb7fraKOPPdGWFH35GMBpvyJ2sxt5wIurZ6XGTr4QXgYffbuynq56k0KjbEL/yrxw=
X-Received: by 2002:a05:6808:1306:b0:3bb:ce08:87ce with SMTP id
 y6-20020a056808130600b003bbce0887cemr739588oiv.9.1704942586089; Wed, 10 Jan
 2024 19:09:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com> <1704919215-91319-9-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1704919215-91319-9-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:09:35 +0800
Message-ID: <CACGkMEuJ4yf4reW2SzDqgNZGBWo5Rcqeg+cFS=N7pa_gQmmDXg@mail.gmail.com>
Subject: Re: [RFC V1 08/13] vduse: flush workers on suspend
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>, 
	Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:40=E2=80=AFAM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> To pass ownership of a live vdpa device to a new process, the user
> suspends the device, calls VHOST_NEW_OWNER to change the mm, and calls
> VHOST_IOTLB_REMAP to change the user virtual addresses to match the new
> mm.  Flush workers in suspend to guarantee that no worker sees the new
> mm and old VA in between.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

It seems we need a better title, probably "suspend support for vduse"?
And it looks better to be an separate patch.

Thanks



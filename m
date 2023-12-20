Return-Path: <linux-kernel+bounces-6330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A16819750
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF711287B88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7413E1DA31;
	Wed, 20 Dec 2023 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjJpTE6T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7977C1CF99
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDgKeSnW9WjPiYCNV2h6BRFrU23HWRGExp1tEJfVp+A=;
	b=DjJpTE6TpcLhzlk47dtTy09vxOC2KtBWMlQhD8/7vtcmAgTVZre1ZX4Cs6JfaCK7kBIp1n
	dJWk9kYCksLIxJ/arRLbQBmoGxMCIu5OPWhtkEtfJxOvCmKyt4bSCPf/b/92hq2JTwWPXv
	OnAU5tUzF+m8X6ggvHAxC8reyN4pvtA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-rvgBnC4DMlGbhdUQXlTQCw-1; Tue, 19 Dec 2023 22:47:15 -0500
X-MC-Unique: rvgBnC4DMlGbhdUQXlTQCw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28b3c0af503so4285518a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044035; x=1703648835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDgKeSnW9WjPiYCNV2h6BRFrU23HWRGExp1tEJfVp+A=;
        b=JfY2EuwEAM5rlycArsCBOmd8OTlH1FdXuiq8zSGa0SMh6Eh89ZCajXrJ/hbicu8f4X
         YYfd1NfdFAaamu29HmYXvjiK2u+ryn5bi+oK3lis0jK9+UamHD2TB223K88kyz8x6m8J
         XnKF8fXAmPw/TSf319Ws5ZlDrnkLcr/xbDBn0CxVUAbisbdy5AwjQOoFjgbHyxWZYeFR
         W+qRrsXYscAS0pnPtGjCMVhy2CbJIHI18ATXRnqH5wrISxscVK1nJkyxEuzeBAiPBwXI
         21EHCsENwoBFSCQpjTPnlk/fMNO3FSbUiDL2eXB9EHO/Y+Sc0UGGKWRGkwoU07bhHg8M
         9oZg==
X-Gm-Message-State: AOJu0YwDNIO2TC4qFYuPK9oD9IQGEX6TW2FXWfe7hie76oUtZ5Kej7qA
	idR3VbIVBGHmh0H2AUnbxPClAeP7sCIOiuuCMTNaCZX+ayKOTN9z6p5YgZfnn90QNRsEjxNlFu0
	kuVxVxWM28pVd9gCFPOipZsKhzP5aNz4AYPFNd7MF
X-Received: by 2002:a17:90a:e550:b0:28b:6b69:425e with SMTP id ei16-20020a17090ae55000b0028b6b69425emr3250714pjb.34.1703044034768;
        Tue, 19 Dec 2023 19:47:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0dF4xSsJZ5QD3HCGa61B+KNXdkWHm1GNDLBaUm0KZYX0Ya7QIXi6kgXFSx5HjjaDaFnAL8BB6HVPmo69iIiE=
X-Received: by 2002:a17:90a:e550:b0:28b:6b69:425e with SMTP id
 ei16-20020a17090ae55000b0028b6b69425emr3250705pjb.34.1703044034544; Tue, 19
 Dec 2023 19:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-13-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-13-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:47:03 +0800
Message-ID: <CACGkMEusxhpgdhf5BXPp_r913xQk7Td1bw+-oEJyDFhZFsc7tg@mail.gmail.com>
Subject: Re: [PATCH vhost v4 12/15] vdpa/mlx5: Mark vq state for modification
 in hw vq
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
> .set_vq_state will set the indices and mark the fields to be modified in
> the hw vq.
>
> Advertise that the device supports changing the vq state when the device
> is in DRIVER_OK state and suspended.
>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



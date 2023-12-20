Return-Path: <linux-kernel+bounces-6328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A05781974B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1BE287B02
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A3217732;
	Wed, 20 Dec 2023 03:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiwNxq9S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECDB16436
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+JDn1KJzJATgI5zfmEFBJrCFOmZkPUddhQTthC2QFc=;
	b=iiwNxq9SFMESWRA5pG0M+S95N7DAAvx+DHKyjjOYriOntCM6YWSSTWpQTyJcHmdbAEKw1Q
	2/qQtJ1ZquIuJ77jucZR+pI/4hnRkqYB1Ns+3McDLRbjyE3k9gX84PHJ7dEV68QwT6f6jq
	ZIu3VCx9bxHpW3HtEjSNqjQGVlrJFTs=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-64gk1MKKOB-bdISzomfNjw-1; Tue, 19 Dec 2023 22:47:10 -0500
X-MC-Unique: 64gk1MKKOB-bdISzomfNjw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bb6938995fso978501b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044030; x=1703648830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+JDn1KJzJATgI5zfmEFBJrCFOmZkPUddhQTthC2QFc=;
        b=S3JqgigEixy18CA6526egCaEfznZgUkBS3hiDFjLPIqNJoRDyWOgYvKjvL8R4uF+kH
         JSU1psVv8JpdM7iB4JPcPsgrGE88MHDNCwpCmt5VdmrZYhIn0BdcRNwDCNGM+z2LT78B
         n/Dbavu0HUbX6uA3n6+H/1p1MKNrKOik5JikFURI7UvgpbwKYVMnoBt9ti9eOVsgVHH3
         zoqAza4iwffQUeNDWRC1/VEQ7QzGTx1XVprM4wPWUquM+pM3ZArGLBx+HbtsQ8WIFbbR
         s1g82zwsxC4jrfgB8Cp32yiCNmhpN7TDHUQ7OLBCh7xfGwjEucG9ZHcnCfw0IWWPaCP6
         XMuQ==
X-Gm-Message-State: AOJu0YwPtZqqKXthO/GVESdTNtHVt/+wMdfvi2G0QeXIuOTp0lJgZkMn
	cqAlm/UCkn1M+6xfcJNjk22y+lXu6TgvIQnnlbZL2EdARqhyLSQuVtdFS3MrKlfQBYcO587FHMG
	Y8e449YFjwB7h4S8gzrK2YDbWvNkD65Xg2cWGPeM4
X-Received: by 2002:a05:6808:16a3:b0:3b8:b063:5d75 with SMTP id bb35-20020a05680816a300b003b8b0635d75mr19240102oib.92.1703044029950;
        Tue, 19 Dec 2023 19:47:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjc78+yw+xCGEIAPfx0ZKd6JVwAwXS+dRnEknTKLfywa1GFI4mcMh1fsZ51KK4vW8KtASd61JsUKG4h1Ooauk=
X-Received: by 2002:a05:6808:16a3:b0:3b8:b063:5d75 with SMTP id
 bb35-20020a05680816a300b003b8b0635d75mr19240092oib.92.1703044029759; Tue, 19
 Dec 2023 19:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-10-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-10-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:46:57 +0800
Message-ID: <CACGkMEu-UOBojsNa_f_XWe6mQJfA+TGdP=ZNTS7bUqky_zdp+w@mail.gmail.com>
Subject: Re: [PATCH vhost v4 09/15] vdpa/mlx5: Allow modifying multiple vq
 fields in one modify command
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
> Add a bitmask variable that tracks hw vq field changes that
> are supposed to be modified on next hw vq change command.
>
> This will be useful to set multiple vq fields when resuming the vq.
>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



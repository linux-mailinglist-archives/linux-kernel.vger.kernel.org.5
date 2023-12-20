Return-Path: <linux-kernel+bounces-6329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88CE81974F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58941B2438F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD541CAB3;
	Wed, 20 Dec 2023 03:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiiEuVsj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34411947F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpf9eaQ+8IyE3naaIp+h7AwEmeiY2hzKB3PbB0UYHK0=;
	b=OiiEuVsjtPZINTgl01eMUrXo7Zn7IE2S3Ikyd8XqdA9xpcoac1CTrss+Jk2rvzmVZT5YKf
	vyxn/8L1mMhB6CbacnRAZjN5TQK5Pp+Bkg+44fKKWfAE4q3UXUwcTaVofYlh+O6WC9k7SW
	03pCpe34g4pBiNvYnet6Me7YJy6gYOE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-xmNd2JZBMdK8SS1msJl4tA-1; Tue, 19 Dec 2023 22:47:13 -0500
X-MC-Unique: xmNd2JZBMdK8SS1msJl4tA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28bd736e536so120730a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 19:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044032; x=1703648832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gpf9eaQ+8IyE3naaIp+h7AwEmeiY2hzKB3PbB0UYHK0=;
        b=KG0JyudbEbDq2J+iK4mt+v3a0hJY3SuWAREnvWeFVFEMljo6WQCwUKznFQpZolID+N
         jlfOXD0SJrRHbwUoR3ukouOndLkCndLiCGDAbgCJBW9IiiJnVmAXqUqlffylCpIn1McD
         WMYth3X47pNhiOcqSYnYfdKWzF7/rvJ0LEM1mXEf8I1j+IYwO2aLz96mL0QpcDIR8QQU
         6EFkNk3m58eb6QaVUpU15fnJFYKViosM/3aRzNvKSx6VzrZoHAjFcyKYwkVM0zcS0+3J
         EcxnteW71+0BwlTX5ueYFO4NhvaNYRMtAGD4IUSl4+OqFoPjZp0WkrnHNcEmoSt1DSW6
         K94A==
X-Gm-Message-State: AOJu0YyPTpM7jHCW/p+RNjocYVUZbfhi6+hBRV1sQjuCUUArv+jtQZFv
	/ZD+NvOdPeQ0Kgrq8wN26+9Jy6PR61gg3gVch/4Cqp6DlGlFJ/mHUSyD9XjltpFan8+efHVZvUT
	0dRIAQjqNVRSR8Z6Y7JHFVnl55rqwNh4Y1omF/QX6
X-Received: by 2002:a17:90a:a091:b0:28b:bc1b:7de with SMTP id r17-20020a17090aa09100b0028bbc1b07demr1614902pjp.40.1703044032152;
        Tue, 19 Dec 2023 19:47:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDcI4ixQybr5i5c0P1DsfG1krVEzdc5+7jCz/VxN07e6GQutc26ICOW0Eu/Hr7GtQW0pJUC6ahOAcBoKibwTQ=
X-Received: by 2002:a17:90a:a091:b0:28b:bc1b:7de with SMTP id
 r17-20020a17090aa09100b0028bbc1b07demr1614895pjp.40.1703044031879; Tue, 19
 Dec 2023 19:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-11-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-11-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:47:00 +0800
Message-ID: <CACGkMEvnDCv7eGQM_fdjg71Mqs5=9Gsox2fHa+vVAoqu+ywy7A@mail.gmail.com>
Subject: Re: [PATCH vhost v4 10/15] vdpa/mlx5: Introduce per vq and device resume
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
> Implement vdpa vq and device resume if capability detected. Add support
> for suspend -> ready state change.
>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



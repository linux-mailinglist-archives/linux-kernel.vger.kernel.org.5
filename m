Return-Path: <linux-kernel+bounces-17437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050BF824D39
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D741C22001
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CEA612F;
	Fri,  5 Jan 2024 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqwQ2t6v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDDF5662
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704422831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cj9qM4WWk3dS+keeMX239nQGN9ivC8XXFg/nyP/Nxfw=;
	b=DqwQ2t6vYbiv/ECR6CzlcsVbqa5+2sGPZkx1+exTFOWXRkbQt5W+x5ONV1FK6dK5fP9u6q
	8hRnFnvKWcRvWGjOVEzktqmBXqmekYsrq4cmPkOiWcAApR+I/AtI/gp3SAkGpLBuVK5OAz
	Tyr8eP5biNzA4OOpsp3+DFfGDXX6GuE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-JdSqS91PNGqxJZ5GXrbHhw-1; Thu, 04 Jan 2024 21:47:09 -0500
X-MC-Unique: JdSqS91PNGqxJZ5GXrbHhw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28cca9bda41so838052a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 18:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704422828; x=1705027628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cj9qM4WWk3dS+keeMX239nQGN9ivC8XXFg/nyP/Nxfw=;
        b=Q+vJbDQfxqBGeRia9QqT7FWGVNOIEws4AmVO0kIBfaw+NvwCD3QlkNJ7J2L1Dgv338
         1io2lksYGWggc15/0Ry9ePb/GnocAMGGgf84adM6NJujapfyPmMvFCotiRKG0Vmj+24+
         4+foVwkfLOhmnjsXAO6rZJbocdUzwAM9DUTQ2oQIr6IlpKORGZ4M8pLLUnpflA24H1lx
         /11nHT9QE0kp5gQ1DVvZP6k8NvLD1/w4lYtpbA5txfChUNVqXiCoyYCPIjOPMBjI/gm4
         u/ox6gAT7xk9UrPBCQ/I2XOb71okLq6UEwAC9PbquK7q5uZ90YTQFMSHHXE4UG3YWmFJ
         YNiA==
X-Gm-Message-State: AOJu0Yx7jQUiYNTbsqVE99StzNtJQWR9w/Ynq93gwDLDLnxfr0okdpk6
	CSugpLMW/3Fi4z/VIICCJ5OL3T27WFhjUzFCagVDuXFqtwc/RVaajQ2yoJrN7crp84qKYHfCoZ6
	wffcURt6xUTgu6eQfAgTo5OdBa2uoH4pIpALxkDa6TNQ63zlC
X-Received: by 2002:a17:90a:6bc1:b0:28b:c057:4e01 with SMTP id w59-20020a17090a6bc100b0028bc0574e01mr1152178pjj.90.1704422828614;
        Thu, 04 Jan 2024 18:47:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKKMNeGhYuYDZT0lc+vAEL/Zscf9ZdFfetLkDt8t9DSjWTGQpscLo+jU5vx4cKUtpjDmi7NatT45l6e6ksc1U=
X-Received: by 2002:a17:90a:6bc1:b0:28b:c057:4e01 with SMTP id
 w59-20020a17090a6bc100b0028bc0574e01mr1152171pjj.90.1704422828347; Thu, 04
 Jan 2024 18:47:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com> <20240104153753.2931026-4-maxime.coquelin@redhat.com>
In-Reply-To: <20240104153753.2931026-4-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Jan 2024 10:46:56 +0800
Message-ID: <CACGkMEvdqT0ct1Uc4-JeagSzhW4omVda+Rj-y3fJOnK6T0oE=Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] vduse: enable Virtio-net device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 11:38=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch adds Virtio-net device type to the supported
> devices types.
>
> Initialization fails if the device does not support
> VIRTIO_F_VERSION_1 feature, in order to guarantee the
> configuration space is read-only. It also fails with
> -EPERM if the CAP_NET_ADMIN is missing.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



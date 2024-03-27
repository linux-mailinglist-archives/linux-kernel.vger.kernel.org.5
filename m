Return-Path: <linux-kernel+bounces-121383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FFC88E741
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0D41F28F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279F913E6DB;
	Wed, 27 Mar 2024 13:44:39 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881A13A27E;
	Wed, 27 Mar 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547078; cv=none; b=G/IqYnFG2gDiuZmwHrGcNt0b6MqivZb/Bq8SP5K1T8LIuscKW+CWZZOBkCfgFk7PJ1/NllBVM6ZX/cKLdbDJG2nzRASCilFCqEsaoL7XBOUETwfpK0L9ZUzM9mQdKJFvhrTzpMEugoA/1mzB7/Yr+XuJ0zQF14FXTlqdVao+2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547078; c=relaxed/simple;
	bh=2xZT353bg+Gd2k0hEm0r6uRcXB+j37Lc80ZKxrL2FNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M28GYBziTQye7HLZ5PjSZQTp4LVgpkFtydwFj+lxzo4BB0uytmNjjQBdm33Sn/2BE45VaXg8vJYCIli1MooYAuxcTVepzlohLJ3c052EO8S/rWgmgdf9OufaUShEwOK28tVf5sYX0D2s+9en/OozX4fZUyhcDBazdlTgLxa/gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4734ae95b3so694288266b.0;
        Wed, 27 Mar 2024 06:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711547075; x=1712151875;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLz16fmiK7clzNfffXEiofOH4lXEAbKlwPA6/CgGe8Y=;
        b=GLn4NIfRsVSvqy33hwqDXqIb+aGddKHlnN2DNNdkcLIidlrJg2E/isG8KTPgs1iPVd
         boFJ7WUyIU/XkqSpJNBLppkCdDW0ABvtw8Okez4rtWgdhiV5HlomzQjMsxVy5802I9JO
         HdzbQqHqwlvs/6yJcnp9Ea97G1quiWm/szuplmvB/1hyS95cKY4YpItAoZg6DEVoR14M
         z+2Jx4nm76GltUsofZRhWEXBJPvHHQuvpYK4LLC+NSSVqJMV64YDC2PDX1Czz0CycfDG
         zVdXSVBwfwPERfQdeYnPVieT0d/gHN8zv2QKCeqzEMfx853G8nXA8qIHhlAyeOLifnfJ
         L/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXs7rC/NwUDZuoXyh5jHX5R/ro70JhoDUmZvexdskq0ofxDBiweMyBw02nHp1tGSzfDlm8yVwHxnFHRLk7GePLkB7F86F0MthM2Yjc3bweej6xp0jM94UmajeFLhYwkjjkV6wPFCNuVfyCodTmGbTBX5EkkZ6IFYZpq8Oeg
X-Gm-Message-State: AOJu0YzCwoF8hSKAjjZkalF/I7OcsGibNDiG4DuI+orU+H2V88dPF0CB
	RzkAftlelRUWS8BS6vH5XnKwdKokT8GlCFZLTnEVTE7VDxZDVV/0
X-Google-Smtp-Source: AGHT+IHlsqprzpnxJBYeJapDRINLx/aNTv+m24jMPvBz9QGVUn18hEMdVfXDoR7rOZNE4m03xIbPbA==
X-Received: by 2002:a17:906:e08a:b0:a4d:fae7:ece3 with SMTP id gh10-20020a170906e08a00b00a4dfae7ece3mr2030643ejb.5.1711547074857;
        Wed, 27 Mar 2024 06:44:34 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906670b00b00a44b90abb1dsm5439004ejp.110.2024.03.27.06.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 06:44:34 -0700 (PDT)
Date: Wed, 27 Mar 2024 06:44:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: xuanzhuo@linux.alibaba.com, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>, rbc@meta.com,
	riel@surriel.com, stable@vger.kernel.org, qemu-devel@nongnu.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 2/2] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <ZgQivw8YG7XT2boy@gmail.com>
References: <20240326151911.2155689-1-leitao@debian.org>
 <20240326151911.2155689-2-leitao@debian.org>
 <bc5a835b-94c8-4500-b05b-0dd32afddbe8@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc5a835b-94c8-4500-b05b-0dd32afddbe8@linux.alibaba.com>

On Wed, Mar 27, 2024 at 10:27:58AM +0800, Heng Qi wrote:
> 
> 
> 在 2024/3/26 下午11:19, Breno Leitao 写道:
> > There is a bug when setting the RSS options in virtio_net that can break
> > the whole machine, getting the kernel into an infinite loop.
> > 
> > Running the following command in any QEMU virtual machine with virtionet
> > will reproduce this problem:
> > 
> >      # ethtool -X eth0  hfunc toeplitz
> > 
> > This is how the problem happens:
> > 
> > 1) ethtool_set_rxfh() calls virtnet_set_rxfh()
> > 
> > 2) virtnet_set_rxfh() calls virtnet_commit_rss_command()
> > 
> > 3) virtnet_commit_rss_command() populates 4 entries for the rss
> > scatter-gather
> > 
> > 4) Since the command above does not have a key, then the last
> > scatter-gatter entry will be zeroed, since rss_key_size == 0.
> > sg_buf_size = vi->rss_key_size;
> > 
> > 5) This buffer is passed to qemu, but qemu is not happy with a buffer
> > with zero length, and do the following in virtqueue_map_desc() (QEMU
> > function):
> > 
> >    if (!sz) {
> >        virtio_error(vdev, "virtio: zero sized buffers are not allowed");
> > 
> > 6) virtio_error() (also QEMU function) set the device as broken
> > 
> >      vdev->broken = true;
> > 
> > 7) Qemu bails out, and do not repond this crazy kernel.
> > 
> > 8) The kernel is waiting for the response to come back (function
> > virtnet_send_command())
> > 
> > 9) The kernel is waiting doing the following :
> > 
> >        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > 	     !virtqueue_is_broken(vi->cvq))
> > 	      cpu_relax();
> > 
> > 10) None of the following functions above is true, thus, the kernel
> > loops here forever. Keeping in mind that virtqueue_is_broken() does
> > not look at the qemu `vdev->broken`, so, it never realizes that the
> > vitio is broken at QEMU side.
> > 
> > Fix it by not sending RSS commands if the feature is not available in
> > the device.
> > 
> > Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> > Cc: stable@vger.kernel.org
> > Cc: qemu-devel@nongnu.org
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >   drivers/net/virtio_net.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c640fdf28fc5..e6b0eaf08ac2 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3809,6 +3809,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
> >   	struct virtnet_info *vi = netdev_priv(dev);
> >   	int i;
> > +	if (!vi->has_rss && !vi->has_rss_hash_report)
> > +		return -EOPNOTSUPP;
> > +
> 
> Why not make the second patch as the first, this seems to work better.

Sure, that works for me. Let me update it in v2.


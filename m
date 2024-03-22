Return-Path: <linux-kernel+bounces-111284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B119F886A20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BED22874C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03D438DDD;
	Fri, 22 Mar 2024 10:21:28 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B2822611;
	Fri, 22 Mar 2024 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102888; cv=none; b=cd4vIBTANEytfhGQoYMRrLbogNEIUfSq9bBswj8QDD0wniDb22R+d4pMaXGpGiT7wKec3UvWVEWKgJeOqIaI/j17cu7uYUUkGzOHvYyr0lPk7Dn2JD1n2dJX7cJsSx2pDnv5aKB1Ih1iIPHQ6T7CeYYBfcMMoZwUD6dnrVf46aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102888; c=relaxed/simple;
	bh=S/hPbQEccrVNk5ZTyBsPVY3O7bBdsDl1BFMRxs5asfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmvFwML+Fr7A6g8ITg5DOdKp/lv+HmM2jbBP8cxpiCz9HQq+Ck+aHnHB6yjp4rYsuOrVFM3zCPjP+kuy93OhrXZYYALJu+YCqxMrimcEE+5eFWzFs5LtNPZTaMl4j2rWMbKWrnYMtZQgW9gNNaoLuemgdV9Mr0/xVDj4x5faBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a470d7f77eeso229831766b.3;
        Fri, 22 Mar 2024 03:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711102885; x=1711707685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGqjI6P0mTPBiKZTNOwbVNYIjw9Vw14Zd3G3C6QS6wY=;
        b=h6Kmtg6uIlQhyQkO++ggq6xObWuREB9XLkkHrPXk6azO860k+NhrnDFkTqRT02CUoF
         uATgxUP3U5S2A6wIXZRDKDeiyepcqR7xwkBd0AgTVYAXh68YcfyfWivl6b1xgODaPaZu
         NGqiZp3y1Q7JUMDtv9dCafvb8apbYPeXJ+Fu+uoC9PeZ0amvcOqE6qq2fnsBjmtRv6hR
         bgH8O+7JAoUlVAxp3yRaBPo2I088HagZxWrcbx1WYHeK14r6MktftoedIwc4ZuKOaDc/
         1s/UXZV1qNv+3ME9QHDN7/fHBLlvS4tJkCA64OrCDmq4qlrtIKxCp00g7oICN+sda6G9
         HntQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsvvLWZ7WoQqHERKsl0EA52OxEgEHjpgSBAUa5pNbRkYkqy8/EQTSoXUY+FJrk8Eiw1qmIQWNpS5dOfIF/jN9f9Y3ySqxohdG6PO8WP8M0xdduHRnr2MT+n9iM4jalNRLOrR6Dm6Hw7rvrYzAfaO7c4ecMiZFVGnuQ2thy
X-Gm-Message-State: AOJu0YykgEI7zpIP+FKcY0UVwVFJ4v7M4t2SASdwopgPxRVqKSgiaIHs
	h5IdozuUy7As1bnKnvCzDjpSNPklL/bz+HzDpkMUmEsLF9kNLGoi
X-Google-Smtp-Source: AGHT+IGEXDCR4iq9rvwz5B26z4GLijSPqxuBAhYB8+zqYJlK7HGPtfYNr6wzSSm9SN6zugWqLIWZmg==
X-Received: by 2002:a17:907:7e94:b0:a47:3527:90c0 with SMTP id qb20-20020a1709077e9400b00a47352790c0mr673262ejc.14.1711102884800;
        Fri, 22 Mar 2024 03:21:24 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id bo10-20020a170906d04a00b00a4728151908sm705505ejb.93.2024.03.22.03.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:21:24 -0700 (PDT)
Date: Fri, 22 Mar 2024 03:21:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: rbc@meta.com, riel@surriel.com, stable@vger.kernel.org,
	qemu-devel@nongnu.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH] virtio_net: Do not send RSS key if it is not supported
Message-ID: <Zf1bofzE4x0wGEm+@gmail.com>
References: <20240321165431.3517868-1-leitao@debian.org>
 <1711072822.882584-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711072822.882584-1-xuanzhuo@linux.alibaba.com>

Hello Xuan,

On Fri, Mar 22, 2024 at 10:00:22AM +0800, Xuan Zhuo wrote:
> On Thu, 21 Mar 2024 09:54:30 -0700, Breno Leitao <leitao@debian.org> wrote:

> > 4) Since the command above does not have a key, then the last
> >    scatter-gatter entry will be zeroed, since rss_key_size == 0.
> >     sg_buf_size = vi->rss_key_size;
> 
> 
> 
> 	if (vi->has_rss || vi->has_rss_hash_report) {
> 		vi->rss_indir_table_size =
> 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
> 				rss_max_indirection_table_length));
> 		vi->rss_key_size =
> 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> 
> 		vi->rss_hash_types_supported =
> 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
> 		vi->rss_hash_types_supported &=
> 				~(VIRTIO_NET_RSS_HASH_TYPE_IP_EX |
> 				  VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
> 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> 
> 		dev->hw_features |= NETIF_F_RXHASH;
> 	}
> 
> 
> vi->rss_key_size is initiated here, I wonder if there is something wrong?

Not really, the code above is never executed (in my machines). This is
because `vi->has_rss` and `vi->has_rss_hash_report` are both unset.

Looking further, vdev does not have the VIRTIO_NET_F_RSS and
VIRTIO_NET_F_HASH_REPORT features.

Also, when I run `ethtool -x`, I got:

	# ethtool  -x eth0
	RX flow hash indirection table for eth0 with 1 RX ring(s):
	Operation not supported
	RSS hash key:
	Operation not supported
	RSS hash function:
	    toeplitz: on
	    xor: off
	    crc32: off


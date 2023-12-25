Return-Path: <linux-kernel+bounces-11065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BFE81E0E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079AC1F2117B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC04D51C52;
	Mon, 25 Dec 2023 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkMMQUES"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7F2524D3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703510876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=eQrFSUCYGMhy2SsSQLQNb28k56c6BCyeTM61vN0o41o=;
	b=GkMMQUESaZURPC8ZfFz72h5Y9EokqUeQtYHZbcOWUYbToA5YEI3VZGGpRu9yUKP6N1tXZQ
	FeBGbTOvZeVL4tQDnp6jICRe15iK2VyTXMqktblkLmwCDo/WRzkMeRag3gguHxdFYKo6xk
	rONJoZzSvx8M9aNKqnLuy1tbdJJgGbA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Cs-FCihGPIyxQpvD8GNKAA-1; Mon, 25 Dec 2023 08:27:53 -0500
X-MC-Unique: Cs-FCihGPIyxQpvD8GNKAA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33694552b9aso1981220f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 05:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703510872; x=1704115672;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQrFSUCYGMhy2SsSQLQNb28k56c6BCyeTM61vN0o41o=;
        b=Z2ejpqWHmbHL3rwapXmndp2G/IatQvSztF8Q6UgJxVrbwgXyqRvmQ5R68mmO/CoPgw
         CGDzh5P2/5zpsedirHeuDoes9IY8hXDlCwWNNdtKpo3UHOmJaFUSvW572OXqAwINBno3
         afX0MUtIBvwZcJO/jYzk+evuMj+wpTDXzOYFMB2yOVA3KBu67t1hkk0FYFdaNcNsgPDu
         v4lg7BKheZsISwezJKYFRfuJVNHePFqFlPk9icYOpSFvqIAf/WrvN+2WLRGK8qeDBWzv
         fnF9IM4XKgORcnQZ3HS/WosaC7NBDXdS64Fx6zkMnt/iHHypWgzQF/DxvrsbD+7WA8TR
         zJnw==
X-Gm-Message-State: AOJu0YyLvflk28U9MrqV871qmyU3qg9rYpkD5ss1p0liCsuM3rSgxQWM
	AdFPFZSOJJQ6mCspPrAaCS82xflLPf5h7SZm11v7KNmyMVFF0vy5EIorvS8HCShK6LKhG/poZQl
	nDJW6XCcQotIjljpHnRYysmxwFVN9CI3j
X-Received: by 2002:adf:efc3:0:b0:336:6413:682 with SMTP id i3-20020adfefc3000000b0033664130682mr2892625wrp.42.1703510872090;
        Mon, 25 Dec 2023 05:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFADLrFfKMHOhtA8f351FSOXWF1tCR+mhRQi9Bja66IW8vKteZ/pT7INfLkesHcwbnd7uOsEA==
X-Received: by 2002:adf:efc3:0:b0:336:6413:682 with SMTP id i3-20020adfefc3000000b0033664130682mr2892612wrp.42.1703510871682;
        Mon, 25 Dec 2023 05:27:51 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id t16-20020adfe450000000b0033666ec47b7sm10354728wrm.99.2023.12.25.05.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 05:27:51 -0800 (PST)
Date: Mon, 25 Dec 2023 08:27:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	hongyu.ning@linux.intel.com, jasowang@redhat.com, lkp@intel.com,
	mst@redhat.com, stefanha@redhat.com, suwan.kim027@gmail.com,
	xuanzhuo@linux.alibaba.com
Subject: [GIT PULL] virtio: bugfixes
Message-ID: <20231225082749-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit cefc9ba6aed48a3aa085888e3262ac2aa975714b:

  pds_vdpa: set features order (2023-12-01 09:55:01 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to b8e0792449928943c15d1af9f63816911d139267:

  virtio_blk: fix snprintf truncation compiler warning (2023-12-04 09:43:53 -0500)

----------------------------------------------------------------
virtio: bugfixes

A couple of bugfixes: one for a regression.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Stefan Hajnoczi (1):
      virtio_blk: fix snprintf truncation compiler warning

Xuan Zhuo (1):
      virtio_ring: fix syncs DMA memory with different direction

 drivers/block/virtio_blk.c   | 8 ++++----
 drivers/virtio/virtio_ring.c | 6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)



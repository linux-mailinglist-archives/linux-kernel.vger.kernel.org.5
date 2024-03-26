Return-Path: <linux-kernel+bounces-119291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0517188C6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CDD1B25F57
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E092E13C9AE;
	Tue, 26 Mar 2024 15:19:27 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81D13C8F9;
	Tue, 26 Mar 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466367; cv=none; b=l+yGU8SfwSkve8Ca0opCfXoZK1/3URfsiAoi/ElHy1htbg+aqwVCSYJEJMewlO9qC+0cFyc1NeTaeA1CVdo7mWgJW8TPUUKioS9Za17Opjr99D5CKvWSuQMqCbWYf0vpZwlSAeV/bQ5OY9LlJU4wukjz0hHgIbFP1NFGYMl1cKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466367; c=relaxed/simple;
	bh=hHinf3uw5mGBk3XfcvWhk/gfoOKl1t3aCvp3XB22w68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9GSY+EW9f8oKZUIIonLuXyf6b7PaM4ztA/DLiATN9zE9DAPpi8DVTMQBy0l7txy4NVkk9fhikxkeo3YCJKv34e8cbBd4F70aDPfRFaMPkaxWWMfXMueCZfGq0jgNrNonXCrYeCyJ4gPThtkIvG2mcP6Wf3CQKsPclSzte6CVOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-515a97846b5so2885688e87.2;
        Tue, 26 Mar 2024 08:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711466363; x=1712071163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUVslbHxJBsutcvQ73cVdAnF0u3jUnm/TB9Hv1RCS88=;
        b=lTf7y/EveBKTZ/gEajfiO3bkUybaOiVGWCowwSiu+WYvXkM8aWYzPiXLC87HNFik8H
         Uxa6r6JOyPI0s99h0RE41Bs/Mcrr0aS8g5rPupuEQtupbbHSIOT+OvowXmzajeNiJdAU
         yRTcryR2RrqU+Iu+e+uDyiiOsYyyadDrAwowfkUoQSRKsw6Yuw9nngEa8yMlPp2m/UQj
         6AwSRw3iR8y/K2o/MbrTsq6CHGmBIDqu4DWER5PURfP/LHTixZP04tnnssBUd+ympkcu
         Occ7ht8zmuVLJbLPaq+A6d0EXDbLtMAbj/rxWRLFpyo1xNxHArLIwa08Ndd4cJZt/W08
         hh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7FGOa0oF4CfN8fJM3UKa+fOCgkwFZfWkTFEcEn8X/11/B67kUMi7v1jQgSrruBQi0oS44+77XZRlgLg/9wKLc1HVeQZYIUKdjfbL/q/DHjJ/PKAKOxWAzVZIvWddBZfMoToyOxg2rmRui2q1NhGLbYkbXYxDN7gLYD+rZ
X-Gm-Message-State: AOJu0Yyh3inStF3XC/iw/ObsR0moDcvlnrS46hqs6s3HOVPPeqAvgdMe
	Cs2PW0kU9NWpZe5jb8T9A1xdPsflPu3X49+CQbRICDW+UYEAcW58
X-Google-Smtp-Source: AGHT+IFP2FZZbpvO9c2stqUmT05DnUhkBn3keNu/tRQhmT0rhlV567sSQvXWBoBrIb87kTJm2cF7ag==
X-Received: by 2002:a05:6512:54e:b0:513:d522:b58c with SMTP id h14-20020a056512054e00b00513d522b58cmr6423792lfl.56.1711466363049;
        Tue, 26 Mar 2024 08:19:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id i16-20020a170906091000b00a4735fc654fsm4295335ejd.205.2024.03.26.08.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:19:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>
Cc: rbc@meta.com,
	riel@surriel.com,
	stable@vger.kernel.org,
	qemu-devel@nongnu.org,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 2/2] virtio_net: Do not send RSS key if it is not supported
Date: Tue, 26 Mar 2024 08:19:09 -0700
Message-ID: <20240326151911.2155689-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326151911.2155689-1-leitao@debian.org>
References: <20240326151911.2155689-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bug when setting the RSS options in virtio_net that can break
the whole machine, getting the kernel into an infinite loop.

Running the following command in any QEMU virtual machine with virtionet
will reproduce this problem:

    # ethtool -X eth0  hfunc toeplitz

This is how the problem happens:

1) ethtool_set_rxfh() calls virtnet_set_rxfh()

2) virtnet_set_rxfh() calls virtnet_commit_rss_command()

3) virtnet_commit_rss_command() populates 4 entries for the rss
scatter-gather

4) Since the command above does not have a key, then the last
scatter-gatter entry will be zeroed, since rss_key_size == 0.
sg_buf_size = vi->rss_key_size;

5) This buffer is passed to qemu, but qemu is not happy with a buffer
with zero length, and do the following in virtqueue_map_desc() (QEMU
function):

  if (!sz) {
      virtio_error(vdev, "virtio: zero sized buffers are not allowed");

6) virtio_error() (also QEMU function) set the device as broken

    vdev->broken = true;

7) Qemu bails out, and do not repond this crazy kernel.

8) The kernel is waiting for the response to come back (function
virtnet_send_command())

9) The kernel is waiting doing the following :

      while (!virtqueue_get_buf(vi->cvq, &tmp) &&
	     !virtqueue_is_broken(vi->cvq))
	      cpu_relax();

10) None of the following functions above is true, thus, the kernel
loops here forever. Keeping in mind that virtqueue_is_broken() does
not look at the qemu `vdev->broken`, so, it never realizes that the
vitio is broken at QEMU side.

Fix it by not sending RSS commands if the feature is not available in
the device.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Cc: stable@vger.kernel.org
Cc: qemu-devel@nongnu.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c640fdf28fc5..e6b0eaf08ac2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3809,6 +3809,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
+	if (!vi->has_rss && !vi->has_rss_hash_report)
+		return -EOPNOTSUPP;
+
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-- 
2.43.0



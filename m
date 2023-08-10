Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15852776E64
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjHJDQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHJDQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:16:13 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2181BFB;
        Wed,  9 Aug 2023 20:16:12 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76c8dd2ce79so41943185a.1;
        Wed, 09 Aug 2023 20:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691637372; x=1692242172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YsP6+M83tJ99Nd1EkOWnQq9Dpk1PaD5qBivEPmeZxDU=;
        b=k1ikJtf0/a6tAsog2qODYu08f/KtYdY2TnmgDrYOYtuPCoJ9GTXZGRxwOycFaD/93m
         h6HhuYmkMsorlw4oevYiTdHyFNenGqRbbD4oqIZ1Cb6SRpYVcpPsi9aXgkcTZLjfuqAg
         jjmtlOFUcrXoh56BwvfbilQWaWTRFeM5hB3wB6wNPnIRQu1QbStwaNgz85yoEff04g5h
         qOJrnjCpwqNTe6MnltyZacILZCgMAmaOkAMbm+XAKls2DThDlkN3QmdNxmjVMhGr5MEW
         J3vBaf5hTOJITclcX7iRSKET3ekA89rTDvgU9ufhsqwa3Zz4H5yypqpO5HgUQvA1mTZd
         FLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691637372; x=1692242172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsP6+M83tJ99Nd1EkOWnQq9Dpk1PaD5qBivEPmeZxDU=;
        b=eT+OfP/5jzwSukgSiGv4QxKD09ipyvHeYDGHZbyUQ907GYHy7L966VSYCsgDJP+Jxx
         6HCsKcju/agoad0/hZ6yI7I8xpNAkGJK5u0V2OrZZKGi2sqvdz9PUYuWhdscV0CCTmlm
         qsWk3QWFEt3p1E4bJb7tfjOWZDlPdnExCK0bSbe/+kTyVEydKhAuSn++jOLxR95f7vQj
         YRAzuOZYSTJBQ8odCmQG0fNvEvYIxnsB9bNd/5Y1pMgvWOpDN9lIpt/2M4OlUcv/bzFg
         AogriQyqLVWzCam7O0ICAUdSTak9KXsJxKTfPy0HGDZW+BOaIerQFupqLaUamCZKasaZ
         5dCw==
X-Gm-Message-State: AOJu0YwQ0i0PzuiCH7NCcwgm7gMoUUddaS6SY05IrO6dG9o0AJyE2KpN
        czt5p2N3TwAda7gpegs3iZ8=
X-Google-Smtp-Source: AGHT+IFMLwyyp8q2A5J1hejT+OuuntqBztSvuBxvqHSxtLwm1T4wMASjwp68c86y5kwEyFOBxVoBAQ==
X-Received: by 2002:a05:620a:2942:b0:767:96e2:a9cb with SMTP id n2-20020a05620a294200b0076796e2a9cbmr1104151qkp.38.1691637371837;
        Wed, 09 Aug 2023 20:16:11 -0700 (PDT)
Received: from localhost ([125.35.86.198])
        by smtp.gmail.com with ESMTPSA id c4-20020a63ea04000000b0055c178a8df1sm357788pgi.94.2023.08.09.20.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 20:16:11 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     eperezma@redhat.com, yin31149@gmail.com, 18801353760@163.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG case
Date:   Thu, 10 Aug 2023 11:15:57 +0800
Message-Id: <20230810031557.135557-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel uses `struct virtio_net_ctrl_rss` to save command-specific-data
for both the VIRTIO_NET_CTRL_MQ_HASH_CONFIG and
VIRTIO_NET_CTRL_MQ_RSS_CONFIG commands.

According to the VirtIO standard, "Field reserved MUST contain zeroes.
It is defined to make the structure to match the layout of
virtio_net_rss_config structure, defined in 5.1.6.5.7.".

Yet for the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command case, the `max_tx_vq`
field in struct virtio_net_ctrl_rss, which corresponds to the
`reserved` field in struct virtio_net_hash_config, is not zeroed,
thereby violating the VirtIO standard.

This patch solves this problem by zeroing this field in
virtnet_init_default_rss().

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---

TestStep
========
1. Boot QEMU with one virtio-net-pci net device with `mq` and `hash`
feature on, command line like:
      -netdev tap,vhost=off,...
      -device virtio-net-pci,mq=on,hash=on,...

2. Trigger VIRTIO_NET_CTRL_MQ_HASH_CONFIG command in guest, command
line like:
	ethtool -K eth0 rxhash on

Without this patch, in virtnet_commit_rss_command(), we can see the
`max_tx_vq` field is 1 in gdb like below:

	pwndbg> p vi->ctrl->rss
	$1 = {
	  hash_types = 63,
	  indirection_table_mask = 0,
	  unclassified_queue = 0,
	  indirection_table = {0 <repeats 128 times>},
	  max_tx_vq = 1,
	  hash_key_length = 40 '(',
	  ...
	}

With this patch, in virtnet_commit_rss_command(), we can see the
`max_tx_vq` field is 0 in gdb like below:

	pwndbg> p vi->ctrl->rss
	$1 = {
	  hash_types = 63,
	  indirection_table_mask = 0,
	  unclassified_queue = 0,
	  indirection_table = {0 <repeats 128 times>},
	  max_tx_vq = 0,
	  hash_key_length = 40 '(',
	  ...
	}

 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1270c8d23463..8db38634ae82 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2761,7 +2761,7 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
 		vi->ctrl->rss.indirection_table[i] = indir_val;
 	}
 
-	vi->ctrl->rss.max_tx_vq = vi->curr_queue_pairs;
+	vi->ctrl->rss.max_tx_vq = vi->has_rss ? vi->curr_queue_pairs : 0;
 	vi->ctrl->rss.hash_key_length = vi->rss_key_size;
 
 	netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
-- 
2.34.1


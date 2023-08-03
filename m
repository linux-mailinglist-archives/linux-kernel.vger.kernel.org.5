Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1891176F31F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjHCTAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjHCTAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:00:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9802D45;
        Thu,  3 Aug 2023 12:00:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bed101b70so177599466b.3;
        Thu, 03 Aug 2023 12:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691089229; x=1691694029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpJNHhs8hGi2yDC45xTTVL8bPEioZdZntYr6lajc9vM=;
        b=k5NDFDrEg+9nNDfAkqK83fDOp8A5hffycEbrlbI1/HFSkoagQYZMmMPYLy72x3L1wF
         JTyYZl2/V9SuoMJt9V3F/7xfyxu01MSFXa2Xhu/TtBD6BVVPbIYsb+0cN3OSQ4ZzY7qV
         sLMQfRL+DlBOv9af5SFsYVhKt8Yrf8E+RH9PvIzTXoXF5B3MwM01l3mdjlPDFa94T/5x
         XIi4lG512p/FVDpSvNiARyeXHw50IbimFnqlTAn/a/o63GlyqwYjJBdWDdtAbFGbfknY
         PcDd53ab0QCfjsii/z7pcosDnLaQrDL9LBgq9QPpZCYn7XUPYkMAEojnEN9BefiQyZTN
         77Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691089229; x=1691694029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpJNHhs8hGi2yDC45xTTVL8bPEioZdZntYr6lajc9vM=;
        b=hliGL4XMG/izhD1vc88sC/3AMnwPi5BEVOqy0h4xklm+8uTHpXUUSmaI887BJ3NK6O
         1AqKAN1wkmWx2kB9NbYCg+ps2kSh3VQW3hWkJdJTLrPZa35lYYRdmv9F6pfPjib7Hb+U
         aBKr9nAvXdgQ8QhHx7s8I339UDOM8SEM/Q9Y1nJhAvRBV3P4TgsJZWbNVzU+7RwIy3LK
         kv5cWVi9MUJbRCNAAIZ25z6bX7KUhOHrTIveyi5MJLqG6IkArDPPWlF+vEZybeEjHdfk
         NFN80W/o8p28qraKQ4CgF68RmOMK/UW4a2GTBAZXpusFrxU8y92fjI/6bADEjPe4Av5N
         EVTQ==
X-Gm-Message-State: ABy/qLaQCra+qoNC0DaP69C/xqa1EVABm1BOEeUnSpJuE8ckWQ29PXV0
        6kbzbVSNNmr10KayXSenttw=
X-Google-Smtp-Source: APBJJlErSeEumK9R9+wnkEORl7kuxFvXLYgJU3sv1JvX9YTgWXsr9PNifF6jZ1kMyJr/QPo0T+vz+w==
X-Received: by 2002:a17:906:20d9:b0:994:47a0:c730 with SMTP id c25-20020a17090620d900b0099447a0c730mr8455282ejc.43.1691089228564;
        Thu, 03 Aug 2023 12:00:28 -0700 (PDT)
Received: from dev7.kernelcare.com ([2a01:4f8:201:23::2])
        by smtp.gmail.com with ESMTPSA id d13-20020a1709063ecd00b00992a8a54f32sm182939ejj.139.2023.08.03.12.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:00:27 -0700 (PDT)
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org,
        hawk@kernel.org, jbrouer@redhat.com, dsahern@gmail.com,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH net-next v5 1/2] drivers: net: prevent tun_build_skb() to exceed the packet size limit
Date:   Thu,  3 Aug 2023 20:59:48 +0200
Message-Id: <20230803185947.2379988-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the syzkaller repro with reduced packet size it was discovered
that XDP_PACKET_HEADROOM is not checked in tun_can_build_skb(),
although pad may be incremented in tun_build_skb(). This may end up
with exceeding the PAGE_SIZE limit in tun_build_skb().

Jason Wang <jasowang@redhat.com> proposed to count XDP_PACKET_HEADROOM
always (e.g. without rcu_access_pointer(tun->xdp_prog)) in
tun_can_build_skb() since there's a window during which XDP program
might be attached between tun_can_build_skb() and tun_build_skb().

Fixes: 7df13219d757 ("tun: reserve extra headroom only when XDP is set")
Link: https://syzkaller.appspot.com/bug?extid=f817490f5bd20541b90a
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---

Notes (akanner):
    v5:
      - always count XDP_PACKET_HEADROOM in tun_can_build_skb() as there's a
        window between tun_can_build_skb() and tun_build_skb() and XDP
        program might be attached there.
      - rcu_read_lock/unlock() for tun->xdp_prog were completely removed and
        there's no need to use rcu_access_pointer() instead which was noted
        by David Ahern <dsahern@gmail.com>.
    v4: https://lore.kernel.org/all/20230801220710.464-1-andrew.kanner@gmail.com/T/
      - fall back to v1, fixing only missing XDP_PACKET_HEADROOM in pad
        and removing bpf_xdp_adjust_tail() check for frame_sz.
      - added rcu read lock, noted by Jason Wang <jasowang@redhat.com> in
        v1
      - I decided to leave the packet length check in tun_can_build_skb()
        instead of moving to tun_build_skb() suggested by Jason Wang
        <jasowang@redhat.com>. Otherwise extra packets will be dropped
        without falling back to tun_alloc_skb(). And in the discussion of
        v3 Jesper Dangaard Brouer <jbrouer@redhat.com> noticed that XDP is
        ok with a higher order pages if it's a contiguous physical memory
        allocation, so falling to tun_alloc_skb() -> do_xdp_generic()
        should be ok.
    v3: https://lore.kernel.org/all/20230725155403.796-1-andrew.kanner@gmail.com/T/
      - attach the forgotten changelog
    v2: https://lore.kernel.org/all/20230725153941.653-1-andrew.kanner@gmail.com/T/
      - merged 2 patches in 1, fixing both issues: WARN_ON_ONCE with
        syzkaller repro and missing XDP_PACKET_HEADROOM in pad
      - changed the title and description of the execution path, suggested
        by Jason Wang <jasowang@redhat.com>
      - move the limit check from tun_can_build_skb() to tun_build_skb()
        to remove duplication and locking issue, and also drop the packet
        in case of a failed check - noted by Jason Wang
        <jasowang@redhat.com>
    v1: https://lore.kernel.org/all/20230724221326.384-1-andrew.kanner@gmail.com/T/

 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 25f0191df00b..100339bc8b04 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1594,7 +1594,7 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 	if (zerocopy)
 		return false;
 
-	if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
+	if (SKB_DATA_ALIGN(len + TUN_RX_PAD + XDP_PACKET_HEADROOM) +
 	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
 		return false;
 
-- 
2.39.3


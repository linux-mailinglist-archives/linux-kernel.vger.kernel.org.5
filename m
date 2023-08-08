Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676A17747AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjHHTRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjHHTQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:16:55 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708A53A682
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:39:21 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44781abd5a8so2436570137.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691512759; x=1692117559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7fE5Alv+EJyDTeeiRz1KQXY25Fs9lEK25v4C7UY4dNc=;
        b=HsUT7hfPGZ2ruM0UEWI1kfUl5gPNIrXUy+235IBog+Y/bjjpcs9xUhx3/BczgwtCSk
         dTW/x8DMglxWvv9hvZq/UM505nkEmJQYC7Al0DRcxnWbDn2NZDkDVEtnupFDCExxnCrO
         YJKGklvKSqowqdHz/TxNSaZq/sDEQ3xa+vb+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512759; x=1692117559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fE5Alv+EJyDTeeiRz1KQXY25Fs9lEK25v4C7UY4dNc=;
        b=JDpVZ0zywFD/+I6HDLtxiVr8MIOuogHLH+ARdNWEGylSGPS+4SgwE9s1A4RaYMiCxT
         0GXuvOSEtRaFnX2drfwULUDvXaqTMkcdWlKIc/MVBKM+FfIaH8nwYIHyQw7QvjL+iOJ3
         8WTclhw+ZKoQ3eUT1iVS/fZubwhejQUy7wRQmgdB3OViiTKOylhlH5gYjynR2kEFfANw
         ft/N3pLUetKA9dYdfPoVti0h1pELYnvmIaT7fQaVpZR9QK9ani+M5AYfq7V5+wDbwSK9
         FnpF93Xs0ZeVubFPmQeGrmtKQu3Tba59Xs4ttil7San/Q6/PpVPkhetwemJ2i/k50xAf
         sbZw==
X-Gm-Message-State: AOJu0YzfCeBhreKu8EIxmPL4z/H2OE4IiWcbcSu0h0PYTHYqSfEeZx35
        DGEsekCvxBzE8mQQ1C4Be1F/FlvR3h0J0+J2k39q4Jg=
X-Google-Smtp-Source: AGHT+IGrqJsxFZVA4udLq2W7wg4gJ19AlRklPG2DQU9S7Cmr2b/b/uTs4CtBMjEimz9dHYUJpLJFHg==
X-Received: by 2002:a05:6a21:3391:b0:13f:b028:789c with SMTP id yy17-20020a056a21339100b0013fb028789cmr12352855pzb.5.1691471492751;
        Mon, 07 Aug 2023 22:11:32 -0700 (PDT)
Received: from yuanyao.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id jd7-20020a170903260700b001bba27d1b65sm7881189plb.85.2023.08.07.22.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 22:11:32 -0700 (PDT)
From:   Yuan Yao <yuanyaogoog@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Keiichi Watanabe <keiichiw@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Takaya Saeki <takayas@chromium.org>,
        Junichi Uekawa <uekawa@chromium.org>,
        Yuan Yao <yuanyaogoog@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
Date:   Tue,  8 Aug 2023 05:10:59 +0000
Message-ID: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current packed virtqueue implementation, the avail_wrap_counter won't
flip, in the case when the driver supplies a descriptor chain with a
length equals to the queue size; total_sg == vq->packed.vring.num.

Let’s assume the following situation:
vq->packed.vring.num=4
vq->packed.next_avail_idx: 1
vq->packed.avail_wrap_counter: 0

Then the driver adds a descriptor chain containing 4 descriptors.

We expect the following result with avail_wrap_counter flipped:
vq->packed.next_avail_idx: 1
vq->packed.avail_wrap_counter: 1

But, the current implementation gives the following result:
vq->packed.next_avail_idx: 1
vq->packed.avail_wrap_counter: 0

To reproduce the bug, you can set a packed queue size as small as
possible, so that the driver is more likely to provide a descriptor
chain with a length equal to the packed queue size. For example, in
qemu run following commands:
sudo qemu-system-x86_64 \
-enable-kvm \
-nographic \
-kernel "path/to/kernel_image" \
-m 1G \
-drive file="path/to/rootfs",if=none,id=disk \
-device virtio-blk,drive=disk \
-drive file="path/to/disk_image",if=none,id=rwdisk \
-device virtio-blk,drive=rwdisk,packed=on,queue-size=4,\
indirect_desc=off \
-append "console=ttyS0 root=/dev/vda rw init=/bin/bash"

Inside the VM, create a directory and mount the rwdisk device on it. The
rwdisk will hang and mount operation will not complete.

This commit fixes the wrap counter error by flipping the
packed.avail_wrap_counter, when start of descriptor chain equals to the
end of descriptor chain (head == i).

Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
Signed-off-by: Yuan Yao <yuanyaogoog@chromium.org>
---

 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c5310eaf8b46..da1150d127c2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1461,7 +1461,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 		}
 	}
 
-	if (i < head)
+	if (i <= head)
 		vq->packed.avail_wrap_counter ^= 1;
 
 	/* We're using some buffers from the free list. */
-- 
2.41.0.640.ga95def55d0-goog


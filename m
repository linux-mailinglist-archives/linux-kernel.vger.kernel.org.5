Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992287D7BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 06:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbjJZEuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 00:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjJZEue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 00:50:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CBB93
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 21:50:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5b92b852390so208196a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 21:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698295830; x=1698900630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zyw+tCacb0pesWXIiVE3DFUWnD0FKkDUZEIm1rsxoog=;
        b=vHH1rohpRvkkdtD3NHS6sndE9qVDuR/ytRxaL40Ncod3k7FDkQCWJwD+QWB8OECOUZ
         aL3Ayd0+ykQ8L9O/kt7vSMncAyYy4+5M47rLQzQUO4BRxAUIBFItgBJhWq/itzHe5Kb1
         7H72JcmmGhmVPy9UhDvfzqsiQ0RFUnmjZpO74M+ICTMfVkgrEs2ykeNiGpCFIrs06AOt
         +6dpvbpcd4wvLO6FkTmjcyLlEafYPEpowk8jOj2ox3y0NeQKYaKyCDEB2+UwfErzVHHN
         aVhgAJqkEbX1gapTgiy/9PBuvecCjSHOxcKqBApu/tnper+x9QSYzw093pYrYNtLyE1K
         heFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698295830; x=1698900630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyw+tCacb0pesWXIiVE3DFUWnD0FKkDUZEIm1rsxoog=;
        b=qQ80wrVO58RfNZrXmg/vT+CPayY6RwY6mKyGNV2omYBV8mEG1CQb5VXiVfKw2QCVdc
         5vPb28jSspmVI576YDdLkyqb6kK/O+lIe0gnlYQn4rDacSwkSYtEKXRUHKZ8pCmNpIYQ
         Ipq6rFGnF44G6++q5kX7sMWnL7o5vFbrFlpss+0LL5bSYgLLGrHYiBLjV1Aqx4UQOUwp
         QJUt11jYYOovt3BPq8jsbMmZIK8Nrk6IYgmL1pldmU3sCqByp523hfmoS7ic0Cx0OvQC
         6HrI0UM9Guj1rb7sCl/2hQGgNVzFATJOMeum/Nyy8U0HK3Auzqf+2BWtS96poYusghE3
         5x6A==
X-Gm-Message-State: AOJu0YzgLGvmGv0Nfk3eb/Pb3UMn5yvYIzc3a//Mu4Csf9I6UzVm/tuf
        ORJ5SEUB5maeHDm0mHTa/AbzJkwAaHD8dsClAw==
X-Google-Smtp-Source: AGHT+IH0dhRidMhQSTgnbwk8LPrmRtaFDLXg4YO8o0Mu9UK5b5D0KSlXE2bAlCFTB2cZpvmkxxre+w==
X-Received: by 2002:a05:6a21:9710:b0:172:eda5:36eb with SMTP id ub16-20020a056a21971000b00172eda536ebmr6384929pzb.55.1698295830463;
        Wed, 25 Oct 2023 21:50:30 -0700 (PDT)
Received: from localhost.localdomain ([103.28.246.120])
        by smtp.gmail.com with ESMTPSA id lr13-20020a17090b4b8d00b0027cbc50b826sm718225pjb.17.2023.10.25.21.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 21:49:53 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alex Elder <elder@linaro.org>
Subject: [PATCH v2] bus: mhi: ep: Use slab allocator where applicable
Date:   Thu, 26 Oct 2023 10:19:32 +0530
Message-Id: <20231026044932.11745-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use slab allocator for allocating the memory for objects used frequently
and are of fixed size. This reduces the overheard associated with
kmalloc().

Suggested-by: Alex Elder <elder@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Rebased on top of mhi-next.

 drivers/bus/mhi/ep/main.c | 70 +++++++++++++++++++++++++++++----------
 include/linux/mhi_ep.h    |  3 ++
 2 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index e2513f5f47a6..b5af23f0e65a 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -74,7 +74,8 @@ static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl, struct m
 	struct mhi_ring_element *event;
 	int ret;
 
-	event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
+	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache,
+				   GFP_KERNEL | GFP_DMA);
 	if (!event)
 		return -ENOMEM;
 
@@ -83,7 +84,7 @@ static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl, struct m
 	event->dword[1] = MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
 
 	ret = mhi_ep_send_event(mhi_cntrl, ring->er_index, event, MHI_TRE_DATA_GET_BEI(tre));
-	kfree(event);
+	kmem_cache_free(mhi_cntrl->ev_ring_el_cache, event);
 
 	return ret;
 }
@@ -93,7 +94,8 @@ int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_stat
 	struct mhi_ring_element *event;
 	int ret;
 
-	event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
+	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache,
+				   GFP_KERNEL | GFP_DMA);
 	if (!event)
 		return -ENOMEM;
 
@@ -101,7 +103,7 @@ int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_stat
 	event->dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_STATE_CHANGE_EVENT);
 
 	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
-	kfree(event);
+	kmem_cache_free(mhi_cntrl->ev_ring_el_cache, event);
 
 	return ret;
 }
@@ -111,7 +113,8 @@ int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_e
 	struct mhi_ring_element *event;
 	int ret;
 
-	event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
+	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache,
+				   GFP_KERNEL | GFP_DMA);
 	if (!event)
 		return -ENOMEM;
 
@@ -119,7 +122,7 @@ int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_e
 	event->dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_EE_EVENT);
 
 	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
-	kfree(event);
+	kmem_cache_free(mhi_cntrl->ev_ring_el_cache, event);
 
 	return ret;
 }
@@ -130,7 +133,8 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
 	struct mhi_ring_element *event;
 	int ret;
 
-	event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
+	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache,
+				   GFP_KERNEL | GFP_DMA);
 	if (!event)
 		return -ENOMEM;
 
@@ -139,7 +143,7 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
 	event->dword[1] = MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
 
 	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
-	kfree(event);
+	kmem_cache_free(mhi_cntrl->ev_ring_el_cache, event);
 
 	return ret;
 }
@@ -451,7 +455,7 @@ static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_elem
 		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
 	} else {
 		/* UL channel */
-		result.buf_addr = kzalloc(len, GFP_KERNEL);
+		result.buf_addr = kmem_cache_zalloc(mhi_cntrl->tre_buf_cache, GFP_KERNEL | GFP_DMA);
 		if (!result.buf_addr)
 			return -ENOMEM;
 
@@ -459,7 +463,7 @@ static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_elem
 			ret = mhi_ep_read_channel(mhi_cntrl, ring, &result, len);
 			if (ret < 0) {
 				dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel\n");
-				kfree(result.buf_addr);
+				kmem_cache_free(mhi_cntrl->tre_buf_cache, result.buf_addr);
 				return ret;
 			}
 
@@ -471,7 +475,7 @@ static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_elem
 			/* Read until the ring becomes empty */
 		} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
 
-		kfree(result.buf_addr);
+		kmem_cache_free(mhi_cntrl->tre_buf_cache, result.buf_addr);
 	}
 
 	return 0;
@@ -780,14 +784,14 @@ static void mhi_ep_ch_ring_worker(struct work_struct *work)
 		if (ret) {
 			dev_err(dev, "Error updating write offset for ring\n");
 			mutex_unlock(&chan->lock);
-			kfree(itr);
+			kmem_cache_free(mhi_cntrl->ring_item_cache, itr);
 			continue;
 		}
 
 		/* Sanity check to make sure there are elements in the ring */
 		if (ring->rd_offset == ring->wr_offset) {
 			mutex_unlock(&chan->lock);
-			kfree(itr);
+			kmem_cache_free(mhi_cntrl->ring_item_cache, itr);
 			continue;
 		}
 
@@ -799,12 +803,12 @@ static void mhi_ep_ch_ring_worker(struct work_struct *work)
 			dev_err(dev, "Error processing ring for channel (%u): %d\n",
 				ring->ch_id, ret);
 			mutex_unlock(&chan->lock);
-			kfree(itr);
+			kmem_cache_free(mhi_cntrl->ring_item_cache, itr);
 			continue;
 		}
 
 		mutex_unlock(&chan->lock);
-		kfree(itr);
+		kmem_cache_free(mhi_cntrl->ring_item_cache, itr);
 	}
 }
 
@@ -860,7 +864,7 @@ static void mhi_ep_queue_channel_db(struct mhi_ep_cntrl *mhi_cntrl, unsigned lon
 		u32 ch_id = ch_idx + i;
 
 		ring = &mhi_cntrl->mhi_chan[ch_id].ring;
-		item = kzalloc(sizeof(*item), GFP_ATOMIC);
+		item = kmem_cache_zalloc(mhi_cntrl->ring_item_cache, GFP_ATOMIC);
 		if (!item)
 			return;
 
@@ -1407,6 +1411,29 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_free_ch;
 	}
 
+	mhi_cntrl->ev_ring_el_cache = kmem_cache_create("mhi_ep_event_ring_el",
+							sizeof(struct mhi_ring_element), 0,
+							SLAB_CACHE_DMA, NULL);
+	if (!mhi_cntrl->ev_ring_el_cache) {
+		ret = -ENOMEM;
+		goto err_free_cmd;
+	}
+
+	mhi_cntrl->tre_buf_cache = kmem_cache_create("mhi_ep_tre_buf", MHI_EP_DEFAULT_MTU, 0,
+						      SLAB_CACHE_DMA, NULL);
+	if (!mhi_cntrl->tre_buf_cache) {
+		ret = -ENOMEM;
+		goto err_destroy_ev_ring_el_cache;
+	}
+
+	mhi_cntrl->ring_item_cache = kmem_cache_create("mhi_ep_ring_item",
+							sizeof(struct mhi_ep_ring_item), 0,
+							0, NULL);
+	if (!mhi_cntrl->ev_ring_el_cache) {
+		ret = -ENOMEM;
+		goto err_destroy_tre_buf_cache;
+	}
+
 	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
 	INIT_WORK(&mhi_cntrl->reset_work, mhi_ep_reset_worker);
 	INIT_WORK(&mhi_cntrl->cmd_ring_work, mhi_ep_cmd_ring_worker);
@@ -1415,7 +1442,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	mhi_cntrl->wq = alloc_workqueue("mhi_ep_wq", 0, 0);
 	if (!mhi_cntrl->wq) {
 		ret = -ENOMEM;
-		goto err_free_cmd;
+		goto err_destroy_ring_item_cache;
 	}
 
 	INIT_LIST_HEAD(&mhi_cntrl->st_transition_list);
@@ -1474,6 +1501,12 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
 err_destroy_wq:
 	destroy_workqueue(mhi_cntrl->wq);
+err_destroy_ring_item_cache:
+	kmem_cache_destroy(mhi_cntrl->ring_item_cache);
+err_destroy_ev_ring_el_cache:
+	kmem_cache_destroy(mhi_cntrl->ev_ring_el_cache);
+err_destroy_tre_buf_cache:
+	kmem_cache_destroy(mhi_cntrl->tre_buf_cache);
 err_free_cmd:
 	kfree(mhi_cntrl->mhi_cmd);
 err_free_ch:
@@ -1495,6 +1528,9 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
 
 	free_irq(mhi_cntrl->irq, mhi_cntrl);
 
+	kmem_cache_destroy(mhi_cntrl->tre_buf_cache);
+	kmem_cache_destroy(mhi_cntrl->ev_ring_el_cache);
+	kmem_cache_destroy(mhi_cntrl->ring_item_cache);
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_chan);
 
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index f198a8ac7ee7..ce85d42b685d 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -128,6 +128,9 @@ struct mhi_ep_cntrl {
 	struct work_struct reset_work;
 	struct work_struct cmd_ring_work;
 	struct work_struct ch_ring_work;
+	struct kmem_cache *ring_item_cache;
+	struct kmem_cache *ev_ring_el_cache;
+	struct kmem_cache *tre_buf_cache;
 
 	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
 	int (*alloc_map)(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t *phys_ptr,

base-commit: 12606ba1d46b34a241eb3d0956727e5379f0f626
-- 
2.25.1


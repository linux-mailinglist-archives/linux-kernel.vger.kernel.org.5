Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB47F9FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjK0MrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjK0Mq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:46:29 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F247C19A3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:46:20 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77d5cf15280so225428785a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089180; x=1701693980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP1Q62qn1qYbW0mN98jl6FxqyTfpy980y9btw+6Mx30=;
        b=dIELJ4041EVuJczGWeurU8L6f3gdMe6j44u6lWX+p57v8wlpIArjBeykCj1OFsm31v
         d2LnMa5X1XC2qcNFLBO1Ua4KKYAgpkNqCWc9Z7hiu6ppu7px9/zDhsocGf00oiQmHyIP
         Y3PT7XjK7ppsuMSy5ekb2YhQBVcIUDiJpdCK4/bTCDK2ccekemtl+WXxrX61S76Slspy
         lrSQAvYcTYQf+5wAOGWXdlo8jgEISYJIxK5ZBQKMLuAKNbNY0rKZMpqF81u8mewTrtWz
         BReWI3ksRi7eoNrQIG5Bz2L7LFY/ZVyymqeExrt+/nd4Xw12IA7WRzivaQYcBdA1KcK/
         L1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089180; x=1701693980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XP1Q62qn1qYbW0mN98jl6FxqyTfpy980y9btw+6Mx30=;
        b=EdkUeIeOZ5E39W4OBhjUPFqRyVg9GlXm/K9lnqXru2mFn8QRIBvAGLe+/KqJLbkz+u
         OZMk1bBltAAH8yEuaUN+BZprD6u7oZJWcwZzFGSUwgeaXuZroUHlID0h5elzxMDp28p3
         suF2rlE3M8+NYrcfUANe9ql9FEt9ngoNlk/SKBb4fV2p0fJgYiA+Qe/hO3/4B/qYhkKU
         hS3BqHSIl6agZx7Gb0sUKyfq1kVn4AeMWXUrvlYbGVqvWGAu72yVt7i93Iaz/9WyASbG
         o36L+njOMI8IUaLPTKJIOdt+KZN392+Fx6466pSczPWbfmrBWiRXQvnBKG1dcfXu+1We
         j4nA==
X-Gm-Message-State: AOJu0YyEnsIIP8dKfjdHHitP/HdXlj9/aUNRhvlGCcZD9XTfVtp0MkQN
        4tB4/TAY3ZoKWG91vG853iWm
X-Google-Smtp-Source: AGHT+IEhhSlGm9jGIVtYRxFiZjw7yEzavFBoXCkhJpRjyMEKjMSY70wOHufalLLn6XKMn005Stusaw==
X-Received: by 2002:a05:6214:d8e:b0:67a:3b18:1b1e with SMTP id e14-20020a0562140d8e00b0067a3b181b1emr5073397qve.54.1701089180007;
        Mon, 27 Nov 2023 04:46:20 -0800 (PST)
Received: from localhost.localdomain ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id er10-20020a056214190a00b0067a204b4688sm2832231qvb.18.2023.11.27.04.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:46:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 8/9] bus: mhi: ep: Add support for async DMA read operation
Date:   Mon, 27 Nov 2023 18:15:28 +0530
Message-Id: <20231127124529.78203-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As like the async DMA write operation, let's add support for async DMA read
operation. In the async path, the data will be read from the transfer ring
continuously and when the controller driver notifies the stack using the
completion callback (mhi_ep_read_completion), then the client driver will
be notified with the read data and the completion event will be sent to the
host for the respective ring element (if requested by the host).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 162 +++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 73 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 81d693433a5f..3e599d9640f5 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -338,17 +338,81 @@ bool mhi_ep_queue_is_empty(struct mhi_ep_device *mhi_dev, enum dma_data_directio
 }
 EXPORT_SYMBOL_GPL(mhi_ep_queue_is_empty);
 
+static void mhi_ep_read_completion(struct mhi_ep_buf_info *buf_info)
+{
+	struct mhi_ep_device *mhi_dev = buf_info->mhi_dev;
+	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_ep_chan *mhi_chan = mhi_dev->ul_chan;
+	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
+	struct mhi_ring_element *el = &ring->ring_cache[ring->rd_offset];
+	struct mhi_result result = {};
+	int ret;
+
+	if (mhi_chan->xfer_cb) {
+		result.buf_addr = buf_info->cb_buf;
+		result.dir = mhi_chan->dir;
+		result.bytes_xferd = buf_info->size;
+
+		mhi_chan->xfer_cb(mhi_dev, &result);
+	}
+
+	/*
+	 * The host will split the data packet into multiple TREs if it can't fit
+	 * the packet in a single TRE. In that case, CHAIN flag will be set by the
+	 * host for all TREs except the last one.
+	 */
+	if (buf_info->code != MHI_EV_CC_OVERFLOW) {
+		if (MHI_TRE_DATA_GET_CHAIN(el)) {
+			/*
+			 * IEOB (Interrupt on End of Block) flag will be set by the host if
+			 * it expects the completion event for all TREs of a TD.
+			 */
+			if (MHI_TRE_DATA_GET_IEOB(el)) {
+				ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el,
+							     MHI_TRE_DATA_GET_LEN(el),
+							     MHI_EV_CC_EOB);
+				if (ret < 0) {
+					dev_err(&mhi_chan->mhi_dev->dev,
+						"Error sending transfer compl. event\n");
+					goto err_free_tre_buf;
+				}
+			}
+		} else {
+			/*
+			 * IEOT (Interrupt on End of Transfer) flag will be set by the host
+			 * for the last TRE of the TD and expects the completion event for
+			 * the same.
+			 */
+			if (MHI_TRE_DATA_GET_IEOT(el)) {
+				ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el,
+							     MHI_TRE_DATA_GET_LEN(el),
+							     MHI_EV_CC_EOT);
+				if (ret < 0) {
+					dev_err(&mhi_chan->mhi_dev->dev,
+						"Error sending transfer compl. event\n");
+					goto err_free_tre_buf;
+				}
+			}
+		}
+	}
+
+	mhi_ep_ring_inc_index(ring);
+
+err_free_tre_buf:
+	kmem_cache_free(mhi_cntrl->tre_buf_cache, buf_info->cb_buf);
+}
+
 static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
-				struct mhi_ep_ring *ring,
-				struct mhi_result *result,
-				u32 len)
+			       struct mhi_ep_ring *ring)
 {
 	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	size_t tr_len, read_offset, write_offset;
 	struct mhi_ep_buf_info buf_info = {};
+	u32 len = MHI_EP_DEFAULT_MTU;
 	struct mhi_ring_element *el;
 	bool tr_done = false;
+	void *buf_addr;
 	u32 buf_left;
 	int ret;
 
@@ -378,83 +442,50 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 		read_offset = mhi_chan->tre_size - mhi_chan->tre_bytes_left;
 		write_offset = len - buf_left;
 
+		buf_addr = kmem_cache_zalloc(mhi_cntrl->tre_buf_cache, GFP_KERNEL | GFP_DMA);
+		if (!buf_addr)
+			return -ENOMEM;
+
 		buf_info.host_addr = mhi_chan->tre_loc + read_offset;
-		buf_info.dev_addr = result->buf_addr + write_offset;
+		buf_info.dev_addr = buf_addr + write_offset;
 		buf_info.size = tr_len;
+		buf_info.cb = mhi_ep_read_completion;
+		buf_info.cb_buf = buf_addr;
+		buf_info.mhi_dev = mhi_chan->mhi_dev;
+
+		if (mhi_chan->tre_bytes_left - tr_len)
+			buf_info.code = MHI_EV_CC_OVERFLOW;
 
 		dev_dbg(dev, "Reading %zd bytes from channel (%u)\n", tr_len, ring->ch_id);
-		ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
+		ret = mhi_cntrl->read_async(mhi_cntrl, &buf_info);
 		if (ret < 0) {
 			dev_err(&mhi_chan->mhi_dev->dev, "Error reading from channel\n");
-			return ret;
+			goto err_free_buf_addr;
 		}
 
 		buf_left -= tr_len;
 		mhi_chan->tre_bytes_left -= tr_len;
 
-		/*
-		 * Once the TRE (Transfer Ring Element) of a TD (Transfer Descriptor) has been
-		 * read completely:
-		 *
-		 * 1. Send completion event to the host based on the flags set in TRE.
-		 * 2. Increment the local read offset of the transfer ring.
-		 */
 		if (!mhi_chan->tre_bytes_left) {
-			/*
-			 * The host will split the data packet into multiple TREs if it can't fit
-			 * the packet in a single TRE. In that case, CHAIN flag will be set by the
-			 * host for all TREs except the last one.
-			 */
-			if (MHI_TRE_DATA_GET_CHAIN(el)) {
-				/*
-				 * IEOB (Interrupt on End of Block) flag will be set by the host if
-				 * it expects the completion event for all TREs of a TD.
-				 */
-				if (MHI_TRE_DATA_GET_IEOB(el)) {
-					ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el,
-								     MHI_TRE_DATA_GET_LEN(el),
-								     MHI_EV_CC_EOB);
-					if (ret < 0) {
-						dev_err(&mhi_chan->mhi_dev->dev,
-							"Error sending transfer compl. event\n");
-						return ret;
-					}
-				}
-			} else {
-				/*
-				 * IEOT (Interrupt on End of Transfer) flag will be set by the host
-				 * for the last TRE of the TD and expects the completion event for
-				 * the same.
-				 */
-				if (MHI_TRE_DATA_GET_IEOT(el)) {
-					ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el,
-								     MHI_TRE_DATA_GET_LEN(el),
-								     MHI_EV_CC_EOT);
-					if (ret < 0) {
-						dev_err(&mhi_chan->mhi_dev->dev,
-							"Error sending transfer compl. event\n");
-						return ret;
-					}
-				}
-
+			if (MHI_TRE_DATA_GET_IEOT(el))
 				tr_done = true;
-			}
 
 			mhi_chan->rd_offset = (mhi_chan->rd_offset + 1) % ring->ring_size;
-			mhi_ep_ring_inc_index(ring);
 		}
-
-		result->bytes_xferd += tr_len;
 	} while (buf_left && !tr_done);
 
 	return 0;
+
+err_free_buf_addr:
+	kmem_cache_free(mhi_cntrl->tre_buf_cache, buf_addr);
+
+	return ret;
 }
 
-static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_element *el)
+static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring)
 {
 	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
 	struct mhi_result result = {};
-	u32 len = MHI_EP_DEFAULT_MTU;
 	struct mhi_ep_chan *mhi_chan;
 	int ret;
 
@@ -475,27 +506,15 @@ static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_elem
 		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
 	} else {
 		/* UL channel */
-		result.buf_addr = kmem_cache_zalloc(mhi_cntrl->tre_buf_cache, GFP_KERNEL | GFP_DMA);
-		if (!result.buf_addr)
-			return -ENOMEM;
-
 		do {
-			ret = mhi_ep_read_channel(mhi_cntrl, ring, &result, len);
+			ret = mhi_ep_read_channel(mhi_cntrl, ring);
 			if (ret < 0) {
 				dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel\n");
-				kmem_cache_free(mhi_cntrl->tre_buf_cache, result.buf_addr);
 				return ret;
 			}
 
-			result.dir = mhi_chan->dir;
-			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
-			result.bytes_xferd = 0;
-			memset(result.buf_addr, 0, len);
-
 			/* Read until the ring becomes empty */
 		} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
-
-		kmem_cache_free(mhi_cntrl->tre_buf_cache, result.buf_addr);
 	}
 
 	return 0;
@@ -804,7 +823,6 @@ static void mhi_ep_ch_ring_worker(struct work_struct *work)
 	struct mhi_ep_cntrl *mhi_cntrl = container_of(work, struct mhi_ep_cntrl, ch_ring_work);
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	struct mhi_ep_ring_item *itr, *tmp;
-	struct mhi_ring_element *el;
 	struct mhi_ep_ring *ring;
 	struct mhi_ep_chan *chan;
 	unsigned long flags;
@@ -849,10 +867,8 @@ static void mhi_ep_ch_ring_worker(struct work_struct *work)
 			continue;
 		}
 
-		el = &ring->ring_cache[ring->rd_offset];
-
 		dev_dbg(dev, "Processing the ring for channel (%u)\n", ring->ch_id);
-		ret = mhi_ep_process_ch_ring(ring, el);
+		ret = mhi_ep_process_ch_ring(ring);
 		if (ret) {
 			dev_err(dev, "Error processing ring for channel (%u): %d\n",
 				ring->ch_id, ret);
-- 
2.25.1


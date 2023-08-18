Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE47809A6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359816AbjHRKF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359773AbjHRKEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:04:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5504498;
        Fri, 18 Aug 2023 03:04:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-688769faa09so603162b3a.2;
        Fri, 18 Aug 2023 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692353006; x=1692957806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LuwoXzqDhTTyykuDON+t5EEWRJc0IM7y1UrzbkNw3g=;
        b=MylJ76JvV95j9vrmsi7p/9NfmZayQ7buTuIm4It68i9VsEfR3OPERAIfAd53x8pZhj
         mg47pkM83fPEHV3GNdAeHfweP686VlrPQIDrnfMBz5EB5rk/CQQ8iGnq6s3cwyK7M3v9
         gO1VmNCKtMCbl9IjA+rVn/KOn/hOGAwRKKhnrNah1hxhsrDvYVj1oRj2knMq5H4SoiXl
         87Q6C6nzmaw/qBCP1WPiIFeeHMRUE+Gl331vj4EaPsbRNYE0LTVmXp7Ikbxpb4fTY3Z/
         OIdwZZMIOQGY4CnXXQN1y/qDvg5lhqqpceE8hJYrdvNkK0+vsxvBl4ShJpGTFteBIZ67
         EeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692353006; x=1692957806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LuwoXzqDhTTyykuDON+t5EEWRJc0IM7y1UrzbkNw3g=;
        b=k6ngGmsZV1laeP2LPLOqnX2UCI4wD2fOnVbScHMoE+4aNK60a+P/wZKoct4qgpm6ex
         6fvWXGZLun4zG4sxQGlQv5Uw6MLteg1fVoLQaNdbVK0LaWwcroH8h7cYlCddqtrO1nNE
         4ZzZ4z1PrMXoMPFz0bMlkSzrivab51bLIWLqCiDVJlQupYjkhESrwTWUwtemi8wm2lLf
         cS3yYBCHQ/CcKqd6tbkYErPsVfb2Y5LE0MDJpm6NesXHyVdRlsg2eYv9cjl7kbIx7TrM
         S8U2BkWo+1iLnnRbmwgglkpr2WQiP2aSUhGJHJ6srnJZgXGdI+uMquE9FuTiS7KJSE3+
         RuYg==
X-Gm-Message-State: AOJu0Ywt6RHN6OO31H5wig34IzMuBPZ08uxAymaGVQ9qaY9AnHzhq9kF
        +9rQip5hexFU8goFSJrGBdFv2eNz8oU=
X-Google-Smtp-Source: AGHT+IH5AnYqydZhAEqCZlg/9XE/czEh8OtTQVSsGI2yV+bcRZo/P3PDqY5Hdo5HjJ9+B+FSU/FBEw==
X-Received: by 2002:a05:6a20:510:b0:140:3775:3086 with SMTP id 16-20020a056a20051000b0014037753086mr2026139pzp.59.1692353005847;
        Fri, 18 Aug 2023 03:03:25 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-55ec-ad14-f925-5202-a39b.emome-ip6.hinet.net. [2001:b400:e25c:55ec:ad14:f925:5202:a39b])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b006870ccfbb54sm1180649pff.196.2023.08.18.03.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:03:25 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V10 19/23] mmc: sdhci-uhs2: add irq() and others
Date:   Fri, 18 Aug 2023 18:02:13 +0800
Message-Id: <20230818100217.12725-20-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818100217.12725-1-victorshihgli@gmail.com>
References: <20230818100217.12725-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a UHS-II version of sdhci's request() operation.
It handles UHS-II related command interrupts and errors.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Updates in V9:
 - Cancel export state of sdhci_set_mrq_done() function.

Updates in V8:
 - Forward declare struct mmc_request in sdhci_uhs2.h.
 - Remove forward declaration of sdhci_send_command().
 - Use mmc_dev() to simplify code in sdhci_request_done_dma().

Updates in V7:
 - Remove unnecessary functions.
 - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_irq().
 - Modify descriptions in sdhci_uhs2_irq().
 - Cancel export state of some functions.

Updates in V6:
 - Remove unnecessary functions.
 - Add sdhci_uhs2_mode() in sdhci_uhs2_complete_work().
 - Add sdhci_uhs2_mode() in sdhci_uhs2_thread_irq().

---

 drivers/mmc/host/sdhci-uhs2.c | 215 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   4 +
 drivers/mmc/host/sdhci.c      |  99 +++++++++-------
 drivers/mmc/host/sdhci.h      |   4 +
 4 files changed, 277 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 08fef7174239..8d1be670af49 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -782,6 +782,221 @@ static void sdhci_uhs2_finish_command(struct sdhci_host *host)
 		__sdhci_finish_mrq(host, cmd->mrq);
 }
 
+/*****************************************************************************\
+ *                                                                           *
+ * Request done                                                              *
+ *                                                                           *
+\*****************************************************************************/
+
+static bool sdhci_uhs2_request_done(struct sdhci_host *host)
+{
+	unsigned long flags;
+	struct mmc_request *mrq;
+	int i;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
+		mrq = host->mrqs_done[i];
+		if (mrq)
+			break;
+	}
+
+	if (!mrq) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return true;
+	}
+
+	/*
+	 * Always unmap the data buffers if they were mapped by
+	 * sdhci_prepare_data() whenever we finish with a request.
+	 * This avoids leaking DMA mappings on error.
+	 */
+	if (host->flags & SDHCI_REQ_USE_DMA)
+		sdhci_request_done_dma(host, mrq);
+
+	/*
+	 * The controller needs a reset of internal state machines
+	 * upon error conditions.
+	 */
+	if (sdhci_needs_reset(host, mrq)) {
+		/*
+		 * Do not finish until command and data lines are available for
+		 * reset. Note there can only be one other mrq, so it cannot
+		 * also be in mrqs_done, otherwise host->cmd and host->data_cmd
+		 * would both be null.
+		 */
+		if (host->cmd || host->data_cmd) {
+			spin_unlock_irqrestore(&host->lock, flags);
+			return true;
+		}
+
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+		host->pending_reset = false;
+	}
+
+	host->mrqs_done[i] = NULL;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (host->ops->request_done)
+		host->ops->request_done(host, mrq);
+	else
+		mmc_request_done(host->mmc, mrq);
+
+	return false;
+}
+
+static void sdhci_uhs2_complete_work(struct work_struct *work)
+{
+	struct sdhci_host *host = container_of(work, struct sdhci_host,
+					       complete_work);
+
+	if (!sdhci_uhs2_mode(host)) {
+		sdhci_complete_work(work);
+		return;
+	}
+
+	while (!sdhci_uhs2_request_done(host))
+		;
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * Interrupt handling                                                        *
+ *                                                                           *
+\*****************************************************************************/
+
+static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
+{
+	struct mmc_command *cmd = host->cmd;
+
+	DBG("*** %s got UHS2 error interrupt: 0x%08x\n",
+	    mmc_hostname(host->mmc), uhs2mask);
+
+	if (uhs2mask & SDHCI_UHS2_INT_CMD_ERR_MASK) {
+		if (!host->cmd) {
+			pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\n",
+			       mmc_hostname(host->mmc),
+			       (unsigned int)uhs2mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+		host->cmd->error = -EILSEQ;
+		if (uhs2mask & SDHCI_UHS2_INT_CMD_TIMEOUT)
+			host->cmd->error = -ETIMEDOUT;
+	}
+
+	if (uhs2mask & SDHCI_UHS2_INT_DATA_ERR_MASK) {
+		if (!host->data) {
+			pr_err("%s: Got data interrupt 0x%08x but no data.\n",
+			       mmc_hostname(host->mmc),
+			       (unsigned int)uhs2mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+
+		if (uhs2mask & SDHCI_UHS2_INT_DEADLOCK_TIMEOUT) {
+			pr_err("%s: Got deadlock timeout interrupt 0x%08x\n",
+			       mmc_hostname(host->mmc),
+			       (unsigned int)uhs2mask);
+			host->data->error = -ETIMEDOUT;
+		} else if (uhs2mask & SDHCI_UHS2_INT_ADMA_ERROR) {
+			pr_err("%s: ADMA error = 0x %x\n",
+			       mmc_hostname(host->mmc),
+			       sdhci_readb(host, SDHCI_ADMA_ERROR));
+			host->data->error = -EIO;
+		} else {
+			host->data->error = -EILSEQ;
+		}
+	}
+
+	if (host->data && host->data->error)
+		sdhci_uhs2_finish_data(host);
+	else
+		sdhci_finish_mrq(host, cmd->mrq);
+}
+
+u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask)
+{
+	u32 mask = intmask, uhs2mask;
+
+	if (!sdhci_uhs2_mode(host))
+		goto out;
+
+	if (intmask & SDHCI_INT_ERROR) {
+		uhs2mask = sdhci_readl(host, SDHCI_UHS2_INT_STATUS);
+		if (!(uhs2mask & SDHCI_UHS2_INT_ERROR_MASK))
+			goto cmd_irq;
+
+		/* Clear error interrupts */
+		sdhci_writel(host, uhs2mask & SDHCI_UHS2_INT_ERROR_MASK,
+			     SDHCI_UHS2_INT_STATUS);
+
+		/* Handle error interrupts */
+		__sdhci_uhs2_irq(host, uhs2mask);
+
+		/* Caller, sdhci_irq(), doesn't have to care about UHS-2 errors */
+		intmask &= ~SDHCI_INT_ERROR;
+		mask &= SDHCI_INT_ERROR;
+	}
+
+cmd_irq:
+	if (intmask & SDHCI_INT_CMD_MASK) {
+		/* Clear command interrupt */
+		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_INT_STATUS);
+
+		/* Handle command interrupt */
+		if (intmask & SDHCI_INT_RESPONSE)
+			sdhci_uhs2_finish_command(host);
+
+		/* Caller, sdhci_irq(), doesn't have to care about UHS-2 commands */
+		intmask &= ~SDHCI_INT_CMD_MASK;
+		mask &= SDHCI_INT_CMD_MASK;
+	}
+
+	/* Clear already-handled interrupts. */
+	sdhci_writel(host, mask, SDHCI_INT_STATUS);
+
+out:
+	return intmask;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_irq);
+
+static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
+{
+	struct sdhci_host *host = dev_id;
+	struct mmc_command *cmd;
+	unsigned long flags;
+	u32 isr;
+
+	if (!sdhci_uhs2_mode(host))
+		return sdhci_thread_irq(irq, dev_id);
+
+	while (!sdhci_uhs2_request_done(host))
+		;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	isr = host->thread_isr;
+	host->thread_isr = 0;
+
+	cmd = host->deferred_cmd;
+	if (cmd && !sdhci_uhs2_send_command_retry(host, cmd, flags))
+		sdhci_finish_mrq(host, cmd->mrq);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
+		struct mmc_host *mmc = host->mmc;
+
+		mmc->ops->card_event(mmc);
+		mmc_detect_change(mmc, msecs_to_jiffies(200));
+	}
+
+	return IRQ_HANDLED;
+}
+
 void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index a3641c5f8c77..3aa2cb4b39d6 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -176,11 +176,15 @@
 
 struct sdhci_host;
 struct mmc_command;
+struct mmc_request;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 bool sdhci_uhs2_mode(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
+void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
+int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
+u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9d031e83b6ba..318d4830732f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1497,7 +1497,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
 }
 
-static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
+bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	return (!(host->flags & SDHCI_DEVICE_DEAD) &&
 		((mrq->cmd && mrq->cmd->error) ||
@@ -1505,6 +1505,7 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 		 (mrq->data && mrq->data->stop && mrq->data->stop->error) ||
 		 (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
 }
+EXPORT_SYMBOL_GPL(sdhci_needs_reset);
 
 static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
 {
@@ -3110,6 +3111,53 @@ static const struct mmc_host_ops sdhci_ops = {
  *                                                                           *
 \*****************************************************************************/
 
+void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	struct mmc_data *data = mrq->data;
+
+	if (data && data->host_cookie == COOKIE_MAPPED) {
+		if (host->bounce_buffer) {
+			/*
+			 * On reads, copy the bounced data into the
+			 * sglist
+			 */
+			if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
+				unsigned int length = data->bytes_xfered;
+
+				if (length > host->bounce_buffer_size) {
+					pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
+					       mmc_hostname(host->mmc),
+					       host->bounce_buffer_size,
+					       data->bytes_xfered);
+					/* Cap it down and continue */
+					length = host->bounce_buffer_size;
+				}
+				dma_sync_single_for_cpu(mmc_dev(host->mmc),
+							host->bounce_addr,
+							host->bounce_buffer_size,
+							DMA_FROM_DEVICE);
+				sg_copy_from_buffer(data->sg,
+						    data->sg_len,
+						    host->bounce_buffer,
+						    length);
+			} else {
+				/* No copying, just switch ownership */
+				dma_sync_single_for_cpu(mmc_dev(host->mmc),
+							host->bounce_addr,
+							host->bounce_buffer_size,
+							mmc_get_dma_dir(data));
+			}
+		} else {
+			/* Unmap the raw data */
+			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+				     data->sg_len,
+				     mmc_get_dma_dir(data));
+		}
+		data->host_cookie = COOKIE_UNMAPPED;
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_request_done_dma);
+
 static bool sdhci_request_done(struct sdhci_host *host)
 {
 	unsigned long flags;
@@ -3174,48 +3222,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 			sdhci_set_mrq_done(host, mrq);
 		}
 
-		if (data && data->host_cookie == COOKIE_MAPPED) {
-			if (host->bounce_buffer) {
-				/*
-				 * On reads, copy the bounced data into the
-				 * sglist
-				 */
-				if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
-					unsigned int length = data->bytes_xfered;
-
-					if (length > host->bounce_buffer_size) {
-						pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
-						       mmc_hostname(host->mmc),
-						       host->bounce_buffer_size,
-						       data->bytes_xfered);
-						/* Cap it down and continue */
-						length = host->bounce_buffer_size;
-					}
-					dma_sync_single_for_cpu(
-						mmc_dev(host->mmc),
-						host->bounce_addr,
-						host->bounce_buffer_size,
-						DMA_FROM_DEVICE);
-					sg_copy_from_buffer(data->sg,
-						data->sg_len,
-						host->bounce_buffer,
-						length);
-				} else {
-					/* No copying, just switch ownership */
-					dma_sync_single_for_cpu(
-						mmc_dev(host->mmc),
-						host->bounce_addr,
-						host->bounce_buffer_size,
-						mmc_get_dma_dir(data));
-				}
-			} else {
-				/* Unmap the raw data */
-				dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-					     data->sg_len,
-					     mmc_get_dma_dir(data));
-			}
-			data->host_cookie = COOKIE_UNMAPPED;
-		}
+		sdhci_request_done_dma(host, mrq);
 	}
 
 	host->mrqs_done[i] = NULL;
@@ -3230,7 +3237,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 	return false;
 }
 
-static void sdhci_complete_work(struct work_struct *work)
+void sdhci_complete_work(struct work_struct *work)
 {
 	struct sdhci_host *host = container_of(work, struct sdhci_host,
 					       complete_work);
@@ -3238,6 +3245,7 @@ static void sdhci_complete_work(struct work_struct *work)
 	while (!sdhci_request_done(host))
 		;
 }
+EXPORT_SYMBOL_GPL(sdhci_complete_work);
 
 static void sdhci_timeout_timer(struct timer_list *t)
 {
@@ -3693,7 +3701,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	return result;
 }
 
-static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
+irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 {
 	struct sdhci_host *host = dev_id;
 	struct mmc_command *cmd;
@@ -3723,6 +3731,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(sdhci_thread_irq);
 
 /*****************************************************************************\
  *                                                                           *
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 9a2bd319d94c..6bbb9f073f29 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -832,6 +832,7 @@ bool sdhci_data_line_cmd(struct mmc_command *cmd);
 void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
 void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
 void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
+bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq);
 void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
 void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
 void __sdhci_finish_data_common(struct sdhci_host *host);
@@ -861,6 +862,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
+void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
+void sdhci_complete_work(struct work_struct *work);
+irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 			   dma_addr_t addr, int len, unsigned int cmd);
 
-- 
2.25.1


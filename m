Return-Path: <linux-kernel+bounces-97204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4988766F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCD31F22538
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67730539C;
	Fri,  8 Mar 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TxkB2Sqe"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5905240;
	Fri,  8 Mar 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910142; cv=none; b=smg/sSDJySGPlQ/9UtdA1c38pWkD1YwXpOVet218ap83M5KZghB14OT7U6L0imSIGacnsVqPF+eO3H6gB9fc6pU7GcKGJofQw7NtfIUbRqUB0ZWVebSXzIOF5ZSPleYcxyizox2i9kPdRqYsfI7nkCake4lJECJx2EN3uIBpa/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910142; c=relaxed/simple;
	bh=p2xXxWzmHRR8ubLL8Uhn4Vd4jVUhgBUQLBtzq+ip1C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsz6vEsDpre/dMl8sPvg6P1wktiSx2hSjqqwosF418wPWYPRw0BOc2Zwbjisyck5euuKb+gpbZysxlWo/2Qmz+AqE83r+vVhnYkMrd0TyOvt3zli+wLkzFetCK2E59W/4B/9fL0M5aEqf4wuJDGjRIozF7u49tXvsf76hR+Gr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TxkB2Sqe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709910138;
	bh=p2xXxWzmHRR8ubLL8Uhn4Vd4jVUhgBUQLBtzq+ip1C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TxkB2SqeNU8wcwg+bXmXXjCBsKQFBmOaA87J91i8w1AED8TJVOWGirid1zNoHyqoq
	 8y/T5eyGy7+H+TU1G9ZY6iuXSBMLeB3GHNPYNWxA59iag9Nq4h6npObDF+smKMe4lG
	 07+i4dc3xEfkLbVHTQt+DB64PIdnVNkYtHPHV0EEo9oa1UWjHej4F7iBje2Plct2sO
	 LDxWX3rlPof3ylcXbmi6SnIyG0GazX5L+qHdkixzm5UE43cRhmsJ/eu2EZ8ypTTEiM
	 fdL4QYt8vGl24YVIZbTcbnzAlZwuQf1zmtQJdPE0BrI6rfmMl0cagj15OE2RdHPUH1
	 OW0kSKjpDUt6w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0E76637820F1;
	Fri,  8 Mar 2024 15:02:18 +0000 (UTC)
Date: Fri, 8 Mar 2024 16:02:17 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: nas.chung@chipsnmedia.com, jackson.lee@chipsnmedia.com,
	mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, nm@ti.com, praneeth@ti.com,
	vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com, b-brnich@ti.com,
	detheridge@ti.com, p-mantena@ti.com, vijayp@ti.com
Subject: Re: [PATCH v2] media: chips-media: wave5: Add hrtimer based polling
 support
Message-ID: <20240308150217.5jy3roywvv2trd2f@basti-XPS-13-9310>
References: <20240305160529.4152865-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240305160529.4152865-1-devarsht@ti.com>

Hey Devarsh,

Alright, overall this looks good and it is tested, it is not my favorite
solution but I don't want you to force doing something experimental just
to satisfy my wish for a cleaner driver.
I have opened a question on the mailing list: https://lkml.org/lkml/2024/3/8/785
And then we (the media subsystem & irqchip subsystem) can develop a clean
solution afterward, as this problem seems not to be limited to just this driver.

Greetings,
Sebastian

On 05.03.2024 21:35, Devarsh Thakkar wrote:
>Add support for starting a polling timer in case an interrupt is not
>available. This helps to keep the VPU functional in SoCs such as AM62A,
>where the hardware interrupt hookup may not be present due to an SoC errata
>[1].
>
>The timer is shared across all instances of encoders and decoders and is
>started when the first instance of an encoder or decoder is opened and
>stopped when the last instance is closed, thus avoiding per instance
>polling and saving CPU bandwidth. As VPU driver manages this instance
>related tracking and synchronization, the aforementioned shared timer
>related polling logic is implemented within the VPU driver itself. This
>scheme may also be useful in general too (even if irq is present) for
>non-realtime multi-instance VPU use-cases (for e.g 32 instances of VPU
>being run together) where system is running already under high interrupt
>load and switching to polling may help mitigate this as the polling thread
>is shared across all the VPU instances.
>
>Hrtimer is chosen for polling here as it provides precise timing and
>scheduling and the API seems better suited for periodic polling task such
>as this.  As a general rule of thumb,
>
>Worst case latency with hrtimer = Actual latency (achievable with irq)
>                                  + Polling interval
>
>NOTE (the meaning of terms used above is as follows):
>- Latency: Time taken to process one frame
>- Actual Latency : Time taken by hardware to process one frame and signal
>  it to OS (i.e. if latency that was possible to achieve if irq line was
>present)
>
>There is a trade-off between latency and CPU usage when deciding the value
>for polling interval. With aggressive polling intervals (i.e. going with
>even lesser values) the CPU usage increases although worst case latencies
>get better. On the contrary, with greater polling intervals worst case
>latencies will increase although the CPU usage will decrease.
>
>The 5ms offered a good balance between the two as we were able to reach
>close to actual latencies (as achievable with irq) without incurring too
>much of CPU as seen in below experiments and thus 5ms is chosen as default
>polling interval.
>
>- 1x 640x480@25 Encoding using different hrtimer polling intervals [2]
>- 4x 1080p30 Transcode (File->decode->encode->file) irq vs polling
>  comparison [3]
>- 1x 1080p Transcode (File->decode->encode->file) irq vs polling comparison
>  [4]
>- 1080p60 Streaming use-case irq vs polling comparison [5]
>- 1x 1080p30 sanity decode and encode tests [6]
>
>The polling interval can also be changed using vpu_poll_interval module
>param in case user want to change it as per their use-case requirement
>keeping in mind above trade-off.
>
>Based on interrupt status, we use a worker thread to iterate over the
>interrupt status for each instance and send completion event as being done
>in irq thread function.
>
>Move the core functionality of the irq thread function to a separate
>function wave5_vpu_handle_irq so that it can be used by both the worker
>thread when using polling mode and irq thread when using interrupt mode.
>
>Protect the hrtimer access and instance list with device specific mutex
>locks to avoid race conditions while different instances of encoder and
>decoder are started together.
>
>[1] https://www.ti.com/lit/pdf/spruj16
>(Ref: Section 4.2.3.3 Resets, Interrupts, and Clocks)
>[2] https://gist.github.com/devarsht/ee9664d3403d1212ef477a027b71896c
>[3] https://gist.github.com/devarsht/3a58b4f201430dfc61697c7e224e74c2
>[4] https://gist.github.com/devarsht/a6480f1f2cbdf8dd694d698309d81fb0
>[5] https://gist.github.com/devarsht/44aaa4322454e85e01a8d65ac47c5edb
>[6] https://gist.github.com/devarsht/2f956bcc6152dba728ce08cebdcebe1d
>
>Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>Tested-by: Jackson Lee <jackson.lee@chipsnmedia.com>
>---
>V2:
>- Update commit message as suggested in review to give more context
>  on design being chosen and analysis that was done to decide on same
>- Add Tested-By
>- Remove extra return variable declaration from wave5_vpu_release_device
>
>Range diff w.r.t v1 :
>https://gist.github.com/devarsht/cd6bbb4ba90b0229be4718b7140ef924
>---
> .../platform/chips-media/wave5/wave5-helper.c |  17 ++-
> .../chips-media/wave5/wave5-vpu-dec.c         |  13 +-
> .../chips-media/wave5/wave5-vpu-enc.c         |  13 +-
> .../platform/chips-media/wave5/wave5-vpu.c    | 117 ++++++++++++------
> .../platform/chips-media/wave5/wave5-vpuapi.h |   4 +
> 5 files changed, 122 insertions(+), 42 deletions(-)
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>index 8433ecab230c..0b1b5a11e15b 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>@@ -52,11 +52,12 @@ int wave5_vpu_release_device(struct file *filp,
> 			     char *name)
> {
> 	struct vpu_instance *inst = wave5_to_vpu_inst(filp->private_data);
>+	struct vpu_device *dev = inst->dev;
>+	int ret;
>
> 	v4l2_m2m_ctx_release(inst->v4l2_fh.m2m_ctx);
> 	if (inst->state != VPU_INST_STATE_NONE) {
> 		u32 fail_res;
>-		int ret;
>
> 		ret = close_func(inst, &fail_res);
> 		if (fail_res == WAVE5_SYSERR_VPU_STILL_RUNNING) {
>@@ -71,8 +72,20 @@ int wave5_vpu_release_device(struct file *filp,
> 	}
>
> 	wave5_cleanup_instance(inst);
>+	if (dev->irq < 0) {
>+		ret = mutex_lock_interruptible(&dev->dev_lock);
>+		if (ret)
>+			return ret;
>
>-	return 0;
>+		if (list_empty(&dev->instances)) {
>+			dev_dbg(dev->dev, "Disabling the hrtimer\n");
>+			hrtimer_cancel(&dev->hrtimer);
>+		}
>+
>+		mutex_unlock(&dev->dev_lock);
>+	}
>+
>+	return ret;
> }
>
> int wave5_vpu_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq,
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>index ef227af72348..c8624c681fa6 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>@@ -1810,7 +1810,6 @@ static int wave5_vpu_open_dec(struct file *filp)
> 	v4l2_fh_add(&inst->v4l2_fh);
>
> 	INIT_LIST_HEAD(&inst->list);
>-	list_add_tail(&inst->list, &dev->instances);
>
> 	inst->v4l2_m2m_dev = inst->dev->v4l2_m2m_dec_dev;
> 	inst->v4l2_fh.m2m_ctx =
>@@ -1867,6 +1866,18 @@ static int wave5_vpu_open_dec(struct file *filp)
>
> 	wave5_vdi_allocate_sram(inst->dev);
>
>+	ret = mutex_lock_interruptible(&dev->dev_lock);
>+	if (ret)
>+		goto cleanup_inst;
>+
>+	if (dev->irq < 0 && !hrtimer_active(&dev->hrtimer) && list_empty(&dev->instances))
>+		hrtimer_start(&dev->hrtimer, ns_to_ktime(dev->vpu_poll_interval * NSEC_PER_MSEC),
>+			      HRTIMER_MODE_REL_PINNED);
>+
>+	list_add_tail(&inst->list, &dev->instances);
>+
>+	mutex_unlock(&dev->dev_lock);
>+
> 	return 0;
>
> cleanup_inst:
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>index f29cfa3af94a..9e88424761b6 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>@@ -1554,7 +1554,6 @@ static int wave5_vpu_open_enc(struct file *filp)
> 	v4l2_fh_add(&inst->v4l2_fh);
>
> 	INIT_LIST_HEAD(&inst->list);
>-	list_add_tail(&inst->list, &dev->instances);
>
> 	inst->v4l2_m2m_dev = inst->dev->v4l2_m2m_enc_dev;
> 	inst->v4l2_fh.m2m_ctx =
>@@ -1729,6 +1728,18 @@ static int wave5_vpu_open_enc(struct file *filp)
>
> 	wave5_vdi_allocate_sram(inst->dev);
>
>+	ret = mutex_lock_interruptible(&dev->dev_lock);
>+	if (ret)
>+		goto cleanup_inst;
>+
>+	if (dev->irq < 0 && !hrtimer_active(&dev->hrtimer) && list_empty(&dev->instances))
>+		hrtimer_start(&dev->hrtimer, ns_to_ktime(dev->vpu_poll_interval * NSEC_PER_MSEC),
>+			      HRTIMER_MODE_REL_PINNED);
>+
>+	list_add_tail(&inst->list, &dev->instances);
>+
>+	mutex_unlock(&dev->dev_lock);
>+
> 	return 0;
>
> cleanup_inst:
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>index 0d90b5820bef..257c5e226129 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>@@ -26,6 +26,9 @@ struct wave5_match_data {
> 	const char *fw_name;
> };
>
>+static int vpu_poll_interval = 5;
>+module_param(vpu_poll_interval, int, 0644);
>+
> int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout)
> {
> 	int ret;
>@@ -40,7 +43,7 @@ int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout)
> 	return 0;
> }
>
>-static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
>+static void wave5_vpu_handle_irq(void *dev_id)
> {
> 	u32 seq_done;
> 	u32 cmd_done;
>@@ -48,42 +51,67 @@ static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
> 	struct vpu_instance *inst;
> 	struct vpu_device *dev = dev_id;
>
>-	if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS)) {
>-		irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
>-		wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
>-		wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
>-
>-		list_for_each_entry(inst, &dev->instances, list) {
>-			seq_done = wave5_vdi_read_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
>-			cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
>-
>-			if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
>-			    irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
>-				if (seq_done & BIT(inst->id)) {
>-					seq_done &= ~BIT(inst->id);
>-					wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO,
>-								 seq_done);
>-					complete(&inst->irq_done);
>-				}
>+	irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
>+	wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
>+	wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
>+
>+	list_for_each_entry(inst, &dev->instances, list) {
>+		seq_done = wave5_vdi_read_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
>+		cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
>+
>+		if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
>+		    irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
>+			if (seq_done & BIT(inst->id)) {
>+				seq_done &= ~BIT(inst->id);
>+				wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO,
>+							 seq_done);
>+				complete(&inst->irq_done);
> 			}
>+		}
>
>-			if (irq_reason & BIT(INT_WAVE5_DEC_PIC) ||
>-			    irq_reason & BIT(INT_WAVE5_ENC_PIC)) {
>-				if (cmd_done & BIT(inst->id)) {
>-					cmd_done &= ~BIT(inst->id);
>-					wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST,
>-								 cmd_done);
>-					inst->ops->finish_process(inst);
>-				}
>+		if (irq_reason & BIT(INT_WAVE5_DEC_PIC) ||
>+		    irq_reason & BIT(INT_WAVE5_ENC_PIC)) {
>+			if (cmd_done & BIT(inst->id)) {
>+				cmd_done &= ~BIT(inst->id);
>+				wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST,
>+							 cmd_done);
>+				inst->ops->finish_process(inst);
> 			}
>-
>-			wave5_vpu_clear_interrupt(inst, irq_reason);
> 		}
>+
>+		wave5_vpu_clear_interrupt(inst, irq_reason);
> 	}
>+}
>+
>+static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
>+{
>+	struct vpu_device *dev = dev_id;
>+
>+	if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS))
>+		wave5_vpu_handle_irq(dev);
>
> 	return IRQ_HANDLED;
> }
>
>+static void wave5_vpu_irq_work_fn(struct kthread_work *work)
>+{
>+	struct vpu_device *dev = container_of(work, struct vpu_device, work);
>+
>+	if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS))
>+		wave5_vpu_handle_irq(dev);
>+}
>+
>+static enum hrtimer_restart wave5_vpu_timer_callback(struct hrtimer *timer)
>+{
>+	struct vpu_device *dev =
>+			container_of(timer, struct vpu_device, hrtimer);
>+
>+	kthread_queue_work(dev->worker, &dev->work);
>+	hrtimer_forward_now(timer, ns_to_ktime(vpu_poll_interval * NSEC_PER_MSEC));
>+
>+	return HRTIMER_RESTART;
>+}
>+
> static int wave5_vpu_load_firmware(struct device *dev, const char *fw_name,
> 				   u32 *revision)
> {
>@@ -209,16 +237,24 @@ static int wave5_vpu_probe(struct platform_device *pdev)
>
> 	dev->irq = platform_get_irq(pdev, 0);
> 	if (dev->irq < 0) {
>-		dev_err(&pdev->dev, "failed to get irq resource\n");
>-		ret = -ENXIO;
>-		goto err_enc_unreg;
>-	}
>-
>-	ret = devm_request_threaded_irq(&pdev->dev, dev->irq, NULL,
>-					wave5_vpu_irq_thread, IRQF_ONESHOT, "vpu_irq", dev);
>-	if (ret) {
>-		dev_err(&pdev->dev, "Register interrupt handler, fail: %d\n", ret);
>-		goto err_enc_unreg;
>+		dev_err(&pdev->dev, "failed to get irq resource, falling back to polling\n");
>+		hrtimer_init(&dev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
>+		dev->hrtimer.function = &wave5_vpu_timer_callback;
>+		dev->worker = kthread_create_worker(0, "vpu_irq_thread");
>+		if (IS_ERR(dev->worker)) {
>+			dev_err(&pdev->dev, "failed to create vpu irq worker\n");
>+			ret = PTR_ERR(dev->worker);
>+			goto err_vdi_release;
>+		}
>+		dev->vpu_poll_interval = vpu_poll_interval;
>+		kthread_init_work(&dev->work, wave5_vpu_irq_work_fn);
>+	} else {
>+		ret = devm_request_threaded_irq(&pdev->dev, dev->irq, NULL,
>+						wave5_vpu_irq_thread, IRQF_ONESHOT, "vpu_irq", dev);
>+		if (ret) {
>+			dev_err(&pdev->dev, "Register interrupt handler, fail: %d\n", ret);
>+			goto err_enc_unreg;
>+		}
> 	}
>
> 	ret = wave5_vpu_load_firmware(&pdev->dev, match_data->fw_name, &fw_revision);
>@@ -254,6 +290,11 @@ static int wave5_vpu_remove(struct platform_device *pdev)
> {
> 	struct vpu_device *dev = dev_get_drvdata(&pdev->dev);
>
>+	if (dev->irq < 0) {
>+		kthread_destroy_worker(dev->worker);
>+		hrtimer_cancel(&dev->hrtimer);
>+	}
>+
> 	mutex_destroy(&dev->dev_lock);
> 	mutex_destroy(&dev->hw_lock);
> 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>index 352f6e904e50..edc50450ddb8 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>@@ -756,6 +756,10 @@ struct vpu_device {
> 	u32 product_code;
> 	struct ida inst_ida;
> 	struct clk_bulk_data *clks;
>+	struct hrtimer hrtimer;
>+	struct kthread_work work;
>+	struct kthread_worker *worker;
>+	int vpu_poll_interval;
> 	int num_clks;
> };
>
>-- 
>2.39.1
>


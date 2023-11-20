Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1E27F0F77
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjKTJwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjKTJwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:52:30 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B3494
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:52:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32f7bd27c2aso3109624f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700473943; x=1701078743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aev2RtC3VeW9ZZ/orYq87Farf78VDzxv5Llep85flDw=;
        b=rM2okNtD14YqloEJn/KkWXmYaflieENwVWgTgoY9jnTt5gajPsaMQOoISMd1XEDwno
         OeaH9AeqFx5SWiqVrMu9MqHELN94tONT+czftUhExJcWSuOvXjtyPf/qewHtreRyOvRs
         P5fFz1EJKc9Kf6W52bZEB6B+gjadlZBBWbuu3zjXiJ5XIng9mguhS3Q/4cSZXAtTPzAG
         cIhB1ef1WRILJrnbgRzsnpeYReBzRWFrHrqAW55wrs1bKEAZnr4N/Kk6wnw4Ym2CV8R2
         tleUQyUnbQ/HdzJobDBSTKuovSIjnSvL5AkN7lEtQg++jX4DlN3ds4oZ2JfQ5H8eWINk
         d2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700473943; x=1701078743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aev2RtC3VeW9ZZ/orYq87Farf78VDzxv5Llep85flDw=;
        b=Mr2qn5gZGl7RdDcQGO1M9Qs/b5wvh8V+tCkguWQyDf3FD7vUb14evNOEi7i1LUISa4
         8evgdkRam+DGBvy4J7Dmjz4cAntFfNYVBoMltyR3zf4P+24Qh3TLzy3P5a9WJq8sJ4AE
         eJ7SQ5ISw8Pt70SeZyDs9LNlFyL2iIIVg2tIiCxqWF45jRprQ+EKBgG+EE7/bmHmsBfW
         5IRTArgqFdD9MCpXvHnXRnTJqL8BA3I1Y6/KMqYcaUfbkXArWtvAwxWfbVTEr9O35rGM
         W8PGMgLufCDaq8lfTeAxR/E6/e4510CgvH619yIpf68eemXw9zTmpGOcoYAi5e/3Us85
         18Qg==
X-Gm-Message-State: AOJu0YzTH7WA3oY0uX7EokGEtjO0mZxhWh59eUZPoo/c9flfQgT1GgQz
        fOOofoq5wjIRSGgMVLHqsBos9g==
X-Google-Smtp-Source: AGHT+IE/GERsRHTxRYfWxy5QzZ1HMPGdNOmLqWaDiNV7MAJaiPQwzYhykWp14Zy92sLmAYYhmDaaEg==
X-Received: by 2002:a5d:570e:0:b0:32f:7ae6:64a7 with SMTP id a14-20020a5d570e000000b0032f7ae664a7mr4288170wrv.55.1700473942452;
        Mon, 20 Nov 2023 01:52:22 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v6-20020adfedc6000000b00326dd5486dcsm10563538wro.107.2023.11.20.01.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 01:52:21 -0800 (PST)
Date:   Mon, 20 Nov 2023 04:52:18 -0500
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2 01/15] staging: vc04_services: Add new vc-sm-cma driver
Message-ID: <5236379f-54e7-423c-9fb7-ef6bde963786@suswa.mountain>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231109210309.638594-2-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109210309.638594-2-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 04:02:53PM -0500, Umang Jain wrote:
> +/* Private file data associated with each opened device. */
> +struct vc_sm_privdata_t {
> +};
> +
> +typedef int (*VC_SM_SHOW) (struct seq_file *s, void *v);
> +struct sm_pde_t {

Get rid of all the _t suffixes.  It's not a typedef.

> +	VC_SM_SHOW show;          /* Debug fs function hookup. */
> +	struct dentry *dir_entry; /* Debug fs directory entry. */
> +	void *priv_data;          /* Private data */
> +};
> +
> +/* Global state information. */
> +struct sm_state_t {

Here too.  Just search for "_t " and delete them all.

> +	struct vchiq_device *device;
> +
> +	struct miscdevice misc_dev;
> +
> +	struct sm_instance *sm_handle;	/* Handle for videocore service. */
> +
> +	spinlock_t kernelid_map_lock;	/* Spinlock protecting kernelid_map */
> +	struct idr kernelid_map;
> +
> +	struct mutex map_lock;          /* Global map lock. */
> +	struct list_head buffer_list;	/* List of buffer. */
> +
> +	struct dentry *dir_root;	/* Debug fs entries root. */
> +	struct sm_pde_t dir_state;	/* Debug fs entries state sub-tree. */
> +
> +	bool require_released_callback;	/* VPU will send a released msg when it
> +					 * has finished with a resource.
> +					 */
> +	/* State for transactions */
> +	int restart_sys;                /* Tracks restart on interrupt. */
> +	enum vc_sm_msg_type int_action; /* Interrupted action. */
> +
> +	u32 int_trans_id;		/* Interrupted transaction. */
> +	struct vchiq_instance *vchiq_instance;
> +};
> +
> +struct vc_sm_dma_buf_attachment {
> +	struct device *dev;
> +	struct sg_table sg_table;
> +	struct list_head list;
> +	enum dma_data_direction	dma_dir;
> +};
> +
> +/* ---- Private Variables ----------------------------------------------- */
> +
> +static struct sm_state_t *sm_state;
> +static int sm_inited;
> +
> +/* ---- Private Function Prototypes -------------------------------------- */
> +
> +/* ---- Private Functions ------------------------------------------------ */
> +
> +static int get_kernel_id(struct vc_sm_buffer *buffer)
> +{
> +	int handle;
> +
> +	spin_lock(&sm_state->kernelid_map_lock);
> +	handle = idr_alloc(&sm_state->kernelid_map, buffer, 0, 0, GFP_KERNEL);
> +	spin_unlock(&sm_state->kernelid_map_lock);
> +
> +	return handle;
> +}
> +
> +static struct vc_sm_buffer *lookup_kernel_id(int handle)
> +{
> +	return idr_find(&sm_state->kernelid_map, handle);

This function would be better open coded.  It adds nothing except a
global variable (which is bad).

> +}
> +
> +static void free_kernel_id(int handle)
> +{
> +	spin_lock(&sm_state->kernelid_map_lock);
> +	idr_remove(&sm_state->kernelid_map, handle);
> +	spin_unlock(&sm_state->kernelid_map_lock);
> +}
> +
> +static int vc_sm_cma_seq_file_show(struct seq_file *s, void *v)
> +{
> +	struct sm_pde_t *sm_pde;
> +
> +	sm_pde = (struct sm_pde_t *)(s->private);
> +
> +	if (sm_pde && sm_pde->show)
> +		sm_pde->show(s, v);
> +
> +	return 0;
> +}
> +
> +static int vc_sm_cma_single_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, vc_sm_cma_seq_file_show, inode->i_private);
> +}
> +
> +static const struct file_operations vc_sm_cma_debug_fs_fops = {
> +	.open = vc_sm_cma_single_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static int vc_sm_cma_global_state_show(struct seq_file *s, void *v)
> +{
> +	struct vc_sm_buffer *resource = NULL;
> +	int resource_count = 0;
> +
> +	if (!sm_state)
> +		return 0;
> +
> +	seq_printf(s, "\nVC-ServiceHandle     %p\n", sm_state->sm_handle);
> +
> +	/* Log all applicable mapping(s). */
> +
> +	mutex_lock(&sm_state->map_lock);
> +	seq_puts(s, "\nResources\n");
> +	if (!list_empty(&sm_state->buffer_list)) {

Delete this check.  It's not required.

> +		list_for_each_entry(resource, &sm_state->buffer_list,
> +				    global_buffer_list) {
> +			resource_count++;
> +
> +			seq_printf(s, "\nResource                %p\n",
> +				   resource);
> +			seq_printf(s, "           NAME         %s\n",
> +				   resource->name);
> +			seq_printf(s, "           SIZE         %zu\n",
> +				   resource->size);
> +			seq_printf(s, "           DMABUF       %p\n",
> +				   resource->dma_buf);
> +			seq_printf(s, "           IMPORTED_DMABUF %p\n",
> +				   resource->imported_dma_buf);
> +			seq_printf(s, "           ATTACH       %p\n",
> +				   resource->attach);
> +			seq_printf(s, "           SGT          %p\n",
> +				   resource->sgt);
> +			seq_printf(s, "           DMA_ADDR     %pad\n",
> +				   &resource->dma_addr);
> +			seq_printf(s, "           VC_HANDLE     %08x\n",
> +				   resource->vc_handle);
> +			seq_printf(s, "           VC_MAPPING    %d\n",
> +				   resource->vpu_state);

Deleting the check will let you pull the code in a tab.  I would just
delete the line breaks.  The longest line will go up to 94 chars so it's
under the 100 character limit.

> +		}
> +	}
> +	seq_printf(s, "\n\nTotal resource count:   %d\n\n", resource_count);
> +
> +	mutex_unlock(&sm_state->map_lock);
> +
> +	return 0;
> +}
> +
> +/*
> + * Adds a buffer to the private data list which tracks all the allocated
> + * data.
> + */
> +static void vc_sm_add_resource(struct vc_sm_buffer *buffer)
> +{
> +	mutex_lock(&sm_state->map_lock);
> +	list_add(&buffer->global_buffer_list, &sm_state->buffer_list);
> +	mutex_unlock(&sm_state->map_lock);
> +
> +	dev_dbg(&sm_state->device->dev,"[%s]: added buffer %p (name %s, size %zu)\n",
> +		 __func__, buffer, buffer->name, buffer->size);
> +}
> +
> +/*
> + * Cleans up imported dmabuf.
> + * Should be called with mutex held.
> + */
> +static void vc_sm_clean_up_dmabuf(struct vc_sm_buffer *buffer)
> +{
> +	/* Handle cleaning up imported dmabufs */
> +	if (buffer->sgt) {
> +		dma_buf_unmap_attachment_unlocked(buffer->attach, buffer->sgt,
> +						  DMA_BIDIRECTIONAL);
> +		buffer->sgt = NULL;
> +	}
> +	if (buffer->attach) {
> +		dma_buf_detach(buffer->imported_dma_buf, buffer->attach);
> +		buffer->attach = NULL;
> +	}
> +}
> +
> +/*
> + * Instructs VPU to decrement the refcount on a buffer.
> + */
> +static void vc_sm_vpu_free(struct vc_sm_buffer *buffer)
> +{
> +	if (buffer->vc_handle && buffer->vpu_state == VPU_MAPPED) {

Reverse this test:

	if (!buffer->vc_handle || buffer->vpu_state != VPU_MAPPED)
		return;

> +		struct vc_sm_free_t free = { buffer->vc_handle, 0 };
> +		int status = vc_sm_cma_vchi_free(sm_state->sm_handle, &free,
> +					     &sm_state->int_trans_id);
> +		if (status != 0 && status != -EINTR) {
> +			dev_err(&sm_state->device->dev,
> +				"[%s]: failed to free memory on videocore (status: %u, trans_id: %u)\n",
> +			       __func__, status, sm_state->int_trans_id);
> +		}
> +
> +		if (sm_state->require_released_callback) {
> +			/* Need to wait for the VPU to confirm the free. */
> +
> +			/* Retain a reference on this until the VPU has
> +			 * released it
> +			 */
> +			buffer->vpu_state = VPU_UNMAPPING;
> +		} else {
> +			buffer->vpu_state = VPU_NOT_MAPPED;
> +			buffer->vc_handle = 0;
> +		}
> +	}
> +}
> +
> +/*
> + * Release an allocation.
> + * All refcounting is done via the dma buf object.
> + *
> + * Must be called with the mutex held. The function will either release the
> + * mutex (if defering the release) or destroy it. The caller must therefore not
> + * reuse the buffer on return.
> + */
> +static void vc_sm_release_resource(struct vc_sm_buffer *buffer)
> +{
> +	dev_dbg(&sm_state->device->dev, "[%s]: buffer %p (name %s, size %zu)\n",
> +		 __func__, buffer, buffer->name, buffer->size);
> +
> +	if (buffer->vc_handle) {
> +		/* We've sent the unmap request but not had the response. */
> +		dev_dbg(&sm_state->device->dev, "[%s]: Waiting for VPU unmap response on %p\n",
> +			 __func__, buffer);
> +		goto defer;
> +	}
> +	if (buffer->in_use) {
> +		/* dmabuf still in use - we await the release */
> +		dev_dbg(&sm_state->device->dev, "[%s]: buffer %p is still in use\n",
> +			__func__, buffer);
> +		goto defer;
> +	}
> +
> +	/* Release the allocation */
> +	if (buffer->imported_dma_buf)
> +		dma_buf_put(buffer->imported_dma_buf);
> +	else
> +		dev_err(&sm_state->device->dev, "%s: Imported dmabuf already been put for buf %p\n",
> +		       __func__, buffer);
> +	buffer->imported_dma_buf = NULL;
> +
> +	/* Free our buffer. Start by removing it from the list */
> +	mutex_lock(&sm_state->map_lock);
> +	list_del(&buffer->global_buffer_list);
> +	mutex_unlock(&sm_state->map_lock);
> +
> +	dev_dbg(&sm_state->device->dev, "%s: Release our allocation - done\n", __func__);
> +	mutex_unlock(&buffer->lock);
> +
> +	mutex_destroy(&buffer->lock);
> +
> +	kfree(buffer);
> +	return;
> +
> +defer:
> +	mutex_unlock(&buffer->lock);
> +}
> +
> +/* Dma_buf operations for chaining through to an imported dma_buf */
> +
> +static void vc_sm_dma_buf_release(struct dma_buf *dmabuf)
> +{
> +	struct vc_sm_buffer *buffer;
> +
> +	if (!dmabuf)
> +		return;
> +
> +	buffer = (struct vc_sm_buffer *)dmabuf->priv;
> +
> +	mutex_lock(&buffer->lock);
> +
> +	dev_dbg(&sm_state->device->dev, "%s dmabuf %p, buffer %p\n", __func__, dmabuf, buffer);
> +
> +	buffer->in_use = 0;
> +
> +	/* Unmap on the VPU */
> +	vc_sm_vpu_free(buffer);
> +	dev_dbg(&sm_state->device->dev, "%s vpu_free done\n", __func__);
> +
> +	/* Unmap our dma_buf object (the vc_sm_buffer remains until released
> +	 * on the VPU).
> +	 */
> +	vc_sm_clean_up_dmabuf(buffer);
> +	dev_dbg(&sm_state->device->dev, "%s clean_up dmabuf done\n", __func__);
> +
> +	/* buffer->lock will be destroyed by vc_sm_release_resource if finished
> +	 * with, otherwise unlocked. Do NOT unlock here.
> +	 */
> +	vc_sm_release_resource(buffer);
> +	dev_dbg(&sm_state->device->dev, "%s done\n", __func__);
> +}
> +
> +static
> +int vc_sm_import_dma_buf_attach(struct dma_buf *dmabuf,
> +				struct dma_buf_attachment *attachment)
> +{
> +	struct vc_sm_buffer *buf = dmabuf->priv;
> +
> +	return buf->imported_dma_buf->ops->attach(buf->imported_dma_buf,
> +						attachment);
> +}
> +
> +static
> +void vc_sm_import_dma_buf_detatch(struct dma_buf *dmabuf,
> +				  struct dma_buf_attachment *attachment)
> +{
> +	struct vc_sm_buffer *buf = dmabuf->priv;
> +
> +	buf->imported_dma_buf->ops->detach(buf->imported_dma_buf, attachment);
> +}
> +
> +static
> +struct sg_table *vc_sm_import_map_dma_buf(struct dma_buf_attachment *attachment,
> +					  enum dma_data_direction direction)
> +{
> +	struct vc_sm_buffer *buf = attachment->dmabuf->priv;
> +
> +	return buf->imported_dma_buf->ops->map_dma_buf(attachment,
> +						     direction);
> +}
> +
> +static
> +void vc_sm_import_unmap_dma_buf(struct dma_buf_attachment *attachment,
> +				struct sg_table *table,
> +				enum dma_data_direction direction)
> +{
> +	struct vc_sm_buffer *buf = attachment->dmabuf->priv;
> +
> +	buf->imported_dma_buf->ops->unmap_dma_buf(attachment, table, direction);
> +}
> +
> +static
> +int vc_sm_import_dmabuf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> +{
> +	struct vc_sm_buffer *buf = dmabuf->priv;
> +
> +	dev_dbg(&sm_state->device->dev, "%s: mmap dma_buf %p, buf %p, imported db %p\n", __func__,
> +		dmabuf, buf, buf->imported_dma_buf);
> +
> +	return buf->imported_dma_buf->ops->mmap(buf->imported_dma_buf, vma);
> +}
> +
> +static
> +int vc_sm_import_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
> +					  enum dma_data_direction direction)
> +{
> +	struct vc_sm_buffer *buf = dmabuf->priv;
> +
> +	return buf->imported_dma_buf->ops->begin_cpu_access(buf->imported_dma_buf,
> +							  direction);
> +}
> +
> +static
> +int vc_sm_import_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
> +					enum dma_data_direction direction)
> +{
> +	struct vc_sm_buffer *buf = dmabuf->priv;
> +
> +	return buf->imported_dma_buf->ops->end_cpu_access(buf->imported_dma_buf,
> +							  direction);
> +}
> +
> +static const struct dma_buf_ops dma_buf_import_ops = {
> +	.map_dma_buf = vc_sm_import_map_dma_buf,
> +	.unmap_dma_buf = vc_sm_import_unmap_dma_buf,
> +	.mmap = vc_sm_import_dmabuf_mmap,
> +	.release = vc_sm_dma_buf_release,
> +	.attach = vc_sm_import_dma_buf_attach,
> +	.detach = vc_sm_import_dma_buf_detatch,
> +	.begin_cpu_access = vc_sm_import_dma_buf_begin_cpu_access,
> +	.end_cpu_access = vc_sm_import_dma_buf_end_cpu_access,
> +};
> +
> +/* Import a dma_buf to be shared with VC. */
> +int
> +vc_sm_cma_import_dmabuf_internal(struct sm_state_t *state,
> +				 struct dma_buf *dma_buf,
> +				 int fd,
> +				 struct dma_buf **imported_buf)
> +{
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct vc_sm_buffer *buffer = NULL;
> +	struct vc_sm_import import = { };
> +	struct vc_sm_import_result result = { };
> +	struct dma_buf_attachment *attach = NULL;
> +	struct sg_table *sgt = NULL;
> +	dma_addr_t dma_addr;
> +	int ret = 0;
> +	int status;
> +
> +	/* Setup our allocation parameters */
> +	dev_dbg(&sm_state->device->dev, "%s: importing dma_buf %p/fd %d\n", __func__, dma_buf, fd);
> +
> +	if (fd < 0)
> +		get_dma_buf(dma_buf);
> +	else
> +		dma_buf = dma_buf_get(fd);
> +
> +	if (!dma_buf)
> +		return -EINVAL;
> +
> +	attach = dma_buf_attach(dma_buf, &sm_state->device->dev);
> +	if (IS_ERR(attach)) {
> +		ret = PTR_ERR(attach);
> +		goto error;

This is One Err Style error handling.  It's the second worst style of
error handling.  The style which is worse than this is One Err Style
but with the error handling done in a separate function called One
Magical Cleanup Function style error handling.

The reason that it's buggy is because we free things that have not
been allocated.  Better to re-write it in Free The Last Thing style.

https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

> +	}
> +
> +	sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
> +	if (IS_ERR(sgt)) {
> +		ret = PTR_ERR(sgt);
> +		goto error;
> +	}
> +
> +	/* Verify that the address block is contiguous */
> +	if (sgt->nents != 1) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	/* Allocate local buffer to track this allocation. */
> +	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	import.type = VC_SM_ALLOC_NON_CACHED;
> +	dma_addr = sg_dma_address(sgt->sgl);
> +	import.addr = (u32)dma_addr;
> +	if ((import.addr & 0xC0000000) != 0xC0000000) {
> +		dev_err(&sm_state->device->dev, "%s: Expecting an uncached alias for dma_addr %pad\n",
> +		       __func__, &dma_addr);
> +		import.addr |= 0xC0000000;
> +	}
> +	import.size = sg_dma_len(sgt->sgl);
> +	import.allocator = current->tgid;
> +	import.kernel_id = get_kernel_id(buffer);
> +
> +	memcpy(import.name, VC_SM_RESOURCE_NAME_DEFAULT,
> +	       sizeof(VC_SM_RESOURCE_NAME_DEFAULT));
> +
> +	dev_dbg(&sm_state->device->dev,
> +		"[%s]: attempt to import \"%s\" data - type %u, addr %pad, size %u.\n",
> +		__func__, import.name, import.type, &dma_addr, import.size);
> +
> +	/* Allocate the videocore buffer. */
> +	status = vc_sm_cma_vchi_import(sm_state->sm_handle, &import, &result,
> +				       &sm_state->int_trans_id);
> +	if (status == -EINTR) {
> +		dev_dbg(&sm_state->device->dev,
> +			"[%s]: requesting import memory action restart (trans_id: %u)\n",
> +			 __func__, sm_state->int_trans_id);
> +		ret = -ERESTARTSYS;
> +		sm_state->restart_sys = -EINTR;
> +		sm_state->int_action = VC_SM_MSG_TYPE_IMPORT;
> +		goto error;
> +	} else if (status || !result.res_handle) {
> +		dev_dbg(&sm_state->device->dev,
> +			"[%s]: failed to import memory on videocore (status: %u, trans_id: %u)\n",
> +			__func__, status, sm_state->int_trans_id);
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	mutex_init(&buffer->lock);
> +	INIT_LIST_HEAD(&buffer->attachments);
> +	memcpy(buffer->name, import.name,
> +	       min(sizeof(buffer->name), sizeof(import.name) - 1));
> +
> +	/* Keep track of the buffer we created. */
> +	buffer->vc_handle = result.res_handle;
> +	buffer->size = import.size;
> +	buffer->vpu_state = VPU_MAPPED;
> +
> +	buffer->imported_dma_buf = dma_buf;
> +
> +	buffer->attach = attach;
> +	buffer->sgt = sgt;
> +	buffer->dma_addr = dma_addr;
> +	buffer->in_use = 1;
> +	buffer->kernel_id = import.kernel_id;
> +
> +	/*
> +	 * We're done - we need to export a new dmabuf chaining through most
> +	 * functions, but enabling us to release our own internal references
> +	 * here.
> +	 */
> +	exp_info.ops = &dma_buf_import_ops;
> +	exp_info.size = import.size;
> +	exp_info.flags = O_RDWR;
> +	exp_info.priv = buffer;
> +
> +	buffer->dma_buf = dma_buf_export(&exp_info);
> +	if (IS_ERR(buffer->dma_buf)) {
> +		ret = PTR_ERR(buffer->dma_buf);
> +		goto error;
> +	}
> +
> +	vc_sm_add_resource(buffer);
> +
> +	*imported_buf = buffer->dma_buf;
> +
> +	return 0;
> +
> +error:
> +	if (result.res_handle) {
> +		struct vc_sm_free_t free = { result.res_handle, 0 };
> +
> +		vc_sm_cma_vchi_free(sm_state->sm_handle, &free,
> +				    &sm_state->int_trans_id);
> +	}
> +	free_kernel_id(import.kernel_id);
> +	kfree(buffer);
> +	if (sgt)
> +		dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
> +	if (attach)
> +		dma_buf_detach(dma_buf, attach);
> +	dma_buf_put(dma_buf);
> +	return ret;
> +}
> +
> +static void
> +vc_sm_vpu_event(struct sm_instance *instance, struct vc_sm_result_t *reply,
> +		int reply_len)
> +{
> +	switch (reply->trans_id & ~0x80000000) {
> +	case VC_SM_MSG_TYPE_CLIENT_VERSION:
> +	{
> +		/* Acknowledge that the firmware supports the version command */
> +		dev_dbg(&sm_state->device->dev,
> +			"%s: firmware acked version msg. Require release cb\n", __func__);
> +		sm_state->require_released_callback = true;
> +	}
> +	break;
> +	case VC_SM_MSG_TYPE_RELEASED:
> +	{
> +		struct vc_sm_released *release = (struct vc_sm_released *)reply;
> +		struct vc_sm_buffer *buffer =
> +					lookup_kernel_id(release->kernel_id);
> +		if (!buffer) {
> +			dev_err(&sm_state->device->dev,
> +				"%s: VC released a buffer that is already released, kernel_id %d\n",
> +			       __func__, release->kernel_id);
> +			break;
> +		}
> +		mutex_lock(&buffer->lock);
> +
> +		dev_dbg(&sm_state->device->dev,
> +			"%s: Released addr %08x, size %u, id %08x, mem_handle %08x\n",
> +			__func__, release->addr, release->size,
> +			release->kernel_id, release->vc_handle);
> +
> +		buffer->vc_handle = 0;
> +		buffer->vpu_state = VPU_NOT_MAPPED;
> +		free_kernel_id(release->kernel_id);
> +
> +		vc_sm_release_resource(buffer);
> +	}
> +	break;
> +	default:
> +		dev_err(&sm_state->device->dev, "%s: Unknown vpu cmd %x\n",
> +			__func__, reply->trans_id);
> +		break;
> +	}
> +}
> +
> +/* Driver load/unload functions */
> +/* Videocore connected.  */
> +static void vc_sm_connected_init(void)
> +{
> +	int ret;
> +	struct vc_sm_version version;
> +	struct vc_sm_result_t version_result;
> +
> +	pr_info("[%s]: start\n", __func__);

Delete this.  Use ftrace instead.

> +
> +	/*
> +	 * Initialize and create a VCHI connection for the shared memory service
> +	 * running on videocore.
> +	 */
> +	ret = vchiq_initialise(&sm_state->vchiq_instance);
> +	if (ret) {
> +		dev_err(&sm_state->device->dev, "[%s]: failed to initialise VCHI instance (ret=%d)\n",
> +			__func__, ret);
> +
> +		return;
> +	}
> +
> +	ret = vchiq_connect(sm_state->vchiq_instance);
> +	if (ret) {
> +		dev_err(&sm_state->device->dev, "[%s]: failed to connect VCHI instance (ret=%d)\n",
> +			__func__, ret);
> +
> +		return;
> +	}
> +
> +	/* Initialize an instance of the shared memory service. */
> +	sm_state->sm_handle = vc_sm_cma_vchi_init(sm_state->vchiq_instance, 1,
> +						  vc_sm_vpu_event);
> +	if (!sm_state->sm_handle) {
> +		dev_err(&sm_state->device->dev,
> +			"[%s]: failed to initialize shared memory service\n", __func__);
> +
> +		return;
> +	}
> +
> +	/* Create a debug fs directory entry (root). */
> +	sm_state->dir_root = debugfs_create_dir(VC_SM_DIR_ROOT_NAME, NULL);
> +
> +	sm_state->dir_state.show = &vc_sm_cma_global_state_show;
> +	sm_state->dir_state.dir_entry =
> +		debugfs_create_file(VC_SM_STATE, 0444, sm_state->dir_root,
> +				    &sm_state->dir_state,
> +				    &vc_sm_cma_debug_fs_fops);
> +
> +	INIT_LIST_HEAD(&sm_state->buffer_list);
> +
> +	version.version = 2;
> +	ret = vc_sm_cma_vchi_client_version(sm_state->sm_handle, &version,
> +					    &version_result,
> +					    &sm_state->int_trans_id);
> +	if (ret) {
> +		dev_err(&sm_state->device->dev,
> +			"[%s]: Failed to send version request %d\n", __func__, ret);
> +	}
> +
> +	/* Done! */
> +	sm_inited = 1;
> +	pr_info("[%s]: installed successfully\n", __func__);
> +}
> +
> +/* Driver loading. */
> +static int bcm2835_vc_sm_cma_probe(struct vchiq_device *device)
> +{
> +	struct device *dev = &device->dev;
> +	int err;
> +
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	if (err) {
> +		dev_err(dev, "dma_set_mask_and_coherent failed: %d\n", err);
> +		return err;
> +	}
> +
> +	sm_state = devm_kzalloc(dev, sizeof(*sm_state), GFP_KERNEL);
> +	if (!sm_state)
> +		return -ENOMEM;
> +	sm_state->device = device;
> +	mutex_init(&sm_state->map_lock);
> +
> +	spin_lock_init(&sm_state->kernelid_map_lock);
> +	idr_init_base(&sm_state->kernelid_map, 1);
> +
> +	dev->dma_parms = devm_kzalloc(dev, sizeof(dev->dma_parms), GFP_KERNEL);
> +
> +	/* dma_set_max_seg_size checks if dma_parms is NULL. */
> +	dma_set_max_seg_size(dev, 0x3FFFFFFF);
> +
> +	vchiq_add_connected_callback(vc_sm_connected_init);
> +	return 0;
> +}
> +
> +/* Driver unloading. */
> +static void bcm2835_vc_sm_cma_remove(struct vchiq_device *device)
> +{
> +	if (sm_inited) {
> +		misc_deregister(&sm_state->misc_dev);
> +
> +		/* Remove all proc entries. */
> +		debugfs_remove_recursive(sm_state->dir_root);
> +
> +		/* Stop the videocore shared memory service. */
> +		vc_sm_cma_vchi_stop(sm_state->vchiq_instance, &sm_state->sm_handle);
> +	}
> +
> +	if (sm_state) {
> +		idr_destroy(&sm_state->kernelid_map);
> +
> +		/* Free the memory for the state structure. */
> +		mutex_destroy(&sm_state->map_lock);
> +	}
> +}
> +
> +/* Kernel API calls */
> +/* Get an internal resource handle mapped from the external one. */
> +int vc_sm_cma_int_handle(void *handle)
> +{
> +	struct dma_buf *dma_buf = (struct dma_buf *)handle;
> +	struct vc_sm_buffer *buf;
> +
> +	/* Validate we can work with this device. */
> +	if (!sm_state || !handle) {
> +		dev_err(&sm_state->device->dev, "[%s]: invalid input\n", __func__);
> +		return 0;
> +	}
> +
> +	buf = (struct vc_sm_buffer *)dma_buf->priv;
> +	return buf->vc_handle;
> +}
> +EXPORT_SYMBOL_GPL(vc_sm_cma_int_handle);
> +
> +/* Free a previously allocated shared memory handle and block. */
> +int vc_sm_cma_free(void *handle)
> +{
> +	struct dma_buf *dma_buf = (struct dma_buf *)handle;
> +
> +	/* Validate we can work with this device. */
> +	if (!sm_state || !handle) {
> +		dev_err(&sm_state->device->dev, "[%s]: invalid input\n", __func__);
> +		return -EPERM;
> +	}
> +
> +	dev_dbg(&sm_state->device->dev, "%s: handle %p/dmabuf %p\n", __func__, handle, dma_buf);
> +
> +	dma_buf_put(dma_buf);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(vc_sm_cma_free);
> +
> +/* Import a dmabuf to be shared with VC. */
> +int vc_sm_cma_import_dmabuf(struct dma_buf *src_dmabuf, void **handle)
> +{
> +	struct dma_buf *new_dma_buf;
> +	int ret;
> +
> +	/* Validate we can work with this device. */
> +	if (!sm_state || !src_dmabuf || !handle) {
> +		dev_err(&sm_state->device->dev, "[%s]: invalid input\n", __func__);
> +		return -EPERM;
> +	}
> +
> +	ret = vc_sm_cma_import_dmabuf_internal(sm_state, src_dmabuf,
> +					       -1, &new_dma_buf);
> +
> +	if (!ret) {
> +		dev_dbg(&sm_state->device->dev, "%s: imported to ptr %p\n",
> +			__func__, new_dma_buf);
> +
> +		/* Assign valid handle at this time.*/
> +		*handle = new_dma_buf;
> +	} else {
> +		/*
> +		 * succeeded in importing the dma_buf, but then
> +		 * failed to look it up again. How?
> +		 * Release the fd again.
> +		 */
> +		dev_err(&sm_state->device->dev, "%s: imported vc_sm_cma_get_buffer failed %d\n",
> +			__func__, ret);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vc_sm_cma_import_dmabuf);
> +
> +static struct vchiq_device_id device_id_table[] = {
> +        { .name = "vcsm-cma" },
> +        {}
> +};
> +MODULE_DEVICE_TABLE(vchiq, device_id_table);
> +
> +static struct vchiq_driver bcm2835_vcsm_cma_driver = {
> +	.probe = bcm2835_vc_sm_cma_probe,
> +	.remove = bcm2835_vc_sm_cma_remove,
> +	.id_table = device_id_table,
> +	.driver = {
> +		   .name = "vcsm-cma",
> +	},
> +};
> +
> +module_vchiq_driver(bcm2835_vcsm_cma_driver);
> +
> +MODULE_AUTHOR("Dave Stevenson");
> +MODULE_DESCRIPTION("VideoCore CMA Shared Memory Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm.h b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.h
> new file mode 100644
> index 000000000000..61e110ec414d
> --- /dev/null
> +++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * VideoCore Shared Memory driver using CMA.
> + *
> + * Copyright: 2018, Raspberry Pi (Trading) Ltd
> + *
> + */
> +
> +#ifndef VC_SM_H
> +#define VC_SM_H
> +
> +#define VC_SM_MAX_NAME_LEN 32
> +
> +enum vc_sm_vpu_mapping_state {
> +	VPU_NOT_MAPPED,
> +	VPU_MAPPED,
> +	VPU_UNMAPPING
> +};
> +
> +struct vc_sm_buffer {
> +	struct list_head global_buffer_list;	/* Global list of buffers. */
> +
> +	/* Index in the kernel_id idr so that we can find the
> +	 * mmal_msg_context again when servicing the VCHI reply.
> +	 */
> +	int kernel_id;
> +
> +	size_t size;
> +
> +	/* Lock over all the following state for this buffer */
> +	struct mutex lock;
> +	struct list_head attachments;
> +
> +	char name[VC_SM_MAX_NAME_LEN];
> +
> +	int in_use:1;	/* Kernel is still using this resource */
> +
> +	enum vc_sm_vpu_mapping_state vpu_state;
> +	u32 vc_handle;	/* VideoCore handle for this buffer */
> +
> +	/* DMABUF related fields */
> +	struct dma_buf *dma_buf;
> +	dma_addr_t dma_addr;
> +	void *cookie;
> +
> +	struct vc_sm_privdata_t *private;
> +
> +	struct dma_buf *imported_dma_buf;
> +	struct dma_buf_attachment *attach;
> +	struct sg_table *sgt;
> +};
> +
> +#endif
> diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
> new file mode 100644
> index 000000000000..08f70e955acf
> --- /dev/null
> +++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
> @@ -0,0 +1,507 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * VideoCore Shared Memory CMA allocator
> + *
> + * Copyright: 2018, Raspberry Pi (Trading) Ltd
> + * Copyright 2011-2012 Broadcom Corporation.  All rights reserved.
> + *
> + * Based on vmcs_sm driver from Broadcom Corporation.
> + *
> + */
> +
> +/* ---- Include Files ----------------------------------------------------- */
> +#include <linux/kthread.h>
> +#include <linux/list.h>
> +#include <linux/semaphore.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "vc_sm_cma_vchi.h"
> +
> +#define VC_SM_VER  1
> +#define VC_SM_MIN_VER 0
> +
> +/* ---- Private Constants and Types -------------------------------------- */
> +
> +/* Command blocks come from a pool */
> +#define SM_MAX_NUM_CMD_RSP_BLKS 32
> +
> +/* The number of supported connections */
> +#define SM_MAX_NUM_CONNECTIONS 3
> +
> +struct sm_cmd_rsp_blk {
> +	struct list_head head;	/* To create lists */
> +	/* To be signaled when the response is there */
> +	struct completion cmplt;
> +
> +	u32 id;
> +	u16 length;
> +
> +	u8 msg[VC_SM_MAX_MSG_LEN];
> +
> +	uint32_t wait:1;
> +	uint32_t sent:1;
> +	uint32_t alloc:1;
> +
> +};
> +
> +struct sm_instance {
> +	u32 num_connections;
> +	unsigned int service_handle[SM_MAX_NUM_CONNECTIONS];
> +	struct task_struct *io_thread;
> +	struct completion io_cmplt;
> +
> +	vpu_event_cb vpu_event;
> +
> +	/* Mutex over the following lists */
> +	struct mutex lock;
> +	u32 trans_id;
> +	struct list_head cmd_list;
> +	struct list_head rsp_list;
> +	struct list_head dead_list;
> +
> +	struct sm_cmd_rsp_blk free_blk[SM_MAX_NUM_CMD_RSP_BLKS];
> +
> +	/* Mutex over the free_list */
> +	struct mutex free_lock;
> +	struct list_head free_list;
> +
> +	struct semaphore free_sema;
> +	struct vchiq_instance *vchiq_instance;
> +};
> +
> +/* ---- Private Variables ------------------------------------------------ */
> +
> +/* ---- Private Function Prototypes -------------------------------------- */
> +
> +/* ---- Private Functions ------------------------------------------------ */
> +static int
> +bcm2835_vchi_msg_queue(struct vchiq_instance *vchiq_instance, unsigned int handle,
> +		       void *data,
> +		       unsigned int size)
> +{
> +	return vchiq_queue_kernel_message(vchiq_instance, handle, data, size);
> +}
> +
> +static struct
> +sm_cmd_rsp_blk *vc_vchi_cmd_create(struct sm_instance *instance,
> +				   enum vc_sm_msg_type id, void *msg,
> +				   u32 size, int wait)
> +{
> +	struct sm_cmd_rsp_blk *blk;
> +	struct vc_sm_msg_hdr_t *hdr;
> +
> +	if (down_interruptible(&instance->free_sema)) {
> +		blk = kmalloc(sizeof(*blk), GFP_KERNEL);
> +		if (!blk)
> +			return NULL;
> +
> +		blk->alloc = 1;

Make this bool.  s/1/true/.

> +		init_completion(&blk->cmplt);
> +	} else {
> +		mutex_lock(&instance->free_lock);
> +		blk =
> +		    list_first_entry(&instance->free_list,
> +				     struct sm_cmd_rsp_blk, head);

How do we know that the ->free_list isn't empty?

> +		list_del(&blk->head);
> +		mutex_unlock(&instance->free_lock);
> +	}
> +
> +	blk->sent = 0;
> +	blk->wait = wait;
> +	blk->length = sizeof(*hdr) + size;
> +
> +	hdr = (struct vc_sm_msg_hdr_t *)blk->msg;
> +	hdr->type = id;
> +	mutex_lock(&instance->lock);
> +	instance->trans_id++;
> +	/*
> +	 * Retain the top bit for identifying asynchronous events, or VPU cmds.
> +	 */
> +	instance->trans_id &= ~0x80000000;
> +	hdr->trans_id = instance->trans_id;
> +	blk->id = instance->trans_id;
> +	mutex_unlock(&instance->lock);
> +
> +	if (size)
> +		memcpy(hdr->body, msg, size);

If I remember right, this size check is there to silence a GCC false
positive about array overflows?  If so it needs a comment, if not then
it can be removed.

> +
> +	return blk;
> +}
> +
> +static void
> +vc_vchi_cmd_delete(struct sm_instance *instance, struct sm_cmd_rsp_blk *blk)
> +{
> +	if (blk->alloc) {
> +		kfree(blk);
> +		return;
> +	}
> +
> +	mutex_lock(&instance->free_lock);
> +	list_add(&blk->head, &instance->free_list);
> +	mutex_unlock(&instance->free_lock);
> +	up(&instance->free_sema);
> +}
> +
> +static void vc_sm_cma_vchi_rx_ack(struct sm_instance *instance,
> +				  struct sm_cmd_rsp_blk *cmd,
> +				  struct vc_sm_result_t *reply,
> +				  u32 reply_len)
> +{
> +	mutex_lock(&instance->lock);
> +	list_for_each_entry(cmd,
> +			    &instance->rsp_list,
> +			    head) {
> +		if (cmd->id == reply->trans_id)
> +			break;
> +	}
> +	mutex_unlock(&instance->lock);
> +
> +	if (&cmd->head == &instance->rsp_list) {
> +		//pr_debug("%s: received response %u, throw away...",
> +		pr_err("%s: received response %u, throw away...",
> +		       __func__,
> +		       reply->trans_id);
> +	} else if (reply_len > sizeof(cmd->msg)) {
> +		pr_err("%s: reply too big (%u) %u, throw away...",
> +		       __func__, reply_len,
> +		     reply->trans_id);
> +	} else {
> +		memcpy(cmd->msg, reply,
> +		       reply_len);

Delete this unnecessary line break.  Generally there are too many line
breaks in this code.  See above as well.

> +		complete(&cmd->cmplt);
> +	}
> +}
> +
> +static int vc_sm_cma_vchi_videocore_io(void *arg)
> +{
> +	struct sm_instance *instance = arg;
> +	struct sm_cmd_rsp_blk *cmd = NULL, *cmd_tmp;
> +	struct vc_sm_result_t *reply;
> +	struct vchiq_header *header;
> +	s32 status;
> +	int svc_use = 1;

bool

> +
> +	while (1) {
> +		if (svc_use)
> +			vchiq_release_service(instance->vchiq_instance,
> +					      instance->service_handle[0]);
> +		svc_use = 0;
> +
> +		if (wait_for_completion_interruptible(&instance->io_cmplt))
> +			continue;
> +		vchiq_use_service(instance->vchiq_instance, instance->service_handle[0]);
> +		svc_use = 1;
> +
> +		do {

Make this a while (1) loop and not a do while (1) loop.

> +			/*
> +			 * Get new command and move it to response list
> +			 */
> +			mutex_lock(&instance->lock);
> +			if (list_empty(&instance->cmd_list)) {
> +				/* no more commands to process */
> +				mutex_unlock(&instance->lock);
> +				break;
> +			}
> +			cmd = list_first_entry(&instance->cmd_list,
> +					       struct sm_cmd_rsp_blk, head);
> +			list_move(&cmd->head, &instance->rsp_list);
> +			cmd->sent = 1;
> +			mutex_unlock(&instance->lock);
> +			/* Send the command */
> +			status =
> +				bcm2835_vchi_msg_queue(instance->vchiq_instance,
> +						       instance->service_handle[0],
> +						       cmd->msg, cmd->length);
> +			if (status) {
> +				pr_err("%s: failed to queue message (%d)",
> +				       __func__, status);
> +			}
> +
> +			/* If no reply is needed then we're done */
> +			if (!cmd->wait) {
> +				mutex_lock(&instance->lock);
> +				list_del(&cmd->head);
> +				mutex_unlock(&instance->lock);
> +				vc_vchi_cmd_delete(instance, cmd);
> +				continue;
> +			}
> +
> +			if (status) {
> +				complete(&cmd->cmplt);
> +				continue;
> +			}
> +
> +		} while (1);
> +
> +		while ((header = vchiq_msg_hold(instance->vchiq_instance,
> +						instance->service_handle[0]))) {
> +			reply = (struct vc_sm_result_t *)header->data;
> +			if (reply->trans_id & 0x80000000) {
> +				/* Async event or cmd from the VPU */
> +				if (instance->vpu_event)
> +					instance->vpu_event(instance, reply,
> +							    header->size);
> +			} else {
> +				vc_sm_cma_vchi_rx_ack(instance, cmd, reply,
> +						      header->size);
> +			}
> +
> +			vchiq_release_message(instance->vchiq_instance,
> +					      instance->service_handle[0],
> +					      header);
> +		}
> +
> +		/* Go through the dead list and free them */
> +		mutex_lock(&instance->lock);
> +		list_for_each_entry_safe(cmd, cmd_tmp, &instance->dead_list,
> +					 head) {
> +			list_del(&cmd->head);
> +			vc_vchi_cmd_delete(instance, cmd);
> +		}
> +		mutex_unlock(&instance->lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static int vc_sm_cma_vchi_callback(struct vchiq_instance *vchiq_instance,
> +				   enum vchiq_reason reason,
> +				   struct vchiq_header *header,
> +				   unsigned int handle, void *userdata)
> +{
> +	struct sm_instance *instance = vchiq_get_service_userdata(vchiq_instance, handle);
> +
> +	switch (reason) {
> +	case VCHIQ_MESSAGE_AVAILABLE:
> +		vchiq_msg_queue_push(vchiq_instance, handle, header);
> +		complete(&instance->io_cmplt);
> +		break;
> +
> +	case VCHIQ_SERVICE_CLOSED:
> +		pr_info("%s: service CLOSED!!", __func__);
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +struct sm_instance *vc_sm_cma_vchi_init(struct vchiq_instance *vchiq_instance,
> +					unsigned int num_connections,
> +					vpu_event_cb vpu_event)
> +{
> +	u32 i;
> +	struct sm_instance *instance;
> +	int status;
> +
> +	pr_debug("%s: start", __func__);

Delete.  Use ftrace.

> +
> +	if (num_connections > SM_MAX_NUM_CONNECTIONS) {
> +		pr_err("%s: unsupported number of connections %u (max=%u)",
> +		       __func__, num_connections, SM_MAX_NUM_CONNECTIONS);
> +
> +		goto err_null;

Just return NULL;

> +	}
> +	/* Allocate memory for this instance */
> +	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
> +
> +	/* Misc initialisations */
> +	mutex_init(&instance->lock);

Check for kzalloc() failure.

regards,
dan carpenter


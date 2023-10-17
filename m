Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3357CD0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbjJQXY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344514AbjJQXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:24:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA1918D;
        Tue, 17 Oct 2023 16:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697585015; x=1729121015;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=P7ejWSafnAHo+ayUhlRwgXcsI5Zgbqlw98e9q6V244E=;
  b=aLBRycpFg6nBCyZG2m6ROYtuqKQSE6hXYOa0c7dKGb7bbKlOsRI0JHCc
   r8MxUvjgZyCQHF43uDAuo0sZl+57ANBt0pb5z6tvjjm9VDVuvWqAdw3tb
   D0j5+PpSIcW9VpST1pWo6gD8CBST5wUq4uR0GHtWf/q+OK6BKp5jLXdqv
   SoXpQNva2fdLvKcFbBPSBENfssc/gQihMWeGnwQ9cbaqlIlLPdv2DOwAo
   r6aO90pVmSTnWJB6zdSIJL39icHlX9OXsLrBt9X/hdpITjbwc1svq2gnZ
   AG20JJARzO7NQn17IM3jJND6iLn3EIx6HdU35eH4KnEYL+yiN2Bxz2R+w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384778269"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384778269"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826637538"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="826637538"
Received: from asprado-mobl2.amr.corp.intel.com (HELO [10.212.55.179]) ([10.212.55.179])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:23:33 -0700
Message-ID: <32b77d2d-340e-49c9-986d-9f9f37e43cda@linux.intel.com>
Date:   Tue, 17 Oct 2023 18:21:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v9 19/34] ALSA: usb-audio: qcom: Introduce QC USB SND
 offloading support
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
 <20231017200109.11407-20-quic_wcheng@quicinc.com>
Content-Language: en-US
In-Reply-To: <20231017200109.11407-20-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +config SND_USB_AUDIO_QMI
> +	tristate "Qualcomm Audio Offload driver"
> +	depends on QCOM_QMI_HELPERS && SND_USB_AUDIO && USB_XHCI_SIDEBAND
> +	select SND_PCM

This select is not needed:

config SND_USB_AUDIO
	tristate "USB Audio/MIDI driver"
	select SND_HWDEP
	select SND_RAWMIDI
	select SND_PCM


> +#include <linux/ctype.h>
> +#include <linux/moduleparam.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +#include <linux/init.h>

alphabetical order?

> +#include <linux/usb/hcd.h>
> +#include <linux/usb/xhci-sideband.h>
> +#include <linux/usb/quirks.h>
> +#include <linux/usb/audio.h>
> +#include <linux/usb/audio-v2.h>
> +#include <linux/usb/audio-v3.h>
> +#include <linux/soc/qcom/qmi.h>
> +#include <linux/iommu.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-map-ops.h>
> +#include <sound/q6usboffload.h>
> +
> +#include <sound/control.h>
> +#include <sound/core.h>
> +#include <sound/info.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/initval.h>
> +
> +#include <sound/soc.h>
> +#include <sound/soc-usb.h>
> +#include "../usbaudio.h"
> +#include "../card.h"
> +#include "../endpoint.h"
> +#include "../helper.h"
> +#include "../pcm.h"
> +#include "../format.h"
> +#include "../power.h"
> +#include "usb_audio_qmi_v01.h"
> +
> +/* Stream disable request timeout during USB device disconnect */
> +#define DEV_RELEASE_WAIT_TIMEOUT 10000 /* in ms */

DEV_RELEASE_WAIT_TIMEOUT_MS?

why 10s btw?

> +
> +/* Data interval calculation parameters */
> +#define BUS_INTERVAL_FULL_SPEED 1000 /* in us */
> +#define BUS_INTERVAL_HIGHSPEED_AND_ABOVE 125 /* in us */
> +#define MAX_BINTERVAL_ISOC_EP 16
> +
> +#define QMI_STREAM_REQ_CARD_NUM_MASK 0xffff0000
> +#define QMI_STREAM_REQ_DEV_NUM_MASK 0xff00
> +#define QMI_STREAM_REQ_DIRECTION 0xff
> +
> +/* iommu resource parameters and management */
> +#define PREPEND_SID_TO_IOVA(iova, sid) ((u64)(((u64)(iova)) | \
> +					(((u64)sid) << 32)))
> +#define IOVA_BASE 0x1000
> +#define IOVA_XFER_RING_BASE (IOVA_BASE + PAGE_SIZE * (SNDRV_CARDS + 1))
> +#define IOVA_XFER_BUF_BASE (IOVA_XFER_RING_BASE + PAGE_SIZE * SNDRV_CARDS * 32)
> +#define IOVA_XFER_RING_MAX (IOVA_XFER_BUF_BASE - PAGE_SIZE)
> +#define IOVA_XFER_BUF_MAX (0xfffff000 - PAGE_SIZE)
> +
> +#define MAX_XFER_BUFF_LEN (24 * PAGE_SIZE)
> +
> +struct iova_info {
> +	struct list_head list;
> +	unsigned long start_iova;
> +	size_t size;
> +	bool in_use;
> +};
> +
> +struct intf_info {
> +	unsigned long data_xfer_ring_va;
> +	size_t data_xfer_ring_size;
> +	unsigned long sync_xfer_ring_va;
> +	size_t sync_xfer_ring_size;
> +	unsigned long xfer_buf_va;
> +	size_t xfer_buf_size;
> +	phys_addr_t xfer_buf_pa;
> +	unsigned int data_ep_pipe;
> +	unsigned int sync_ep_pipe;
> +	u8 *xfer_buf;
> +	u8 intf_num;
> +	u8 pcm_card_num;
> +	u8 pcm_dev_num;
> +	u8 direction;
> +	bool in_use;
> +};
> +
> +struct uaudio_qmi_dev {
> +	struct device *dev;
> +	u32 sid;
> +	u32 intr_num;
> +	struct xhci_ring *sec_ring;
> +	struct iommu_domain *domain;
> +
> +	/* list to keep track of available iova */
> +	struct list_head xfer_ring_list;
> +	size_t xfer_ring_iova_size;
> +	unsigned long curr_xfer_ring_iova;
> +	struct list_head xfer_buf_list;
> +	size_t xfer_buf_iova_size;
> +	unsigned long curr_xfer_buf_iova;
> +
> +	/* bit fields representing pcm card enabled */
> +	unsigned long card_slot;
> +	/* indicate event ring mapped or not */
> +	bool er_mapped;
> +	/* reference count to number of possible consumers */
> +	atomic_t qdev_in_use;
> +	/* idx to last udev card number plugged in */
> +	unsigned int last_card_num;
> +};
> +
> +struct uaudio_dev {
> +	struct usb_device *udev;
> +	/* audio control interface */
> +	struct usb_host_interface *ctrl_intf;
> +	unsigned int usb_core_id;
> +	atomic_t in_use;
> +	struct kref kref;
> +	wait_queue_head_t disconnect_wq;
> +
> +	/* interface specific */
> +	int num_intf;
> +	struct intf_info *info;
> +	struct snd_usb_audio *chip;
> +
> +	/* xhci sideband */
> +	struct xhci_sideband *sb;
> +
> +	/* SoC USB device */
> +	struct snd_soc_usb_device *sdev;
> +};

these structures feel like a set of kitchen sinks... Or a possible
copy-paste, I don't know how one would add all these pointers on their own?

Do you really need all this? Is there not a way to use existing
substructures?


> +static int get_data_interval_from_si(struct snd_usb_substream *subs,
> +	u32 service_interval)
> +{
> +	unsigned int bus_intval, bus_intval_mult, binterval;
> +
> +	if (subs->dev->speed >= USB_SPEED_HIGH)
> +		bus_intval = BUS_INTERVAL_HIGHSPEED_AND_ABOVE;
> +	else
> +		bus_intval = BUS_INTERVAL_FULL_SPEED;
> +
> +	if (service_interval % bus_intval)
> +		return -EINVAL;
> +
> +	bus_intval_mult = service_interval / bus_intval;
> +	binterval = ffs(bus_intval_mult);
> +	if (!binterval || binterval > MAX_BINTERVAL_ISOC_EP)
> +		return -EINVAL;
> +
> +	/* check if another bit is set then bail out */
> +	bus_intval_mult = bus_intval_mult >> binterval;
> +	if (bus_intval_mult)
> +		return -EINVAL;
> +
> +	return (binterval - 1);
> +}

This also feels like a generic helper. I don't see what's Qualcomm
specific here?


> +static unsigned long uaudio_iommu_map(enum mem_type mtype, bool dma_coherent,
> +		phys_addr_t pa, size_t size, struct sg_table *sgt)
> +{
> +	unsigned long va_sg, va = 0;
> +	bool map = true;
> +	int i, ret;
> +	size_t sg_len, total_len = 0;
> +	struct scatterlist *sg;
> +	phys_addr_t pa_sg;
> +	int prot = IOMMU_READ | IOMMU_WRITE;

reverse x-mas tree style?

> +
> +	if (dma_coherent)
> +		prot |= IOMMU_CACHE;
> +
> +	switch (mtype) {
> +	case MEM_EVENT_RING:
> +		va = IOVA_BASE;
> +		/* er already mapped */
> +		if (uaudio_qdev->er_mapped)
> +			map = false;
> +		break;
> +	case MEM_XFER_RING:
> +		va = uaudio_get_iova(&uaudio_qdev->curr_xfer_ring_iova,
> +		&uaudio_qdev->xfer_ring_iova_size, &uaudio_qdev->xfer_ring_list,
> +		size);
> +		break;
> +	case MEM_XFER_BUF:
> +		va = uaudio_get_iova(&uaudio_qdev->curr_xfer_buf_iova,
> +		&uaudio_qdev->xfer_buf_iova_size, &uaudio_qdev->xfer_buf_list,
> +		size);
> +		break;
> +	default:
> +		dev_err(uaudio_qdev->dev, "unknown mem type %d\n", mtype);
> +	}
> +
> +	if (!va || !map)
> +		goto done;
> +
> +	if (!sgt)
> +		goto skip_sgt_map;
> +
> +	va_sg = va;
> +	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +		sg_len = PAGE_ALIGN(sg->offset + sg->length);
> +		pa_sg = page_to_phys(sg_page(sg));
> +		ret = iommu_map(uaudio_qdev->domain, va_sg, pa_sg, sg_len,
> +				prot, GFP_KERNEL);
> +		if (ret) {
> +			dev_err(uaudio_qdev->dev, "mapping failed ret%d\n", ret);
> +			dev_err(uaudio_qdev->dev,
> +				"type:%d, pa:%pa iova:0x%08lx sg_len:%zu\n",
> +				mtype, &pa_sg, va_sg, sg_len);
> +			uaudio_iommu_unmap(MEM_XFER_BUF, va, size, total_len);
> +			va = 0;

so it's an error but the function returns 0?

> +			goto done;
> +		}
> +		dev_dbg(uaudio_qdev->dev,
> +			"type:%d map pa:%pa to iova:0x%08lx len:%zu offset:%u\n",
> +			mtype, &pa_sg, va_sg, sg_len, sg->offset);
> +		va_sg += sg_len;
> +		total_len += sg_len;
> +	}
> +
> +	if (size != total_len) {
> +		dev_err(uaudio_qdev->dev, "iova size %zu != mapped iova size %zu\n",
> +			size, total_len);
> +		uaudio_iommu_unmap(MEM_XFER_BUF, va, size, total_len);
> +		va = 0;
> +	}
> +	return va;
> +
> +skip_sgt_map:
> +	dev_dbg(uaudio_qdev->dev, "type:%d map pa:%pa to iova:0x%08lx size:%zu\n",
> +		mtype, &pa, va, size);
> +
> +	ret = iommu_map(uaudio_qdev->domain, va, pa, size, prot, GFP_KERNEL);
> +	if (ret)
> +		dev_err(uaudio_qdev->dev,
> +			"failed to map pa:%pa iova:0x%lx type:%d ret:%d\n",
> +			&pa, va, mtype, ret);
> +done:
> +	return va;
> +}
> +
> +/* looks up alias, if any, for controller DT node and returns the index */
> +static int usb_get_controller_id(struct usb_device *udev)
> +{
> +	if (udev->bus->sysdev && udev->bus->sysdev->of_node)
> +		return of_alias_get_id(udev->bus->sysdev->of_node, "usb");
> +
> +	return -ENODEV;
> +}
> +
> +/**
> + * uaudio_dev_intf_cleanup() - cleanup transfer resources
> + * @udev: usb device
> + * @info: usb offloading interface
> + *
> + * Cleans up the transfer ring related resources which are assigned per
> + * endpoint from XHCI.  This is invoked when the USB endpoints are no
> + * longer in use by the adsp.
> + *
> + */
> +static void uaudio_dev_intf_cleanup(struct usb_device *udev,
> +	struct intf_info *info)
> +{
> +	uaudio_iommu_unmap(MEM_XFER_RING, info->data_xfer_ring_va,
> +		info->data_xfer_ring_size, info->data_xfer_ring_size);
> +	info->data_xfer_ring_va = 0;
> +	info->data_xfer_ring_size = 0;
> +
> +	uaudio_iommu_unmap(MEM_XFER_RING, info->sync_xfer_ring_va,
> +		info->sync_xfer_ring_size, info->sync_xfer_ring_size);
> +	info->sync_xfer_ring_va = 0;
> +	info->sync_xfer_ring_size = 0;
> +
> +	uaudio_iommu_unmap(MEM_XFER_BUF, info->xfer_buf_va,
> +		info->xfer_buf_size, info->xfer_buf_size);
> +	info->xfer_buf_va = 0;
> +
> +	usb_free_coherent(udev, info->xfer_buf_size,
> +		info->xfer_buf, info->xfer_buf_pa);
> +	info->xfer_buf_size = 0;
> +	info->xfer_buf = NULL;
> +	info->xfer_buf_pa = 0;
> +
> +	info->in_use = false;
> +}
> +
> +/**
> + * uaudio_event_ring_cleanup_free() - cleanup secondary event ring
> + * @dev: usb offload device
> + *
> + * Cleans up the secondary event ring that was requested.  This will
> + * occur when the adsp is no longer transferring data on the USB bus
> + * across all endpoints.
> + *
> + */
> +static void uaudio_event_ring_cleanup_free(struct uaudio_dev *dev)
> +{
> +	clear_bit(dev->chip->card->number, &uaudio_qdev->card_slot);
> +	/* all audio devices are disconnected */
> +	if (!uaudio_qdev->card_slot) {
> +		uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE,
> +			PAGE_SIZE);
> +		xhci_sideband_remove_interrupter(uadev[dev->chip->card->number].sb);
> +	}
> +}
> +
> +static void uaudio_dev_cleanup(struct uaudio_dev *dev)

there should be a comment that this assumes a mutex is locked in the caller.

> +{
> +	int if_idx;
> +
> +	if (!dev->udev)
> +		return;
> +
> +	/* free xfer buffer and unmap xfer ring and buf per interface */
> +	for (if_idx = 0; if_idx < dev->num_intf; if_idx++) {
> +		if (!dev->info[if_idx].in_use)
> +			continue;
> +		uaudio_dev_intf_cleanup(dev->udev, &dev->info[if_idx]);
> +		dev_dbg(uaudio_qdev->dev, "release resources: intf# %d card# %d\n",
> +			dev->info[if_idx].intf_num, dev->chip->card->number);
> +	}
> +
> +	dev->num_intf = 0;
> +
> +	/* free interface info */
> +	kfree(dev->info);
> +	dev->info = NULL;
> +	uaudio_event_ring_cleanup_free(dev);
> +	dev->udev = NULL;
> +}
> +
> +/**
> + * disable_audio_stream() - disable usb snd endpoints
> + * @subs: usb substream
> + *
> + * Closes the USB SND endpoints associated with the current audio stream
> + * used.  This will decrement the USB SND endpoint opened reference count.
> + *
> + */
> +static void disable_audio_stream(struct snd_usb_substream *subs)
> +{
> +	struct snd_usb_audio *chip = subs->stream->chip;
> +
> +	snd_usb_hw_free(subs);
> +	snd_usb_autosuspend(chip);
> +}
> +
> +/* QMI service disconnect handlers */
> +static void qmi_disconnect_work(struct work_struct *w)
> +{
> +	struct intf_info *info;
> +	int idx, if_idx;
> +	struct snd_usb_substream *subs;
> +	struct snd_usb_audio *chip;
> +
> +	mutex_lock(&qdev_mutex);
> +	/* find all active intf for set alt 0 and cleanup usb audio dev */
> +	for (idx = 0; idx < SNDRV_CARDS; idx++) {
> +		if (!atomic_read(&uadev[idx].in_use))
> +			continue;
> +
> +		chip = uadev[idx].chip;
> +		for (if_idx = 0; if_idx < uadev[idx].num_intf; if_idx++) {
> +			if (!uadev[idx].info || !uadev[idx].info[if_idx].in_use)
> +				continue;
> +			info = &uadev[idx].info[if_idx];
> +			subs = find_substream(info->pcm_card_num,
> +						info->pcm_dev_num,
> +						info->direction);
> +			if (!subs || !chip || atomic_read(&chip->shutdown)) {
> +				dev_err(&subs->dev->dev,
> +					"no sub for c#%u dev#%u dir%u\n",
> +					info->pcm_card_num,
> +					info->pcm_dev_num,
> +					info->direction);
> +				continue;
> +			}
> +			disable_audio_stream(subs);
> +		}
> +		atomic_set(&uadev[idx].in_use, 0);
> +		mutex_lock(&chip->mutex);
> +		uaudio_dev_cleanup(&uadev[idx]);
> +		mutex_unlock(&chip->mutex);
> +	}
> +	mutex_unlock(&qdev_mutex);
> +}
> +
> +/**
> + * qmi_bye_cb() - qmi bye message callback
> + * @handle: QMI handle
> + * @node: id of the dying node
> + *
> + * This callback is invoked when the QMI bye control message is received
> + * from the QMI client.  Handle the message accordingly by ensuring that
> + * the USB offload path is disabled and cleaned up.  At this point, ADSP
> + * is not utilizing the USB bus.
> + *
> + */
> +static void qmi_bye_cb(struct qmi_handle *handle, unsigned int node)
> +{
> +	struct uaudio_qmi_svc *svc = uaudio_svc;
> +
> +	if (svc->uaudio_svc_hdl != handle)
> +		return;
> +
> +	if (svc->client_connected && svc->client_sq.sq_node == node) {
> +		queue_work(svc->uaudio_wq, &svc->qmi_disconnect_work);
> +		svc->client_sq.sq_node = 0;
> +		svc->client_sq.sq_port = 0;
> +		svc->client_sq.sq_family = 0;
> +		svc->client_connected = false;
> +	}
> +}
> +
> +/**
> + * qmi_svc_disconnect_cb() - qmi client disconnected
> + * @handle: QMI handle
> + * @node: id of the dying node
> + * @port: port of the dying client
> + *
> + * Invoked when the remote QMI client is disconnected.  Handle this event
> + * the same way as when the QMI bye message is received.  This will ensure
> + * the USB offloading path is disabled and cleaned up.
> + *
> + */
> +static void qmi_svc_disconnect_cb(struct qmi_handle *handle,
> +				  unsigned int node, unsigned int port)
> +{
> +	struct uaudio_qmi_svc *svc;
> +
> +	if (uaudio_svc == NULL)
> +		return;
> +
> +	svc = uaudio_svc;
> +	if (svc->uaudio_svc_hdl != handle)
> +		return;
> +
> +	if (svc->client_connected && svc->client_sq.sq_node == node &&
> +			svc->client_sq.sq_port == port) {
> +		queue_work(svc->uaudio_wq, &svc->qmi_disconnect_work);
> +		svc->client_sq.sq_node = 0;
> +		svc->client_sq.sq_port = 0;
> +		svc->client_sq.sq_family = 0;
> +		svc->client_connected = false;

this feels racy, shouldn't all these reset values be set in the work
function?

> +	}
> +}
> +
> +/* QMI client callback handlers from QMI interface */
> +static struct qmi_ops uaudio_svc_ops_options = {
> +	.bye = qmi_bye_cb,
> +	.del_client = qmi_svc_disconnect_cb,
> +};
> +
> +/* kref release callback when all streams are disabled */
> +static void uaudio_dev_release(struct kref *kref)
> +{
> +	struct uaudio_dev *dev = container_of(kref, struct uaudio_dev, kref);
> +
> +	uaudio_event_ring_cleanup_free(dev);
> +	atomic_set(&dev->in_use, 0);
> +	wake_up(&dev->disconnect_wq);
> +}
> +
> +/**
> + * enable_audio_stream() - enable usb snd endpoints
> + * @subs: usb substream
> + * @pcm_format: pcm format requested
> + * @channels: number of channels
> + * @cur_rate: sample rate
> + * @datainterval: interval
> + *
> + * Opens all USB SND endpoints used for the data interface.  This will increment
> + * the USB SND endpoint's opened count.  Requests to keep the interface resumed
> + * until the audio stream is stopped.  Will issue the USB set interface control
> + * message to enable the data interface.
> + *
> + */
> +static int enable_audio_stream(struct snd_usb_substream *subs,
> +				snd_pcm_format_t pcm_format,
> +				unsigned int channels, unsigned int cur_rate,
> +				int datainterval)
> +{
> +	struct snd_usb_audio *chip = subs->stream->chip;
> +	struct snd_pcm_hw_params params;
> +	struct snd_mask *m;
> +	struct snd_interval *i;
> +	int ret;
> +
> +	_snd_pcm_hw_params_any(&params);
> +
> +	m = hw_param_mask(&params, SNDRV_PCM_HW_PARAM_FORMAT);
> +	snd_mask_leave(m, pcm_format);
> +
> +	i = hw_param_interval(&params, SNDRV_PCM_HW_PARAM_CHANNELS);
> +	snd_interval_setinteger(i);
> +	i->min = i->max = channels;
> +
> +	i = hw_param_interval(&params, SNDRV_PCM_HW_PARAM_RATE);
> +	snd_interval_setinteger(i);
> +	i->min = i->max = cur_rate;
> +
> +	pm_runtime_barrier(&chip->intf[0]->dev);
> +	snd_usb_autoresume(chip);
> +
> +	ret = snd_usb_hw_params(subs, &params);
> +	if (ret < 0)
> +		goto put_suspend;
> +
> +	if (!atomic_read(&chip->shutdown)) {
> +		ret = snd_usb_lock_shutdown(chip);
> +		if (ret < 0)
> +			goto detach_ep;
> +
> +		if (subs->sync_endpoint) {
> +			ret = snd_usb_endpoint_prepare(chip, subs->sync_endpoint);
> +			if (ret < 0)
> +				goto unlock;
> +		}
> +
> +		ret = snd_usb_endpoint_prepare(chip, subs->data_endpoint);
> +		if (ret < 0)
> +			goto unlock;
> +
> +		snd_usb_unlock_shutdown(chip);
> +
> +		dev_dbg(uaudio_qdev->dev,
> +			"selected %s iface:%d altsetting:%d datainterval:%dus\n",
> +			subs->direction ? "capture" : "playback",
> +			subs->cur_audiofmt->iface, subs->cur_audiofmt->altsetting,
> +			(1 << subs->cur_audiofmt->datainterval) *
> +			(subs->dev->speed >= USB_SPEED_HIGH ?
> +			BUS_INTERVAL_HIGHSPEED_AND_ABOVE :
> +			BUS_INTERVAL_FULL_SPEED));
> +	}
> +
> +	return 0;
> +
> +unlock:
> +	snd_usb_unlock_shutdown(chip);
> +
> +detach_ep:
> +	snd_usb_hw_free(subs);
> +
> +put_suspend:
> +	snd_usb_autosuspend(chip);
> +
> +	return ret;
> +}
> +
> +/* returns usb hcd sysdev */
> +static struct device *usb_get_usb_backend(struct usb_device *udev)
> +{
> +	if (udev->bus->sysdev && udev->bus->sysdev->of_node)
> +		return udev->bus->sysdev;
> +
> +	return NULL;
> +}
> +
> +/**
> + * prepare_qmi_response() - prepare stream enable response
> + * @subs: usb substream
> + * @req_msg: QMI request message
> + * @resp: QMI response buffer
> + * @info_idx: usb interface array index
> + *
> + * Prepares the QMI response for a USB QMI stream enable request.  Will parse
> + * out the parameters within the stream enable request, in order to match
> + * requested audio profile to the ones exposed by the USB device connected.
> + *
> + * In addition, will fetch the XHCI transfer resources needed for the handoff to
> + * happen.  This includes, transfer ring and buffer addresses and secondary event
> + * ring address.  These parameters will be communicated as part of the USB QMI
> + * stream enable response.
> + *
> + */
> +static int prepare_qmi_response(struct snd_usb_substream *subs,
> +		struct qmi_uaudio_stream_req_msg_v01 *req_msg,
> +		struct qmi_uaudio_stream_resp_msg_v01 *resp, int info_idx)
> +{
> +	struct usb_interface *iface;
> +	struct usb_host_interface *alts;
> +	struct usb_interface_descriptor *altsd;
> +	struct usb_interface_assoc_descriptor *assoc;
> +	struct usb_host_endpoint *ep;
> +	struct uac_format_type_i_continuous_descriptor *fmt;
> +	struct uac_format_type_i_discrete_descriptor *fmt_v1;
> +	struct uac_format_type_i_ext_descriptor *fmt_v2;
> +	struct uac1_as_header_descriptor *as;
> +	struct q6usb_offload *data;
> +	int ret;
> +	int protocol, card_num, pcm_dev_num;
> +	void *hdr_ptr;
> +	u8 *xfer_buf;
> +	unsigned int data_ep_pipe = 0, sync_ep_pipe = 0;
> +	u32 len, mult, remainder, xfer_buf_len;
> +	unsigned long va, tr_data_va = 0, tr_sync_va = 0;
> +	phys_addr_t xhci_pa, xfer_buf_pa, tr_data_pa = 0, tr_sync_pa = 0;
> +	struct sg_table *sgt;
> +	struct sg_table xfer_buf_sgt;
> +	struct page *pg;
> +	bool dma_coherent;

consider simplifying or splitting in different functions? you have 20
lines and probably 30-odd variables. This is a bit beyond what reviewers
can handle...
> +
> +	iface = usb_ifnum_to_if(subs->dev, subs->cur_audiofmt->iface);
> +	if (!iface) {
> +		dev_err(uaudio_qdev->dev, "interface # %d does not exist\n",
> +			subs->cur_audiofmt->iface);
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	assoc = iface->intf_assoc;
> +	pcm_dev_num = (req_msg->usb_token & QMI_STREAM_REQ_DEV_NUM_MASK) >> 8;
> +	xfer_buf_len = req_msg->xfer_buff_size;
> +	card_num = uaudio_qdev->last_card_num;
> +
> +	alts = &iface->altsetting[subs->cur_audiofmt->altset_idx];
> +	altsd = get_iface_desc(alts);
> +	protocol = altsd->bInterfaceProtocol;
> +
> +	/* get format type */
> +	if (protocol != UAC_VERSION_3) {
> +		fmt = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL,
> +				UAC_FORMAT_TYPE);
> +		if (!fmt) {
> +			dev_err(uaudio_qdev->dev,
> +				"%u:%d : no UAC_FORMAT_TYPE desc\n",
> +				subs->cur_audiofmt->iface,
> +				subs->cur_audiofmt->altset_idx);
> +			ret = -ENODEV;
> +			goto err;
> +		}
> +	}
> +
> +	if (!uadev[card_num].ctrl_intf) {
> +		dev_err(uaudio_qdev->dev, "audio ctrl intf info not cached\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	if (protocol != UAC_VERSION_3) {
> +		hdr_ptr = snd_usb_find_csint_desc(uadev[card_num].ctrl_intf->extra,
> +				uadev[card_num].ctrl_intf->extralen, NULL,
> +				UAC_HEADER);
> +		if (!hdr_ptr) {
> +			dev_err(uaudio_qdev->dev, "no UAC_HEADER desc\n");
> +			ret = -ENODEV;
> +			goto err;
> +		}
> +	}
> +
> +	if (protocol == UAC_VERSION_1) {
> +		struct uac1_ac_header_descriptor *uac1_hdr = hdr_ptr;
> +
> +		as = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL,
> +			UAC_AS_GENERAL);
> +		if (!as) {
> +			dev_err(uaudio_qdev->dev,
> +				"%u:%d : no UAC_AS_GENERAL desc\n",
> +				subs->cur_audiofmt->iface,
> +				subs->cur_audiofmt->altset_idx);
> +			ret = -ENODEV;
> +			goto err;
> +		}
> +		resp->data_path_delay = as->bDelay;
> +		resp->data_path_delay_valid = 1;
> +		fmt_v1 = (struct uac_format_type_i_discrete_descriptor *)fmt;
> +		resp->usb_audio_subslot_size = fmt_v1->bSubframeSize;
> +		resp->usb_audio_subslot_size_valid = 1;
> +
> +		resp->usb_audio_spec_revision = le16_to_cpu(uac1_hdr->bcdADC);
> +		resp->usb_audio_spec_revision_valid = 1;
> +	} else if (protocol == UAC_VERSION_2) {
> +		struct uac2_ac_header_descriptor *uac2_hdr = hdr_ptr;
> +
> +		fmt_v2 = (struct uac_format_type_i_ext_descriptor *)fmt;
> +		resp->usb_audio_subslot_size = fmt_v2->bSubslotSize;
> +		resp->usb_audio_subslot_size_valid = 1;
> +
> +		resp->usb_audio_spec_revision = le16_to_cpu(uac2_hdr->bcdADC);
> +		resp->usb_audio_spec_revision_valid = 1;
> +	} else if (protocol == UAC_VERSION_3) {
> +		if (assoc->bFunctionSubClass ==
> +					UAC3_FUNCTION_SUBCLASS_FULL_ADC_3_0) {
> +			dev_err(uaudio_qdev->dev, "full adc is not supported\n");
> +			ret = -EINVAL;
> +		}
> +
> +		switch (le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize)) {
> +		case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_16:
> +		case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_16:
> +		case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_16:
> +		case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_16: {
> +			resp->usb_audio_subslot_size = 0x2;
> +			break;
> +		}
> +
> +		case UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_24:
> +		case UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_24:
> +		case UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_24:
> +		case UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_24: {
> +			resp->usb_audio_subslot_size = 0x3;
> +			break;
> +		}
> +
> +		default:
> +			dev_err(uaudio_qdev->dev,
> +				"%d: %u: Invalid wMaxPacketSize\n",
> +				subs->cur_audiofmt->iface,
> +				subs->cur_audiofmt->altset_idx);
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		resp->usb_audio_subslot_size_valid = 1;
> +	} else {
> +		dev_err(uaudio_qdev->dev, "unknown protocol version %x\n",
> +			protocol);
> +		ret = -ENODEV;
> +		goto err;
> +	}

these 100-odd lines look like duplicated code. Why would we redo the
parsing of UAC3 stuff in a QCOM-specific driver?

> +
> +	resp->slot_id = subs->dev->slot_id;
> +	resp->slot_id_valid = 1;
> +
> +	memcpy(&resp->std_as_opr_intf_desc, &alts->desc, sizeof(alts->desc));
> +	resp->std_as_opr_intf_desc_valid = 1;
> +
> +	ep = usb_pipe_endpoint(subs->dev, subs->data_endpoint->pipe);
> +	if (!ep) {
> +		dev_err(uaudio_qdev->dev, "data ep # %d context is null\n",
> +			subs->data_endpoint->ep_num);
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +	data_ep_pipe = subs->data_endpoint->pipe;
> +	memcpy(&resp->std_as_data_ep_desc, &ep->desc, sizeof(ep->desc));
> +	resp->std_as_data_ep_desc_valid = 1;
> +
> +	ret = xhci_sideband_add_endpoint(uadev[card_num].sb, ep);
> +	if (ret < 0) {
> +		dev_err(uaudio_qdev->dev, "failed to add data ep to sideband\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	sgt = xhci_sideband_get_endpoint_buffer(uadev[card_num].sb, ep);
> +	if (!sgt) {
> +		dev_err(uaudio_qdev->dev, "failed to get data ep ring address\n");
> +		ret = -ENODEV;
> +		goto drop_data_ep;
> +	}
> +
> +	pg = sg_page(sgt->sgl);
> +	tr_data_pa = page_to_phys(pg);
> +	resp->xhci_mem_info.tr_data.pa = sg_dma_address(sgt->sgl);
> +	sg_free_table(sgt);
> +
> +	if (subs->sync_endpoint) {
> +		ep = usb_pipe_endpoint(subs->dev, subs->sync_endpoint->pipe);
> +		if (!ep) {
> +			dev_err(uaudio_qdev->dev, "implicit fb on data ep\n");
> +			goto skip_sync_ep;
> +		}
> +		sync_ep_pipe = subs->sync_endpoint->pipe;
> +		memcpy(&resp->std_as_sync_ep_desc, &ep->desc, sizeof(ep->desc));
> +		resp->std_as_sync_ep_desc_valid = 1;
> +
> +		ret = xhci_sideband_add_endpoint(uadev[card_num].sb, ep);
> +		if (ret < 0) {
> +			dev_err(uaudio_qdev->dev,
> +				"failed to add sync ep to sideband\n");
> +			ret = -ENODEV;
> +			goto drop_data_ep;
> +		}
> +
> +		sgt = xhci_sideband_get_endpoint_buffer(uadev[card_num].sb, ep);
> +		if (!sgt) {
> +			dev_err(uaudio_qdev->dev, "failed to get sync ep ring address\n");
> +			ret = -ENODEV;
> +			goto drop_sync_ep;
> +		}
> +
> +		pg = sg_page(sgt->sgl);
> +		tr_sync_pa = page_to_phys(pg);
> +		resp->xhci_mem_info.tr_sync.pa = sg_dma_address(sgt->sgl);
> +		sg_free_table(sgt);
> +	}
> +
> +skip_sync_ep:
> +	data = snd_soc_usb_find_priv_data(usb_get_usb_backend(subs->dev));
> +	if (!data)
> +		goto drop_sync_ep;
> +
> +	uaudio_qdev->domain = data->domain;
> +	uaudio_qdev->sid = data->sid;
> +	uaudio_qdev->intr_num = data->intr_num;
> +	uaudio_qdev->dev = data->dev;
> +
> +	resp->interrupter_num_valid = 1;
> +	resp->controller_num_valid = 0;
> +	ret = usb_get_controller_id(subs->dev);
> +	if (ret >= 0) {
> +		resp->controller_num = ret;
> +		resp->controller_num_valid = 1;
> +	}
> +	/* map xhci data structures PA memory to iova */
> +	dma_coherent = dev_is_dma_coherent(subs->dev->bus->sysdev);
> +
> +	/* event ring */
> +	ret = xhci_sideband_create_interrupter(uadev[card_num].sb, uaudio_qdev->intr_num);
> +	if (ret < 0) {
> +		dev_err(uaudio_qdev->dev, "failed to fetch interrupter\n");
> +		ret = -ENODEV;
> +		goto drop_sync_ep;
> +	}
> +
> +	sgt = xhci_sideband_get_event_buffer(uadev[card_num].sb);
> +	if (!sgt) {
> +		dev_err(uaudio_qdev->dev, "failed to get event ring address\n");
> +		ret = -ENODEV;
> +		goto free_sec_ring;
> +	}
> +
> +	xhci_pa = page_to_phys(sg_page(sgt->sgl));
> +	resp->xhci_mem_info.evt_ring.pa = sg_dma_address(sgt->sgl);
> +	sg_free_table(sgt);
> +	if (!xhci_pa) {
> +		dev_err(uaudio_qdev->dev,
> +			"failed to get sec event ring address\n");
> +		ret = -ENODEV;
> +		goto free_sec_ring;
> +	}
> +
> +	resp->interrupter_num = xhci_sideband_interrupter_id(uadev[card_num].sb);
> +
> +	va = uaudio_iommu_map(MEM_EVENT_RING, dma_coherent, xhci_pa, PAGE_SIZE,
> +			NULL);
> +	if (!va) {
> +		ret = -ENOMEM;
> +		goto free_sec_ring;
> +	}
> +
> +	resp->xhci_mem_info.evt_ring.va = PREPEND_SID_TO_IOVA(va,
> +						uaudio_qdev->sid);
> +	resp->xhci_mem_info.evt_ring.size = PAGE_SIZE;
> +	uaudio_qdev->er_mapped = true;
> +
> +	resp->speed_info = get_speed_info(subs->dev->speed);
> +	if (resp->speed_info == USB_QMI_DEVICE_SPEED_INVALID_V01) {
> +		ret = -ENODEV;
> +		goto unmap_er;
> +	}
> +
> +	resp->speed_info_valid = 1;
> +
> +	/* data transfer ring */
> +	va = uaudio_iommu_map(MEM_XFER_RING, dma_coherent, tr_data_pa,
> +			PAGE_SIZE, NULL);
> +	if (!va) {
> +		ret = -ENOMEM;
> +		goto unmap_er;
> +	}
> +
> +	tr_data_va = va;
> +	resp->xhci_mem_info.tr_data.va = PREPEND_SID_TO_IOVA(va,
> +						uaudio_qdev->sid);
> +	resp->xhci_mem_info.tr_data.size = PAGE_SIZE;
> +
> +	/* sync transfer ring */
> +	if (!resp->xhci_mem_info.tr_sync.pa)
> +		goto skip_sync;
> +
> +	xhci_pa = resp->xhci_mem_info.tr_sync.pa;
> +	va = uaudio_iommu_map(MEM_XFER_RING, dma_coherent, tr_sync_pa,
> +			PAGE_SIZE, NULL);
> +	if (!va) {
> +		ret = -ENOMEM;
> +		goto unmap_data;
> +	}
> +
> +	tr_sync_va = va;
> +	resp->xhci_mem_info.tr_sync.va = PREPEND_SID_TO_IOVA(va,
> +						uaudio_qdev->sid);
> +	resp->xhci_mem_info.tr_sync.size = PAGE_SIZE;
> +
> +skip_sync:
> +	/* xfer buffer, multiple of 4K only */
> +	if (!xfer_buf_len)
> +		xfer_buf_len = PAGE_SIZE;
> +
> +	mult = xfer_buf_len / PAGE_SIZE;
> +	remainder = xfer_buf_len % PAGE_SIZE;
> +	len = mult * PAGE_SIZE;
> +	len += remainder ? PAGE_SIZE : 0;
> +
> +	if (len > MAX_XFER_BUFF_LEN) {
> +		dev_err(uaudio_qdev->dev,
> +			"req buf len %d > max buf len %lu, setting %lu\n",
> +			len, MAX_XFER_BUFF_LEN, MAX_XFER_BUFF_LEN);
> +		len = MAX_XFER_BUFF_LEN;
> +	}
> +
> +	xfer_buf = usb_alloc_coherent(subs->dev, len, GFP_KERNEL, &xfer_buf_pa);
> +	if (!xfer_buf) {
> +		ret = -ENOMEM;
> +		goto unmap_sync;
> +	}
> +
> +	dma_get_sgtable(subs->dev->bus->sysdev, &xfer_buf_sgt, xfer_buf, xfer_buf_pa,
> +			len);
> +	va = uaudio_iommu_map(MEM_XFER_BUF, dma_coherent, xfer_buf_pa, len,
> +			&xfer_buf_sgt);
> +	if (!va) {
> +		ret = -ENOMEM;
> +		goto unmap_sync;
> +	}
> +
> +	resp->xhci_mem_info.xfer_buff.pa = xfer_buf_pa;
> +	resp->xhci_mem_info.xfer_buff.size = len;
> +
> +	resp->xhci_mem_info.xfer_buff.va = PREPEND_SID_TO_IOVA(va,
> +						uaudio_qdev->sid);
> +
> +	resp->xhci_mem_info_valid = 1;
> +
> +	sg_free_table(&xfer_buf_sgt);
> +
> +	if (!atomic_read(&uadev[card_num].in_use)) {
> +		kref_init(&uadev[card_num].kref);
> +		init_waitqueue_head(&uadev[card_num].disconnect_wq);
> +		uadev[card_num].num_intf =
> +			subs->dev->config->desc.bNumInterfaces;
> +		uadev[card_num].info = kcalloc(uadev[card_num].num_intf,
> +			sizeof(struct intf_info), GFP_KERNEL);
> +		if (!uadev[card_num].info) {
> +			ret = -ENOMEM;
> +			goto unmap_sync;
> +		}
> +		uadev[card_num].udev = subs->dev;
> +		atomic_set(&uadev[card_num].in_use, 1);
> +	} else {
> +		kref_get(&uadev[card_num].kref);
> +	}
> +
> +	uadev[card_num].usb_core_id = resp->controller_num;
> +
> +	/* cache intf specific info to use it for unmap and free xfer buf */
> +	uadev[card_num].info[info_idx].data_xfer_ring_va = tr_data_va;
> +	uadev[card_num].info[info_idx].data_xfer_ring_size = PAGE_SIZE;
> +	uadev[card_num].info[info_idx].sync_xfer_ring_va = tr_sync_va;
> +	uadev[card_num].info[info_idx].sync_xfer_ring_size = PAGE_SIZE;
> +	uadev[card_num].info[info_idx].xfer_buf_va = va;
> +	uadev[card_num].info[info_idx].xfer_buf_pa = xfer_buf_pa;
> +	uadev[card_num].info[info_idx].xfer_buf_size = len;
> +	uadev[card_num].info[info_idx].data_ep_pipe = data_ep_pipe;
> +	uadev[card_num].info[info_idx].sync_ep_pipe = sync_ep_pipe;
> +	uadev[card_num].info[info_idx].xfer_buf = xfer_buf;
> +	uadev[card_num].info[info_idx].pcm_card_num = card_num;
> +	uadev[card_num].info[info_idx].pcm_dev_num = pcm_dev_num;
> +	uadev[card_num].info[info_idx].direction = subs->direction;
> +	uadev[card_num].info[info_idx].intf_num = subs->cur_audiofmt->iface;
> +	uadev[card_num].info[info_idx].in_use = true;
> +
> +	set_bit(card_num, &uaudio_qdev->card_slot);
> +
> +	return 0;
> +
> +unmap_sync:
> +	usb_free_coherent(subs->dev, len, xfer_buf, xfer_buf_pa);
> +	uaudio_iommu_unmap(MEM_XFER_RING, tr_sync_va, PAGE_SIZE, PAGE_SIZE);
> +unmap_data:
> +	uaudio_iommu_unmap(MEM_XFER_RING, tr_data_va, PAGE_SIZE, PAGE_SIZE);
> +unmap_er:
> +	uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE, PAGE_SIZE);
> +free_sec_ring:
> +	xhci_sideband_remove_interrupter(uadev[card_num].sb);
> +drop_sync_ep:
> +	if (subs->sync_endpoint)
> +		xhci_sideband_remove_endpoint(uadev[card_num].sb,
> +			usb_pipe_endpoint(subs->dev, subs->sync_endpoint->pipe));
> +drop_data_ep:
> +	xhci_sideband_remove_endpoint(uadev[card_num].sb,
> +			usb_pipe_endpoint(subs->dev, subs->data_endpoint->pipe));
> +
> +err:
> +	return ret;
> +}

this is really the largest function I've seen in a while... Can this use
helpers or be more modular?

> +
> +/**
> + * handle_uaudio_stream_req() - handle stream enable/disable request
> + * @handle: QMI client handle
> + * @sq: qrtr socket
> + * @txn: QMI transaction context
> + * @decoded_msg: decoded QMI message
> + *
> + * Main handler for the QMI stream enable/disable requests.  This executes the
> + * corresponding enable/disable stream apis, respectively.
> + *
> + */
> +static void handle_uaudio_stream_req(struct qmi_handle *handle,
> +			struct sockaddr_qrtr *sq,
> +			struct qmi_txn *txn,
> +			const void *decoded_msg)
> +{
> +	struct qmi_uaudio_stream_req_msg_v01 *req_msg;
> +	struct qmi_uaudio_stream_resp_msg_v01 resp = {{0}, 0};
> +	struct snd_usb_substream *subs;
> +	struct snd_usb_audio *chip = NULL;
> +	struct uaudio_qmi_svc *svc = uaudio_svc;
> +	struct intf_info *info;
> +	struct usb_host_endpoint *ep;
> +	u8 pcm_card_num, pcm_dev_num, direction;
> +	int info_idx = -EINVAL, datainterval = -EINVAL, ret = 0;
> +
> +	if (!svc->client_connected) {
> +		svc->client_sq = *sq;
> +		svc->client_connected = true;
> +	}
> +
> +	mutex_lock(&qdev_mutex);
> +	req_msg = (struct qmi_uaudio_stream_req_msg_v01 *)decoded_msg;
> +	if (!req_msg->audio_format_valid || !req_msg->bit_rate_valid ||
> +	    !req_msg->number_of_ch_valid || !req_msg->xfer_buff_size_valid) {
> +		ret = -EINVAL;

this looks like copy pasted code, this function return void so all uses
of 'ret' are not so useful, are they?

> +		goto response;
> +	}
> +
> +	if (!uaudio_qdev) {
> +		ret = -EINVAL;
> +		goto response;
> +	}
> +
> +	direction = (req_msg->usb_token & QMI_STREAM_REQ_DIRECTION);
> +	pcm_dev_num = (req_msg->usb_token & QMI_STREAM_REQ_DEV_NUM_MASK) >> 8;
> +	pcm_card_num = req_msg->enable ? uaudio_qdev->last_card_num :
> +				ffs(uaudio_qdev->card_slot) - 1;
> +	if (pcm_card_num >= SNDRV_CARDS) {
> +		ret = -EINVAL;
> +		goto response;
> +	}
> +
> +	if (req_msg->audio_format > USB_QMI_PCM_FORMAT_U32_BE) {
> +		ret = -EINVAL;
> +		goto response;
> +	}
> +
> +	subs = find_substream(pcm_card_num, pcm_dev_num, direction);
> +	chip = uadev[pcm_card_num].chip;
> +	if (!subs || !chip || atomic_read(&chip->shutdown)) {
> +		ret = -ENODEV;
> +		goto response;
> +	}
> +
> +	info_idx = info_idx_from_ifnum(pcm_card_num, subs->cur_audiofmt ?
> +			subs->cur_audiofmt->iface : -1, req_msg->enable);
> +	if (atomic_read(&chip->shutdown) || !subs->stream || !subs->stream->pcm
> +			|| !subs->stream->chip) {
> +		ret = -ENODEV;
> +		goto response;
> +	}
> +
> +	if (req_msg->enable) {
> +		if (info_idx < 0 || chip->system_suspend) {
> +			ret = -EBUSY;
> +			goto response;
> +		}
> +	}
> +
> +	if (req_msg->service_interval_valid) {
> +		ret = get_data_interval_from_si(subs,
> +						req_msg->service_interval);
> +		if (ret == -EINVAL)
> +			goto response;
> +
> +		datainterval = ret;
> +	}
> +
> +	uadev[pcm_card_num].ctrl_intf = chip->ctrl_intf;
> +
> +	if (req_msg->enable) {
> +		ret = enable_audio_stream(subs,
> +				map_pcm_format(req_msg->audio_format),
> +				req_msg->number_of_ch, req_msg->bit_rate,
> +				datainterval);
> +
> +		if (!ret)
> +			ret = prepare_qmi_response(subs, req_msg, &resp,
> +					info_idx);
> +	} else {
> +		info = &uadev[pcm_card_num].info[info_idx];
> +		if (info->data_ep_pipe) {
> +			ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
> +						info->data_ep_pipe);
> +			if (ep)
> +				xhci_sideband_stop_endpoint(uadev[pcm_card_num].sb,
> +						ep);
> +			xhci_sideband_remove_endpoint(uadev[pcm_card_num].sb, ep);
> +			info->data_ep_pipe = 0;
> +		}
> +
> +		if (info->sync_ep_pipe) {
> +			ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
> +						info->sync_ep_pipe);
> +			if (ep)
> +				xhci_sideband_stop_endpoint(uadev[pcm_card_num].sb,
> +						ep);
> +			xhci_sideband_remove_endpoint(uadev[pcm_card_num].sb, ep);
> +			info->sync_ep_pipe = 0;
> +		}
> +
> +		disable_audio_stream(subs);
> +	}
> +
> +response:
> +	if (!req_msg->enable && ret != -EINVAL && ret != -ENODEV) {
> +		mutex_lock(&chip->mutex);
> +		if (info_idx >= 0) {
> +			info = &uadev[pcm_card_num].info[info_idx];
> +			uaudio_dev_intf_cleanup(
> +					uadev[pcm_card_num].udev,
> +					info);
> +		}
> +		if (atomic_read(&uadev[pcm_card_num].in_use))
> +			kref_put(&uadev[pcm_card_num].kref,
> +					uaudio_dev_release);
> +		mutex_unlock(&chip->mutex);
> +	}
> +	mutex_unlock(&qdev_mutex);
> +
> +	resp.usb_token = req_msg->usb_token;
> +	resp.usb_token_valid = 1;
> +	resp.internal_status = ret;
> +	resp.internal_status_valid = 1;
> +	resp.status = ret ? USB_QMI_STREAM_REQ_FAILURE_V01 : ret;
> +	resp.status_valid = 1;
> +	ret = qmi_send_response(svc->uaudio_svc_hdl, sq, txn,
> +			QMI_UAUDIO_STREAM_RESP_V01,
> +			QMI_UAUDIO_STREAM_RESP_MSG_V01_MAX_MSG_LEN,
> +			qmi_uaudio_stream_resp_msg_v01_ei, &resp);

ret is not used?

> +}


I stopped here...

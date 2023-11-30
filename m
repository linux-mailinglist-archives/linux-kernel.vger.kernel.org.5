Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249037FEA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbjK3IWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjK3IWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:22:01 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B240ED50
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:22:06 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1fa486a0e10so316850fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701332526; x=1701937326; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6fFtvMm9yl0lPcAmlRwHHNDchE2fl94adz7eE2fgLUQ=;
        b=Jowcm666R20Dm2jszDojJ4v2WOlR2J76uclrmLmOrUx+q7+YjLD7Q+Tfaclp6D3Lej
         6kJwbBqxoiDdQAZPX3H4y9ZYZ0QWZTe95abIgrueXm9a+aqmu9Q19BqrsGCHRnQNGKmC
         Aoo3vce0ZcomvW+AkcTBTZI0PBg9UXjn9GFIi3ZpFPROt6JyWaBgbWUzIhfYTil6ohvd
         lgGaj8SqQ2KJhx77yPdNa7LNVR4T7cLDTOQ/ssCaQLq758ogoBiGsulzpMd5MajEy+wu
         Bh3cA68XI6Drc/MHy5zNmzPaAQDJ8hr6FUOhRdEanxvamsjxQRAvbTCiT6WHpkbodjIT
         3ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701332526; x=1701937326;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fFtvMm9yl0lPcAmlRwHHNDchE2fl94adz7eE2fgLUQ=;
        b=KwLGkEosaTPgCURxNpcPW0sPd2RkW4Wsn5d9Xa77d4FaUNcF4Jh1j9sffLWALekxP1
         8hwW81wBf4uGupLoUFIyZAFzoyML/2J6CdCFr9oduI3JoPkY/0wpoZVTP3kEobiyOeKg
         nwkum/dBuwocWL5QRq97xkTH1H9rHG7hEdiWvD0YzykhRsG93sel22hZgqXpibw9IZiq
         53TNsZF50x/nUUOwAqY4TRRWqz+6G+eQdRMuRNG7saKf+NElGlRT2knZpH0RUVOj0glJ
         0Lf9uYqgvO6gnexQzDdS7ktsXkXLy0jlMhqaIhQzMAdk66BmgdTcuVWcMxSmTEn9w4FJ
         qShg==
X-Gm-Message-State: AOJu0Yx+459SvYdjxy8RAuilalaPs9PREZ6powJ2+tv1Nr+dqsfhyR1g
        XNEt4/DHpfdUOGndGsmq9nTuaQld5r2LfoQajQ==
X-Google-Smtp-Source: AGHT+IESiVrnCDdwf6AtlJDG8qdmmXEpsxG9JJTQQ76c7rG9Do52+Sl2zNkV7SXJ9RaP66TsEod2SA==
X-Received: by 2002:a05:6870:498a:b0:1f9:5f20:8c7a with SMTP id ho10-20020a056870498a00b001f95f208c7amr27293949oab.21.1701332525987;
        Thu, 30 Nov 2023 00:22:05 -0800 (PST)
Received: from thinkpad ([59.92.100.237])
        by smtp.gmail.com with ESMTPSA id z19-20020a05620a101300b0077d75164ef9sm265513qkj.124.2023.11.30.00.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 00:22:05 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:51:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: Re: [PATCH] bus: mhi: ep: Use slab allocator where applicable
Message-ID: <20231130082159.GK3043@thinkpad>
References: <20231018122812.47261-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018122812.47261-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 05:58:12PM +0530, Manivannan Sadhasivam wrote:
> Use slab allocator for allocating the memory for objects used frequently
> and are of fixed size. This reduces the overheard associated with
> kmalloc().
> 
> Suggested-by: Alex Elder <elder@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to mhi-next!

- Mani

> ---
>  drivers/bus/mhi/ep/main.c | 70 +++++++++++++++++++++++++++++----------
>  include/linux/mhi_ep.h    |  3 ++
>  2 files changed, 56 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 66ca470bf302..834e7afadd64 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -71,7 +71,8 @@ static int mhi_ep_send_event(struct mhi_ep_cntrl *mhi_cntrl, u32 ring_idx,
>  static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
>  					struct mhi_ring_element *tre, u32 len, enum mhi_ev_ccs code)
>  {
> -	struct mhi_ring_element *event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
> +	struct mhi_ring_element *event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache,
> +							   GFP_KERNEL | GFP_DMA);
>  	int ret;
>  
>  	event->ptr = cpu_to_le64(ring->rbase + ring->rd_offset * sizeof(*tre));
> @@ -79,42 +80,45 @@ static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl, struct m
>  	event->dword[1] = MHI_TRE_EV_DWORD1(ring->ch_id, MHI_PKT_TYPE_TX_EVENT);
>  
>  	ret = mhi_ep_send_event(mhi_cntrl, ring->er_index, event, MHI_TRE_DATA_GET_BEI(tre));
> -	kfree(event);
> +	kmem_cache_free(mhi_cntrl->ev_ring_el_cache, event);
>  
>  	return ret;
>  }
>  
>  int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_state state)
>  {
> -	struct mhi_ring_element *event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
> +	struct mhi_ring_element *event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache,
> +							   GFP_KERNEL | GFP_DMA);
>  	int ret;
>  
>  	event->dword[0] = MHI_SC_EV_DWORD0(state);
>  	event->dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_STATE_CHANGE_EVENT);
>  
>  	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
> -	kfree(event);
> +	kmem_cache_free(mhi_cntrl->ev_ring_el_cache, event);
>  
>  	return ret;
>  }
>  
>  int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_env)
>  {
> -	struct mhi_ring_element *event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
> +	struct mhi_ring_element *event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache,
> +							   GFP_KERNEL | GFP_DMA);
>  	int ret;
>  
>  	event->dword[0] = MHI_EE_EV_DWORD0(exec_env);
>  	event->dword[1] = MHI_SC_EV_DWORD1(MHI_PKT_TYPE_EE_EVENT);
>  
>  	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
> -	kfree(event);
> +	kmem_cache_free(mhi_cntrl->ev_ring_el_cache, event);
>  
>  	return ret;
>  }
>  
>  static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ev_ccs code)
>  {
> -	struct mhi_ring_element *event = kzalloc(sizeof(struct mhi_ring_element), GFP_KERNEL);
> +	struct mhi_ring_element *event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache,
> +							   GFP_KERNEL | GFP_DMA);
>  	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_cmd->ring;
>  	int ret;
>  
> @@ -123,7 +127,7 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
>  	event->dword[1] = MHI_CC_EV_DWORD1(MHI_PKT_TYPE_CMD_COMPLETION_EVENT);
>  
>  	ret = mhi_ep_send_event(mhi_cntrl, 0, event, 0);
> -	kfree(event);
> +	kmem_cache_free(mhi_cntrl->ev_ring_el_cache, event);
>  
>  	return ret;
>  }
> @@ -435,7 +439,7 @@ static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_elem
>  		mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
>  	} else {
>  		/* UL channel */
> -		result.buf_addr = kzalloc(len, GFP_KERNEL);
> +		result.buf_addr = kmem_cache_zalloc(mhi_cntrl->tre_buf_cache, GFP_KERNEL | GFP_DMA);
>  		if (!result.buf_addr)
>  			return -ENOMEM;
>  
> @@ -443,7 +447,7 @@ static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_elem
>  			ret = mhi_ep_read_channel(mhi_cntrl, ring, &result, len);
>  			if (ret < 0) {
>  				dev_err(&mhi_chan->mhi_dev->dev, "Failed to read channel\n");
> -				kfree(result.buf_addr);
> +				kmem_cache_free(mhi_cntrl->tre_buf_cache, result.buf_addr);
>  				return ret;
>  			}
>  
> @@ -455,7 +459,7 @@ static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_elem
>  			/* Read until the ring becomes empty */
>  		} while (!mhi_ep_queue_is_empty(mhi_chan->mhi_dev, DMA_TO_DEVICE));
>  
> -		kfree(result.buf_addr);
> +		kmem_cache_free(mhi_cntrl->tre_buf_cache, result.buf_addr);
>  	}
>  
>  	return 0;
> @@ -764,14 +768,14 @@ static void mhi_ep_ch_ring_worker(struct work_struct *work)
>  		if (ret) {
>  			dev_err(dev, "Error updating write offset for ring\n");
>  			mutex_unlock(&chan->lock);
> -			kfree(itr);
> +			kmem_cache_free(mhi_cntrl->ring_item_cache, itr);
>  			continue;
>  		}
>  
>  		/* Sanity check to make sure there are elements in the ring */
>  		if (ring->rd_offset == ring->wr_offset) {
>  			mutex_unlock(&chan->lock);
> -			kfree(itr);
> +			kmem_cache_free(mhi_cntrl->ring_item_cache, itr);
>  			continue;
>  		}
>  
> @@ -783,12 +787,12 @@ static void mhi_ep_ch_ring_worker(struct work_struct *work)
>  			dev_err(dev, "Error processing ring for channel (%u): %d\n",
>  				ring->ch_id, ret);
>  			mutex_unlock(&chan->lock);
> -			kfree(itr);
> +			kmem_cache_free(mhi_cntrl->ring_item_cache, itr);
>  			continue;
>  		}
>  
>  		mutex_unlock(&chan->lock);
> -		kfree(itr);
> +		kmem_cache_free(mhi_cntrl->ring_item_cache, itr);
>  	}
>  }
>  
> @@ -844,7 +848,7 @@ static void mhi_ep_queue_channel_db(struct mhi_ep_cntrl *mhi_cntrl, unsigned lon
>  		u32 ch_id = ch_idx + i;
>  
>  		ring = &mhi_cntrl->mhi_chan[ch_id].ring;
> -		item = kzalloc(sizeof(*item), GFP_ATOMIC);
> +		item = kmem_cache_zalloc(mhi_cntrl->ring_item_cache, GFP_ATOMIC);
>  		if (!item)
>  			return;
>  
> @@ -1391,6 +1395,29 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>  		goto err_free_ch;
>  	}
>  
> +	mhi_cntrl->ev_ring_el_cache = kmem_cache_create("mhi_ep_event_ring_el",
> +							sizeof(struct mhi_ring_element), 0,
> +							SLAB_CACHE_DMA, NULL);
> +	if (!mhi_cntrl->ev_ring_el_cache) {
> +		ret = -ENOMEM;
> +		goto err_free_cmd;
> +	}
> +
> +	mhi_cntrl->tre_buf_cache = kmem_cache_create("mhi_ep_tre_buf", MHI_EP_DEFAULT_MTU, 0,
> +						      SLAB_CACHE_DMA, NULL);
> +	if (!mhi_cntrl->tre_buf_cache) {
> +		ret = -ENOMEM;
> +		goto err_destroy_ev_ring_el_cache;
> +	}
> +
> +	mhi_cntrl->ring_item_cache = kmem_cache_create("mhi_ep_ring_item",
> +							sizeof(struct mhi_ep_ring_item), 0,
> +							0, NULL);
> +	if (!mhi_cntrl->ev_ring_el_cache) {
> +		ret = -ENOMEM;
> +		goto err_destroy_tre_buf_cache;
> +	}
> +
>  	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
>  	INIT_WORK(&mhi_cntrl->reset_work, mhi_ep_reset_worker);
>  	INIT_WORK(&mhi_cntrl->cmd_ring_work, mhi_ep_cmd_ring_worker);
> @@ -1399,7 +1426,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>  	mhi_cntrl->wq = alloc_workqueue("mhi_ep_wq", 0, 0);
>  	if (!mhi_cntrl->wq) {
>  		ret = -ENOMEM;
> -		goto err_free_cmd;
> +		goto err_destroy_ring_item_cache;
>  	}
>  
>  	INIT_LIST_HEAD(&mhi_cntrl->st_transition_list);
> @@ -1458,6 +1485,12 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
>  	ida_free(&mhi_ep_cntrl_ida, mhi_cntrl->index);
>  err_destroy_wq:
>  	destroy_workqueue(mhi_cntrl->wq);
> +err_destroy_ring_item_cache:
> +	kmem_cache_destroy(mhi_cntrl->ring_item_cache);
> +err_destroy_ev_ring_el_cache:
> +	kmem_cache_destroy(mhi_cntrl->ev_ring_el_cache);
> +err_destroy_tre_buf_cache:
> +	kmem_cache_destroy(mhi_cntrl->tre_buf_cache);
>  err_free_cmd:
>  	kfree(mhi_cntrl->mhi_cmd);
>  err_free_ch:
> @@ -1479,6 +1512,9 @@ void mhi_ep_unregister_controller(struct mhi_ep_cntrl *mhi_cntrl)
>  
>  	free_irq(mhi_cntrl->irq, mhi_cntrl);
>  
> +	kmem_cache_destroy(mhi_cntrl->tre_buf_cache);
> +	kmem_cache_destroy(mhi_cntrl->ev_ring_el_cache);
> +	kmem_cache_destroy(mhi_cntrl->ring_item_cache);
>  	kfree(mhi_cntrl->mhi_cmd);
>  	kfree(mhi_cntrl->mhi_chan);
>  
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index f198a8ac7ee7..ce85d42b685d 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -128,6 +128,9 @@ struct mhi_ep_cntrl {
>  	struct work_struct reset_work;
>  	struct work_struct cmd_ring_work;
>  	struct work_struct ch_ring_work;
> +	struct kmem_cache *ring_item_cache;
> +	struct kmem_cache *ev_ring_el_cache;
> +	struct kmem_cache *tre_buf_cache;
>  
>  	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl, u32 vector);
>  	int (*alloc_map)(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t *phys_ptr,
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

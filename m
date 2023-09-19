Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AC87A575F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjISCX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjISCXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:23:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E9E10A;
        Mon, 18 Sep 2023 19:23:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fe39555a0so4774308b3a.3;
        Mon, 18 Sep 2023 19:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695090199; x=1695694999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPpSRzjJaCaf4D1jgJn/ubxCnO7O3efMaVWn3iI95Gs=;
        b=nnFfH9audDNUcdPrcXUDYNpfbhvJNhYVavP0bq9V6LN6jwZZKmL5waWFuG/Uz5e491
         tHtqjaPvF8BE7rDjcbSqhj72LDL0tBytBqAeDFn+ZRYKnqAuULmpYyMEdsWgjpP2r6ea
         i736TVAnPTVpKzZFRQsg3LZk14VArLHMPb2cpChTwaMuVEqMKvufZPTcnucA333q5yi2
         +S6qVQUsOh1ZRZUz6Tlv5hqHLfEdwjY+6ltFTz0zsKONZ4oJ+pVw43uEMlPOFDvwosX6
         cRYN/unSxG1PIAA7DSrRHrcBUON/pIs3o/EDfNVCZUeXSh/vYc10PX+BgzgucEUSu5FP
         Lhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695090199; x=1695694999;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPpSRzjJaCaf4D1jgJn/ubxCnO7O3efMaVWn3iI95Gs=;
        b=IFNXQoeXstRRIo8IdPA+qD5WhQcKR97FR0nYDaU9a44Y+qS8B9Vin9LqWCUMwxkecg
         46gV8WJWtj+SO3uDbIvWO0fbWmP3/SASri5bdc9heQKzr1gFmbHQjcyUTrA/dlj7Y3SM
         4nd60PkrrVCGZU6HvaCCCkL7XymdB7yAsWOSH7qDg2lrDW3RSIoS9VmEKPGo3x0AptS4
         04MhcrR3e/IZMfyXO4qxfHZ2fZmH3kyvYHkGFBZfJfvg7u6SU8L8P92paLyJh+kN+Oke
         pw3aqJv+UvRHnUTG0pDNERQ3MC5sdTN76/K8YHY4oJD1H02el4lmcv+jsUHGkQud4n5p
         Y71Q==
X-Gm-Message-State: AOJu0YzjuaHvGTVx47l3irH1ldz/1pkcpv5HENZKRW4j1LxtteuumWGA
        RLosXYBj0MH9uleqkgB2Cvo=
X-Google-Smtp-Source: AGHT+IHkCaI/3LfzOykTLtUIR5QISDnGk5BtEJ+BJBbENkQzk/RE9BzmMVndAP/AI4EFJ6UOsWvHbQ==
X-Received: by 2002:a05:6a21:2720:b0:157:609f:6012 with SMTP id rm32-20020a056a21272000b00157609f6012mr10718199pzb.61.1695090199202;
        Mon, 18 Sep 2023 19:23:19 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:e163:7509:9018:42b6? ([2600:8802:b00:4a48:e163:7509:9018:42b6])
        by smtp.gmail.com with ESMTPSA id ji3-20020a170903324300b001c446dea2c5sm5662600plb.143.2023.09.18.19.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 19:23:18 -0700 (PDT)
Message-ID: <f9099556-2360-41dc-8388-28a55dd2d588@gmail.com>
Date:   Mon, 18 Sep 2023 19:23:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] net: axienet: Introduce dmaengine support
Content-Language: en-US
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, linux@armlinux.org.uk
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com
References: <1695064615-3164315-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1695064615-3164315-4-git-send-email-radhey.shyam.pandey@amd.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <1695064615-3164315-4-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/2023 12:16 PM, Radhey Shyam Pandey wrote:
> Add dmaengine framework to communicate with the xilinx DMAengine
> driver(AXIDMA).
> 
> Axi ethernet driver uses separate channels for transmit and receive.
> Add support for these channels to handle TX and RX with skb and
> appropriate callbacks. Also add axi ethernet core interrupt for
> dmaengine framework support.
> 
> The dmaengine framework was extended for metadata API support.
> However it still needs further enhancements to make it well suited for
> ethernet usecases. The ethernet features i.e ethtool set/get of DMA IP
> properties, ndo_poll_controller,(mentioned in TODO) are not supported
> and it requires follow-up discussions.
> 
> dmaengine support has a dependency on xilinx_dma as it uses
> xilinx_vdma_channel_set_config() API to reset the DMA IP
> which internally reset MAC prior to accessing MDIO.
> 
> Benchmark with netperf:
> 
> xilinx-zcu102-20232:~$ netperf -H 192.168.10.20 -t TCP_STREAM
> MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET
> to 192.168.10.20 () port 0 AF_INET
> Recv   Send    Send
> Socket Socket  Message  Elapsed
> Size   Size    Size     Time     Throughput
> bytes  bytes   bytes    secs.    10^6bits/sec
> 
> 131072  16384  16384    10.03     915.55
> 
> xilinx-zcu102-20232:~$ netperf -H 192.168.10.20 -t UDP_STREAM
> MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET
> to 192.168.10.20 () port 0 AF_INET
> Socket  Message  Elapsed      Messages
> Size    Size     Time         Okay Errors   Throughput
> bytes   bytes    secs            #      #   10^6bits/sec
> 
> 212992   65507   10.00       18192      0     953.35
> 212992           10.00       18192            953.35
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
[snip]

Nice example of how to integrate an Ethernet driver with dmaengine, BTW.


> +
> +	/*Fill up app fields for checksum */

Missing space between * and Fill up, there are a few comments where it 
is the opposite where you don't add a space at the end before the *.

> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
> +			/* Tx Full Checksum Offload Enabled */
> +			app[0] |= 2;
> +		} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {

This is the transmit path here, is this path even taken?

> +			csum_start_off = skb_transport_offset(skb);
> +			csum_index_off = csum_start_off + skb->csum_offset;
> +			/* Tx Partial Checksum Offload Enabled */
> +			app[0] |= 1;
> +			app[1] = (csum_start_off << 16) | csum_index_off;
> +		}
> +	} else if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
> +		app[0] |= 2; /* Tx Full Checksum Offload Enabled */
> +	}
> +
> +	dma_tx_desc = lp->tx_chan->device->device_prep_slave_sg(lp->tx_chan, skbuf_dma->sgl,
> +			sg_len, DMA_MEM_TO_DEV,
> +			DMA_PREP_INTERRUPT, (void *)app);
> +	if (!dma_tx_desc)
> +		goto xmit_error_unmap_sg;
> +
> +	skbuf_dma->skb = skb;
> +	skbuf_dma->sg_len = sg_len;
> +	dma_tx_desc->callback_param = lp;
> +	dma_tx_desc->callback_result = axienet_dma_tx_cb;
> +	dmaengine_submit(dma_tx_desc);
> +	dma_async_issue_pending(lp->tx_chan);
> +
> +	return NETDEV_TX_OK;
> +
> +xmit_error_unmap_sg:
> +	dma_unmap_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
> +	return NETDEV_TX_OK;
> +}
> +
>   /**
>    * axienet_tx_poll - Invoked once a transmit is completed by the
>    * Axi DMA Tx channel.
> @@ -911,7 +1036,42 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>   	if (!lp->use_dmaengine)
>   		return axienet_start_xmit_legacy(skb, ndev);
>   	else
> -		return NETDEV_TX_BUSY;
> +		return axienet_start_xmit_dmaengine(skb, ndev);
> +}
> +
> +/**
> + * axienet_dma_rx_cb - DMA engine callback for RX channel.
> + * @data:       Pointer to the skbuf_dma_descriptor structure.
> + * @result:     error reporting through dmaengine_result.
> + * This function is called by dmaengine driver for RX channel to notify
> + * that the packet is received.
> + */
> +static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
> +{
> +	struct axienet_local *lp = data;
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	size_t meta_len, meta_max_len, rx_len;
> +	struct sk_buff *skb;
> +	u32 *app;
> +
> +	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
> +	skb = skbuf_dma->skb;
> +	app = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len, &meta_max_len);

app might not be the best name, I understand this refers to a DMA 
application, in a broad sense that it is not specific, maybe cookie, or 
opaque_ptr would work better?

> +	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
> +			 DMA_FROM_DEVICE);
> +	/* TODO: Derive app word index programmatically */
> +	rx_len = (app[LEN_APP] & 0xFFFF);
> +	skb_put(skb, rx_len);
> +	skb->protocol = eth_type_trans(skb, lp->ndev);
> +	skb->ip_summed = CHECKSUM_NONE;
> +
> +	netif_rx(skb);

Could save some cycles and call __netif_rx() here since AFAIR dmaengine 
uses a tasklet? netif_rx() is fine, just would have to compute need_bh_off.

> +	u64_stats_update_begin(&lp->rx_stat_sync);
> +	u64_stats_add(&lp->rx_packets, 1);
> +	u64_stats_add(&lp->rx_bytes, rx_len);
> +	u64_stats_update_end(&lp->rx_stat_sync);
> +	axienet_rx_submit_desc(lp->ndev);
> +	dma_async_issue_pending(lp->rx_chan);
>   }
>   
>   /**
> @@ -1147,6 +1307,142 @@ static irqreturn_t axienet_eth_irq(int irq, void *_ndev)
>   
>   static void axienet_dma_err_handler(struct work_struct *work);
>   
> +/**
> + * axienet_rx_submit_desc - Submit the descriptors with required data
> + * like call backup API, skb buffer.. etc to dmaengine.
> + *
> + * @ndev:	net_device pointer
> + *
> + *Return: 0, on success.
> + *          non-zero error value on failure
> + */
> +static int axienet_rx_submit_desc(struct net_device *ndev)
> +{
> +	struct dma_async_tx_descriptor *dma_rx_desc = NULL;
> +	struct axienet_local *lp = netdev_priv(ndev);
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	struct sk_buff *skb;
> +	dma_addr_t addr;
> +	int ret;
> +
> +	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_head);
> +	if (!skbuf_dma)
> +		return -ENOMEM;
> +	lp->rx_ring_head++;
> +	skb = netdev_alloc_skb(ndev, lp->max_frm_size);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	sg_init_table(skbuf_dma->sgl, 1);
> +	addr = dma_map_single(lp->dev, skb->data, lp->max_frm_size, DMA_FROM_DEVICE);

Need to check with dma_mapping_error() that the mapping succeeded.

Thanks!

pw-bot: cr
-- 
Florian

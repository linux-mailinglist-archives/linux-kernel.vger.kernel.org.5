Return-Path: <linux-kernel+bounces-19701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A03827126
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070551C21BD4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890CD46559;
	Mon,  8 Jan 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FS5DPdyi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75B46443
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704723788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnFeTcpG9phIMeXvdCzxU+gpiTkjWy0SG3KvKVSyquQ=;
	b=FS5DPdyinyypybjMTOZ67Ye6+Sq4oSUUdgC17vbNr6Rq2plVeGy3V1a8rvD7FjYM7rwCDR
	f8twBD/0G10/DGW/dg7t1nh3rYaAIckGM2lo5bYt5yu4z8FIo1blJ/qM/i4VvB2Ku6XA16
	PJKciaO3D38LaN0tiPEd9v8T4TCj8Gc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-kc5Ea4xnNbexY0CLEStXNg-1; Mon, 08 Jan 2024 09:23:06 -0500
X-MC-Unique: kc5Ea4xnNbexY0CLEStXNg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-555fa79f410so2905001a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723783; x=1705328583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnFeTcpG9phIMeXvdCzxU+gpiTkjWy0SG3KvKVSyquQ=;
        b=Noq1zaWFTCz6hVcjslZ+HcL2FJLgq6JBtkwrE+5HY+PQgRQx/49YTKBiuTsgURGs3z
         JCFFFoV1akKO5ThcM81f+vRdU1sPgEQdCJFwLLEmIlUeqQC6dhkm9gPiojD2Lq0uQ3pW
         eAGkhKFlPLJsiO6ypO1HzOcD1U7fPxJjLD7NVVGrb7bx4eIRpP0dh8J8OdGvoDac+5Aq
         NpoeOT+YFgfT9CygeaL6nRXW1DFwRXXBHO+6uh9queHXOf1rSVTMEr3KaBxZp1fOihTJ
         /L3Hcmn23q40l7n85Qjk58pNsoOIMaF2Rs1I80Ht1BRdHkKkI1gWKZcZqJ2xmL6CVdaB
         sBuw==
X-Gm-Message-State: AOJu0Yx9zZbjZY386hfJPI5/S+ex86Fe0LRN3u+aBx6U9V7xQPCBrzcH
	oPxRqk/oNcqyQNSzCxgtsIrIxWTxSu+YzZot3QM46MF1RPeD9or8/+k2Qpci+1lm67lwsixI5SZ
	jTgmWt8ms0Z4LZdInAOpb9N6U/z+RNv8n
X-Received: by 2002:a17:907:7f1a:b0:a2a:d987:f7f8 with SMTP id qf26-20020a1709077f1a00b00a2ad987f7f8mr1294663ejc.31.1704723783017;
        Mon, 08 Jan 2024 06:23:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJjRy1GVEFPzoDeUl5awHlprX9/LGBmPN8pM/iYrJF+yyKrUVHFJ15ooSwn3bJuULNDngoZQ==
X-Received: by 2002:a17:907:7f1a:b0:a2a:d987:f7f8 with SMTP id qf26-20020a1709077f1a00b00a2ad987f7f8mr1294642ejc.31.1704723782730;
        Mon, 08 Jan 2024 06:23:02 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id g21-20020a17090613d500b00a289d772555sm3949670ejc.66.2024.01.08.06.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 06:23:02 -0800 (PST)
Message-ID: <d5ce7c9f-eaf8-45d4-bb8b-24fb1153d946@redhat.com>
Date: Mon, 8 Jan 2024 15:23:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Drop Tx network packet when Tx TmFIFO is full
Content-Language: en-US
To: Liming Sun <limings@nvidia.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Vadim Pasternak <vadimp@nvidia.com>,
 David Thompson <davthompson@nvidia.com>, Mark Gross <markgross@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <f250079635da4ba75c3a3a1d7c3820f48cfc3f06.1704380474.git.limings@nvidia.com>
 <02fd0faaa555d1914b6ff4bd4b0b294e16989cef.1704381197.git.limings@nvidia.com>
 <c510206b-1dbb-8f1-642d-7e1c8ac7a7c@linux.intel.com>
 <BN9PR12MB5068662A46D3B8A23BFE5DA6D3662@BN9PR12MB5068.namprd12.prod.outlook.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BN9PR12MB5068662A46D3B8A23BFE5DA6D3662@BN9PR12MB5068.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 1/5/24 18:40, Liming Sun wrote:
> 
> 
>> -----Original Message-----
>> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Sent: Thursday, January 4, 2024 12:39 PM
>> To: Liming Sun <limings@nvidia.com>
>> Cc: Vadim Pasternak <vadimp@nvidia.com>; David Thompson
>> <davthompson@nvidia.com>; Hans de Goede <hdegoede@redhat.com>;
>> Mark Gross <markgross@kernel.org>; Dan Carpenter
>> <dan.carpenter@linaro.org>; platform-driver-x86@vger.kernel.org; LKML
>> <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH v2 1/1] Drop Tx network packet when Tx TmFIFO is full
>>
>> On Thu, 4 Jan 2024, Liming Sun wrote:
>>
>>> Starting from Linux 5.16 kernel, Tx timeout mechanism was added
>>> into the virtio_net driver which prints the "Tx timeout" message
>>> when a packet is stuck in Tx queue for too long which could happen
>>> when external host driver is stuck or stopped and failed to read
>>> the FIFO.
>>>
>>> Below is an example of the reported message:
>>>
>>> "[494105.316739] virtio_net virtio1 tmfifo_net0: TX timeout on
>>> queue: 0, sq: output.0, vq: 0×1, name: output.0, usecs since
>>> last trans: 3079892256".
>>>
>>> To avoid such "Tx timeout" messages, this commit adds a timeout
>>> mechanism to drop and release the pending Tx packet if not able to
>>> transmit for two seconds due to Tx FIFO full.
>>>
>>> This commit also handles the special case that the packet is half-
>>> transmitted into the Tx FIFO. In such case, the packet is discarded
>>> with remaining length stored in vring->rem_padding. So paddings with
>>> zeros can be sent out when Tx space is available to maintain the
>>> integrity of the packet format. The padded packet will be dropped on
>>> the receiving side.
>>>
>>> Signed-off-by: Liming Sun <limings@nvidia.com>
>>
>> This doesn't really explain how it helps (other than avoiding the
>> message which sounds like just hiding the issue). That is, how this helps
>> to resume Tx? Or does Tx resume? There's nothing to indicate either way.
> 
> As the commit message mentioned, the expired packet is discarded and the
> packet buffer is released (see changes of calling mlxbf_tmfifo_release_pkt()).
> The Tx will resume automatically once the FIFO space is available, such as when
> external host driver starts to drain the TMFIFO. No need for any other logic.

Hmm, it seems to me that the same (resuming on FIFO space available)
will happen without this patch ?

So as Ilpo mentioned the only purpose here seems to be to avoid the warning
getting logged? And things work properly without this too ?

I guess the advantage of this patch is that during a blocked FIFO packets
get discarded rather the piling up ?

Regards,

Hans




>>> ---
>>>  drivers/platform/mellanox/mlxbf-tmfifo.c | 67
>> ++++++++++++++++++++++++
>>>  1 file changed, 67 insertions(+)
>>>
>>> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c
>> b/drivers/platform/mellanox/mlxbf-tmfifo.c
>>> index 5c683b4eaf10..f39b7b9d2bfe 100644
>>> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
>>> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
>>> @@ -47,6 +47,9 @@
>>>  /* Message with data needs at least two words (for header & data). */
>>>  #define MLXBF_TMFIFO_DATA_MIN_WORDS		2
>>>
>>> +/* Tx timeout in milliseconds. */
>>> +#define TMFIFO_TX_TIMEOUT			2000
>>> +
>>>  /* ACPI UID for BlueField-3. */
>>>  #define TMFIFO_BF3_UID				1
>>>
>>> @@ -62,12 +65,14 @@ struct mlxbf_tmfifo;
>>>   * @drop_desc: dummy desc for packet dropping
>>>   * @cur_len: processed length of the current descriptor
>>>   * @rem_len: remaining length of the pending packet
>>> + * @rem_padding: remaining bytes to send as paddings
>>>   * @pkt_len: total length of the pending packet
>>>   * @next_avail: next avail descriptor id
>>>   * @num: vring size (number of descriptors)
>>>   * @align: vring alignment size
>>>   * @index: vring index
>>>   * @vdev_id: vring virtio id (VIRTIO_ID_xxx)
>>> + * @tx_timeout: expire time of last tx packet
>>>   * @fifo: pointer to the tmfifo structure
>>>   */
>>>  struct mlxbf_tmfifo_vring {
>>> @@ -79,12 +84,14 @@ struct mlxbf_tmfifo_vring {
>>>  	struct vring_desc drop_desc;
>>>  	int cur_len;
>>>  	int rem_len;
>>> +	int rem_padding;
>>>  	u32 pkt_len;
>>>  	u16 next_avail;
>>>  	int num;
>>>  	int align;
>>>  	int index;
>>>  	int vdev_id;
>>> +	unsigned long tx_timeout;
>>>  	struct mlxbf_tmfifo *fifo;
>>>  };
>>>
>>> @@ -819,6 +826,50 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct
>> mlxbf_tmfifo_vring *vring,
>>>  	return true;
>>>  }
>>>
>>> +static void mlxbf_tmfifo_check_tx_timeout(struct mlxbf_tmfifo_vring
>> *vring)
>>> +{
>>> +	unsigned long flags;
>>> +
>>> +	/* Only handle Tx timeout for network vdev. */
>>> +	if (vring->vdev_id != VIRTIO_ID_NET)
>>> +		return;
>>> +
>>> +	/* Initialize the timeout or return if not expired. */
>>> +	if (!vring->tx_timeout) {
>>> +		/* Initialize the timeout. */
>>> +		vring->tx_timeout = jiffies +
>>> +			msecs_to_jiffies(TMFIFO_TX_TIMEOUT);
>>> +		return;
>>> +	} else if (time_before(jiffies, vring->tx_timeout)) {
>>> +		/* Return if not timeout yet. */
>>> +		return;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Drop the packet after timeout. The outstanding packet is
>>> +	 * released and the remaining bytes will be sent with padding byte
>> 0x00
>>> +	 * as a recovery. On the peer(host) side, the padding bytes 0x00 will be
>>> +	 * either dropped directly, or appended into existing outstanding
>> packet
>>> +	 * thus dropped as corrupted network packet.
>>> +	 */
>>> +	vring->rem_padding = round_up(vring->rem_len, sizeof(u64));
>>> +	mlxbf_tmfifo_release_pkt(vring);
>>> +	vring->cur_len = 0;
>>> +	vring->rem_len = 0;
>>> +	vring->fifo->vring[0] = NULL;
>>> +
>>> +	/*
>>> +	 * Make sure the load/store are in order before
>>> +	 * returning back to virtio.
>>> +	 */
>>> +	virtio_mb(false);
>>> +
>>> +	/* Notify upper layer. */
>>> +	spin_lock_irqsave(&vring->fifo->spin_lock[0], flags);
>>> +	vring_interrupt(0, vring->vq);
>>> +	spin_unlock_irqrestore(&vring->fifo->spin_lock[0], flags);
>>> +}
>>> +
>>>  /* Rx & Tx processing of a queue. */
>>>  static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
>>>  {
>>> @@ -841,6 +892,7 @@ static void mlxbf_tmfifo_rxtx(struct
>> mlxbf_tmfifo_vring *vring, bool is_rx)
>>>  		return;
>>>
>>>  	do {
>>> +retry:
>>>  		/* Get available FIFO space. */
>>>  		if (avail == 0) {
>>>  			if (is_rx)
>>> @@ -851,6 +903,17 @@ static void mlxbf_tmfifo_rxtx(struct
>> mlxbf_tmfifo_vring *vring, bool is_rx)
>>>  				break;
>>>  		}
>>>
>>> +		/* Insert paddings for discarded Tx packet. */
>>> +		if (!is_rx) {
>>> +			vring->tx_timeout = 0;
>>> +			while (vring->rem_padding >= sizeof(u64)) {
>>> +				writeq(0, vring->fifo->tx.data);
>>> +				vring->rem_padding -= sizeof(u64);
>>> +				if (--avail == 0)
>>> +					goto retry;
>>> +			}
>>> +		}
>>> +
>>>  		/* Console output always comes from the Tx buffer. */
>>>  		if (!is_rx && devid == VIRTIO_ID_CONSOLE) {
>>>  			mlxbf_tmfifo_console_tx(fifo, avail);
>>> @@ -860,6 +923,10 @@ static void mlxbf_tmfifo_rxtx(struct
>> mlxbf_tmfifo_vring *vring, bool is_rx)
>>>  		/* Handle one descriptor. */
>>>  		more = mlxbf_tmfifo_rxtx_one_desc(vring, is_rx, &avail);
>>>  	} while (more);
>>> +
>>> +	/* Check Tx timeout. */
>>> +	if (avail <= 0 && !is_rx)
>>> +		mlxbf_tmfifo_check_tx_timeout(vring);
>>>  }
>>>
>>>  /* Handle Rx or Tx queues. */
>>>



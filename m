Return-Path: <linux-kernel+bounces-4175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E125C8178C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049751C24EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622335BF98;
	Mon, 18 Dec 2023 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KF8kz8Kq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7B5A845
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702920782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GfgmirgpPKx36i//2L3nndaHAF0yKMBiEStk+Rn60Bw=;
	b=KF8kz8KqF7QOMR7YTm3mmwuLxg/vcFXiNu0Tto5v9tXIg6iSYgN8/aNxuXrkty6v5Z08X6
	UUUDtHkEE1oYFLaI26JjT42mNG6boaTKVCutk9HOFbPrbqOUsDRhqtdbG8hDCSFChRTo1S
	BGPS4YW/cSqyL2oaveSDE9JumJDf9Hs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-olLSW3VNMJyLDAW25oVy4w-1; Mon, 18 Dec 2023 12:33:00 -0500
X-MC-Unique: olLSW3VNMJyLDAW25oVy4w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c295f59ceso21644715e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920779; x=1703525579;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfgmirgpPKx36i//2L3nndaHAF0yKMBiEStk+Rn60Bw=;
        b=lUnciY1H+qTWn7vLM6r/e5d6HEAAwpp2Io9E/GU5EeThczfpX8Xmiy777XDJD40qhl
         eRHgA9EzcQ7Aek1TSGEIIIxAjkJXo8csYcY3ldu3+yX6opAgHqhhAGRDERyls5Bm3WgO
         E3vysBFVXzetCsyFj7frkBN6O0F3cBtnAiK4LhmN50ClO85EP3IB02IvXOeVhNQjH7bm
         uua7DmQ4ydOxyOnyl5n3Pk+k9TJLb4ia3VQglQA8cGxnxtLer18JXoPym62X5YyAPN+R
         41c0yioVjYY2EoSWct/jBkE275rZlSkFvMHN7NhtNeGgJ1nnH/HxVNGC1dyqf3S/nMdm
         VNkg==
X-Gm-Message-State: AOJu0YwQQtxbwYq1YeYn5DqC6Vvrdh/zbe10kmnMJTws93CvGsbSuO4i
	+7Pue+2mAIbkbu/AX+Dy8n7ArZqwVoJdDvyZ5XgRN5IffAwPI84UiKu30JaSELswf5ObUPavqrV
	jpFFn6p7fZDd70eGh1M6DdUjKU4bTWurB
X-Received: by 2002:a05:600c:1c8b:b0:405:2d29:1648 with SMTP id k11-20020a05600c1c8b00b004052d291648mr8777171wms.19.1702920779190;
        Mon, 18 Dec 2023 09:32:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXM7mmyeRcbopD4bV2LKBQXTZxL+mkAjFbsm9//GKOEGnciblOC/C/g6Ld0XEPDnk8aY63MA==
X-Received: by 2002:a05:600c:1c8b:b0:405:2d29:1648 with SMTP id k11-20020a05600c1c8b00b004052d291648mr8777163wms.19.1702920778651;
        Mon, 18 Dec 2023 09:32:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c72b:b500:b53e:6e32:1408:27ac? (p200300cbc72bb500b53e6e32140827ac.dip0.t-ipconnect.de. [2003:cb:c72b:b500:b53e:6e32:1408:27ac])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d5108000000b003366fb71297sm218452wrt.81.2023.12.18.09.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 09:32:58 -0800 (PST)
Message-ID: <aae229d7-0675-47c5-9a02-5ba0b6a64906@redhat.com>
Date: Mon, 18 Dec 2023 18:32:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_balloon: stay awake while adjusting balloon
Content-Language: en-US
To: David Stevens <stevensd@chromium.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20231218151842.2756673-1-stevensd@google.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231218151842.2756673-1-stevensd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.12.23 16:18, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> A virtio_balloon's parent device may be configured so that a
> configuration change interrupt is a wakeup event. Extend the processing
> of such a wakeup event until the balloon finishes inflating or deflating
> by calling pm_stay_awake/pm_relax in the virtio_balloon driver. Note
> that these calls are no-ops if the parent device doesn't support wakeup
> events or if the wakeup events are not enabled.
> 
> This change allows the guest to use system power states such as s2idle
> without running the risk the virtio_balloon's cooperative memory
> management becoming unresponsive to the host's requests.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
> v1 -> v2:
>   - Use adjustment_signal_pending flag instead of a sequence number
>   - Call pm_stay_awake/pm_relax on parent device instead of adding a wake
>     event to the virtio balloon device
> 
>   drivers/virtio/virtio_balloon.c | 57 +++++++++++++++++++++++++++------
>   1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 1fe93e93f5bc..a3c11159cbe0 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -119,6 +119,11 @@ struct virtio_balloon {
>   	/* Free page reporting device */
>   	struct virtqueue *reporting_vq;
>   	struct page_reporting_dev_info pr_dev_info;
> +
> +	/* State for keeping the wakeup_source active while adjusting the balloon */
> +	spinlock_t adjustment_lock;
> +	bool adjustment_signal_pending;
> +	bool adjustment_in_progress;
>   };
>   
>   static const struct virtio_device_id id_table[] = {
> @@ -437,6 +442,31 @@ static void virtio_balloon_queue_free_page_work(struct virtio_balloon *vb)
>   	queue_work(vb->balloon_wq, &vb->report_free_page_work);
>   }
>   
> +static void start_update_balloon_size(struct virtio_balloon *vb)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vb->adjustment_lock, flags);
> +	vb->adjustment_signal_pending = true;
> +	if (!vb->adjustment_in_progress) {
> +		vb->adjustment_in_progress = true;
> +		pm_stay_awake(vb->vdev->dev.parent);
> +	}
> +	spin_unlock_irqrestore(&vb->adjustment_lock, flags);
> +
> +	queue_work(system_freezable_wq, &vb->update_balloon_size_work);
> +}
> +
> +static void end_update_balloon_size(struct virtio_balloon *vb)
> +{
> +	spin_lock(&vb->adjustment_lock);
> +	if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {

How could vb->adjustment_in_progress ever not be set at this point?

> +		vb->adjustment_in_progress = false;
> +		pm_relax(vb->vdev->dev.parent);
> +	}
> +	spin_unlock(&vb->adjustment_lock);
> +}
> +

LGTM, although I wonder what happens when calling pm_stay_awake() etc. 
on a parent device that is not wakeup-even-capable?

-- 
Cheers,

David / dhildenb



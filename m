Return-Path: <linux-kernel+bounces-108680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80722880E57
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B0B1F22628
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C7639AEC;
	Wed, 20 Mar 2024 09:11:22 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094038F94
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925881; cv=none; b=QDSln9pj6eT4DKOSCKYhOvnYja50lB7w3Uai5+WPxFII6/OYD198JWmIEYLXN+JFI6JoB8VrSWHpBAAC8EhIVOqNgW7P+H8b3W+N7+NP3xxGnxC2bn6v9QCcWk2EbG6i3zNnisSljjYYrKMWsD/ce16IxN7aYmJ76kyJDYFlA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925881; c=relaxed/simple;
	bh=5vMlbOGBj9xsefyKotdnBYkTfFPfx6qag6aKEmZ1brg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cW529cFDbVs4BIdU9ZNGWMhk0kysmZVMTc9ybkaXbVJxFR9spVIvz4xeop8fVPxWFlQxUQH6aiGVTJQIBBo/Z85HotBSLZoH4YFNMR/VeIcE6C9xze7kQEhhBGK4aR1KgCP9ShCUV2aFFzyJSeqR0/YuK2VuIAKW2crryD31jg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d49871732fso10600131fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925878; x=1711530678;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ic1nLAZlOIEz8qJZURNZoS0hfHmBW2vxO0Mxv1zSKM4=;
        b=DXcFFWYhAouH76IdwKVnPLYUgp1wbblZZGzkb/7Dum+8Xzj1KanfeKM/JERi+NoFOg
         3CV9dPoDidgmlNGtkRpEDfXb9i2OUX0ZvALJz3mGUIsRxpxW1HaK7yKrSqHxTmhUY6+j
         hn/twRyFmpPbvTAFfHQm4XUlV/edb1Hfrzyay3gZZDoEMeWfxlbkFU1VWFPeQVK2CcEe
         5+I9Ph9GZ8pB/3+gUS1TZM100/CbIiAAS0mFL7ZO05fedcND/fIbEHzLf7lYCGCfenme
         eWxrPf0owZbhGN/ZtQRuW2g66UF75c9/pb2d0pWojShKFr/j44nzXtf+dPitTxUgF/BV
         tuXw==
X-Forwarded-Encrypted: i=1; AJvYcCUZTElFPxSrmpeTa5F+jba3P/ipn8FrZf6LbXb7QL7ASptVRbqvQDhWvF9OCc61RwIsYe/cIk3o9pgwNYt++szVzWfE+48l4+fblMD8
X-Gm-Message-State: AOJu0YyMS22Sh3jFGF2Nxv1J4K8QMu0EMmP8bjcAH+3HeBRRJbaYvzTr
	f1+bkqcCSYnycgbPhIiXZQBvqtxGijxy79SqFFjX2TGB5MCzMDhx
X-Google-Smtp-Source: AGHT+IHuIGZmvxQyYFiZryw0Ofph5rR4aa1Rc8TH0jQHfwdyjSFp9UHdVF7zdFnNwwSVwQHZ+8j4qw==
X-Received: by 2002:a2e:b1c5:0:b0:2d4:7458:b65 with SMTP id e5-20020a2eb1c5000000b002d474580b65mr3346780lja.2.1710925877737;
        Wed, 20 Mar 2024 02:11:17 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id p31-20020a05600c1d9f00b00414109c66f7sm1572006wms.38.2024.03.20.02.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:11:17 -0700 (PDT)
Message-ID: <c4057654-97bd-4721-9bed-9dd5ef8b3f8d@grimberg.me>
Date: Wed, 20 Mar 2024 11:11:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers
Content-Language: he-IL, en-US
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>
References: <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/03/2024 0:33, Kamaljit Singh wrote:
> Hello,
>
> After switching from Kernel v6.6.2 to v6.6.21 we're now seeing these workqueue
> warnings. I found a discussion thread about the the Intel drm driver here
> https://lore.kernel.org/lkml/ZO-BkaGuVCgdr3wc@slm.duckdns.org/T/
>
> and this related bug report https://gitlab.freedesktop.org/drm/intel/-/issues/9245
> but that that drm fix isn't merged into v6.6.21. It appears that we may need the same
> WQ_UNBOUND change to the nvme host tcp driver among others.
>   
> [Fri Mar 15 22:30:06 2024] workqueue: nvme_tcp_io_work [nvme_tcp] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> [Fri Mar 15 23:44:58 2024] workqueue: drain_vmap_area_work hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> [Sat Mar 16 09:55:27 2024] workqueue: drain_vmap_area_work hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
> [Sat Mar 16 17:51:18 2024] workqueue: nvme_tcp_io_work [nvme_tcp] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
> [Sat Mar 16 23:04:14 2024] workqueue: nvme_tcp_io_work [nvme_tcp] hogged CPU for >10000us 16 times, consider switching to WQ_UNBOUND
> [Sun Mar 17 21:35:46 2024] perf: interrupt took too long (2707 > 2500), lowering kernel.perf_event_max_sample_rate to 73750
> [Sun Mar 17 21:49:34 2024] workqueue: drain_vmap_area_work hogged CPU for >10000us 16 times, consider switching to WQ_UNBOUND
> ...
> workqueue: drm_fb_helper_damage_work [drm_kms_helper] hogged CPU for >10000us 32 times, consider switching to WQ_UNBOUND

Hey Kamaljit,

Its interesting that this happens because nvme_tcp_io_work is bound to 1 
jiffie.
Although in theory we do not stop receiving from a socket once we 
started, so
I guess this can happen in some extreme cases. Was the test you were running
read-heavy?

I was thinking that we may want to optionally move the recv path to 
softirq instead to
get some latency improvements, although I don't know if that would 
improve the situation
if we end up spending a lot of time in soft-irq...

>   
>   
> Thanks,
> Kamaljit Singh



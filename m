Return-Path: <linux-kernel+bounces-25373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B112382CEB9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 22:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BABA1C211C2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 21:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989116426;
	Sat, 13 Jan 2024 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbolCwbt"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6462CA6;
	Sat, 13 Jan 2024 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67fe0264dd2so49322856d6.0;
        Sat, 13 Jan 2024 13:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705180430; x=1705785230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmVgSOgYUo8HP5jrE+8RTTvoKKQaWMMzD4Kt9s/iPcQ=;
        b=KbolCwbta0h8vYuQhFPCS8FLsgHtAD06wJ11yow0V3/IGDAiTdu6EY3ObZmMLOGB6Z
         HExt9U2jTIVTMqK2JLvtIw2i/5+/5kyioLg88caNjGYTJI7nuiB0T0n6m3YYzaRYTyeG
         IuZt1DRIFNjxgZiRIXuTwB0CmeRjvVLZkPJTT331Cln36ww7jtS8poX2+DZorlqrRLj9
         M7L/vxnMUbWk1geqOQ88Gek8AqdANXDv7h5cTBGtEB5neOzAIIjKzMlbRGRLEf1tAw0K
         19L5ykZnNbofRgVoG1sVIypVK1EAjNbJSATOu+NISHxFxWpLWhAwULovuaoDJjfx2Pfi
         HQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705180430; x=1705785230;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LmVgSOgYUo8HP5jrE+8RTTvoKKQaWMMzD4Kt9s/iPcQ=;
        b=pGF/gz0v9fxCaNCRuhZw+NsF1FGAX43XMWzWkmnrVdA7GETkcoUzWsz7NfQASwUUgD
         3p+WWYSAW8DfuXl6BxZgYnfvvZUjbPQ0/uiIoljQnrfAsbBZVZuf/JOVKM8GK4xxyQJz
         HWPSFICCNUYnQ8ZlcbgBuV10lshhKqri6gwYadDKDOXQeXz98TiSyYP2peCeVXyGw1OZ
         MYtBDTd7GVglA7f76oO+oO3TIMWiZSwux+TgI1hAsoq5acC+2WmAXcOM4if+0TecQA1R
         x55qeaZevsyvZuHfeoiQqNNr690mzIpl3mNwE3ftutV8aELmph5FAQbCafLsmqRXPAEU
         q/pQ==
X-Gm-Message-State: AOJu0YyJOKzFJApXJa30rCjDqIfvm8FfTbH4d3JHbhdEHpy9HHVESrwL
	vt7mC5E8Xd+H2pPJUiulQ6w=
X-Google-Smtp-Source: AGHT+IFU7AiIjEFa+o309orShfUqjo5NtyeiJj8iZqf7xfLAP4vcJ1VRfvfurxReX86sJdMEietA8A==
X-Received: by 2002:a05:6214:4113:b0:680:86d5:ecd5 with SMTP id kc19-20020a056214411300b0068086d5ecd5mr4322727qvb.85.1705180429816;
        Sat, 13 Jan 2024 13:13:49 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id j22-20020a05620a147600b007832104bba9sm1944177qkl.23.2024.01.13.13.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jan 2024 13:13:49 -0800 (PST)
Message-ID: <ad44b540-0b17-4d13-8c89-984e0432805d@gmail.com>
Date: Sat, 13 Jan 2024 13:13:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ravb: Fix wrong dma_unmap_single() calls in ring
 unmapping
Content-Language: en-US
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240113044721.481131-1-nikita.yoush@cogentembedded.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240113044721.481131-1-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/12/2024 8:47 PM, Nikita Yushchenko wrote:
> When unmapping ring entries on Rx ring release, ravb driver needs to
> unmap only those entries that have been mapped successfully.
> 
> To check if an entry needs to be unmapped, currently the address stored
> inside descriptor is passed to dma_mapping_error() call. But, address
> field inside descriptor is 32-bit, while dma_mapping_error() is
> implemented by comparing it's argument with DMA_MAPPING_ERROR constant
> that is 64-bit when dma_addr_t is 64-bit. So the comparison gets wrong,
> resulting into ravb driver calling dma_unnmap_single() for 0xffffffff
> address.

I would still spell out explicitly that a failed mapping from 
ravb_rx_ring_format_gbeth() and ravb_rx_ring_format_rcar() results in 
writing the ds_cc descriptor field to 0.

With that fixed and the typo spotted by Sergey, you may add:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


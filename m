Return-Path: <linux-kernel+bounces-48143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254368457EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E9EB21FCB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4911E86639;
	Thu,  1 Feb 2024 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="I8GeZnd3"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013886632
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791152; cv=none; b=JW1sbQuONZtYd9nBzQBBLeLlcnRuYCJhRSr+S0xxY9dzT0NEYV5ysACGp0TfTVfltvYMv1Szyp2vKlOSoSrcmHP9+A+m0Efg3BUZF3ndvqNbb3pwHaZptcX6I7m3fEYh3CtSY8d9Aw3OCyJgQTD1gbUnj+qBver15qD9dXqU9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791152; c=relaxed/simple;
	bh=vcSXNWqKLKnr/XxvBuwOVYodoel7yAEy8t0XbIE1FLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F19J8tdQUZceeAH/mTBwfvKfW21fa30jkG9/XKjpTJ0fZDWTLiF9uCXMEZ1iCmJAzYqMjvqMUBx62qggrgC8EZXiuG0zXkw2ITDITmJGv8nmy1EqDfm/U7vjl+Y7nbkubZbp5zmioChzv2LIHR6MMQcAHFMaFnSoSkEWmCfhrOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=I8GeZnd3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ef75adf44so7871755e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706791147; x=1707395947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+R0ydXD/di7fbrB8jfxyy8IuF2nnjQdgLn7lXVeRMY=;
        b=I8GeZnd3FjUF0hKA8uLNdRU2aXQWfOiHaed5YoFnxP8BcQyj0f5rD/apEI7eY1Qlmv
         oXz+s+GQcLUPesU6qaQhxVmTOWvF+n5dHTXFo/axdRCPhkcXQKwrNQF63jgCiwIGfy5S
         qgUOrMts2nz0zJL9FY5rKO0XZiXQ9n7aoYcM22osu5ivQ/nOZNJyUD6ozsYVcQppBOd6
         oL77WkmFRzj9xFnl7T7Y2TszJmfv3PENd8ylEsc4LF60LCRuAI5vnFhLwehedpaD68YT
         LmTx0yzps/XAD+H5szhQE27q/RRtBveBgQ0Cr8/3UegSBgorksBQ3WfF1ng+6UPL1ZQh
         9h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791147; x=1707395947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+R0ydXD/di7fbrB8jfxyy8IuF2nnjQdgLn7lXVeRMY=;
        b=OKfh61w5J3qqlRFKxN3lHTjCTDbSIRrsA6NGNpHVBvH6hZoMBoGpeJZrPbb/Qhaqj2
         BmLuzoMM+KSl7AS7NoynihFt+ha/i/6iLM7mux7aK+NGvOnwn6IHssWQiH0gzerbq0K0
         wP/LfgcxvWvAiQrFwCMcSfPMgHYA7wf89PVduuT7gu70X+Blp09+CCQftUWNRWxw0ygQ
         JLpvterIZhtQiMH/t6fKBabZjZCaocHzjsFk/bMzbbqq6nOIY0vWnpe3CTKjm4w0wz64
         rHJLDxU7pI1Ek1I2ej6WQqf+VxQZQZI+cbSwHx35iiVuNlYriTyKQUl4CpU5ajqJ7EHb
         dDPA==
X-Gm-Message-State: AOJu0Yzbble/NIRZPXUaxqqH5b8rTJC0ZSmVp/rZjrnXHyuVfA0Syt9w
	oIfZtOy+OC/zXu9R17bmY7r09vS8S0zquYOvYm25Ah+buR/90yRu97q2OVdTB6A=
X-Google-Smtp-Source: AGHT+IEu0L318kNsyVOJlQFrGCea8JQ3yLCrd9+VDQ6+MeMgB75U7I6tgx2Oef+Ldiu1FpmF1HB+HA==
X-Received: by 2002:a05:600c:1705:b0:40e:4f81:3f68 with SMTP id c5-20020a05600c170500b0040e4f813f68mr4280509wmn.16.1706791146931;
        Thu, 01 Feb 2024 04:39:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV1oNiYoCy1UgJxP9Ql5prbzFAsWudfeZsVk2LzshOEsDr8SMvy53OEcb+atyC7KHyYzHIGu88E2LDymf/j6i843WMGxBgn65w3khjqo79UvJk1T7xTg4l6YjzMFF2iL18IW6JXRceG/UQPsK3eW2Pc3ITiXy+aghMOW3n+G21OYK6X3BWO5Xi+g292zTJ+fgyRT5aLAfwo6FBMDKRx6lHOHYgmevL9cvNC7PrfgviypD/uBvs8pWJWN/9BXN8zEAP+zMwNnIQCjpe0uYo5sx/o7E1lWWEgHwhclEsj7fOkuFNEFy+qCwKXyHhXuyig178PyOLeoDhUY6g/GOXxjwly8wbaE5NTe0OrBqvKbabAplT9I7OeP7D8BQN5+2HvEDqISfhbqKk2k1pp667cxaF6Iw==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c468e00b0040fbad272f6sm1785216wmo.46.2024.02.01.04.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:39:06 -0800 (PST)
Date: Thu, 1 Feb 2024 13:39:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Egor Pomozov <epomozov@marvell.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Dmitry Bezrukov <dmitry.bezrukov@aquantia.com>,
	Sergey Samoilenko <sergey.samoilenko@aquantia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: atlantic: Fix DMA mapping for PTP hwts ring
Message-ID: <ZbuQ58l4DoWU70Bp@nanopsycho>
References: <20240201094752.883026-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201094752.883026-1-ivecera@redhat.com>

Thu, Feb 01, 2024 at 10:47:51AM CET, ivecera@redhat.com wrote:
>Function aq_ring_hwts_rx_alloc() maps extra AQ_CFG_RXDS_DEF bytes
>for PTP HWTS ring but then generic aq_ring_free() does not take this
>into account.
>Create and use a specific function to free HWTS ring to fix this
>issue.
>
>Trace:
>[  215.351607] ------------[ cut here ]------------
>[  215.351612] DMA-API: atlantic 0000:4b:00.0: device driver frees DMA memory with different size [device address=0x00000000fbdd0000] [map size=34816 bytes] [unmap size=32768 bytes]
>[  215.351635] WARNING: CPU: 33 PID: 10759 at kernel/dma/debug.c:988 check_unmap+0xa6f/0x2360
>...
>[  215.581176] Call Trace:
>[  215.583632]  <TASK>
>[  215.585745]  ? show_trace_log_lvl+0x1c4/0x2df
>[  215.590114]  ? show_trace_log_lvl+0x1c4/0x2df
>[  215.594497]  ? debug_dma_free_coherent+0x196/0x210
>[  215.599305]  ? check_unmap+0xa6f/0x2360
>[  215.603147]  ? __warn+0xca/0x1d0
>[  215.606391]  ? check_unmap+0xa6f/0x2360
>[  215.610237]  ? report_bug+0x1ef/0x370
>[  215.613921]  ? handle_bug+0x3c/0x70
>[  215.617423]  ? exc_invalid_op+0x14/0x50
>[  215.621269]  ? asm_exc_invalid_op+0x16/0x20
>[  215.625480]  ? check_unmap+0xa6f/0x2360
>[  215.629331]  ? mark_lock.part.0+0xca/0xa40
>[  215.633445]  debug_dma_free_coherent+0x196/0x210
>[  215.638079]  ? __pfx_debug_dma_free_coherent+0x10/0x10
>[  215.643242]  ? slab_free_freelist_hook+0x11d/0x1d0
>[  215.648060]  dma_free_attrs+0x6d/0x130
>[  215.651834]  aq_ring_free+0x193/0x290 [atlantic]
>[  215.656487]  aq_ptp_ring_free+0x67/0x110 [atlantic]
>...
>[  216.127540] ---[ end trace 6467e5964dd2640b ]---
>[  216.132160] DMA-API: Mapped at:
>[  216.132162]  debug_dma_alloc_coherent+0x66/0x2f0
>[  216.132165]  dma_alloc_attrs+0xf5/0x1b0
>[  216.132168]  aq_ring_hwts_rx_alloc+0x150/0x1f0 [atlantic]
>[  216.132193]  aq_ptp_ring_alloc+0x1bb/0x540 [atlantic]
>[  216.132213]  aq_nic_init+0x4a1/0x760 [atlantic]
>
>Fixes: 94ad94558b0f ("net: aquantia: add PTP rings infrastructure")
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


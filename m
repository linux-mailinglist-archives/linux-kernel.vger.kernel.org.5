Return-Path: <linux-kernel+bounces-111354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C73886B13
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E871C21E26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6773F8D6;
	Fri, 22 Mar 2024 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dLNx6cbs"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FCD3E494
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105796; cv=none; b=rCdshhBC3Kn7QxCqHFt8LvNDTe+R5cLRB8GtKCJKrPG9xNq/fiGUtl1jiBwqFNzqZl8N+TuE26PyaEW1Jgm4ghr7fJ4oUFBxs+xiDoerAdPoO0TarNBqbCp4vZjBNjjWPUkusUN/cwLWVKKazPWTZh75Ia7l5XFKJfnx2bYusZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105796; c=relaxed/simple;
	bh=OhkkM88lwuLzNAXGaw51HYg1u1XUt5s+jikR7+zDo5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmXUCbepXxprRTPwKS3E6EfWCfo5yUiVLc6w/GktYXMi/cKiq1sc4Qa/VWYIVpwcjIm0G+unwykDSbSDNq4j1T4FKTBN3wjhSaVTSgrOgm1Q1VuLAAP8O66vjQUfzEn8CELC3vSXW2+iAiqPE64tyIbFma4m2B/KdPeIxOwcGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dLNx6cbs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4147c8e7965so2670715e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711105792; x=1711710592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OhkkM88lwuLzNAXGaw51HYg1u1XUt5s+jikR7+zDo5k=;
        b=dLNx6cbsXLVequzp7kB0WWhNgnYxRk5VQDrXKHR2i6VT8gaQZ1oaoZFiWzGGG3W7iy
         xI4RyYT8oOqjXH6nZrFEDgM5yAN4muxSsH8nFLlJ4ONbQKGF+srpyhhW7fWog6cNeK50
         8mlxRGdItpDY1OzWeaIYVS+e45Y0xQ0DpCQd+V20zp9/2P74j5KQZooenXYOQFX4bbNj
         ahF6YI4YrXrcIavPzsxm60xdt0TTCjur49PiKNJ7c7fA42HoFj8IxQ+PxBk7gUzELS3x
         7C88gH9ifv+RNsgJa40p90tlGvR5aiIc/XBmsHv8sv0rX88RzeXSD3nrPy4xuLt7ymFb
         y+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711105792; x=1711710592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhkkM88lwuLzNAXGaw51HYg1u1XUt5s+jikR7+zDo5k=;
        b=MzAf00kEBhlAfstnLemB0tO+kLmor6/zZdXGYTzV9l3XyWQsQnVYLSPkEzEI3UqDIz
         lemoeGY3HX/HEt8duXl/8/o6m2BiWn8mg/6gb6k9Pjf5kiYsOE+Jh9VYSy+KkmuGVQxu
         En6zRIKliD6mAnnT+SGULC/CP7dVDlt6W+RQTNKuFtU4LnWZEMD1AkkltF+HBgkfUS3y
         H4K3YrT/fK2sKUNb+2OZiLQ5hKlEu+U2Of5/2eSBypTMsDTrcnBPFnoT4WfxEfkwPj13
         uIXp0NGIegJZZryKv/sGSwoESFyxXlDhgYG9mq0v7tLe0Wbo7nuhDu7x11Qg4CoCNrnL
         74CA==
X-Forwarded-Encrypted: i=1; AJvYcCXjGngsAIiNzhe6k8DiTYkTQr3sfRNhibO52WMZKOao7MMoDK2kTarYk4afCRn3sgg3DgJOasVsKAx/NwgBqUy49S8PKmx8VCLCf3Su
X-Gm-Message-State: AOJu0Yxhi+XIQsgwQJtFdijjfXzyNPoHzI2mfFpORCgFfJjCiHEuigk4
	f7rwn4w9dVoEax1YfxjjSdlVn7mWQpjEmYnRvlgVwQke1t2eZOYzTIO4C0Tekwo=
X-Google-Smtp-Source: AGHT+IEGh31F6bP7iW8kYZ27cyXYp8lSwvwrvkTsxWHY4EN8KOt+AluViZO2itKlEWQETskirhb/TA==
X-Received: by 2002:a05:600c:3ca6:b0:413:f75f:98b6 with SMTP id bg38-20020a05600c3ca600b00413f75f98b6mr1385875wmb.26.1711105792061;
        Fri, 22 Mar 2024 04:09:52 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c0a0e00b004147d1bd57csm1016431wmp.8.2024.03.22.04.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 04:09:51 -0700 (PDT)
Date: Fri, 22 Mar 2024 12:09:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com
Subject: Re: [PATCH net] net: hsr: hsr_slave: Fix the promiscuous mode in
 offload mode
Message-ID: <Zf1m_Ac-476UJ29d@nanopsycho>
References: <20240322100447.27615-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322100447.27615-1-r-gunasekaran@ti.com>

Fri, Mar 22, 2024 at 11:04:47AM CET, r-gunasekaran@ti.com wrote:
>commit e748d0fd66ab ("net: hsr: Disable promiscuous mode in
>offload mode") disables promiscuous mode of slave devices
>while creating an HSR interface. But while deleting the
>HSR interface, it does not take care of it. It decreases the
>promiscuous mode count, which eventually enables promiscuous
>mode on the slave devices when creating HSR interface again.
>
>Fix this by not decrementing the promiscuous mode count while
>deleting the HSR interface when offload is enabled.
>
>Fixes: e748d0fd66ab ("net: hsr: Disable promiscuous mode in offload mode")
>Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


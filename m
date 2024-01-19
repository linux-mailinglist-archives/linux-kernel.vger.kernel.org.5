Return-Path: <linux-kernel+bounces-31303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31208832C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54841F23EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1941254789;
	Fri, 19 Jan 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Qwxy2vIL"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8441C3C465
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677405; cv=none; b=Qg0gmW/LGSRMeX2qPiqpgpsp0SzQcoXe4HVndotDsk/mkjmPBH/L3QQ5i7G8ONztHQlxqdvzNfdQiCTiwF0mRsEFHTg9na2jW6fqaUb7V0yIvuyiZ+DaSwBRVOJIHANEOoqlBapE2/z8vdMqaErFaQIfTC7dwiOZXD2sajmLCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677405; c=relaxed/simple;
	bh=XS/UGzJlsduOTTq5EzQftnYlXauoUIX8jE5HfWAcKMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFo+5ZW09iLpBU72eGyOysRu3jazfUiZsCKPIzWzbtOctyHu0tLmjIbPmfe2B7hKa0rMij1SzdHLCa4ghnrQq6n41vPwdr56I3IYXeG8mNjeJIFQCY8Eo0uzpsCIDbO/nnekm0VCt7NTg8tE1by3ma68RNadTZfAKxkbC+gkgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Qwxy2vIL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e880121efso9202555e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705677401; x=1706282201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XS/UGzJlsduOTTq5EzQftnYlXauoUIX8jE5HfWAcKMs=;
        b=Qwxy2vILULyh2qJauhuWR4VS8KfUgX6PC+aK5GGjCw2iBOSK91Dti4mNn5LVfqWFDH
         LwKTlh20z43A6KPes1Xq0+NTmITaK0PAUJtyjhzktz/WDuQca9AUvPIfDHu2HSejSY7n
         M+5cGQlUdvpd130kpp4P+fE4EUUZCJeWyhRBeDyc/g0Lm9Ea1ID9AQjpBVstqHpJ6FfO
         sMZgf/VMwv5h9qfVIaf3MWDNyOwCM2cq/T4j9Pev97VKGbt9DMb2iK6z+WBEN6mY8xd9
         NZqIJg1HSarnvGDd8YllbKjiBM8H/t+m5wiqxBmgsjikLO1beeJEC6TNDSLgwuvUSP4f
         nMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705677401; x=1706282201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XS/UGzJlsduOTTq5EzQftnYlXauoUIX8jE5HfWAcKMs=;
        b=ar+TaboKjSiubXy0U+De5+rqNZE/H5GVozVNhpliRkqefbouJPbnvN7RZFod+WfSou
         imwkATRMduSUyjL/EKkNwPspsrm3vOVZGhXlX7MB6gNW6pUA+HhXkSFIK5OqLeOff7K0
         XYgdYEY5KHpaq8ftH5K3BjOHyXfXxfFPo92OlGmFKB4lZHH6wKX+6Ihi1ZzKltCq0As3
         0KojzO7SXg8YhbSphRCdyrJXtrr+xF2NF50EMEZ/yuQHay8DSmVXqr/u8YLiRjQ0K6Gi
         FDbd3eCSBvBKXhfTb+QJyjGllLhzltKr5HWtiYO+VmwhEfOQtwMAk3QqPVu1otRhHmVC
         9nfA==
X-Gm-Message-State: AOJu0YymxOKbIw39hzxyiTbtMlRFvYDx1euPWN6/19RL3/3AasYVLGGF
	TkVXFvtbLX5z57ps3vlEaE/P7NIWiv1OzzBFEbpx/zpz74OERtItIOWNz1fg9Po=
X-Google-Smtp-Source: AGHT+IG0KxjVDwCtYO1ZcfLfYt1CAC00P/UJqg0tnjxff7dkNav5xy4kvEhMpby3K+m2nTs2estJ+w==
X-Received: by 2002:a05:600c:4513:b0:40e:4119:cb4a with SMTP id t19-20020a05600c451300b0040e4119cb4amr1741043wmo.15.1705677400700;
        Fri, 19 Jan 2024 07:16:40 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b0040d772030c2sm29381969wms.44.2024.01.19.07.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 07:16:40 -0800 (PST)
Date: Fri, 19 Jan 2024 16:16:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, davem@davemloft.net,
	milena.olech@intel.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, mschmidt@redhat.com,
	Jan Glaza <jan.glaza@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v6 2/4] dpll: fix pin dump crash for rebound module
Message-ID: <ZaqSV-OjYPrSTbew@nanopsycho>
References: <20240119134304.576956-1-arkadiusz.kubalewski@intel.com>
 <20240119134304.576956-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119134304.576956-3-arkadiusz.kubalewski@intel.com>

Fri, Jan 19, 2024 at 02:43:02PM CET, arkadiusz.kubalewski@intel.com wrote:
>When a kernel module is unbound but the pin resources were not entirely
>freed (other kernel module instance of the same PCI device have had kept
>the reference to that pin), and kernel module is again bound, the pin
>properties would not be updated (the properties are only assigned when
>memory for the pin is allocated), prop pointer still points to the
>kernel module memory of the kernel module which was deallocated on the
>unbind.
>
>If the pin dump is invoked in this state, the result is a kernel crash.
>Prevent the crash by storing persistent pin properties in dpll subsystem,
>copy the content from the kernel module when pin is allocated, instead of
>using memory of the kernel module.
>
>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


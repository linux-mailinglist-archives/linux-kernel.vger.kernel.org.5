Return-Path: <linux-kernel+bounces-29076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0721E8307F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812461F248EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC635208AF;
	Wed, 17 Jan 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XV5nPUyv"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4107208A5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501439; cv=none; b=B1u7PTFanBwlFimMlaWzogC9e4IqcOMTLLaFkf3O6P1xMKzhYFBM1pocjl3BZrpC6H7gtmZ/D+sBMwTyPNXOgcIQj3nFp1AkjHsyJ42E3KGfbQED3V27xcl/6MVUq+0zkNDqbj3eDjaEx2mhFhlT+CfmoH/i1jx63+1XR7vGLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501439; c=relaxed/simple;
	bh=QP/kog4WDMsS1IF6m1eXj7s6QZfFY1iVp9xzDjKr3rU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KdeL1cnKS1rETq0Byhd79fWfZp5LZ1T2ENuy0X0w2Jz6jVOPavcd3Pftj6dpyrmF+7lVC3wWz7tt2RkhDSfZJyzg991X+Rak+Termyk37/B4lnEQ4EkXSyWBT3VUmrFYHx9jNF3FWqE7zrskDvPKCfFxRlldVecXJANPpgIdb0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XV5nPUyv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so25749465e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705501434; x=1706106234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=604UT1Bh5cvzg3izJCcO+M0xyGx8IRNQYli2dc+rEGM=;
        b=XV5nPUyvxsieeTV7Q7rqt++1lAbCFwJUuI3oPMlJpEFvtnDNRaG9dLgDulBa+yd6Dq
         WS+pC5vhIKL5B5/5wq+6DdB3wgKUc+KRXl7V2rSmQQPQzu9J/mlx81mrzQntYQoC1zm3
         uFp6AZdXRmH9VhVCMXZakur/GmbscQUCcbmm9h90S/2slwbxgXSH6BZORcFR9Z6OAFK0
         3ii2NyRQjfqnakInm+dd/h6sTY0qnDQQTUvFAQvZx4uhO5K0lnS0GhmsDd8XnXs4/jkv
         lxeCy/Iyf25JulhYmlZ7HmEOjGhI0hEFlMSpR1vOf6oHoDyVyTIELco1VdwJ948OaYXj
         5WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705501434; x=1706106234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=604UT1Bh5cvzg3izJCcO+M0xyGx8IRNQYli2dc+rEGM=;
        b=iUsCrxyCPQeDYcqNXVRE/URAgFauw+/jOyq6OEMFpzdM9tPbMYCRQJNdFVgzcGvvL0
         /y+hILL+YqUwAXlo+xvO0XL5YKw1cGqkiCykfnMFG3rR1yWCksYySe2X8uQUBug1TpCX
         0dkccq9CxW0pNXkSxal4VywvzbG/KvCBHRKaZQI0Fise58MzmlGdrcuiw1hrQFVR4y5d
         Vo3hPn0bIn9PQirACh6oWJb3C9y7ko1TdvhIKJSn5HgHoqCgHrIsjdfz8JtBzwWjh4AH
         zRDZFHC7IH/Axixjcwl/My+kzULKUFWeoQ78ixEhE7F6DI9fNhT9ul6uIRpSOszdtXBU
         2Vmw==
X-Gm-Message-State: AOJu0YxwFf5KHL37ulHkhTSSX8Pe6Pcp1gXSzian3ipl+Ltgq33LZnIH
	Y5WbpjCHuaZf8RkTfF1c/QA5AFaADnwifQ==
X-Google-Smtp-Source: AGHT+IEzCYnpT0aGCLswtugyXmRr7OAjNIP+l0tmTjACK6cWD6nZoVc2Imq8DJHpETdynXPlXfxtcQ==
X-Received: by 2002:a7b:cbc8:0:b0:40e:5f07:8179 with SMTP id n8-20020a7bcbc8000000b0040e5f078179mr4900074wmi.55.1705501433765;
        Wed, 17 Jan 2024 06:23:53 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t25-20020a1c7719000000b0040d84bb7d6csm5805520wmi.0.2024.01.17.06.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 06:23:53 -0800 (PST)
Date: Wed, 17 Jan 2024 15:23:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, davem@davemloft.net,
	milena.olech@intel.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, mschmidt@redhat.com,
	Jan Glaza <jan.glaza@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net v4 1/4] dpll: fix pin dump crash for rebound module
Message-ID: <Zafi9wid9HlbLM0z@nanopsycho>
References: <20240117091416.504096-1-arkadiusz.kubalewski@intel.com>
 <20240117091416.504096-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117091416.504096-2-arkadiusz.kubalewski@intel.com>

Wed, Jan 17, 2024 at 10:14:13AM CET, arkadiusz.kubalewski@intel.com wrote:
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

[...]


>@@ -443,7 +490,9 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
> 		ret = -EINVAL;
> 		goto err;
> 	}
>-	pin->prop = prop;
>+	ret = dpll_pin_prop_dup(prop, &pin->prop);
>+	if (ret)
>+		goto pin_free;

This does not compile, does it? Please fix the error path first (patch
4 should be patch 1) and then use properly named label right away there.

pw-bot: cr


> 	refcount_set(&pin->refcount, 1);
> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);

[...]


Return-Path: <linux-kernel+bounces-153450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453128ACE40
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDB5281ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F30814F9FE;
	Mon, 22 Apr 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SQIWe0kd"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B283F14F9EC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792685; cv=none; b=ukB+UDNcCXuwROPCpV/wrg0B7qRDEe58ZCnk4mBXrMmurt/K+wARTuE6tW4UmbSdU2e+6O3mpQwQp9wgRpPx9MqPP8om9hpVvaSHtSpPPzMI4u/bF5r7gl9yq8wqsavCDozUc0kGhLsn7xtb5XFxKikINs2J+iJr5cX4gCDOAqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792685; c=relaxed/simple;
	bh=8fA3TgGvoky2+yTrrPUrw7Y450/xNnRGDxxK59xj4xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY5o16FTFzxV3auInvWDo5IzZ+/YrR1Mm9YK0T45t3NUnokjjTKbT4FFCVnkYRWes6YRhgWxHw41A6cJuZ9vnwV+W4H3Pw5xK4KYQi2Q3oKxte1mfTqtT4BVs6p04qO2v6fXs+RQ5QTTMjLQLwuoKSPfbK4gcD1K1KsbSEtcano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SQIWe0kd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-418c2bf2f55so29613415e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713792681; x=1714397481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f/MngZQXdZZfwg1mKUe1CDRIHgGlqjOS5NNa7bAOpCE=;
        b=SQIWe0kdUk14wy4DekdiiF7DV8pYG5N8Yv7doBu9YOSbFzV+k6TIPBolKTiwtIt+mp
         GOjakivGLxULyw5snSV8ZMq5EEioXWM1PSEcSl7Nzvc/q2vkeHKCI0hBGfwE/6oQM+YV
         JpLUQDFRmEhHSPN5OXNu4nIG61ELetEusA0EE/gjAHKCLiuxG9Fn7RwzAPKABnmD1eWR
         KPvf5Dhy0btBYF2TN+Ku9c5SlhhiFBKUDDh9OV+Gg6VN9hx8iAQtRFnsmRz45ipVLZGN
         ZZK5bdXNYSL6eQaHU/t/Hp0w3FlPbdt6pveEga23mDbenyRgrmVMWokuoooiSbDd1uZs
         8YbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792681; x=1714397481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/MngZQXdZZfwg1mKUe1CDRIHgGlqjOS5NNa7bAOpCE=;
        b=BhVhdc+WFa+42oK6XzOBhan+vQnDf64GKFCOtHC/dT5HFSXm2QpxUijQF6mb4v8Lyg
         AhQw0KlWrNjqhkebIB1JIyi5slIkFaHGjfVQDSTIiM2dKJLTlMSnag5vUfbb3l98dNvn
         bkRMdQcOQCn4NRRY1iLWGT0k2eNNf2bPDxgzwWz3t/0c/+VFrwTDMNHXa6229r6cNio2
         OTjQ0bAAySqQROI8NNrLh0hcMmWa3Tb/Cou6FMAX2HpZEm3fBSJFHtkj95EN9pLp+e/i
         3sbsY2klbN01mi2ce5bjL5CF/+W5ahqEM9znQgrGo3CyTwF98Q3OxxaIt7o7QE0llhSH
         Dv8g==
X-Forwarded-Encrypted: i=1; AJvYcCUkzLor4SQdea6uKLqcmIDRUI7vErVlsyPKBbZe3P4ppG2nepufD+HLFm7UTcquU6FaG5/VUn41GC1ZLKa1bGDQqDFYg/dSCXfDd2TK
X-Gm-Message-State: AOJu0Yw57QUjBf8xPNnzQ82DBnt9qURnAwAVrjJ7OsetZKsfx0CWqSUw
	n6eoQBLaGZ3SdlNk/IRnswlQqu/srlitYmWvTFyOIbS/kUy2cRL/Ut2ihJK8U+4=
X-Google-Smtp-Source: AGHT+IFcxtQBTYafkchwt8ZWHFimE9yIbN5RHKFdoTAga4Ct03S83SdcD/iOdVDlpCeKJ4AuSBJxRA==
X-Received: by 2002:a05:600c:4688:b0:418:a2ce:77ae with SMTP id p8-20020a05600c468800b00418a2ce77aemr7437610wmo.27.1713792680588;
        Mon, 22 Apr 2024 06:31:20 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b00418729383a4sm16574352wmq.46.2024.04.22.06.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:31:19 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:31:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, davem@davemloft.net,
	rrameshbabu@nvidia.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, mschmidt@redhat.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net] dpll: fix dpll_pin_registration missing refcount
Message-ID: <ZiZmpg7GF99Ihxk0@nanopsycho>
References: <20240419194711.1075349-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419194711.1075349-1-arkadiusz.kubalewski@intel.com>

Fri, Apr 19, 2024 at 09:47:11PM CEST, arkadiusz.kubalewski@intel.com wrote:
>In scenario where pin is registered with multiple parent pins via
>dpll_pin_on_pin_register(..), belonging to the same dpll device,
>and each time with the same set of ops/priv data, a reference
>between a pin and dpll is created once and then refcounted, at the same
>time the dpll_pin_registration is only checked for existence and created
>if does not exist. This is wrong, as for the same ops/priv data a
>registration shall be also refcounted, a child pin is also registered
>with dpll device, until each child is unregistered the registration data
>shall exist.

I read this 3 time, don't undestand clearly the matter of the problem.
Could you perhaps make it somehow visual?


>
>Add refcount and check if all registrations are dropped before releasing
>dpll_pin_registration resources.
>
>Currently, the following crash/call trace is produced when ice driver is
>removed on the system with installed NIC which includes dpll device:
>
>WARNING: CPU: 51 PID: 9155 at drivers/dpll/dpll_core.c:809 dpll_pin_ops+0x20/0x30
>Call Trace:
> dpll_msg_add_pin_freq+0x37/0x1d0
> dpll_cmd_pin_get_one+0x1c0/0x400
> ? __nlmsg_put+0x63/0x80
> dpll_pin_event_send+0x93/0x140
> dpll_pin_on_pin_unregister+0x3f/0x100
> ice_dpll_deinit_pins+0xa1/0x230 [ice]
> ice_remove+0xf1/0x210 [ice]
>
>Fixes: b446631f355e ("dpll: fix dpll_xa_ref_*_del() for multiple registrations")
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---
> drivers/dpll/dpll_core.c | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 64eaca80d736..7ababa327c0c 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -40,6 +40,7 @@ struct dpll_device_registration {
> 
> struct dpll_pin_registration {
> 	struct list_head list;
>+	refcount_t refcount;
> 	const struct dpll_pin_ops *ops;
> 	void *priv;
> };
>@@ -81,6 +82,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
> 		reg = dpll_pin_registration_find(ref, ops, priv);
> 		if (reg) {
> 			refcount_inc(&ref->refcount);
>+			refcount_inc(&reg->refcount);

I don't like this. Registration is supposed to be created for a single
registration. Not you create one for many and refcount it.

Instead of this, I suggest to extend __dpll_pin_register() for a
"void *cookie" arg. That would be NULL for dpll_pin_register() caller.
For dpll_pin_on_pin_register() caller, it would pass "parent" pointer.

Than dpll_xa_ref_pin_add() can pass this cookie value to
dpll_pin_registration_find(). The if case there would look like:
if (reg->ops == ops && reg->priv == priv && reg->cookie == cookie)

This way, we will create separate "sub-registration" for each parent.

Makes sense?

> 			return 0;
> 		}
> 		ref_exists = true;
>@@ -113,6 +115,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
> 	reg->priv = priv;
> 	if (ref_exists)
> 		refcount_inc(&ref->refcount);
>+	refcount_set(&reg->refcount, 1);
> 	list_add_tail(&reg->list, &ref->registration_list);
> 
> 	return 0;
>@@ -131,8 +134,10 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
> 		reg = dpll_pin_registration_find(ref, ops, priv);
> 		if (WARN_ON(!reg))
> 			return -EINVAL;
>-		list_del(&reg->list);
>-		kfree(reg);
>+		if (refcount_dec_and_test(&reg->refcount)) {
>+			list_del(&reg->list);
>+			kfree(reg);
>+		}
> 		if (refcount_dec_and_test(&ref->refcount)) {
> 			xa_erase(xa_pins, i);
> 			WARN_ON(!list_empty(&ref->registration_list));
>@@ -160,6 +165,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
> 		reg = dpll_pin_registration_find(ref, ops, priv);
> 		if (reg) {
> 			refcount_inc(&ref->refcount);
>+			refcount_inc(&reg->refcount);
> 			return 0;
> 		}
> 		ref_exists = true;
>@@ -192,6 +198,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
> 	reg->priv = priv;
> 	if (ref_exists)
> 		refcount_inc(&ref->refcount);
>+	refcount_set(&reg->refcount, 1);
> 	list_add_tail(&reg->list, &ref->registration_list);
> 
> 	return 0;
>@@ -211,8 +218,10 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
> 		reg = dpll_pin_registration_find(ref, ops, priv);
> 		if (WARN_ON(!reg))
> 			return;
>-		list_del(&reg->list);
>-		kfree(reg);
>+		if (refcount_dec_and_test(&reg->refcount)) {
>+			list_del(&reg->list);
>+			kfree(reg);
>+		}
> 		if (refcount_dec_and_test(&ref->refcount)) {
> 			xa_erase(xa_dplls, i);
> 			WARN_ON(!list_empty(&ref->registration_list));
>
>base-commit: ac1a21db32eda8a09076bad025d7b848dd086d28
>-- 
>2.38.1
>


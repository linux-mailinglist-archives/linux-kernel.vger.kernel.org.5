Return-Path: <linux-kernel+bounces-154962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB4A8AE3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B30E1C22687
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F8F7E58A;
	Tue, 23 Apr 2024 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wC8oKOk7"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168B60279
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870998; cv=none; b=girEENuXPFbxa0uY/5Up/i3qOtxeaWPYKIiGXKtd8SKcdT+Ja2YTWSFVQDt7alNSXusvxEBYfNYvzlrgoGrfKXiJquy0y1N069DHGj/osVlXS73nPGFiYatCUVajUrLtTT3ek/bcbDYLPXPAd0twdwheaI/LUMAkg0VEpUPIEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870998; c=relaxed/simple;
	bh=vJ7vKFjiwn65Rjcu8oRwURAmmYugDNrXhg2GErSucAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtlCtOkJtSHRJOREBHQEok4p0QueIA+iUDlkzBGWKYNDJArncxceQr6y1ZjU9iaUQPn5xpx4GnEC6MWQAjEBBVF0SDLDu/t0N/B0z+yR9VB67rmqolhAM4dTJhN91BPBYJdTGMvdHVmIHouAxNvzMfUg4P6jcSn6bj7otCwAJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wC8oKOk7; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so7484971e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713870994; x=1714475794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdL15pJ77Sj0Cva8ICRQ2JuwbtlCzNTOoIbNph6ObY8=;
        b=wC8oKOk7ZgiHqMWO6b5nkVAx+mkpNxz5AjXyGiMMXcfWZee4AXbUp1cqURMBOoUZGQ
         9Lbp+cLpGPqPGxY7pvi/cw9So0Gbw/2U75spxFDcm366zZIAgtTqZpUxTh6DU7aUO+P/
         yQQqm8Cl6D22lBDkPvwkL7s/2yYYxmSysl9XWhQvv2c5oB7DcMhxkfe9zcAOOJeyCIi3
         4uO1T0Zwpriyni+xoHDbiSmNmY4o8UsUJZkfXoRxKBodTAmOZG1nXzkz8p+ynbjV5EwE
         Emmvj9l++ozi+hr55ancLGCkT5QVOPyd++Epse0cXTWDaweWsod0oneiVSR1MRRZ97Rd
         IbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870994; x=1714475794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdL15pJ77Sj0Cva8ICRQ2JuwbtlCzNTOoIbNph6ObY8=;
        b=XDzqd+jz1C/Ci9o0x0Swfy5/V/Aw8vbnMfkmHW7cERmbcsGhuYSiAqU9rpA4TqjF4d
         sCXXf7z+KuxjpZpszav+MWeiEomtNVidAvFzvOq+2Q8h+nfSo+D+KC0lhtysUw3AlcNH
         +vuPxEbcwjm+yVPcKdnGOpM8dGJT5PJoIEo38ahv04inpi65CO7BSceUpVLASqPICocz
         jNM/VxmSXXBkuNQad9Rsobidffx4IFHuEAU2JpfZ045eXAdA7T2XGEOScuj11S424ad8
         Z8fjz9YH5t50v40RUpORlFTj8DlSXrVnknpkWPMyhLS3r7Ae4JvssUtS1D6AfLpldgJw
         tnbg==
X-Forwarded-Encrypted: i=1; AJvYcCUIt8nqpIrJWztfKFyiciAjMFMOFw1zloGyjCuzrXT8S6Z8YCNXiacKpBoJHn8zZV5BvAehP39I2fPX363v8jFfaNKnL1ot00tN9+pW
X-Gm-Message-State: AOJu0YwebEKV5S84dPl8v0eT7aw3gwWT1yFCTbuf8L9CtQ4aQlod0HxT
	Rnxhs4alwdIxjNBC0Sf4BLSO/HX9T5OorRwcZyk3P8wZyuKcS+yNhv0QtXutKvM=
X-Google-Smtp-Source: AGHT+IEqq/LsVJtE0wthdIKhcntSB7Gb2ngStY4jSM2+07iy0TxYP6vVZWhu/ZbRAHN6en41+ZreBQ==
X-Received: by 2002:a19:3855:0:b0:515:9d9e:7339 with SMTP id d21-20020a193855000000b005159d9e7339mr9434432lfj.20.1713870993542;
        Tue, 23 Apr 2024 04:16:33 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id em3-20020a170907288300b00a5871e215c8sm1340551ejc.127.2024.04.23.04.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:16:32 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:16:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"rrameshbabu@nvidia.com" <rrameshbabu@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, mschmidt <mschmidt@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net] dpll: fix dpll_pin_registration missing refcount
Message-ID: <ZieYjuoRl61WCVZg@nanopsycho>
References: <20240419194711.1075349-1-arkadiusz.kubalewski@intel.com>
 <ZiZmpg7GF99Ihxk0@nanopsycho>
 <DM6PR11MB465781953B5600F67C96AA809B112@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB465781953B5600F67C96AA809B112@DM6PR11MB4657.namprd11.prod.outlook.com>

Tue, Apr 23, 2024 at 01:04:22PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Monday, April 22, 2024 3:31 PM
>>
>>Fri, Apr 19, 2024 at 09:47:11PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>>In scenario where pin is registered with multiple parent pins via
>>>dpll_pin_on_pin_register(..), belonging to the same dpll device,
>>>and each time with the same set of ops/priv data, a reference
>>>between a pin and dpll is created once and then refcounted, at the same
>>>time the dpll_pin_registration is only checked for existence and created
>>>if does not exist. This is wrong, as for the same ops/priv data a
>>>registration shall be also refcounted, a child pin is also registered
>>>with dpll device, until each child is unregistered the registration data
>>>shall exist.
>>
>>I read this 3 time, don't undestand clearly the matter of the problem.
>>Could you perhaps make it somehow visual?
>>
>
>Many thanks for all your insights on this!
>
>Register child pin twice (via dpll_pin_on_pin_register(..)) with two different
>parents but the same ops/priv. Then, a single dpll_pin_on_pin_unregister(..) will
>cause below stack trace.
>
>It was good to add a fix in b446631f355e, but the fix did not cover a multi-parent
>registration case, here I am fixing it.
>
>>
>>>
>>>Add refcount and check if all registrations are dropped before releasing
>>>dpll_pin_registration resources.
>>>
>>>Currently, the following crash/call trace is produced when ice driver is
>>>removed on the system with installed NIC which includes dpll device:
>>>
>>>WARNING: CPU: 51 PID: 9155 at drivers/dpll/dpll_core.c:809 dpll_pin_ops+0x20/0x30
>>>Call Trace:
>>> dpll_msg_add_pin_freq+0x37/0x1d0
>>> dpll_cmd_pin_get_one+0x1c0/0x400
>>> ? __nlmsg_put+0x63/0x80
>>> dpll_pin_event_send+0x93/0x140
>>> dpll_pin_on_pin_unregister+0x3f/0x100
>>> ice_dpll_deinit_pins+0xa1/0x230 [ice]
>>> ice_remove+0xf1/0x210 [ice]
>>>
>>>Fixes: b446631f355e ("dpll: fix dpll_xa_ref_*_del() for multiple registrations")
>>>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>---
>>> drivers/dpll/dpll_core.c | 17 +++++++++++++----
>>> 1 file changed, 13 insertions(+), 4 deletions(-)
>>>
>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>index 64eaca80d736..7ababa327c0c 100644
>>>--- a/drivers/dpll/dpll_core.c
>>>+++ b/drivers/dpll/dpll_core.c
>>>@@ -40,6 +40,7 @@ struct dpll_device_registration {
>>>
>>> struct dpll_pin_registration {
>>> 	struct list_head list;
>>>+	refcount_t refcount;
>>> 	const struct dpll_pin_ops *ops;
>>> 	void *priv;
>>> };
>>>@@ -81,6 +82,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct
>>>dpll_pin *pin,
>>> 		reg = dpll_pin_registration_find(ref, ops, priv);
>>> 		if (reg) {
>>> 			refcount_inc(&ref->refcount);
>>>+			refcount_inc(&reg->refcount);
>>
>>I don't like this. Registration is supposed to be created for a single
>>registration. Not you create one for many and refcount it.
>>
>
>If register function is called with the same priv/ops, why to do all you
>suggested below instead of just refcounting?
>
>>Instead of this, I suggest to extend __dpll_pin_register() for a
>>"void *cookie" arg. That would be NULL for dpll_pin_register() caller.
>>For dpll_pin_on_pin_register() caller, it would pass "parent" pointer.
>>
>>Than dpll_xa_ref_pin_add() can pass this cookie value to
>>dpll_pin_registration_find(). The if case there would look like:
>>if (reg->ops == ops && reg->priv == priv && reg->cookie == cookie)
>>
>>This way, we will create separate "sub-registration" for each parent.
>>
>>Makes sense?
>>
>
>It would do, but only if the code would anyhow use that new parent
>sub-registration explicitly for anything else later.
>
>Creating a sub-registration with additional parent cookie just to create a
>second registration with only difference parent cookie and not using the
>cookie even once after, seems overshot for a fix.

Well, we have ref with multiple references and refcount, single
registration instance per registration. Now you make that multiple
references and refcounted as well, just because the parent is different.
That is why I suggested to add the parent to the registration look-up
if. Makes things a bit cleaner to read in already quite complex code.


>
>What you suggest is rather a refactor, but again needed only after we would
>make use of the parent cooking somewhere else.
>And such refactor shall target next-tree, right?

Not sure what refactor you refer to. Couple of lines, similar to your
version.


>
>Thank you!
>Arkadiusz
>
>>> 			return 0;
>>> 		}
>>> 		ref_exists = true;
>>>@@ -113,6 +115,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct
>>>dpll_pin *pin,
>>> 	reg->priv = priv;
>>> 	if (ref_exists)
>>> 		refcount_inc(&ref->refcount);
>>>+	refcount_set(&reg->refcount, 1);
>>> 	list_add_tail(&reg->list, &ref->registration_list);
>>>
>>> 	return 0;
>>>@@ -131,8 +134,10 @@ static int dpll_xa_ref_pin_del(struct xarray
>>>*xa_pins, struct dpll_pin *pin,
>>> 		reg = dpll_pin_registration_find(ref, ops, priv);
>>> 		if (WARN_ON(!reg))
>>> 			return -EINVAL;
>>>-		list_del(&reg->list);
>>>-		kfree(reg);
>>>+		if (refcount_dec_and_test(&reg->refcount)) {
>>>+			list_del(&reg->list);
>>>+			kfree(reg);
>>>+		}
>>> 		if (refcount_dec_and_test(&ref->refcount)) {
>>> 			xa_erase(xa_pins, i);
>>> 			WARN_ON(!list_empty(&ref->registration_list));
>>>@@ -160,6 +165,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct
>>>dpll_device *dpll,
>>> 		reg = dpll_pin_registration_find(ref, ops, priv);
>>> 		if (reg) {
>>> 			refcount_inc(&ref->refcount);
>>>+			refcount_inc(&reg->refcount);
>>> 			return 0;
>>> 		}
>>> 		ref_exists = true;
>>>@@ -192,6 +198,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct
>>>dpll_device *dpll,
>>> 	reg->priv = priv;
>>> 	if (ref_exists)
>>> 		refcount_inc(&ref->refcount);
>>>+	refcount_set(&reg->refcount, 1);
>>> 	list_add_tail(&reg->list, &ref->registration_list);
>>>
>>> 	return 0;
>>>@@ -211,8 +218,10 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct
>>>dpll_device *dpll,
>>> 		reg = dpll_pin_registration_find(ref, ops, priv);
>>> 		if (WARN_ON(!reg))
>>> 			return;
>>>-		list_del(&reg->list);
>>>-		kfree(reg);
>>>+		if (refcount_dec_and_test(&reg->refcount)) {
>>>+			list_del(&reg->list);
>>>+			kfree(reg);
>>>+		}
>>> 		if (refcount_dec_and_test(&ref->refcount)) {
>>> 			xa_erase(xa_dplls, i);
>>> 			WARN_ON(!list_empty(&ref->registration_list));
>>>
>>>base-commit: ac1a21db32eda8a09076bad025d7b848dd086d28
>>>--
>>>2.38.1
>>>


Return-Path: <linux-kernel+bounces-90064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BE286F9AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A1DEB21142
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82057BE65;
	Mon,  4 Mar 2024 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vF8V8jHP"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FB6138
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709531126; cv=none; b=gvZlZ8+HmK7kvMXdwQdmIcuKEiKvJqVJgug47/0A+/qY+2jTSLKsQSU55JDxM1kShUvlYjm6V9BckM6P3MfDX1ykJPmbB4t/KLgOmnI7q9beZa3Q9X+/Db7Kiel+KNqyGJrOQaQOtNMyZwBzLhSWKzsAxJOX1lDyzdTYBSJadFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709531126; c=relaxed/simple;
	bh=++rr3GGIRoaCERnG/cWu7OqJ4/FLWkd9s2osDrEnVgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYB/GXDeYlOQwv5EbIKvyjoRbO7QsMZGdoVCK8DfW7M2Wu/6EcBhWT92lG/mBGPA1inqRAtlGtErWA307jw7cHNTIA2gu4aNERFsOqyIjaoy7YfSLenLbthprWwXTsHJES+tAUmEJdR899Nrcy5NvBXoDl6VzHl8ce73l3fWyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vF8V8jHP; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-47268589ec9so2010338137.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 21:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709531123; x=1710135923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iS66EljrgAI6W0osXJVskq7IlYu87j8C6OY/XQH31Zo=;
        b=vF8V8jHPR7CBdSwL53hMRpGPaIO5AYRMOd7BWo6/IxDU1LurYEQzHr6vwsANkyX8Nh
         wE9nY2S7irp9X5uvVfoUyoCr0QyfuUgU5Jg8luabewNVOqzz3wYSlj0AfDx/3qq20tNT
         6bgSmRHP22IkvUS9s5e74ttGsaVs4f/JSNN8GcIoq9EKbcwB+Z/icEt5jirI1Y8tZ2A0
         Z2rDHQ3denQYgdMbRoLCFqgYk+yeIs3XCbT/+seo8EUch0Q+ctafAQQIssZBkEitrOHR
         q4lcAnHG4tJwCqBwIPSHlYq3gCKZbgUBMQIa4TFPO88VISolKhgwsClOqxfvvjyDfdsD
         KRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709531123; x=1710135923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iS66EljrgAI6W0osXJVskq7IlYu87j8C6OY/XQH31Zo=;
        b=kBj1Y7azbL5fFr7W8YFLXc4LjZwj0T4M1HaGYKpFqEpEKcZRphmb9LZiCQZvGdPTej
         xGjsjROA1Z+MRrxzLgPtPT3haUpNX+eaHlhAr0+U/oCZTV7V7is+y8K+3jAhxoOQ2VDY
         Mi4mIXJGnSRujCI1BU1x6M9MJ0qtGvem/WuR/iWKmzZTPbHA7aQIdoFcXjPBFka6hfcN
         ApYFJZeRaN2UMHLyQgjhp8Ct0snks+hagGDJ2Ww47zvQ+IZTgcHCBwdDNl39snzlJqW7
         BgvA+B0dKSt8fY3/YfVnAFwEJMnceyvCboQ/nY6zf6AJQpRmJj4ojzT/kiIAN/ZljITr
         J8tg==
X-Forwarded-Encrypted: i=1; AJvYcCUL4hN0EPGjrZjVRDxFP/bTnCn/psz3rYaGwG95ov3Ls/qRKAcw+938qNJTfdAgcbZVvr5d1rch6VGxUD912dAqYefRN2KBI0j8379F
X-Gm-Message-State: AOJu0YwZebBdJooeSs0ZbrXzcuxc11S44pmzk0QQ5bEG92U9MH26HMHq
	PfN8xMD3JzRVVl5NTE5xZMfk+kVEiQTIJNT2p36zxsTmKraTBkuLYvOPxLh94VuR7PYxzlUAMCq
	JuuEa4OckoKw8OT0bjC1m0l/WRJG4AYi/Revt2w==
X-Google-Smtp-Source: AGHT+IGJiKCOmmG+6e4PqjE1sfyU8YCCfMdFjZs0DvF1bN/K25rjAZqRY4ze3L0+lpCsgPEmXAeBpB3H3Xx+bx16hSQ=
X-Received: by 2002:a05:6102:3e07:b0:472:c993:a596 with SMTP id
 j7-20020a0561023e0700b00472c993a596mr1004393vsv.11.1709531122998; Sun, 03 Mar
 2024 21:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301143731.3494455-1-sumit.garg@linaro.org>
In-Reply-To: <20240301143731.3494455-1-sumit.garg@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 4 Mar 2024 11:15:11 +0530
Message-ID: <CAFA6WYOdyPG8xNCwchSzGW+KiaXZJ8LTYuKpyEbhV=tdYz=gUg@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix kernel panic caused by incorrect error handling
To: jens.wiklander@linaro.org, Arnd Bergmann <arnd@arndb.de>
Cc: op-tee@lists.trustedfirmware.org, ilias.apalodimas@linaro.org, 
	jerome.forissier@linaro.org, linux-kernel@vger.kernel.org, 
	mikko.rapeli@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+ Arnd

On Fri, 1 Mar 2024 at 20:07, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> The error path while failing to register devices on the TEE bus has a
> bug leading to kernel panic as follows:
>
> [   15.398930] Unable to handle kernel paging request at virtual address ffff07ed00626d7c
> [   15.406913] Mem abort info:
> [   15.409722]   ESR = 0x0000000096000005
> [   15.413490]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   15.418814]   SET = 0, FnV = 0
> [   15.421878]   EA = 0, S1PTW = 0
> [   15.425031]   FSC = 0x05: level 1 translation fault
> [   15.429922] Data abort info:
> [   15.432813]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> [   15.438310]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [   15.443372]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   15.448697] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000d9e3e000
> [   15.455413] [ffff07ed00626d7c] pgd=1800000bffdf9003, p4d=1800000bffdf9003, pud=0000000000000000
> [   15.464146] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>
> Commit 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
> lead to the introduction of this bug. So fix it appropriately.
>
> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218542
> Fixes: 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Jens, Arnd,

Is there any chance for this fix to make it into v6.8 release?

-Sumit

> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 9d2afac96acc..d296c70ddfdc 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -90,13 +90,14 @@ static int optee_register_device(const uuid_t *device_uuid, u32 func)
>         if (rc) {
>                 pr_err("device registration failed, err: %d\n", rc);
>                 put_device(&optee_device->dev);
> +               return rc;
>         }
>
>         if (func == PTA_CMD_GET_DEVICES_SUPP)
>                 device_create_file(&optee_device->dev,
>                                    &dev_attr_need_supplicant);
>
> -       return rc;
> +       return 0;
>  }
>
>  static int __optee_enumerate_devices(u32 func)
> --
> 2.34.1
>


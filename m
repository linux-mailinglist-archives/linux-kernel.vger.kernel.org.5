Return-Path: <linux-kernel+bounces-86614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D486C7D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB0D28573C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F477A711;
	Thu, 29 Feb 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5RwuDUp"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3BD7A704;
	Thu, 29 Feb 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205329; cv=none; b=Wk6CzTMaImZqCmow9tStANU5e8sMAMbc9w4AiSWgxgDcyofR+iL2/IoNR4wc/6wGXUlqqnx3aCOfJIOhKUiui0B1slVpcyP75RTrtvWTRKuriXyA3zMy0rm25ftgmJeJDTsApjmOz7/tHd7ENiOju9cfFy6mlbNMmL4yOxPOnWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205329; c=relaxed/simple;
	bh=oVy3i+UrUumrf3a4PnAuzzf3DQEDoVYk6MSRN5VLtyM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bddvQmbkjvvp07QjPEJKFuQZ3KHenBdV7N/XZ/U/xSaiW0NWgLgF8jomfrU/WahBf1PA0pGKQgKwxpYegg9i1mmcL6VN0KX52QPFGr/OzuO+5CxHSU1levOOFBQrWWUmqUL8/9Jd1Hp1Al/nMqVzJdjxILxsKSsEM3daUzHnxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5RwuDUp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-566adfeced4so376965a12.1;
        Thu, 29 Feb 2024 03:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709205326; x=1709810126; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ly35jGeNvOrKRwndvR1mRFcyvn9CVQRuowe5Y/I2C+s=;
        b=Y5RwuDUp3+cfhMp7AYQbQsxwnVWu2cvkhfRGBWJC/fB2M/da/AaR++zFnjdgRgEhed
         pcRSBF4VgbyFon/4UBNvNSSODVJ8kQISt4FLxf9aX2tp5w8Pgr3FJvRL11x7LrfXglPR
         f/tVNCVHYbFixASXSuO+7GEkNiPtEskyc4hn7sFCMyBAb1/Z762LCCMCn1hf/OEo5Rxq
         PMhUMbSq4osMEUTwc2+S4vMuMu5/JJee9iOG5KDqtrU/Ckj1oX6SnMrmXnfWGzfAhehZ
         jnJFx5vZrPXukRk5FgED9nxftqyu+1mj+oMS6pV/uvLMIzU0GHBEHtDvHnmINPgdTRBI
         Oz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709205326; x=1709810126;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ly35jGeNvOrKRwndvR1mRFcyvn9CVQRuowe5Y/I2C+s=;
        b=l0rIm2iAlyk6+6eD+C0OvFQ9Tpp+C43tXQmL+MA2C/1ZcHc727V0UQfogsr4vC4b0n
         S+VjoW+RIBSiolTbtnrRhziKCcwnHZwZthFc7Jm15wlxmYUmWXZ9mNqJkZDS7bKXYNnK
         D/R+/Gur5ZX+K9uXuGpRntF2Op6oYpiMx5DGPbyfsiVmlRxX+QhtajVHi8P6cWh84MXR
         AzTwZaorNZr4oAvHPWjDSZDBaOGx9CfdPT5JtMV0CNqg5nElY4j50eiOCB5Czh7H1d+H
         9xpNIMyRRYpxyxKUPJpTTlDw+m4ZienFWzdtgbwvqNYbrhioVBjOHWhyfsDt+tST64L1
         9O2A==
X-Forwarded-Encrypted: i=1; AJvYcCV0WPf86qJxh1G0M/D9TVsRaMey1bmmKd/rz5hC2U5O86WJbhy6M5q6GN/iEWZ6JqQlhGlWLZkaPuF3ivbjgTEzR3ZQv3v8OOhT6AjHFhTMhpx9ZzfK7Kvl+56Sw5xvbbv//0c8aH5rsarVk6EPiQAhGIadjog+bns8EFjiHaWucQ==
X-Gm-Message-State: AOJu0YxeTyAaLQtGAFvC6PAv20B/fxBmi3n8qm6DSNCCdH6Oqy74ZNGs
	ldLAU/9r4c/rgvp2TJMN0G5f+f+yDx9ygJWfn/17ROXMAFRiom8P
X-Google-Smtp-Source: AGHT+IG0KTZhknphV433fC9NXoAD7v5l7VPJ90+eS0jpKwG+RqAn1KUkRQtvn1rMAAnH8A+2TU1i6A==
X-Received: by 2002:a50:d697:0:b0:566:414d:d70e with SMTP id r23-20020a50d697000000b00566414dd70emr1257676edi.39.1709205325740;
        Thu, 29 Feb 2024 03:15:25 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id q12-20020a056402518c00b00563ec73bbafsm516360edd.46.2024.02.29.03.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:15:25 -0800 (PST)
Message-ID: <acb69aa8c1a4c4e9849123ef538b9646a71507a0.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] of: overlay: Synchronize of_overlay_remove()
 with the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
	Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
  Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Thu, 29 Feb 2024 12:18:49 +0100
In-Reply-To: <20240229105204.720717-3-herve.codina@bootlin.com>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
	 <20240229105204.720717-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 11:52 +0100, Herve Codina wrote:
> In the following sequence:
> =C2=A0 1) of_platform_depopulate()
> =C2=A0 2) of_overlay_remove()
>=20
> During the step 1, devices are destroyed and devlinks are removed.
> During the step 2, OF nodes are destroyed but
> __of_changeset_entry_destroy() can raise warnings related to missing
> of_node_put():
> =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2 ...
>=20
> Indeed, during the devlink removals performed at step 1, the removal
> itself releasing the device (and the attached of_node) is done by a job
> queued in a workqueue and so, it is done asynchronously with respect to
> function calls.
> When the warning is present, of_node_put() will be called but wrongly
> too late from the workqueue job.
>=20
> In order to be sure that any ongoing devlink removals are done before
> the of_node destruction, synchronize the of_overlay_remove() with the
> devlink removals.
>=20
> Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> =C2=A0drivers/of/overlay.c | 10 +++++++++-
> =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 2ae7e9d24a64..7a010a62b9d8 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -8,6 +8,7 @@
> =C2=A0
> =C2=A0#define pr_fmt(fmt)	"OF: overlay: " fmt
> =C2=A0
> +#include <linux/device.h>

This is clearly up to the DT maintainers to decide but, IMHO, I would very =
much
prefer to see fwnode.h included in here rather than directly device.h (so y=
eah,
renaming the function to fwnode_*).

But yeah, I might be biased by own series :)

> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/of.h>
> @@ -853,6 +854,14 @@ static void free_overlay_changeset(struct
> overlay_changeset *ovcs)
> =C2=A0{
> =C2=A0	int i;
> =C2=A0
> +	/*
> +	 * Wait for any ongoing device link removals before removing some of
> +	 * nodes. Drop the global lock while waiting
> +	 */
> +	mutex_unlock(&of_mutex);
> +	device_link_wait_removal();
> +	mutex_lock(&of_mutex);

I'm still not convinced we need to drop the lock. What happens if someone e=
lse
grabs the lock while we are in device_link_wait_removal()? Can we guarantee=
 that
we can't screw things badly?

The question is, do you have a system/use case where you can really see the
deadlock happening? Until I see one, I'm very skeptical about this. And if =
we
have one, I'm not really sure this is also the right solution for it.

- Nuno S=C3=A1




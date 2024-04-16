Return-Path: <linux-kernel+bounces-146936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F568A6D38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35EAFB21D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B8912CD8A;
	Tue, 16 Apr 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klQ1tMyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BED12838C;
	Tue, 16 Apr 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276131; cv=none; b=rx9YP7t0xisuMi6Rfn2GFuOTVJzzoazSoBtu+WwdZPO6qGOG9ktqBROzgKzTmuZ4eRcwhby8YdRPTKw94wmUNwSJyQNcCM/rkAn/QKGIYGLfvnd6xCTehEjOY0LIbTwhyTmq9A/6eX7g2rPKj5e7atqjXxf275VtK7P+NmsBcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276131; c=relaxed/simple;
	bh=Q0srnPsNgdVGApS4nokFMXyw70bcUKLeBiaOGmWA0dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRQrd4Cx63hGHmLRqe9VN7EjLo44KezTDize4kQIPBntsG55tuIZDRwHGGv/HrNGM2AOWvxOAVaKzy28zvdI0l88O85K3Nyz54pkbhYaPoRGdcAWrP0cvh+EfQzwmjrexGZDO6GFYpuyRyxp5zwuF3kFLegLVApcJiIYWjAsLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klQ1tMyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422F6C113CE;
	Tue, 16 Apr 2024 14:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276131;
	bh=Q0srnPsNgdVGApS4nokFMXyw70bcUKLeBiaOGmWA0dg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=klQ1tMyGeuwVsVZveuTv0UGKXYDq1Yy/mEBDBaQ5CrRfVrxhXSyMGwDck/fHLfIMU
	 PrFog82RvCejfpaO8qVW9zLi0uouLKVl2KY5rtyL8VZMi2yBDXY2M9iIc4YlOw2Lkz
	 5Squ7cef16w+/I0gUHfEW5GFFBFX7M2ptBg4s6GG07FDwBQsgTJDxIBDnK+mdSr+M+
	 SXu2jNVo7ccpbDz6W4zEy3HOhK6lT3NObPs85XareV0qwy0KWHkjwtBBzYwppLZVkZ
	 v8QMftq5T4f/tIBc+6Ok8Qykni2zoSPJPCAP81vlei0esWdUqs/NYSOMkyluIeyi9s
	 Ey0p0LFeXmb6w==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22ed9094168so578501fac.1;
        Tue, 16 Apr 2024 07:02:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVX8OhXOaUq0dCf4Lokntpcy1QUpiycyzmk015pkULqha+EqjEw8Py59qbHS8A/n4u2XVVRGb4SPDu+++teVpfbLaiibqAbT3bnX468iaAyzYPs5bZXIOy9omipi225rSowgeqCYJk=
X-Gm-Message-State: AOJu0YwbED2AMvWB7eS3MQo0RF0FpkOS4Hy9ppkF8IV6SJJppH/ffMRd
	3KKN28Ip2MkWWYF5EcXaRy4YiJj/DB4U3IKQThbmpI0ZMOguuodqD6mYa6N+yMGPMG8VWLZyGKr
	Mpm1Q5VgRlvv8/W8FmGsvJ8TpxiU=
X-Google-Smtp-Source: AGHT+IFFUIDgyFns9LiCqj7gnvGR9x8URlGsGvNu+7oVL+MkZgIFtvNt4Zto7OH/4QUpCT82yad70NdxEbkZ+DAXOro=
X-Received: by 2002:a05:6870:b411:b0:22e:b2ea:5758 with SMTP id
 x17-20020a056870b41100b0022eb2ea5758mr14589971oap.0.1713276130532; Tue, 16
 Apr 2024 07:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408035141.248644-1-rui.zhang@intel.com> <20240408035141.248644-2-rui.zhang@intel.com>
In-Reply-To: <20240408035141.248644-2-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Apr 2024 16:01:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hF-AHY97y-Hz78=1MYGM4zHtOZ8U62NQBMMUNP4L-Kqw@mail.gmail.com>
Message-ID: <CAJZ5v0hF-AHY97y-Hz78=1MYGM4zHtOZ8U62NQBMMUNP4L-Kqw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] powercap: intel_rapl: Sort header files
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 5:51=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wrot=
e:
>
> Sort header files alphabetically.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index a28d54fd5222..1f4a7aa12d77 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -5,27 +5,27 @@
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/bitmap.h>
>  #include <linux/cleanup.h>
> +#include <linux/cpu.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/intel_rapl.h>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
>  #include <linux/list.h>
> -#include <linux/types.h>
> -#include <linux/device.h>
> -#include <linux/slab.h>
>  #include <linux/log2.h>
> -#include <linux/bitmap.h>
> -#include <linux/delay.h>
> -#include <linux/sysfs.h>
> -#include <linux/cpu.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
>  #include <linux/powercap.h>
> -#include <linux/suspend.h>
> -#include <linux/intel_rapl.h>
>  #include <linux/processor.h>
> -#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/suspend.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
>
> -#include <asm/iosf_mbi.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
> +#include <asm/iosf_mbi.h>
>
>  /* bitmasks for RAPL MSRs, used by primitive access functions */
>  #define ENERGY_STATUS_MASK      0xffffffff
> --

I can apply this cleanup right away, so do you want me to do that?


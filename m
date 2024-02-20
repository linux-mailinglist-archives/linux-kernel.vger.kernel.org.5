Return-Path: <linux-kernel+bounces-73231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1643585BFB8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2619284507
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8CE76039;
	Tue, 20 Feb 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYbUOILk"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3A71B57;
	Tue, 20 Feb 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442394; cv=none; b=smZUXEZxClzETf6naAYRRMOcwchbzdthGrviGY5gwVWvXni3+tf+Gr9j8suAPhQFyQyE4hHzGU7ipF9xRWu8zdAKc+qZxnTTtKkaZc+unqxCIIEwfnB4k0bhxfS9Fne5PNp3Idi6yUwJwUrqf750xtFlhBMk7B2rJz/de7Eyvfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442394; c=relaxed/simple;
	bh=MVpAxKMaoHyl+tjsX4STMfRQZ/gZH1SX3lmaukbkocQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwWfy7OYKp16VgVDq89Ms170BQOy2pODmW48QZ/RFH04zBYUPLk7yiCqAYKm4ad3lD4RnxTHiKSdTm9rEGTJZYw7NlFQOfZtG5kDu6YIJcGSe0hfCAhG28zBegFpeEh56bzKQRsX+9ciiWW1X+58t0RdIgJDnI6vNCoB32cM4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYbUOILk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e75e30d36so420692366b.1;
        Tue, 20 Feb 2024 07:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708442391; x=1709047191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6V+rVntGm0bOfQX7UIre1kuKHlkaeQH5c/FoECJBeI=;
        b=OYbUOILkyG2eQO/tekDpJ/uqTxrvR1sMH19AKNolVjuO/3og/VMBrkTGF/HHudob+f
         6/6z3a7SWBLWN88xB+a+GvHY+xMWUdhdqTHBRoVxg+7hNd3y2MtCAxPmigdd9C8WHKyS
         bGJZcznALJu6fs0QjCzmRLYxW82pQd9W+dY9mMRLs/1M2ixJn393+SXFs3ssNIBm7Ybv
         8bCd6u3HE+tensWlE64E2ls6+Y+m/doFQ4kGL+aYMf/Ym/eHDqKUcXMlDGuLixTb1ckD
         9C7ux/q2/aJ8hRm5eQjT6/UTDBhTU2p7Qo+iAoTj8vH6BqO9o9NjSctSGRDcODtfmUb2
         d6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708442391; x=1709047191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6V+rVntGm0bOfQX7UIre1kuKHlkaeQH5c/FoECJBeI=;
        b=HTOBNAI8k3Yo45pKNzIsvlDbT0KAK4t7x273y8DxUfIPkDhahRTlFgwuqZvkSa9Wj3
         YcTqlNcRxvM7byBO+W7wgdmkreQLUxDZBsxNhzBOX2Kk4wrqkjeEvQv2SrIKlnksTeqa
         PbQZg8VJfla5vS4ulBmC2IkwZR7Tq61XBJymjskkrndRwt8y8ojnlwGQ7myf/D6hfvxe
         29bxzttCUVrrk1EQUxE1G/Pz/cnOGN1WEJy++IUhrJTiEAY9NLcIUTj4VuaBkdRQsqvO
         nKYfzI+Wc0yWqpQezaDVn0vuPsbCG3zPM6YRIb1HivusHF1Q3aQ0gFjO5GklGEMxRp2u
         Dxug==
X-Forwarded-Encrypted: i=1; AJvYcCVk5rwVxora0sfyKXELDZShkwfGL+3sPSqT983+SIvzm0ADKJbDy3VShVq3WkONzWK6bcFCYvlxEXmlGZNlJDKq1iBOPBZv34bN6C2u9PPz8Md6Aj0v2+VxB6ALOfKccUcTo46vmICZoBS78iFrP3abwkVHKUCmuOvZI4qR+sy1QCEB2VtO
X-Gm-Message-State: AOJu0YwjvBo59dxPcKPJPCrqP+LtgItgLyTmVKnXiQOhEN9Fww6hm84/
	V8o3AJXBXUa+XUdMDprZNOhEy0wbvlFQSv+AEC9LZfkvlOxVSrOIN+4drTOLy/UFJHvFgSYAPJO
	M30s6mWO1fUpgA34Iv6cOV9Gj18U=
X-Google-Smtp-Source: AGHT+IHBktehyWtuPC8JEh2f3v6ZPaKc7tieXF4JIjb1uKLdxCvS6Vf9PHPXLkJ7d4YELA+8vPBi/rm2rEx/UyXknd0=
X-Received: by 2002:a17:906:fa87:b0:a3e:c6de:e5ae with SMTP id
 lt7-20020a170906fa8700b00a3ec6dee5aemr4612713ejb.0.1708442390911; Tue, 20 Feb
 2024 07:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220012540.10607-1-zhi.mao@mediatek.com> <20240220012540.10607-3-zhi.mao@mediatek.com>
In-Reply-To: <20240220012540.10607-3-zhi.mao@mediatek.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Feb 2024 17:19:14 +0200
Message-ID: <CAHp75Vfbc0jE43Z-trFRnFdT5SxvJN+w2x7hS4vHuF5M2kTXgg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] media: i2c: Add GC08A3 image sensor driver
To: Zhi Mao <zhi.mao@mediatek.com>
Cc: mchehab@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com, 
	shengnan.wang@mediatek.com, yaya.chang@mediatek.com, 10572168@qq.com, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, yunkec@chromium.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, jacopo.mondi@ideasonboard.com, 
	hverkuil-cisco@xs4all.nl, heiko@sntech.de, jernej.skrabec@gmail.com, 
	macromorgan@hotmail.com, linus.walleij@linaro.org, hdegoede@redhat.com, 
	tomi.valkeinen@ideasonboard.com, gerald.loacker@wolfvision.net, 
	bingbu.cao@intel.com, dan.scally@ideasonboard.com, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 3:47=E2=80=AFAM Zhi Mao <zhi.mao@mediatek.com> wrot=
e:
>
> Add a V4L2 sub-device driver for Galaxycore GC08A3 image sensor.

..

> +#include <asm/unaligned.h>

Usually asm/* go after linux/*

> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>

This looks semi-random.
For example, _at least_ the array_size.h, bits.h, container_of.h,
device.h, err.h, mod_devicetable.h, property.h, types.h are missing,
Please, use IWYU principle.

..

> +#define GC08A3_DEFAULT_CLK_FREQ 24000000

HZ_PER_MHZ ?

..

> +#define GC08A3_SLEEP_US  2000

USEC_PER_MSEC ?

..

> +static const s64 gc08a3_link_freq_menu_items[] =3D {
> +       336000000ULL,
> +       207000000ULL,

HZ_PER_MHZ ?

> +};

..

> +static const struct dev_pm_ops gc08a3_pm_ops =3D {
> +       SET_RUNTIME_PM_OPS(gc08a3_power_off, gc08a3_power_on, NULL)
> +};

> +               .pm =3D &gc08a3_pm_ops,

Use new PM macros (pm_ptr() and friends).

--=20
With Best Regards,
Andy Shevchenko


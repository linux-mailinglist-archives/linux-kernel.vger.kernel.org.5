Return-Path: <linux-kernel+bounces-23781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE68B82B196
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8591C22D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25F64C623;
	Thu, 11 Jan 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt9jpnLU"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EDB15E96;
	Thu, 11 Jan 2024 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2045bedb806so4453017fac.3;
        Thu, 11 Jan 2024 07:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704986389; x=1705591189; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m0gUKXnvGBRGSWtHWq6wUDapG9aWepBE2/ZXYl3J8z0=;
        b=jt9jpnLUSyvIpYBW/qqR6Ci5hI8enstBP9ofjH1+oI3e5PSxmHufrO4+oDtxBjcQ0E
         jkPfJW4/hwoYlk4i0DdNxkvJJl94elqT7K4jE/bD/fNR8uRbu/txrzx/bbanWsAJuUHu
         mULl9JOyM2i/U5gyFcIg5jfzxnFl3tLocAXSIYx2M5Hcp+kWQNBkkKD9cmvNBU9KBO1T
         rT1J6wf9tVj7LeS8PSvg2ATmLURjv7WHkztz+r+YNAYWUulF6u5kTJ68Km4OE4SlbCvz
         QN8b+Iez7bpX+3SzWTyJ0ZMYhIC+WuNaBxZeJvhlceseyqdDNNZL28HmW94RVYta4s+v
         eydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704986389; x=1705591189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m0gUKXnvGBRGSWtHWq6wUDapG9aWepBE2/ZXYl3J8z0=;
        b=Rfhk3ezNAljII+W7uNbP8PxCBU8GMM4C6/S1InTdGFgTi3OpMaTX0/gLml+QMxYZpa
         2y9Yq2A6DfxLSud7NEBO4Yj4p0i4fRcHIKOIiU4GnLjYsFpNKy6xJ8Gc0h0xGELii4lZ
         EVWagrt2ZhWVCeifmWllMRmCX4VAigO37m9hYjiOfi/uLC1/F1DCxNl3FItZ+L5OgIXk
         rUsTVvkkVL7qcpdyVQqcSFvnaAM0qN9vIZAhVm00pwLaLuL89usTtPY08tH92Kee9+tr
         tEyZK0nN5CZBOdpC4ZzRlVlml/LCim90eysY2/HYlHAXJ9UFAyln00GEu9E1yd912ZhM
         DkSg==
X-Gm-Message-State: AOJu0YxwKYsqb0zZ3RKcv1IGE1vZdLI7Kzn2SahfOV7cE8BAIdwI+2WF
	XRfvPLVbie5SQxG2/cDtPiiVphJqpqbOYRUtM3k=
X-Google-Smtp-Source: AGHT+IEM29mP17E+vpTQpYx9kvqaHi4J/A6cife0hh+3SKU1qs+gz2XKAFKflvxcSwo7KXlBd4c0jY8yfo1xngAydFQ=
X-Received: by 2002:a05:6870:6e10:b0:203:fb78:bc20 with SMTP id
 qt16-20020a0568706e1000b00203fb78bc20mr1595478oab.51.1704986389598; Thu, 11
 Jan 2024 07:19:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110140903.4090946-1-nm@ti.com> <20240110140903.4090946-6-nm@ti.com>
In-Reply-To: <20240110140903.4090946-6-nm@ti.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Thu, 11 Jan 2024 16:19:38 +0100
Message-ID: <CAH9NwWftK_A5oP-WWpSsm8mDfB8uBK3bAz-e=mg5QuM2xMrM6A@mail.gmail.com>
Subject: Re: [PATCH 05/16] arm64: dts: ti: k3-am64: Add MIT license along with GPL-2.0
To: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Wadim Egorov <w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"

>
> Modify license to include dual licensing as GPL-2.0-only OR MIT
> license for SoC and TI evm device tree files. This allows for Linux
> kernel device tree to be used in other Operating System ecosystems
> such as Zephyr or FreeBSD.
>
> While at this, update the GPL-2.0 to be GPL-2.0-only to be in sync
> with latest SPDX conventions (GPL-2.0 is deprecated).
>
> While at this, update the TI copyright year to sync with current year
> to indicate license change (and add it at least for one file which was
> missing TI copyright).
>

Acked-by: Christian Gmeiner <christian.gmeiner@gmail.com>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy


Return-Path: <linux-kernel+bounces-9193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0891281C225
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9AC1F253BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3779945;
	Thu, 21 Dec 2023 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JGYQOHbT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547779496
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e7bb1e0db8so13127227b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703202746; x=1703807546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f4uDw1WRa5SG6czjbnHQWjQZqqBhTvomA48xZ5HM1C0=;
        b=JGYQOHbTu5Gxz60wEAoJB654AtQ8EeAk4+j6KhBmg1QHmoRQykAgBS4pAI6KhlK9yx
         /5wMO3ua50bhBqZGBzZcw72fd0xF8YJg05FTo+/sB7c3cMJZBuoQ4idgRr8F73KhiuSS
         7gleeIOqQW1qoWd3/xqyl3JcuKBUySOtzOpF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703202746; x=1703807546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4uDw1WRa5SG6czjbnHQWjQZqqBhTvomA48xZ5HM1C0=;
        b=PjWU1V8oZF2zMJLAjfxm+biXsZ1F/Ir/Zl/pzLjv7ca8b3WNwQvNc63jILbr6PkbZW
         O2YaYUCnIQz3T+5316qXg3Y8cROUPQUvU36MFTTU1MA2z8N+/ghkeveLGmRqxQkIXeyI
         qHNS2h3skst75PaMxeFj4urAlzfoji5HW9Y9vGQexzK6cWZt3Ds/8j0zs3iHCbNYL0Sd
         mcNYBuYV8oYdOuHIS7CjitqyqcNwKGFQaXe2Mzbf9e90Hjyf5FIH575V/Jecz2w6t9yx
         /K+qnErCkks13Rp441w0qzigqq/Sj47mjt3dssEouTeNkiEWo/RLWvEDl5egkpHL6aXs
         s4Rw==
X-Gm-Message-State: AOJu0Yz4CnNtW7Jt6PThaRbLxPnuvp49KnYMhGb+nIcWWhwhTPrHycOz
	ak7cMcGYZdV86hPIDQYi1oOPbqGVqkc54Kq0khHrSImvHP7L
X-Google-Smtp-Source: AGHT+IG96IeFRHAEMgt3Wqqj3SdhdbJwAuHf3E0l0lDeoWxWb2boVBsBUrO5u3oIhl+2lMoELCJ/o71NhaoTJPqm+AU=
X-Received: by 2002:a81:6f04:0:b0:5d7:1940:53d0 with SMTP id
 k4-20020a816f04000000b005d7194053d0mr557320ywc.72.1703202746631; Thu, 21 Dec
 2023 15:52:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid> <ZYQVdE4esAZbtMrn@kekkonen.localdomain>
In-Reply-To: <ZYQVdE4esAZbtMrn@kekkonen.localdomain>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Thu, 21 Dec 2023 16:52:15 -0700
Message-ID: <CANg-bXCshpg5=rRiaxbjdEeD3VNsdV-cKxu-nCqT7K_f8wJodA@mail.gmail.com>
Subject: Re: [PATCH v2 20/22] device property: Modify fwnode irq_get() to use resource
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Raul Rangel <rrangel@chromium.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Both acpi_irq_get() and of_irq_to_resourece() use EXPORT_SYMBOL_GPL()
> instead. I don't see why fwnode_irq_get_resource() shouldn't do the same.
>
> With this changed,
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> In fact this should have always been the case for fwnode_irq_get(). I
> wouldn't mind changing that, too, in a separate patch.

Sure. It looks like fwnode_iomap(), fwnode_irq_get(),
fwnode_irq_get_byname(), and fwnode_graph_parse_endpoint() could all
be updated. I'll add another patch with these changes unless there's a
reason some of those functions shouldn't be GPL'd?


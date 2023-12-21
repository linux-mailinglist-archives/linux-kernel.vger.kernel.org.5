Return-Path: <linux-kernel+bounces-9187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0052581C214
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966DE1F25167
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B379479;
	Thu, 21 Dec 2023 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fyDSnKZy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FAF78E9D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbd739853easo1238794276.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703202381; x=1703807181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C5yx1D4sy7Cq5xnSJGT/Y8ISb8yXl+5GPlJ3CTgBqlQ=;
        b=fyDSnKZy0Tc6WHuq9MNrw2Q9bKBZMm8Jyf0nItmRhcYRD50M70EgPaHX6fW0/XQOsK
         EVM2mzNXKR++YEYmmPwqDqE8y5IGTowaDbeSK42I/ha+7MiMJaZ5EbwbRICQR/ap7TOF
         nqbqWxw8iYyM1vAXPCR4Um0pxfpadvKm0RLTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703202381; x=1703807181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5yx1D4sy7Cq5xnSJGT/Y8ISb8yXl+5GPlJ3CTgBqlQ=;
        b=OT1DgSsnU9sNJAN8zvEmFcRPUaBZNCBtjmTzFMARqMRKBD+xf+wxqYWx+VJktHmekk
         QMZexEEeNxSpiXSJOXvIrhPX+V5gZQ9LNELbB911YqQNMfjC9XfPeOKJsMixH1zkWZct
         D4M9CETKcM7VDcHIbfSh+/ojYG+9EoHcEHhaWQH+tZdxCqhQ280y9A4WBIV5KmMq/o0F
         W/cyCwbRdj3eZGpkzrN6ICSAecwRJ0JnzNCLZA/w5XaNiMt9j3hVXZIhksSVEN4tsOdh
         Ox0WVjJnin1ExsDabyKyGoumi5CwRUHgRbc1+r6XsEhqFKfuD7W5chTkeiVQ/N34z9/T
         1+qQ==
X-Gm-Message-State: AOJu0YzR+QSHN+mtBdtsVXzIgrEQSrxZfaVRdnlbuhCk/NgRAEGIytXa
	wF++YDeb0/qsgM8L7n6SDZ/dXyKl1mzaTiUR4vuq8Nbbi+em
X-Google-Smtp-Source: AGHT+IHQuqPUTWtpvEWWlBXrPZ7P2rJCDTvZXPGIY5MnJ0dX/9smRrJ/j9aAo6gegLAC+pvb0F1tQqld2angQtN2hv0=
X-Received: by 2002:a25:8387:0:b0:dbd:c3cf:2433 with SMTP id
 t7-20020a258387000000b00dbdc3cf2433mr366468ybk.84.1703202381711; Thu, 21 Dec
 2023 15:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid> <ZYRD9Y3Y_jd1NBs8@smile.fi.intel.com>
In-Reply-To: <ZYRD9Y3Y_jd1NBs8@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Thu, 21 Dec 2023 16:46:11 -0700
Message-ID: <CANg-bXDLC_+mxFU+dHyCx1K=HKTwwGw+r__6_++Co2-viTbsgQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/22] device property: Modify fwnode irq_get() to use resource
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Raul Rangel <rrangel@chromium.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Daniel Scally <djrscally@gmail.com>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > -int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
> > +int fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
> > +                         unsigned int index, struct resource *r)
>
> It's perfectly fine to replace ) by , on the previous line, no need
> to make it shorter.

That puts the line at 115 chars? checkpatch.pl allows a maximum line
length of 100. I can bump the 'index' argument up a line and keep it
to a length of 95?


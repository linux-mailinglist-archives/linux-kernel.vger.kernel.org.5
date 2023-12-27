Return-Path: <linux-kernel+bounces-12224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CC081F18B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA65DB2183A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7CC4776F;
	Wed, 27 Dec 2023 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bZKxzJtr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3C46B88
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e745891a69so41897767b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703704171; x=1704308971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qpVnpJ3HNKYUH8rCvM4ORfSgTVpxbE0LVqXKt4MxqHI=;
        b=bZKxzJtraZRf8W0aLeIxkAhrE1yBK1mlZ6lyxNbBRMQ2jqbPZ3tO9t7aWsXNZ1KQ1V
         2VW682vAvXvrJMS9eto9p62JYi6CO/iVkSA1BXF1OvBnwch4SASGfi2oAFXSIMt7L3ry
         HfvGmE1rxW6ugkvXE0+jNJylMKjyQVzg20f5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703704171; x=1704308971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpVnpJ3HNKYUH8rCvM4ORfSgTVpxbE0LVqXKt4MxqHI=;
        b=hPx8aAIAbTaHHbdt091fuCwIPaRNNWF2iHh6Vdde8Y6BeEdyOEx2QoCGKyrKsEJl6s
         +zGihOx9ys+s+FMpXWFuwRDjsw+fv4M6LkJc/hHw59SsynDaT/dUYKo7RXkdCPgHxgk7
         0O4Pxv5/LY40Rl/NP6p2AnPuS8hQ5C5Ed+YPRuCJVqm/iefSB6RR1cgdLAzDGbJ+IdtW
         Q3LklTlX+Pra4b8drPO4Nc3exfuUL5PMvvkoE48T2F0AQO1DSwCfrZzCNGuuxdlHmTgo
         ENNN9HS7+HzusNc2C9/o6tjDGKwRE0RpMnx3r7sgt4TopopoD/dme+npRkVGrGe4vfOk
         /UXQ==
X-Gm-Message-State: AOJu0Yzk/rBW9fJ0H/ILP4F9y2aVqi6gzPC278FXwFmg1UVnfe2VqBZm
	z8SLGhTEoponniiXG1ws+JVg72PPmHZ1XZagcCCJlJtJhu7v
X-Google-Smtp-Source: AGHT+IGlFw9UNPB1dmm/olk7+22ViwCbjSSFDnD2ZfUBYa15s3f3lFEPDK25bDg1fgThWm1hx47FabuTsv+tR68Ua3w=
X-Received: by 2002:a0d:d811:0:b0:5e4:da23:14b9 with SMTP id
 a17-20020a0dd811000000b005e4da2314b9mr4637533ywe.50.1703704170861; Wed, 27
 Dec 2023 11:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.21.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid> <ZYxdwrJw7_JudQXB@smile.fi.intel.com>
In-Reply-To: <ZYxdwrJw7_JudQXB@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Wed, 27 Dec 2023 12:09:19 -0700
Message-ID: <CANg-bXBwWXaJWv9gMtjYvRBnOaP3E8U1nh5-ScWOoyRayzn7Zw@mail.gmail.com>
Subject: Re: [PATCH v3 21/24] device property: Modify fwnode irq_get() to use resource
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Raul Rangel <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> A side note: in all files where you use ioport.h check if you actually included it.
>
> ...
>
> > -#include <linux/types.h>
> > -#include <linux/list.h>
> >  #include <linux/bits.h>
> >  #include <linux/err.h>
> > +#include <linux/ioport.h>
> > +#include <linux/list.h>
> > +#include <linux/types.h>
>
> Fine, but no. This file is still not using the iopoll.h.
> See the forward declarations below? It should be there.
>
> >  struct fwnode_operations;
> >  struct device;
>
> ...
>
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
>
> Same comment(s) here.

I don't fully follow. Are you suggesting adding an explicit 'struct
resource' declaration as opposed to including ioport.h? If so, why? To
reduce scope?


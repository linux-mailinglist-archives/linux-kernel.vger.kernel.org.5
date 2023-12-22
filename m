Return-Path: <linux-kernel+bounces-10079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8A681CFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60102B211F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038902F845;
	Fri, 22 Dec 2023 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B25jCCsg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0382FC2E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e784ce9bb8so18850367b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703283787; x=1703888587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gfhVqE6PywI59kitxuraVSFK4Xjyt3t9xe0U5Ctj/oU=;
        b=B25jCCsg4fq5NjWci0QNQXsdTY1hzxtOTd0VBeDUHP4ngIQg7IiPXZ5nEi8G1V3U5U
         zeB5vq4q0j0fM8J4zuPUrIzhYJhVD4e9z0j3uQh8h0aBgjLIDLJVSBn9Ei+Yais+8zey
         HOyq09A4chBJzo+8147j6/uW1n7m4rjVRTcoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703283787; x=1703888587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfhVqE6PywI59kitxuraVSFK4Xjyt3t9xe0U5Ctj/oU=;
        b=L/20SyTsmGuEIu7rgTK8ahCRYgF9RDZ4xYbMaCKhahx0L7s+Y04EwmUB0MCuGlzD9Q
         zp1BaDpfDSn8e4CivGgxMYcnD8A0enP1fUlRazSzZki9ayUcAYtXC8jABKf0gw6B6DNc
         7T90uK4DuSmF8zyhfFY3wNg18/puwC3DGgkSZ8pQHta0CmYJHEl8Rp7aUicXKCu+clW5
         dbSmMoD1MIVOX8Jts+0fyJXvVn2igks37rDUC/pfrU4N426o8h6aOG3IMpNwhgeUgReL
         7svzuJyiv2WSXNHk3yFs997FnrRqMgD2F1Z0OJOS6K9Woxy2K4oGjf2Bjro17HBeB07Q
         B7Fw==
X-Gm-Message-State: AOJu0YzmsTALlEO2aqwFonpU7wnxzqBWzvpiP4FCAuxBH6wTXV8fwS4Y
	S7pZzQKxu28+0Ej9h60eGsL89ml4qrgEIPHyIOaG3hGp5/yG
X-Google-Smtp-Source: AGHT+IGnklybkwz8AzG5KTZoC2vAHrEy7lPgcjnDbmjp8QDtLU3J89D71Xz4NVj3OS+l++HEweT1D4kZ9FKcDRSvjj8=
X-Received: by 2002:a05:690c:a15:b0:5ea:3c8d:40dd with SMTP id
 cg21-20020a05690c0a1500b005ea3c8d40ddmr1028354ywb.0.1703283787197; Fri, 22
 Dec 2023 14:23:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.17.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid> <ZYRY8ypZ1cYNRMcP@smile.fi.intel.com>
In-Reply-To: <ZYRY8ypZ1cYNRMcP@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Fri, 22 Dec 2023 15:22:56 -0700
Message-ID: <CANg-bXBvjHpxd2-ondCw5+oZGdi-ehdErTqTmw_5SJgtDqc9aA@mail.gmail.com>
Subject: Re: [PATCH v2 17/22] of: irq: add wake capable bit to of_irq_resource()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Raul Rangel <rrangel@chromium.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Or even refactor ioport.h (in a separate patch) as we seems already have
> two users (and might be more in the existing code):
>
> #define DEFINE_RES_IRQ_NAMED_FLAGS(_irq, _name, _flags)                 \
>         DEFINE_RES_NAMED((_irq), 1, (_name), (_flags) | IORESOURCE_IRQ)
> #define DEFINE_RES_IRQ_NAMED(_irq, _name)                               \
>         DEFINE_RES_IRQ_NAMED_FLAGS((_irq), (_name), 0)
> #define DEFINE_RES_IRQ(_irq)                                            \
>         DEFINE_RES_IRQ_NAMED((_irq), NULL)
>
> (Note, I will Ack such a patch once it appears.)

I'll add a new patch to the series. I'll probably include the MEM, IO,
and RES variants as well.


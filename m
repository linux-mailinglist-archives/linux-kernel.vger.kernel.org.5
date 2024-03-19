Return-Path: <linux-kernel+bounces-107544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA39F87FDEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 159A8B210C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99F440865;
	Tue, 19 Mar 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Z3OFpBnA"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E83C08E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853116; cv=none; b=LyDNF9RbGvYtE8ZENU/pHTPDfQ/VkT88NvlSXSiiyIYtSNK1+n65iG4RFs9aIA2Jv9HQRFHL/HAQMt+9+DnhOPrDemYYNpbsQRZ8bwGh0bYu5GH+kafaBfz8u47Lfbg2/YBJqNemyKlZccpQxDgyVOGZC2H1ZOEk4BcRDbrYzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853116; c=relaxed/simple;
	bh=BU86mkt/Ka5CMfIKuRWwdKPasrg+HQf2iS085pqvClQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArSxE3Z523sXhk4SZ7zmTXM1AolhXcs0mcdJioZd+5nQHftS1wj1SNc8JViqUFjpiHV0FKXiUbYEwcI9H7oqtyqTxzTPJvyRhQ5OcOl7F9PaL9mkyMQZ2MNJGN207+XXbNif1Wu83zCPZtNBZtUsYqoPRKomEe5Lpd9Y6QRrXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Z3OFpBnA; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60a434ea806so59510417b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1710853113; x=1711457913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JBD2QIEr5rKcJqehTbPK3gKFjK6RT89LdsFIyo3OZSo=;
        b=Z3OFpBnAavwZPNt+ZEPSTWdWwZyRpXuG3N8RY/FkG4IlnRedB4iZoChMKaftZzRz01
         qt0nCyqaJhOvJNWuG4tx8D+W9Coooj5joMv+UUdG/dFqdm/2qYx9G8/5xYB8ghrZvlw5
         Isji4Pysc81Dle0DvWvGoR11gqBSpcsc6FbEX7R0uqW/NH2ThjO6INqD+LhmUEEB6r0q
         I1efuJonc7m7LRD1G8OSQtn5Hj0kQGwHp/O/NIrUWewtZEhvXngiiavYfh/VBb8AKcOF
         hml4NmuCg1R4x/w3Xvda5YwENS3BKUsEcRaayA2AGnZIZ85VSspbgz19mCts0+b/Kxzt
         a7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710853113; x=1711457913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBD2QIEr5rKcJqehTbPK3gKFjK6RT89LdsFIyo3OZSo=;
        b=AyXxdlkbVO9CWF/OYV0MRZVYR0pojLRuGFPbJUVyvIuLxC/51EJp+uWN40kfDXLndk
         Kp9tOy31Agnu4luUjZ3kIVbrOrqmAEri71/WvUOqG8dqbkPnCRYQSGEbAU1Z/trNfapC
         zidEX0c2dn4wzfIyKbY+MkdOLRE/k7ZNoQs+81BGAUo0wCt61FVb0ZO/aiNG2tBRKfg/
         f4mGTapfPVGKv047gU5H2hRbwkTWYwMyj91xMQClxAytJihKkNRvv7AV179O+EzscYZD
         6TcapdyVOb2XJACcgeErPsSIBFGJ1lA6FCCrVnLauuRoYo8uNSOOrVsfeWWhjWC9f0p8
         RSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxHc1HdZ9YBPhk8BOo8LWJ28n39ZvyxUFstpbcINkVYeTpjXGIghaf5F6HMXhljQVkgTOMnA4dcUn7vyJ8ls0o7brnRQt0ghaMuxVs
X-Gm-Message-State: AOJu0YwUpYqS7Ev9/kXLIGC0RZtZ4Mb8NPM5iHcFfYfoRbfiBrpbzIFp
	Ak7vBClL3vNHBbRnCw4VTTeSPD23Pqe4pbCsfrAIsTqbagoa1K1OEEDu+TvwA9KpmuTl6IurqSW
	njBT4kRVq6g6+qwSAsVlsaO8pKzYxcWGUOKwx/g==
X-Google-Smtp-Source: AGHT+IFvOcuO4OJJA1ZvGKt3d4wULBOkk2d61EBXmybZlxtEuOaN4dke+s6TRNw/Gpy3hehkpZ0dwMeQ4BRR8a5tdfM=
X-Received: by 2002:a0d:efc3:0:b0:60d:547:bc38 with SMTP id
 y186-20020a0defc3000000b0060d0547bc38mr12960286ywe.0.1710853113341; Tue, 19
 Mar 2024 05:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
 <20240318-rp1-cfe-v1-2-ac6d960ff22d@ideasonboard.com> <eb854c43-1e92-4c19-bfd3-1bde94924319@linaro.org>
 <f97faeb9-8a6b-47c6-9317-daca88257802@ideasonboard.com> <30430e0e-70de-4831-97ad-974e350a2e54@ideasonboard.com>
 <5ca1d005-1beb-47ec-943a-9358ae3c6704@linaro.org> <CAEmqJPp7uGYe993L+ujth2mfRy66s8-S9FNxPY7vwkrboDq9yg@mail.gmail.com>
 <89d459dd-cc8c-4780-a56a-809e24343e69@linaro.org>
In-Reply-To: <89d459dd-cc8c-4780-a56a-809e24343e69@linaro.org>
From: Naushir Patuck <naush@raspberrypi.com>
Date: Tue, 19 Mar 2024 12:57:57 +0000
Message-ID: <CAEmqJPrLP3j37Kcj0mX23x00p=gWuxZPNSUTRGNkcEqsUJ2MjQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: media: Add bindings for raspberrypi,rp1-cfe
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 12:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/03/2024 13:06, Naushir Patuck wrote:
> > Hi,
> >
> > On Tue, 19 Mar 2024 at 09:32, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 19/03/2024 08:00, Tomi Valkeinen wrote:
> >>> On 19/03/2024 08:48, Tomi Valkeinen wrote:
> >>>> On 19/03/2024 08:23, Krzysztof Kozlowski wrote:
> >>>>> On 18/03/2024 16:49, Tomi Valkeinen wrote:
> >>>>>> Add DT bindings for raspberrypi,rp1-cfe.
> >>>>>>
> >>>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> >>>>>> ---
> >>>>>>   .../bindings/media/raspberrypi,rp1-cfe.yaml        | 103
> >>>>>> +++++++++++++++++++++
> >>>>>>   1 file changed, 103 insertions(+)
> >>>>>>
> >>>>>> diff --git
> >>>>>> a/Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
> >>>>>> b/Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..7b2beeaaab0e
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
> >>>>>> @@ -0,0 +1,103 @@
> >>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>>> +%YAML 1.2
> >>>>>> +---
> >>>>>> +$id: http://devicetree.org/schemas/media/raspberrypi,rp1-cfe.yaml#
> >>>>>
> >>>>> Use compatible as filename.
> >>>>
> >>>> Ah, indeed. I changed the compatible quite late, adding the "rpi5" as
> >>>> versioning, and missed changing the file name.
> >>>>
> >>>> I'll rename.
> >>>
> >>> Actually, maybe it's better to have two compatibles,
> >>> "raspberrypi,rp1-cfe" as the generic one, and "raspberrypi,rpi5-rp1-cfe"
> >>> (or something similar) for RaspberryPi 5.
> >>>
> >>> And I'm not sure if the "rp1" part is relevant there, would
> >>> "raspberrypi,cfe" be just as fine? Naush?
> >>
> >> See writing bindings. Compatibles should be SoC specific. In some cases
> >> generic fallbacks make sense, in some note. But don't just choose
> >> "generic fallback" because you want. Provide rationale.
> >
> > If the compatible is SoC specific, I suppose "raspberrypi,rp1-cfe"
> > would be the correct string.
>
> Sure, but then please think what if rp1 is on Rpi6, called exactly the
> same (rp1), with some minor differences? Could it be?

Yes, this is definitely possible.  In such cases, I would expect the
hardware to have a version register that would be queried by the
driver to adjust for minor differences, and the compatible string
remains the same.  Does that seem reasonable?


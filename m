Return-Path: <linux-kernel+bounces-26324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5426882DE8B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA11BB21B62
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F6182A1;
	Mon, 15 Jan 2024 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOPt/Hn/"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14028F72;
	Mon, 15 Jan 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3376ead25e1so7007680f8f.3;
        Mon, 15 Jan 2024 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705340218; x=1705945018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kx0olFuw+rWfaGw9tfp+XkjX2b+u9ESGzSxY7G46xRE=;
        b=NOPt/Hn/TuX3gy7qE3WsnKLi1wh58fYxKwBtNAZm/pvCYoBvtzZeerq/XPXgNBBHMh
         HYuv/OMNzbD5qpt3PUnX0ARMcDL+8cKyUQfAoRQqBmovXww76Vg7hqeSn6jDji8dU0BO
         7fsLhLIxLw0czLF0hFa0hkhLGLXqJjthxRQosjYY/kfZparoR8FbAYrBb7v4xPHQwbPo
         eq2X2a91enACoeMjRg9Kv/1dye6E66vBpmkeC7F5kglLUscv5SpHbiDdYI4Jw2w0k9w0
         cL9ppm5jIJytySf1evdB55c72tzI69SO7kZrdOtld9tWYtH/TUwxMgMLAXrGggT60nkM
         9hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705340218; x=1705945018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx0olFuw+rWfaGw9tfp+XkjX2b+u9ESGzSxY7G46xRE=;
        b=xINWuTYHA+LV2z43Y+1rtH5834LztrTXSULISb3DSYExKg+5bS2Vt6RKAKPk/jKAo0
         3yL7SMBN9AfF2kInQQHgG0eJ63OwtQ8KtD39gY+qYqIfH/yX2F4l5nMFvMUSDBdRQij7
         3ftezXe0YM46tP5+//3omD2+GYE9kjJUWLL/aNN3luBkldOZxeB6PW04bgiXwivA6JPf
         xLHcj0O19/taAESPmtQKda1vp+iZEezS8pzaYL6jbjtCTjnOUMW7ZDbdp2UheYomKyBL
         GB8iXkymaUQjnyMVHLfe0+lZe+4hPFarnW/4YwooXiE8VekEfwS0tCUXv35pOpzcnjv8
         IoCQ==
X-Gm-Message-State: AOJu0YzFzwDJzd2xk04/CfyTPD3SM4rUFr7pAVqgXQpppALAgfvnnmAd
	gNUsvdDiIdTibLUOLbYW+/Q=
X-Google-Smtp-Source: AGHT+IFmNxeS6EDVKe79tQhOTctYIXVnIx901GrCRPbT56iCqzf+VsIghY08iUphbcf6YPfnxEQdzQ==
X-Received: by 2002:a05:600c:190c:b0:40e:6009:94ae with SMTP id j12-20020a05600c190c00b0040e600994aemr3188249wmq.186.1705340217724;
        Mon, 15 Jan 2024 09:36:57 -0800 (PST)
Received: from cjw-notebook (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id je14-20020a05600c1f8e00b0040e3635ca65sm20525173wmb.2.2024.01.15.09.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 09:36:57 -0800 (PST)
Date: Mon, 15 Jan 2024 18:36:54 +0100
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: w1: UART 1-Wire bus
Message-ID: <ZaVtNmvRjPAn9bph@cjw-notebook>
References: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
 <20240106-w1-uart-v4-1-7fe1378a8b3e@gmail.com>
 <20240113013917.GA3795949-robh@kernel.org>
 <ZaLQxGjjmA_iKOv2@cjw-notebook>
 <81c79939-56cc-4d78-9552-56568999df09@linaro.org>
 <ZaP0CoCYLQxrT3VD@cjw-notebook>
 <1b8cb3ba-6727-45ab-acaa-c727a0a7ad85@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b8cb3ba-6727-45ab-acaa-c727a0a7ad85@linaro.org>

On Sun, Jan 14, 2024 at 04:55:42PM +0100, Krzysztof Kozlowski wrote:
> On 14/01/2024 15:47, Christoph Winklhofer wrote:
> > On Sun, Jan 14, 2024 at 11:54:48AM +0100, Krzysztof Kozlowski wrote:
> >> On 13/01/2024 19:04, Christoph Winklhofer wrote:
> >>> On Fri, Jan 12, 2024 at 07:39:17PM -0600, Rob Herring wrote:
> >>>> On Sat, Jan 06, 2024 at 05:02:24PM +0100, Christoph Winklhofer wrote:
> >>>>> Add device tree binding for UART 1-Wire bus.
> >>>>>
> >>>>> Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/w1/w1-uart.yaml | 62 +++++++++++++++++++++++
> >>>>>  1 file changed, 62 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/w1/w1-uart.yaml b/Documentation/devicetree/bindings/w1/w1-uart.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..6b90693b2ca0
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/w1/w1-uart.yaml
> >>>>> @@ -0,0 +1,62 @@
> >>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/w1/w1-uart.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> ...
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    const: w1-uart
> >>>>> +
> >>>>> +  reset-speed:
> >>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>>> +    default: 9600
> >>>>> +    description: |
> >>>>
> >>>> Don't need '|' if no formatting
> >>>>
> >>>
> >>> Ok.
> >>>
> >>>>> +      The baud rate for the 1-Wire reset and presence detect.
> >>>>> +
> >>>>> +  touch_0-speed:
> >>>>
> >>>> Don't use '_' in property names.
> >>>>
> >>>> I'm somewhat familar with 1-wire, but I don't get what 'touch' means 
> >>>> here. I assume these are low and high times which are a function of the 
> >>>> baudrate.
> >>>>
> >>>
> >>> I change the name to 'write-0-speed' and 'write-1-speed'. The function
> >>> in the w1-framework is named 'touch_bit' - therefore the previous
> >>> naming. 
> >>>
> >>> It is the baud-rate used in the 1-Wire cycle to write a 0-Bit
> >>> (write-0-speed) and to perform a 1-Wire cycle that writes a 1-Bit and
> >>> reads a 0-Bit or 1-Bit (write-1-speed).
> >>
> >>
> >> Then probably -bps:
> >> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> > 
> > The serial.yaml uses prefix -speed for the baud rate but I can change it
> > to -bps.
> 
> Do you reference serial.yaml?
> 

No, serial.yaml is not referenced but 'onewire' will be a child-node of
a serial-device which already defines baud rate related properties
with -speed (e.g. max-speed although not used in w1-uart). Hence, I
thought -speed is typically used for baud rates.

Thanks,
Christoph


Return-Path: <linux-kernel+bounces-19250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF7826A51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DACBB22627
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F56FE570;
	Mon,  8 Jan 2024 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsF6SftS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F512B74;
	Mon,  8 Jan 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5983686ef62so687748eaf.3;
        Mon, 08 Jan 2024 01:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704705032; x=1705309832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BNk0vEp/T06pV48VMkJResRLpbsMI3MWGq9I4p+kNk=;
        b=WsF6SftS0GQrxkz8NY8BH5/iA2AQhXZ/wXvOvxY2sO4WhUspIUFgugY2zR0CACXEkP
         1nj8GygmpnEHAlaYsNvT7lhxTdN7YstH0rwBXbM7k0oe2Cu+ciRDeKkuRUZE185YBsfC
         QvAfamwmhmWMB0TtSBAPUbAoqMVvcaiW0obyBV6jGVw/P90QdWiX7Hxcgp86oo5tWmeo
         PoOtR8n9aProXuFyj14zvYLuWGm1LR+2pkyJ2Va5x2JqyYLS4T89U0vkO6BC693hpJNW
         BeBN7tBsPDsJwvvabMAa/jOKhm9sz0Fv7e/vwAeTfmBO6q3qM12q2xmy61aJbs+iYA2c
         +oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705032; x=1705309832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BNk0vEp/T06pV48VMkJResRLpbsMI3MWGq9I4p+kNk=;
        b=Sg9rx3hsEb8Ja+tYYU3+KnwZ7EBbR6FJ1z0hBavLWFPGudhay17Hm+pn0dG8IRlBm2
         lUDJMtFD8oNaFGRpBJjHSCvbxW9BgCYkpMfAE9AjL9cUHj4p1cWHB9WIQ6HcHLtvFJW3
         dzJ5Nvps+cLWM+SMnLfc79UedA1xqDbFZy8g3Z0FVnmmrE6Y8XhIbcfmDLE9KB6U91DX
         Zy1hf0MKxI/tZ8haXe8/rKe17oZ2K2rvlAN6vovSpuYoVNItetLj8QpCdP8GIZXKxAGq
         jy4K4adx+fF6KeRVdtj8lMQWa7I+gg8XX8Hn4sxvKPtY7fcDNRhz3biRtAa4ZTquJYE3
         XSpA==
X-Gm-Message-State: AOJu0YzllBRseun9RnGg1yO9b6BMJQyOL13R6Y3pmH3hQEpHhIivT787
	E1V8rapzQk5FZkBJeioUi+y6YcSI7ELNaXcUsAY=
X-Google-Smtp-Source: AGHT+IF2MwJ/UZzPV8uyJamt7LhXi1gqzFtMrt+HSyf/3ZHTC8mbQhMMQTQjX3ZC7FHw0NkGYyqC1jicwunwbc66LFY=
X-Received: by 2002:a05:6820:60c:b0:596:3121:1425 with SMTP id
 e12-20020a056820060c00b0059631211425mr2183414oow.5.1704705032001; Mon, 08 Jan
 2024 01:10:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108072253.30183-1-qiujingbao.dlmu@gmail.com>
 <20240108072253.30183-2-qiujingbao.dlmu@gmail.com> <cd4c5c26-fef9-44d8-a2fe-1cff0fc6fd03@linaro.org>
In-Reply-To: <cd4c5c26-fef9-44d8-a2fe-1cff0fc6fd03@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 8 Jan 2024 17:10:21 +0800
Message-ID: <CAJRtX8TcXrP8aqr3ejvtDGR5Y-ogbLkvJvJkLh_MzpnK7wgLGw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] dt-bindings: rtc: sophgo: add RTC support for
 Sophgo CV1800 series SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 4:04=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/01/2024 08:22, Jingbao Qiu wrote:
> > Add RTC devicetree binding for Sophgo CV1800 SoC.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800=
-rtc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.ya=
ml b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
> > new file mode 100644
> > index 000000000000..01a926cb5c81
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/sophgo,cv1800-rtc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Real Time Clock of the Sophgo CV1800 SoC
> > +
> > +allOf:
> > +  - $ref: rtc.yaml#
>
> Why the allOf has moved?

Hi,
Do you mean allof should be under maintainers? Or other meanings.

>
> > +
> > +maintainers:
> > +  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > +
> > +description:
> > +  Real Time Clock (RTC) is an independently powered module
> > +  within the chip, which includes a 32KHz oscillator and a
> > +  Power On Reset/POR submodule. It can be used for time display
> > +  and timed alarm generation. In addition, the hardware state
> > +  machine provides triggering and timing control for chip
> > +  power on, off, and reset.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sophgo,cv1800-rtc
> > +      - const: syscon
>
> Why is this syscon? Description does not explain this.

Because the driver of the submodule POR in RTC only requires register
address and range to work, according to what you said, it is only a compati=
ble
attribute and does not need to be a child node.

So I wrote the following in the changelog.

- add syscon attribute to share registers
  with POR

Best regards,
Jingbao Qiu


Return-Path: <linux-kernel+bounces-64974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7845B854554
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9E48B23506
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D9312E5E;
	Wed, 14 Feb 2024 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MwFEjeGN"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B817581
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903121; cv=none; b=l9bNUMbH2gRWnT12usiDdsBQd61JwzfKTZE0hWhJXPTzU6TNRt1rfAPRyl2SHI8/gu18oMPyurJwvPBVuTXOEJhtK9Q0pp6UA5ivCqT7PDnc9W+Hh98Sjm0bHRDUkeB+h5BzbqsPV0n9kqpHwGYU5/a9bk4svkLdqiHWsWmhHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903121; c=relaxed/simple;
	bh=PNBPQQfDhnyfFmsyjofTq3seA50s+CQGQT4eK1YzTfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5LRvjr7rm3XGoDUDiEja+c4AKjCmB0sSflWGFWzxJKjlQ2I69ypk1BbFfLH1u6KLcdGUyTNp85BG50xbiLq18jUZctyr++3kgK6MR092TJzoYsvUegMm/qb03wPogXGgmoBR38XXSUo8CtAipQ5hNZ7pIFowauVyS4PfinJQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MwFEjeGN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso799289766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707903117; x=1708507917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPkMEDM6CGcLhgxC9XLiOvcJXbRVQx7jQnt9AcMiATE=;
        b=MwFEjeGNTfviwU3z3OsO+WJR2gpQmzoeKVd97dxqNzmWGg8KSYJ3clKaYNL9k/ILOG
         rCDi4usOSJvpAuXQ5aFq2m4AYibeIBfNX6KiuQYeE2X7TyjrXJAxQdRzXeXE5cJoz+Um
         r/hhw+JSHec9FJcc0giF6axs3Evn9dV6401tMFZLCHnlRY2B/pb7y6WUp/Qbx44Q4GJY
         apJd1kema6Hxzn1kb0zdBklmeDrrEwQ9uznzLXGtRh94Ky8lgsDqHL7fnftLNpPQw1dP
         EfMYvdO8wnPzNeODPQ9OkmIr6d/N0xYcmzxLi1TtOEoQZVfBkeO12eXekHPAfXmjhAav
         Kw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707903117; x=1708507917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPkMEDM6CGcLhgxC9XLiOvcJXbRVQx7jQnt9AcMiATE=;
        b=l8giJCXESXsuzKFvcT1UbbcBE3Xj6c2DFMY99q4nahkyAUt6rohz+xGYY/n3HELYAP
         2DSSidIjw77zEJEqvoE55X5cd0JZ3bhRkxonwP3ooFyjKC/U99XNm1/Kyd3YUaWm9gUo
         TdqXxLx91A1gmY8bmfiePEQw/wgXifI0Ds1Oju8x6Sv9cYoZ+vMWe6N5DNoQso90pQGy
         7KqSRKRXNTB3oeFQe4L6OG8nw+ISJ/mtKVwjRidiIN/UIUe/lAKK2ZM1iZfI9HzTzJKw
         gSFw0p0+2PvkORdqsdKLczKQxyWY3n6yFFUnXubgEbnj6vDNfvhgrmH/I3KZ/H1zwVvG
         Ep3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjBu0zkySuNCd20GFOI0/2UExMR714kF5+vss//+G6A4fQODEjivV2ofqKm/1QAeNoFyhvb7pblIQH4LwtJDBla8w2AEqaKV/ZxMi8
X-Gm-Message-State: AOJu0YwsMfjPEkUG6vrjvZ5I1OlszPGaI0WjGjitsDnAIdnIlG78YfxU
	6JhCISXEdR85DMR+Wq2dHHitLJLhe7a4vya8dv4elEP1FMwSQBxemTJUp1EizLv+gsYieZSrrzX
	F
X-Google-Smtp-Source: AGHT+IF8kkzFen/v5G4itl1C1HxmRqShxMaO5flZTd2cApaQ6jUtGYGLvIPncX0tBNHzcsWS6KEBiQ==
X-Received: by 2002:a17:906:d95:b0:a3c:91aa:6a6d with SMTP id m21-20020a1709060d9500b00a3c91aa6a6dmr1312354eji.25.1707903117523;
        Wed, 14 Feb 2024 01:31:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7O3+pEWeOpRvppTPJpkXv4A5Ltp/JnGt6+2P5pT/x0xR9RuZLv8Gy989tdZvcv3xHAwpfieRgOQ+EPPYUAZYSsh03LMkAwRDCkGELLOgkAQWDXlUi6KduTUXZ6j8wOPJHI0MgUYiMy2Htt5IohkYM6YieH09GFUw+Qy3TtIcbizGWxxFJNI6TuGVsHmZwOk8HrRXtyEQfpo5qgQJdsXK/rDn/WJ/znwaVOF0usc7I+kU7/0ZLEY9xd+DfI33dUooQdJon9CUUpvZjZSWqaPeZS/QWmNS1kpc5QXVjkfoDnDrJVIb4XOuZxe7cqSFo9X2Edp3IBk7aVJSRg32ua5aGnqBCxWja9WT4zDEvWj2IhQ5TgEO3a/FHw64wXcq4A4JrilIEb8oILy5rPw==
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id i18-20020a170906115200b00a3d310a2684sm665364eja.158.2024.02.14.01.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:31:57 -0800 (PST)
Date: Wed, 14 Feb 2024 10:31:56 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Rob Herring <robh@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Tero Kristo <kristo@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Andrew Davis <afd@ti.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: hwinfo: ti,k3-socinfo: Add nvmem-cells
Message-ID: <z56fiu2jpokp57sjvnrdcbfy7brpq2ag4yxpektqlhtidecx4n@vc7dsurhxorb>
References: <20240206143711.2410135-1-msp@baylibre.com>
 <20240206143711.2410135-3-msp@baylibre.com>
 <20240206184305.GA1875492-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206184305.GA1875492-robh@kernel.org>

Hi Rob,

On Tue, Feb 06, 2024 at 06:43:05PM +0000, Rob Herring wrote:
> On Tue, Feb 06, 2024 at 03:37:09PM +0100, Markus Schneider-Pargmann wrote:
> > The information k3-socinfo requires is stored in an efuse area. This
> > area is required by other devices/drivers as well, so using nvmem-cells
> > can be a cleaner way to describe which information are used.
> > 
> > If nvmem-cells are supplied, the address range is not required.
> > Cells chipvariant, chippartno and chipmanufacturer are introduced to
> > cover all required information.
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > Reviewed-by: Andrew Davis <afd@ti.com>
> > ---
> >  .../bindings/hwinfo/ti,k3-socinfo.yaml        | 23 ++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> > index dada28b47ea0..f085b7275b7d 100644
> > --- a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> > +++ b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
> > @@ -26,9 +26,24 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  nvmem-cells:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +
> > +  nvmem-cell-names:
> > +    items:
> > +      - const: chipvariant
> > +      - const: chippartno
> > +      - const: chipmanufacturer
> > +
> >  required:
> >    - compatible
> > -  - reg
> > +
> > +oneOf:
> > +  - required:
> > +      - reg
> > +  - required:
> > +      - nvmem-cells
> > +      - nvmem-cell-names
> >  
> >  additionalProperties: false
> >  
> > @@ -38,3 +53,9 @@ examples:
> >          compatible = "ti,am654-chipid";
> >          reg = <0x43000014 0x4>;
> >      };
> > +  - |
> > +    chipid: chipid@14 {
> > +        compatible = "ti,am654-chipid";
> 
> This isn't compatible if you have a completely different way to access 
> it. 

Thanks, it is not entirely clear to me how I could go forward with this?
Are you suggesting to use a different compatible? Or is it something
else I could do to proceed with this conversion?

Thank you!

Best,
Markus


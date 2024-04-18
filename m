Return-Path: <linux-kernel+bounces-150113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A283A8A9A95
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A591F22857
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84231165FC9;
	Thu, 18 Apr 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX7SseTS"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F15165FB4;
	Thu, 18 Apr 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445070; cv=none; b=oi4fdO5WmLf9SO4iHq5yO/yfSoTHOOe/ZSJEPVGuznRdiDSUUDpbERIdj/evudCjUxA4qSWfJsamsMqyURH90XGHf915igtRJ19aHoO7f+n4arP+uI+mjVqlTp+PJ2AtAWXXuK6svTedWDBzyZpgEVil1Dc/5QAeMNzRijTAwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445070; c=relaxed/simple;
	bh=mq0LVEhgLrutQcuF19JR7w3laIzCRdDcXlTvXzp+kR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCczj1KGN0CZD5Xr5Di+HgSSwPHc6o8ZYmjTwAPum89MeJJ4kdkU1IJzoSqH7pgiOrL426ylVvjjhy+HqnzmjbYL/ANPkjR9t4+N8kez9J7oML5CSzX7u9TKgyn6eesnHbMHkF42db1XDvaYlaHGuc70737IHEflp+v5X1K4sf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX7SseTS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2da0f8f7b24so9948741fa.1;
        Thu, 18 Apr 2024 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713445067; x=1714049867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7TvlJDHh6PM8Lai+72isa4pBtCMtiwvjV7L+/XlE4U=;
        b=VX7SseTSyaorQla78jmVqGvTMcrIOP9x4/fUZGjX+cwsRV2ZqVveFXYM0ufThK/PvQ
         W2ck8Lx3KSVk8IZju/2XUH3E55UL+W3ui1keDu1xcMIw3PxYtedXBicYwVkujnei5mx2
         yaRPQseRLy4J1qbn/6mcM3vRozqEqEXhcYeKV9VtZxihF1OMgAv9GzqfhgYN3FpXCkU/
         8EfH4l2HQvmOIy0AcKedgwMGmELCJbpnXu32g1Uarz7NJiWFFH+HNSNW1sXnIK5XM7X6
         PriS8U4FRITTDFkMpi7EN/ZceESsCNpB3Wr23gsUbpegWJIhv1112iGpjBxg4Fxd4BzW
         Ge7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713445067; x=1714049867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7TvlJDHh6PM8Lai+72isa4pBtCMtiwvjV7L+/XlE4U=;
        b=p1eEfi9DTFqs/u7iBa0sGVkHeh0vAOtx4OgmQ9hZyVXgrvhkm9dydCIX6t8IQV/p5+
         lAHgUbbwGMO7CXCTFKC0Go3hCLwdHMhAIklfFKoIkgIOZbDYKz0Tk029rGyEdOcWEz43
         ELAEXHXcWq6+JoPv7Umk+CG+tm4PebIH0Cazx/wdebYelCsrH96rotChM6GKG4O5R67y
         iPAMDqm33oZiaIadXPsNZ+jj80wwH/WlZZYNIWq/NSw1R0i0zrNMusegYzKhFXvCHQNY
         9owkO9/DmdXfsIKaPfMa8fUFaIS96zsVqYaHccMfUUDT4wVGOkrsBhqPry7PrOoBp6we
         jo2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYDnvHB3pc9CU1qKKFK4kkY1sC2lYlqI2rQbVuBo435GGuyRs4dH546nvIE0uzlMn6JPkNXHVm32K4QHgqLfBD9Bk00GAJg0z4jaKHqviNCmJJ6FKK13ihkV2oAZpVZ7vptlNlbaEDMI+y0MgKKWhHk78/YTSndxaakTh8WtC1ReG/kDh9P8gw1j97u0WAaoPQKR2x2FXE/DRj9g7JJvHAA+3I
X-Gm-Message-State: AOJu0YxHIvJQ0XPwlI+v1D1GvRFLA5KS2jyaGRn/s6ldg6Hikde0SEpe
	jUs+3gQo8a3sCT2qqPLtYxbaO0bE5HMRd4PcBrYLaJ4eq7+UCSUU
X-Google-Smtp-Source: AGHT+IHfKLq2UzaMXO/4uNIuhb8wjwhcxG7kZvjOwkPLDKwcLA+nxELTBqKKXudYnYTNlpQpw0rHVQ==
X-Received: by 2002:a2e:9f17:0:b0:2d7:1a35:d580 with SMTP id u23-20020a2e9f17000000b002d71a35d580mr683715ljk.15.1713445067067;
        Thu, 18 Apr 2024 05:57:47 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id f23-20020a2eb5b7000000b002d88804b368sm190667ljn.43.2024.04.18.05.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:57:46 -0700 (PDT)
Date: Thu, 18 Apr 2024 15:57:44 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 4/5] net: stmmac: add support for RZ/N1 GMAC
Message-ID: <eqfta73ost45nbzz3aoa2tw5tasg3geehf4fgphu4teq5yfvar@ngif2e6j5j2k>
References: <20240415-rzn1-gmac1-v3-0-ab12f2c4401d@bootlin.com>
 <20240415-rzn1-gmac1-v3-4-ab12f2c4401d@bootlin.com>
 <xp34tp5cjmdshefxjczltz2prqtiikagfspf4lobznzypvsyah@ihpmwfynwzhh>
 <232e3b0c-ca55-2da0-1c9f-47520a1bcfbd@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <232e3b0c-ca55-2da0-1c9f-47520a1bcfbd@bootlin.com>

On Thu, Apr 18, 2024 at 01:57:47PM +0200, Romain Gantois wrote:
> Hi Serge,
> 
> On Tue, 16 Apr 2024, Serge Semin wrote:
> 
> > > +static int rzn1_dwmac_pcs_init(struct stmmac_priv *priv,
> > 
> > > +			       struct mac_device_info *hw)
> > 
> > AFAICS hw is unused, and the mac_device_info instance is reached via
> > the priv pointer. What about dropping the unused argument then?
> 

> Unfortunately, this is an implementation of the pcs_init() callback, which is 
> also used by socfpga (see patch 4/6 in this series). The socfpga implementations 
> use the hw parameter for both pcs_init() and pcs_exit() so I can't remove it.

I had that patch content in mind when was writing my comment. There is
no point in passing the hw-pointer there either because you already
have the stmmac_priv pointer. There is stmmac_priv::hw field which you
can use instead in the same way as you do in this patch. Here is the
respective change for your SoCFPGA patch:

+static int socfpga_dwmac_pcs_init(struct stmmac_priv *priv,
+				  struct mac_device_info *hw)
+{
..
+
+	priv->hw->phylink_pcs = pcs;
+	return 0;
+}
+
+static void socfpga_dwmac_pcs_exit(struct stmmac_priv *priv,
+				   struct mac_device_info *hw)
+{
+	if (priv->hw->phylink_pcs)
+		lynx_pcs_destroy(priv->hw->phylink_pcs);
+}

-Serge(y)

> 
> Thanks,
> 
> -- 
> Romain Gantois, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


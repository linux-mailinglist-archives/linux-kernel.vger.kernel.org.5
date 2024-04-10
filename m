Return-Path: <linux-kernel+bounces-139007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3089FD5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F56283589
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC7317B515;
	Wed, 10 Apr 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG29tawy"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B917B4FF;
	Wed, 10 Apr 2024 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767413; cv=none; b=At1sucPnPuHX7jWMGTBAPH31ZcXLlFoxVYHkIHkF3Xxe6xTnoVXr0XrX3gA5bcYZdvW4uNtKUk/QTX6Rcgwb6OqDbsdl8WtsbK39wbs3QjwBxbdSxSGqkVpgPjXaZTlSsDOcXmxCV0SnVdoXBJhRI5/NgV7EQ13iAtbeblsP37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767413; c=relaxed/simple;
	bh=qP4rwcDDBXWsYnnCO06i7GA685vxVAn/SFCuKVL5ymk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhV/tfQl2zv25Bc7lAE3nhGFPJCJD9iIX0C66CVhKmiKRoBy+mX9YJL0q1hVQSV4nJ3h57fHiYpuqJS2LOceUl95wzmQ/UpSyrEjl8nqZfPAZnep3PI+3UT7+i1Amgss+gH+cNs7JGUM7oT5QD68cr3ULPf7K/rAHRyHwbP/P2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BG29tawy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso296087b3a.3;
        Wed, 10 Apr 2024 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712767410; x=1713372210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Awh8ecAEWQZ1WcJzJZ+Zpya1KnuzGUc8tEokrA81tso=;
        b=BG29tawyLg6MJBxfO9YMPP3PN0FOh7+ntNPrIFASsTQkc7Pufpr8pfR6A0viww10Vh
         +NI5hMGZXCtcpv5a1Blo4EECiq18kTuZ9ohQULSBcup6D8oBP2Yjf4OopqH7DUXuWy75
         T4ARM7WoC3uKC07YoIhH+Xqc+GUAlNgh31OrdPUsvytjApu6J+aRN6MH9QEYEiMwuNwr
         7oVPGFytvhViojS3NvtTXrYC70jxSqvhC8DchDaaanvRANIEKCG5sm+mmu9M8ikf0K/t
         OmOYnzbcllA+WeIFTbVO+w47xaTQCjTpgLjubAKxA8aEnVP5zi1tp19R6cDJMk226SDC
         UEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767410; x=1713372210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Awh8ecAEWQZ1WcJzJZ+Zpya1KnuzGUc8tEokrA81tso=;
        b=GrDngHgy9xwmZEDd1HK6wFHhVeCSW7rhpAaNLfdmvX5B8ftxXBKaMtSGXEfaDVxXbw
         0fMfxQ4XBBTi2GBNPCj9ulNBOqITrog/a/GyzcZ+JcSWCHZqJECaknrcYx0mxu6z0uxD
         0tfHgp9/SmGQGlHy5uMPDdu5r3ntsc/fGwlK4RlzXUJAqtotiar8zFUjMgreUkJVqpUQ
         sPk7TE8Hx4fWItfQ+BA7CuBpFZ7F+GnHYfvB7V2MHfNLJqa0ThvfIrwwHtQMw5OVzsse
         /ZK8DashCBNO+TaH/gmwRxpkG0fP4Q2tc1//JrpBRm1F8YSQSHBePyVV3vpSsP4nd35/
         BNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+wPD53SalWl8n1xK72FJi4643ilVrL1yZz40PxNU3qAjUbjQnT0aoivRmS1mgQJSbLFw1jwi46APEOZneVF39WqPb0Eg1VwjP7jn4mwo1qOo9lkmOfDf4cecrYucWX+NxwdfFi8xEuZ+joVXWMnE7V2Tvat/QLd0dIYiPQ+jymxpaROcwV9EfosGTGqly/vvwgrupxMyKHiAqPmz1Mt8fenMa6OjfL6I+G+w=
X-Gm-Message-State: AOJu0YzPOMMjGopgMMR64oAOx8Ac4sJlm6QZOuqM+dDHAm3TwSfMbY7f
	Q2GC77fj9jNYDyfslUsupGCs8MoP/R4yJTTIKt7Go1juG7arTX8R
X-Google-Smtp-Source: AGHT+IGowoxPbo5rXFumvdr4rBUE6oPeTkSAeAkpKiGPVElZ0Zqp0XkSo3uaxirSokB6jzLHky18fg==
X-Received: by 2002:a05:6a21:3d95:b0:1a7:507a:c9f4 with SMTP id bj21-20020a056a213d9500b001a7507ac9f4mr3348678pzc.30.1712767410142;
        Wed, 10 Apr 2024 09:43:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a408900b002a26430fc7bsm1578654pjg.2.2024.04.10.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:43:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 09:43:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH RESEND v8 10/10] dt-bindings: watchdog: renesas,wdt:
 Document RZ/G3S support
Message-ID: <c6467ae4-c3f7-4a2c-abf9-8428bc068d42@roeck-us.net>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-11-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134044.2138310-11-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 10, 2024 at 04:40:44PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Document the support for the watchdog IP available on RZ/G3S SoC. The
> watchdog IP available on RZ/G3S SoC is identical to the one found on
> RZ/G2L SoC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes in v8:
> - none
> 
> Changes in v7:
> - none
> 
> Changes in v6:
> - none
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - none
> 
> Changes in v3:
> - re-arranged the tags as my b4 am/shazam placed previously the
>   Ab, Rb tags before the author's Sob
> 
> Changes in v2:
> - collected tags
> - s/G2UL/G2L in patch description
> 
>  Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> index ffb17add491a..eba454d1680f 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> @@ -29,6 +29,7 @@ properties:
>                - renesas,r9a07g043-wdt    # RZ/G2UL and RZ/Five
>                - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
>                - renesas,r9a07g054-wdt    # RZ/V2L
> +              - renesas,r9a08g045-wdt    # RZ/G3S
>            - const: renesas,rzg2l-wdt
>  
>        - items:
> -- 
> 2.39.2
> 


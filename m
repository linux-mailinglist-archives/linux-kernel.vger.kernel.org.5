Return-Path: <linux-kernel+bounces-50008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 149408472F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C282887DE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69F1468ED;
	Fri,  2 Feb 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctN0Iwm+"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675BEF4F3;
	Fri,  2 Feb 2024 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887163; cv=none; b=htz7gYCnn0zEpFqCQ/c4CaHnNBf8VRQBX2QZdNdOim3ErfY63sABr0Gfknqqj96qn2q4deSPhR09T8icHVMYYFnZC96j7DKZvJShahdS7ZUGyhb6rYw0pWin19iI3GcUKDtgETYpFG0h//Yr1hBt8jv6xDvWbBYKC8u1EtqtsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887163; c=relaxed/simple;
	bh=Ox8L57JA4AUkcDs2pE0/4jJPX9j0BxzICdkXV9TY1Ic=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoGe8kaMSDmKpcqJ+qYOWjNtPUYm76/zMTE6bNnebAczqDTtx6jeMQRLbOl2LZyUaGE5dAsgM1hPvXdOpRiCDe20PvDU1Eo1mlUvGzDK7eYak1uLgxTWMX8q2EmMEm6FHMCcalz78M2D8O3R+eGHg1H2jupb69jjHMOvOSVaRFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctN0Iwm+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fc549ab9bso7343885e9.0;
        Fri, 02 Feb 2024 07:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706887159; x=1707491959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aE9RDzquXUnyGWyqx2WNSmBkRu7c0fXOe0fgH0xt2RM=;
        b=ctN0Iwm+k9xjon0XsBg6U9HdazIHPJh5CrvU7yRDRsvUqUQScVuvXvMwfmNU31NOY7
         hm4I4Wgb3m0W6bQ6Jgo0PPxUq6hBAN/0XmvoTrzHRzSBhYizrD9DgeE2pzvVsUsmBuiN
         u33ab2dwOcEuxNK6o7/2D4OkRq5uwjx4u8IC/G8pZl7upmzCczLOtmnB9JyNrUMza+69
         diUgiGDxasT3kdpWuZOO3PLw0roDVIXVprW5fvoz6hXiblX97W4P26SB7Q+e6AIKGNwW
         KBlIAzHYkKRmlJeXaF0l/GoTh8cFRXoO1pQFnh216uB9KWiFqTVHI5llBTiGRBfpx4T0
         CWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887159; x=1707491959;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aE9RDzquXUnyGWyqx2WNSmBkRu7c0fXOe0fgH0xt2RM=;
        b=BgwK25+Z5d6XQnKTA8yu+0T2gbK4on62ZBUbBgdaEo3JncKbsykwUDumkFg2srCebb
         VFluBkvo0imI1QiDAw6bN8OO5MktWgT0p1sQxd2mU14ReFNKsWRmIBdXMemHu+85oKe3
         QWNtOjRKk5Q6MWHe/zAM0sZrmHCez20mfbCpvGognkjEBFmyOPpTtYZv8axAX60snBPz
         IATKusYd2bQe9/EQsU3FoEfb5EJmK+h9WoznF1vVSLz1Oez91lhAlbxI+v5gA7aDfp6y
         McV68LteAipNsqLdggTzdnpdsq+VMGDYo66KAVgBwgeWsbMzwGiZJxowsq5vxNhQXdIF
         G+IA==
X-Gm-Message-State: AOJu0Yx7pXunfmZJy4H66dDoMoQq9C7OkDlDp8WdAtcuBrk/fr6qAuQL
	/T08AKgo5+ivhrCDTb7DrZ570u8IGBC8cSBy7uD8DCUEtgYGLEqB
X-Google-Smtp-Source: AGHT+IEo7/Rzm0+xYpDkykRaqOuEUD5HBdSjeFCGgYWOO5TRuwAEy1mX6pCrsH5WXijWGxUgOtl9Bw==
X-Received: by 2002:a5d:4750:0:b0:33b:1b2d:1b36 with SMTP id o16-20020a5d4750000000b0033b1b2d1b36mr1584527wrs.60.1706887159342;
        Fri, 02 Feb 2024 07:19:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqaNGiczieVynTdbeIb5Hq9n8fAiBLtKq21c8lIci57jJWxN1hxES9cetibpdKn9WU1A5NCX7dIBfquSoVXp6e9WLbXWMRXkaQ8KVG6YmvyU5mszXeEa+3GmOhpIB7vuY+aDQCUkF50mtHa4prgqQN4JBfhhikRv2ZeL7ZUjvcyWjudZWvcbfnNOzIq4+nm0coCKvRJtCaoiZ7NLA8ajE5i1kmN2khux/hQYco9LDpDNQ+glw7lC9Ag+AKxsB9P3u3BQuZSuD/YU9NQ8oFCxD5ZEB5VKmx05/tIUaXE0dvgLv1Y8c8fObMomc57ZyVyRjV3o1jfDHgOsMF1TFFymTtKAFfwMqG3nVK51aeKYubwvt0Q9p/dcdQ8IhO/sSQnvl0XPRjqU4SFlZjt1X06U6yTJOF/nJDCecqnzm5yKDt/6HcRIlzteqIMt5n2R2KaB5EoTBE+aj3isj/ZQgMqDPJSiVsRXDSIK3D7YEPAgJb5ZKg0K5oUkRC5sFOG436cs9oC4H+CIzjzdUUteM+NEwk9IToD98nxD6QzlKpWoa1
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b0033affaade9csm2149033wrx.68.2024.02.02.07.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:19:19 -0800 (PST)
Message-ID: <65bd07f7.050a0220.e8e5e.9e28@mx.google.com>
X-Google-Original-Message-ID: <Zb0H82fRtGfMbXfQ@Ansuel-xps.>
Date: Fri, 2 Feb 2024 16:19:15 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 5/9] dt-bindings: net: add QCA807x PHY defines
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-6-ansuelsmth@gmail.com>
 <9933685a-5265-467e-aa39-d2c92a12edca@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9933685a-5265-467e-aa39-d2c92a12edca@linaro.org>

On Fri, Feb 02, 2024 at 08:41:56AM +0100, Krzysztof Kozlowski wrote:
> On 01/02/2024 16:17, Christian Marangi wrote:
> > From: Robert Marko <robert.marko@sartura.hr>
> > 
> > Add DT bindings defined for Qualcomm QCA807x PHY series related to
> > calibration and DAC settings.
> 
> Nothing from this file is used and your commit msg does not provide
> rationale "why", thus it does not look like something for bindings.
> Otherwise please point me which patch with *driver* uses these bindings.
>

Hi, since I have to squash this, I will include the reason in the schema
patch.

Anyway these are raw values used to configure the qcom,control-dac
property.

In the driver it's used by qca807x_config_init. We read what is set in
DT and we configure the reg accordingly.

If this is wrong should we use a more schema friendly approach with
declaring an enum of string and document that there?

> > 
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  include/dt-bindings/net/qcom-qca807x.h | 30 ++++++++++++++++++++++++++
> 
> Use filename matching compatible, so vendor,device. No wildcards, unless
> your compatible also has them.
> 
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 include/dt-bindings/net/qcom-qca807x.h
> > 
> 
> 
> 
> Best regards,
> Krzysztof
> 

-- 
	Ansuel


Return-Path: <linux-kernel+bounces-38347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DE183BE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ACC0B24434
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6A61CAA1;
	Thu, 25 Jan 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e10KUXJY"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAC1CA8F;
	Thu, 25 Jan 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176645; cv=none; b=bcuyDpUrqpVQlI2Brn3ZQi4+U20OSY/l3Evw5lvBfOpRKeqiQPkfEM/F4vqiswz7lOviiBs6YSYbtFggHzrFbiOltDybX5ogu1iYBF9lqQFt6v1HRagS6gWzI/2CQYb7vAwRfwnWj7Y11NBW4S+YKRw8KLtKmV5jwLsiB7iaRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176645; c=relaxed/simple;
	bh=nDBj2jaw5rA3cCvKk+09ETAP4UZsp4kCO/FWScfddaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHtjzndgwmGM4bx2jHNkUN8JX4ehK0+n+QSVz1zEfapWSapU1yDTsaYUQGmnsnzYkBku9Qq/IW+KPQl9e0vneT0fd6gv3/eDK3RTXWzyK7dC+gZaCrLCyuazGAqwzZ7jbSWp/001bquvreTeX2Q8nXtUxML/FkpMY76eBXGiXLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e10KUXJY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3106f5aac8so213273066b.0;
        Thu, 25 Jan 2024 01:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706176642; x=1706781442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBbqKY/v6t61r3biu1JvqsGDvuKRc6bpf7H0wAyMpUs=;
        b=e10KUXJYM0iTljz7redYixUolXVLKkd4NEhJZnMvrANt4/xS1BVjTAQFk84K3Zjq/6
         AAvrjZKzzeOZLKiixv87kMODhdSfCYEWU2Ynq0+iJSfPRYod/oLaSkVXbcrTl27dEgO5
         AUU1tqjL1IYgXs6Nureri02FHXXjU+1w/jsDSgpujBNsdkQD1UtHAIqYjiJGgi+Rk8v5
         DJ/T1/MR1XgAo1AIMZEXOR+lG24GGOtHzdpNa1mZ62o7kqJWE9IZintUaGKedcnVjIy7
         kRio3jLaHVGqjr560JmbD7u/aARd9clRApHAT0D2wkSyVUdvR0HG7Ij0PcBPUVc9CAcg
         GGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176642; x=1706781442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBbqKY/v6t61r3biu1JvqsGDvuKRc6bpf7H0wAyMpUs=;
        b=e81Kh2KKWflTnB8W46r3QHXc5+h+DfAIMxWYFrU2896aFbj0K/EWDz4J8nW4hmGtTF
         KEvChj3HcQZ342mILR0YhMWAmPoi4I8vgsCIiEYm2/keB/jWQ9CuSXbQoyulsw8Z8Ge1
         7locfC44L8uVTq3RqNfomhZihTiDDY1TLWeuzb/b6G+RC66uCa9zQH4/53d7w4m2xYSe
         szIz8A9qOqykUx4rKgl8o3RGcOVA/WMxYN57rVI3Hphrd5zeXkDotIk6OWYbmA7BysA8
         jgI0/iO4F8g+P6/+kR/2EXPMOc5E5NEwGK0nmVt9B+lu3GXJF/Xr/0Qgp+A/dk0zymBS
         ruKg==
X-Gm-Message-State: AOJu0YxyEO5Q90Rvcwyvur3IRCE8ropGXpIOe9I1ktZwIPR+YmRfV/pN
	muRQk72UkvLgge8yNlikvA7nMgD9y1hdxZupip2KdFyOXX9FsIRveVjAzy8yC+I=
X-Google-Smtp-Source: AGHT+IFSLNteMzFmcoCxXhKIiQTLIeb3M6E1SRC9QOgEuM+h6q1NvxgMhZSWrXXmAt1a6HlmbzKLog==
X-Received: by 2002:a17:907:b9d3:b0:a27:7075:7613 with SMTP id xa19-20020a170907b9d300b00a2770757613mr374859ejc.67.1706176642129;
        Thu, 25 Jan 2024 01:57:22 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id vg8-20020a170907d30800b00a3172cc2a0fsm543030ejc.136.2024.01.25.01.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:57:21 -0800 (PST)
Date: Thu, 25 Jan 2024 11:57:19 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Philippe Schenker <dev@pschenker.ch>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Marek Vasut <marex@denx.de>,
	Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH net-next v1 1/2] dt-bindings: net: dsa: Add KSZ8567
 switch support
Message-ID: <20240125095719.2nu3u3auwdcmouaw@skbuf>
References: <20240123135014.614858-1-dev@pschenker.ch>
 <20240123-ripening-tabby-b97785375990@spud>
 <b2e232de11cee47a5932fccc2d151a9c7c276784.camel@pschenker.ch>
 <20240123-atlas-dart-7e955e7e24e5@spud>
 <979b1e77b5bb62463d52e7b9d3f9ca1415f4006a.camel@pschenker.ch>
 <20240123-carpool-avatar-c1e51ab3cc32@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-carpool-avatar-c1e51ab3cc32@spud>

Hi Conor,

On Tue, Jan 23, 2024 at 06:37:55PM +0000, Conor Dooley wrote:
> On Tue, Jan 23, 2024 at 06:30:16PM +0100, Philippe Schenker wrote:
> > > > Hi Conor, Thanks for your message!
> > > > 
> > > > I need the compatible to make sure the correct ID of the switch is
> > > > being set in the driver as well as its features.
> > > 
> > > Are the features of this switch such that a driver for another ksz
> > > switch would not work (even in a limited capacity) with the 8567?
> > > Things like the register map changing or some feature being removed
> > > are
> > > examples of why it may not work.
> > 
> > Yes the ksz dsa driver is made so that it checks the ID of the attached
> > chip and refuses to work if it doesn't match. [1]
> 
> That sounds counter productive to be honest. Why does the driver not
> trust that the dt is correct? I saw this recently in some IIO drivers,
> but it was shot down for this sort of reason.

If the hardware provides device ID registers, what is the best practice
in reconciling them with the compatible string?

I see 2 extreme cases. Ethernet PHY devices seem to blindly trust the
PHY ID from the "ethernet-phy-idXXXX.XXXX" compatible string, and phylib
won't read the PHY ID from the standard MDIO registers when this is present.
Whereas PCI seems to completely disregard the vendor ID and device ID
from the "pciXXXX,XXXX" compatible string of function OF nodes. Both
these subsystems have the "compatible" string optional.

I could see an advantage in using a precise device ID in the compatible
string, rather than just one from which the _location_ of the device ID
can be deduced, because the precise compatible string allows for much
finer grained static analysis in the schema for the device. In case of a
switch, that is the number of ports, supported interface modes for each
port, etc. With an imprecise device ID, you don't know what you really
get until you boot the board.

> And despite the email, I have nothing to do with these switches, I am
> just a sucker that signed up to review dt-bindings...

Same here, just a sucker with some switches and not many clues about
other things :)


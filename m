Return-Path: <linux-kernel+bounces-140350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F06A8A1329
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B4D1F2359A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A46A149C7E;
	Thu, 11 Apr 2024 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/xivzch"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B5140E3C;
	Thu, 11 Apr 2024 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835549; cv=none; b=GOebKOXZ0esm4awFDt720Db5YZzbQi8+ONsHEl/2fZzGPMvUOvYv2XC91FjCs6CSGyJRpddxsfCMMs7qFS1Qx0sBR1ArAbiXMy0rhAdyMWx/oxU6pHX82835HyjWdL9rhcnRMRTrNQQIqTS9XRwoNajCuk1lAFquekGqkNV4eqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835549; c=relaxed/simple;
	bh=vir+RzMXsA+ZWkB1YHRhXpnLDAGiAl3s8xAjXf+9X4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxm4OloLRqyILezug1UD2GF/AwRiqyRucZiuk3ge4jRcLhQoTOut5ZJFWbZHuDLm60ZD6On2fR3N3w7QDijVjMbs88BqqeOqVZS+RAASf4f1g5mPbdYdq7UfCQbqAfbRv088o6quMEohRnIFGdUJB5Mft2mobcpbIERWJJo4ECY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/xivzch; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343f1957ffcso483369f8f.0;
        Thu, 11 Apr 2024 04:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712835546; x=1713440346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+QtFIdkYQfA3KeFxJi+DljnW6EEW0jiP3wWfMAzQBw=;
        b=g/xivzchh/ZOdcT5qmolwPZSl4rWND8tYu4tj1aHS9waVRBb0bu7AI1VA0zghMX27W
         RnzW9P1o5rdnnoeGcLFuhcdxg976Awgw7Fq47Fe3wXGHfVMGF60jM0MUqDADVN1fHY0U
         V4Ko8O5mT0rzyiODyTLrLuPMUuZYyYAejZHOWM0csjdBUIUPPzC/F5xexPL3OwL2KAAx
         zSxqxYqjwHBPLcm6GvFzPidYeAPqeuTU5S+7JpczD8cQnMFIHUue4uJOZHLcihv6L1Ol
         vlioM2UAOpNP4EfRjtobcqDaQ3OSxvOWjkmfRC0gCzrb+BhXDUhtCP9DHrCgVpHCeTMa
         mW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712835546; x=1713440346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+QtFIdkYQfA3KeFxJi+DljnW6EEW0jiP3wWfMAzQBw=;
        b=fYV1UJp9bVgi0ITaDjCytg6U/nl4Dwv3K92iYjD8DNAOzr2LjfQaC/H/ACAUf9bFBo
         m1nTylIPhd41JeDO1FIj8WLoOISjcNmYlXSWsLq/f2GwDl7Xn/nhhnGBkIFHj7XHv08n
         ltgtLJA1qE/ffMPxnQEqNPdsBNW/hcDTwI6xr7oAROK1B8RQHMdzH1/QosHRaYkRgsUU
         z+V8b2XTxjB15GdBQnjqAv7ETcvWoUmp8QVsy2igCkPx+Fk4LkO6jZOU5W4lHs33uLEy
         AsJC63GfBcS3aIK1jw/RmGcTHV3/Y5t3YyjVz6lZZXYnHbEC0J11xUmQdo22L+zTF4RD
         1V+A==
X-Forwarded-Encrypted: i=1; AJvYcCV9vbUTtHyVz8v1VKGCwhet68OIbnozgYcWzwBNuwWVwu8x23/C1FnBv9ulhO+H2KbNX6frrYBFW5UNhpHuFVwPtEhiiXb/YiJevVDAKZ9LSAo6e5ptScydzX+MMLTvI6zE0rP/
X-Gm-Message-State: AOJu0YxQuSyN/Vh+H14B3OTKQEoAHWLQOh8dDqa66dTY00SvMsp6bcyn
	CnGhQDBuo2Od5ue1zBNKmV0WbRVENxJpqZ536UaB4HiyCnBXyB/G
X-Google-Smtp-Source: AGHT+IHrXmlbg6UDJ/BIVy1PEozMkGt3WCujEmCVA7MuO0EpPdjSW4FIrG8D0FRMhtB2hZ4yNFjvFQ==
X-Received: by 2002:a05:6000:1d1:b0:346:a69e:5afc with SMTP id t17-20020a05600001d100b00346a69e5afcmr2292049wrx.4.1712835546063;
        Thu, 11 Apr 2024 04:39:06 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id e18-20020adffd12000000b00343826878e8sm1571589wrr.38.2024.04.11.04.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 04:39:05 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:39:02 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>, kernel@pengutronix.de,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Message-ID: <20240411113902.gh7hfivwdwdzzqea@skbuf>
References: <20240410080556.1241048-1-o.rempel@pengutronix.de>
 <20240410080556.1241048-1-o.rempel@pengutronix.de>
 <20240410080556.1241048-6-o.rempel@pengutronix.de>
 <20240410080556.1241048-6-o.rempel@pengutronix.de>
 <20240410231251.macw4i46jfi57wtc@skbuf>
 <ZheHpK7egVvszSQF@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZheHpK7egVvszSQF@pengutronix.de>

On Thu, Apr 11, 2024 at 08:48:04AM +0200, Oleksij Rempel wrote:
> > No, I think we _need_ the thing to be configurable, and not try so hard
> > with the ieee8021q helpers to hardcode things just right in the kernel.
> 
> Yes, I agree with you.
> 
> ieee8021q helpers are not the attempt to avoid the work needed to
> implement global DSCP configuration. The interface is still needed and
> we need to agree on how it should be implemented.
> 
> The problem which I try to address with ieee8021q helpers are initial
> defaults. KSZ8 and KSZ9 families of switches have different initial
> defaults. So, if i need to align defaults for this driver, why not to
> provide default which are reusable for every one?

Yeah, I don't know. "Don't trust DSCP" is not a good default?
Although at the same time I do realize that my own position is not
justified by my own actions (my drivers do trust VLAN PCP by default,
and the mapping is hardcoded and not configurable).

> > Have you tried the obvious: "every time there is a change to the global
> > DSCP mapping table, push the change into the dcbnl app table of all user
> > netdevs, so that the user becomes aware of what happens"? Kernel drivers
> > can do that, through direct calls to dcb_ieee_setapp(). DSA does it too,
> > to probe the initial QoS configuration of the ports and push it to the
> > application priority tables.
> 
> Hm... what interface should be used for the global DSCP mapping table?

Not any different than if it was per port... Just access the global DSCP
mapping table per port, and the kernel updates the table for every other
user port. That was my idea.


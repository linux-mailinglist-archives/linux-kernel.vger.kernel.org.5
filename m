Return-Path: <linux-kernel+bounces-148044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B528A7D00
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47161F220CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C26BB5B;
	Wed, 17 Apr 2024 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYsQSqmX"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65C40850;
	Wed, 17 Apr 2024 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338577; cv=none; b=GmZhG6ryZSqi4SJGYEwUeoYcVZ2VfAQRP5+PF5UBT1taApjvHKs5q7exkfket9gq2eYP1a+f1PMMlA5g8sUVCcvbXcbEEwuMbUsoDL/WV1jmCSx0O05smy5hmPuzCGDQnRSEIFUWYTskpCJrXOJWh1xf78I5zpkWBpAPS6BkhxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338577; c=relaxed/simple;
	bh=88FMoahohhlkfN+9CzcIFpURNfThc9jeG/zAbMllpjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX3lzQO6sLdIHwAP1+yIgrocJnbCTXoa+1xAtU9zKTymYRYQ3EiezFeJkH6f/VqgE0WTv3ed6M6UI5PV14/PqS6CC7YcaOGeCHecS79gD9nJi6b0xVUalWj4SY/4wzNcW0HV9HRIq62xI4n16J3m2ql/58S+1G1RE2AlqTkkr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYsQSqmX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5176f217b7bso9283641e87.0;
        Wed, 17 Apr 2024 00:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713338573; x=1713943373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFd3LuiLz7mwemccGmzwHdBRLXnnOHlxLN8go5cVxJg=;
        b=VYsQSqmXFqgrWbyZMu57YaRK9vXMXtzjqof9gDh4Iiubf56zvn2li8VXdeqDW6TfZ3
         bQkS8etfoL962yJhkNbycmVZW1UVemh872tp8WlJUq+vJ1S9YlnHPbkqbVFsVLGbo8xQ
         3U07pyGXB2Uidm407EBDbXCHmcds9hQunjJgAud58KX+O03feV17orMgKqp8JemlE15T
         7N9BY22skFFsjYLEb4cjppI81nwN76pB/1g14jix9VDjwJ46hJCqiRPPV93xBn2/1mTU
         L9e77+89y3YQ58ZUi3ybiJS8GPhsAUtV7DJ59YHgIX6ckUohrGnW0gmGlkm5MS/CSI+h
         TxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713338573; x=1713943373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFd3LuiLz7mwemccGmzwHdBRLXnnOHlxLN8go5cVxJg=;
        b=QS6BVSR42hsFCsrPTUCTD10TZVMZhxSrdKA60HxlYwWzUTF4/my3YkzH7Yw2joRcjd
         1kX9XSWUojvzxPx8jwwlJ0cko52PGemQKbPNDnnb8iMNs+5cD5+2VlxI4oYCdvslAfPa
         759RWbEVnV7dwZ6xsXo6sHWZ5CATgFmqTiZKZf3HttMEXdxsxoRJZN65zc7Af3cUrdI8
         7RUeSOL7U9BhkT+vv3PLI6fObLRDUmymyRsS7ZgmsebZYrWo1WDpp+h8zXeZpCXcdr8G
         HIJUXb7MEm9brvleeMCkH2CpSXT00lDYddRiLJZEikDQiy/hfJ9iVFbFYryqYp/WFVKS
         73zw==
X-Forwarded-Encrypted: i=1; AJvYcCUL9qWbDiwYKvH6qO0umPLBSR28bvZr2BYOdYjjAYxoyjeYVAofu5qNmZCWuBhMri3wEV/qAs2jbBGICdFtHUOaSzBLfT+i76CYzjZz7sic06LJVIZ2bDiGuVlLb3BmgXgucMp1PhHGSD+aMZhJeT+6/zo8ORLZb6zqbxz/nCvABQ==
X-Gm-Message-State: AOJu0Yw9CMnSC7nrWbhzrt4aXxvEpqUVW7j70fwmhIkROFKp45DWyAil
	mavTEQughvaRhal+ap+i+2bMst0sdNwVEoK/w1AZkl18yeMHFA5w
X-Google-Smtp-Source: AGHT+IFZZ2U7d0JdYD8EptTdQp9cL8YV7EclZe9DISQJlewmpYlm0svdc0PjJZvieY/1vVanvlp2Xg==
X-Received: by 2002:a19:9112:0:b0:516:9f03:6a92 with SMTP id t18-20020a199112000000b005169f036a92mr11278915lfd.43.1713338573024;
        Wed, 17 Apr 2024 00:22:53 -0700 (PDT)
Received: from eichest-laptop (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id kw6-20020a170907770600b00a555be38aaasm317083ejc.164.2024.04.17.00.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:22:52 -0700 (PDT)
Date: Wed, 17 Apr 2024 09:22:50 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, michael@walle.cc,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <Zh94yqo2EHRq8eEq@eichest-laptop>
References: <20240416121032.52108-1-eichest@gmail.com>
 <20240416121032.52108-3-eichest@gmail.com>
 <3f7f278f-e490-47f1-971c-ecf44a70cee4@lunn.ch>
 <Zh6clAtI3NO+nMEi@eichest-laptop>
 <5ed39628-4ac0-4c4e-9a16-fd4bf9a6db29@lunn.ch>
 <Zh6mIv1Ee+1h21Xo@shell.armlinux.org.uk>
 <Zh6z90iCpLqF4fla@eichest-laptop>
 <Zh6/oVHUvnOVtHaC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh6/oVHUvnOVtHaC@shell.armlinux.org.uk>

On Tue, Apr 16, 2024 at 07:12:49PM +0100, Russell King (Oracle) wrote:
> On Tue, Apr 16, 2024 at 07:23:03PM +0200, Stefan Eichenberger wrote:
> > Hi Russell and Andrew,
> > 
> > On Tue, Apr 16, 2024 at 05:24:02PM +0100, Russell King (Oracle) wrote:
> > > On Tue, Apr 16, 2024 at 06:02:08PM +0200, Andrew Lunn wrote:
> > > > On Tue, Apr 16, 2024 at 05:43:16PM +0200, Stefan Eichenberger wrote:
> > > > > Hi Andrew,
> > > > > 
> > > > > Thanks a lot for the feedback.
> > > > > 
> > > > > On Tue, Apr 16, 2024 at 03:46:19PM +0200, Andrew Lunn wrote:
> > > > > > On Tue, Apr 16, 2024 at 02:10:32PM +0200, Stefan Eichenberger wrote:
> > > > > > > Add a new device tree property to disable SGMII autonegotiation and
> > > > > > > instead use the option to match the SGMII speed to what was negotiated
> > > > > > > on the twisted pair interface (tpi).
> > > > > > 
> > > > > > Could you explain this is more detail.
> > > > > > 
> > > > > > SGMII always runs its clocks at 1000Mbps. The MAC needs to duplicate
> > > > > > the symbols 100 times when running at 10Mbs, and 10 times when running
> > > > > > at 100Mbps.
> > > > > 
> > > > > Currently, the mxl-gpy driver uses SGMII autonegotiation for 10 Mbps,
> > > > > 100 Mbps, and 1000 Mbps. For our Ethernet controller, which is on an
> > > > > Octeon TX2 SoC, this means that we have to enable "in-band-status" on
> > > > > the controller. This will work for all three speed settings. However, if
> > > > > we have a link partner that can do 2.5 Gbps, the mxl-gpy driver will
> > > > > disable SGMII autonegotiation in gpy_update_interface. This is not
> > > > > supported by this Ethernet controller because in-band-status is still
> > > > > enabled. Therefore, we will not be able to transfer data at 2.5 Gbps,
> > > > > the SGMII link will not go into a working state.
> > > > 
> > > > This is where i expect Russel to point out that SGMII does not support
> > > > 2.5G. What you actually mean is that the PHY swaps to 2500BaseX. And
> > > > 2500BaseX does not perform speed negotiation, since it only supports
> > > > 2500. So you also need the MAC to swap to 2500BaseX.
> > > 
> > > Yes, absolutely true that SGMII does not support 2.5G... and when
> > > operating faster, than 2500base-X is normally used.
> > > 
> > > How, 2500base-X was slow to be standardised, and consequently different
> > > manufacturers came up with different ideas. The common theme is that
> > > it's 1000base-X up-clocked by 2.5x. Where the ideas differ is whether
> > > in-band negotiation is supported or not. This has been a pain point for
> > > a while now.
> > > 
> > > As I mentioned in my previous two messages, I have an experimental
> > > patch series that helps to address this.
> > > 
> > > The issue is that implementations mix manufacturers, so we need to
> > > know the capabilities of the PHY and the capabilities of the PCS, and
> > > then hope that we can find some common ground between their
> > > requirements.
> > > 
> > > There is then the issue that if you're not using phylink, then...
> > > guess what... you either need to convert to use phylink or implement
> > > the logic in your own MAC driver to detect what the PHY is doing
> > > and what its capabilities are - but I think from what you've said,
> > > you are using phylink.
> > 
> > Thanks for the patch series and the explanation. In our use case we have
> > the mismatch between the PHY and the mvpp2 driver in 2500BaseX mode.
> 
> Ah, mvpp2. This is one of those cases where I think you have a
> disagreement between manufacturers over 2500base-X.
> 
> Marvell's documentation clearly states that when operating in 1000base-X
> mode, AN _must_ be enabled. Since programming 2500base-X is programming
> the mvpp2 hardware for 1000base-X and then configuring the COMPHY to
> clock faster, AN must also be enabled when operating at 2500base-X.
> 
> It seems you've coupled it with the mxl-gpy PHY which doesn't apparently
> support AN when in 2500base-X.
> 
> Welcome to the mess of 2500base-X, and sadly we finally have the
> situation that I've feared for years: one end of a 2500base-X link
> that's documented as requiring AN, and the other end not providing it.
> 
> Sigh. If only the IEEE 802.3 committee had been more pro-active and
> standardised 2500base-X _before_ manufacturers went off and did their
> own different things.

I also checked the datasheet and you are right about the 1000base-X mode
and in-band AN. What worked for us so far was to use SGMII mode even for
2.5Gbps and disable in-band AN (which is possible for SGMII). I think
this works because as you wrote, the genphy just multiplies the clock by
2.5 and doesn't care if it's 1000base-X or SGMII. With your patches we
might even be able to use in-band autonegoation for 10,100 and 1000Mbps
and then just disable it for 2.5Gbps. I need to test it, but I have hope
that this should work.

Regards,
Stefan


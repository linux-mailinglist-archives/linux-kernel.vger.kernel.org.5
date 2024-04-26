Return-Path: <linux-kernel+bounces-160559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4198B3F24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1B1282F54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3920A16DED9;
	Fri, 26 Apr 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hTuCAS+Y"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3862230C;
	Fri, 26 Apr 2024 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155492; cv=none; b=fxt4YNT4yDJi7+De9o5anB1NP+iEea9hrLpCHfwhrgc63fIW+FKehkZxLJ3vPYqF4NvitBouEW6QAqNJfYKvP8e/IRxfkw8B7DRQ5LzR/tVScMryXbYO7u4o5jH2Y3lLUaTjgDENF+fX94sYAe7L2bQcyepo2LMa5gJvl9/yAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155492; c=relaxed/simple;
	bh=O9XSwSp510W6WOyoXgJ1ualqTyt8QGmV84/lupByN3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxdEza9oVYQFWb90III5+k/ZIVCKJjUwILQc26ceFDPCOFBwriMef9LfdTLPWsIW8m23LyGPOd4bU+CrbE2DpBRYaF0LQS3DwDiJ3nGEWt8+fOcldJ5anVb73Y08FY9vtCD2rgLfU19eDJ96rc9H9+wWOQVu0MAH+0GN5Iib0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hTuCAS+Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=scI06n3r0oxha4J8FtQmpFEaYl4EwJiQYGgGjaGKA/k=; b=hTuCAS+YH9+3J1v1Ga2yWSCxzh
	au6G1rD9EPaUKXdsK9GlhcOVjkt0L60gLi9Ui4U4SL/nthYiGr0nYo0yl8meyBRzGRe2G6GNaiaEF
	vap4duzUFl2pUk9Dj0UCX21lW+utyuFAZMPg0u3GsSzyg3xrSkww0pEAlBgP/P+uz6kc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s0Q95-00E65B-Oi; Fri, 26 Apr 2024 20:18:03 +0200
Date: Fri, 26 Apr 2024 20:18:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Message-ID: <d0426bb3-1f40-48ed-9032-6ffdce455cd4@lunn.ch>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
 <20240414-cn9130-som-v3-4-350a67d44e0a@solid-run.com>
 <3958052d-fc09-4c4c-a9e3-4923871cff44@solid-run.com>
 <fd466583-3221-4b94-b66b-18840615fb71@lunn.ch>
 <15b79794-41f4-43e0-888e-286ca1fc4321@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15b79794-41f4-43e0-888e-286ca1fc4321@solid-run.com>

> >> Colours are similar to RJ45 connectors (yellow, green),
> >> and are intended for the same purpose: link, activity.
> > For the switch LEDs you used label = "LED10"; Does the silk screen
> > have similar numbers for these LEDs?
> Correct, on CN9130 Clearfog Pro DSA switch, all LEDs are labeled
> individually on the silk screen.
> 
> The SolidWAN SFP leds are dual-colour leds with 3 terminals:
> anode to 3.3V, 2x cathode to gpio-controlled transistors.
> They are labeled on the silk-screen as "LED9", "LED10".
> 
> Duplicate labels are not great, is there a better way?
> old style "LED9:green" e.g. ...?

So you have copper LEDs and SFP LEDs, each with the same silk screen
label? Maybe put 'copper' and 'sfp' as a prefix into the label?

       Andrew


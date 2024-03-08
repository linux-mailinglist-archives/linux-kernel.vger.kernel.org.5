Return-Path: <linux-kernel+bounces-97039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 028DD8764BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817F01F21EA0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE201F944;
	Fri,  8 Mar 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YagOmkjY"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1110A34;
	Fri,  8 Mar 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903376; cv=none; b=YaHZNWq4QnSS+P92qNjZughaFfwwg8qjuOCnQJ8guJWquYRQCikT7aRnRvkqigamD3nNK+tGIEQrdoEbIkgHcBPjMmfZMNqza1UvktOdu2WEiQF+nlSV6/je1lEksOqzTo58WD4d9OZOyZITsCJP6Kef4XnDl/mlIKiIc0m61r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903376; c=relaxed/simple;
	bh=3s7B61u0O5WBb5LsTp0Swao4U/4c4g9vSPfWy89nIWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGJQejoZKNt/3LJzjTUzkSm/Aw30+60scvcGEQTPUABanaoszRTtVbN8P6ymz2Ag/a07j7XlfLzeD5ACu5wDTRoADwd/p2vnW67vfFxyA7UYNixqDxxnRTUK6pHzJwTxZHtkcR6wuBqEpQFp9CQbuMyPbrFXCl4PemrxNgV1tEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YagOmkjY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so305129066b.2;
        Fri, 08 Mar 2024 05:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709903373; x=1710508173; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CMhlkwPS1UfeE3borfMPgZJTbQuPTDfnGxPpeT682Q4=;
        b=YagOmkjYmVyqg4bNo9ahIG/xHG3MVfHNSiLyr1atOKx46loPFHUPnACb1FoMQgwEHv
         w5FzTwN3ULwO/Vl5vx+Ck9yBaoNjSjdpSZEIpUcn3ZDTetiKwRkmHeVbKPhfSxb1Ubq0
         2JHjAsiyi1M84p3l3ZmZIbeWKOYgV1mw8L6mRvGmW1kNsLJ3Ci07ZQC1ALI5jydVETbV
         MuaNFuoGW5SaY9PEHX0oUjA804XGnIt/HVJKbsj7bPN+5fFUks5FSi7+YNXTNcOHkL1P
         nY5VeiPQwEZSQAyck17FxIivbrHNnsblclLp1MZ5TN9wIJ76zEFZFMFgf8BPYIvsRmc8
         GYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709903373; x=1710508173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMhlkwPS1UfeE3borfMPgZJTbQuPTDfnGxPpeT682Q4=;
        b=be8nLEirQLMX+KSAT3E2gzmU/sVdWRT5JxIeAwU1VMGG40YcduZlJPHOoL0S9CcOTZ
         36tEjUym7Gg7KwJUzt4R9WjHPzzBf5BkvOcqFsUDMG6uT/JEomnzw1mFp+r+763IVC8S
         GZEr+KBlmMA99w9QTjNQuDPprMUT5I0QmO7CzkT/SaNxZ3qsDl/qcH9qOkR9RpJ8ePV6
         mXV6s4RKHTMWwKHTaFparuXMlbwDmugwHnMzg3Y8u0fJDoTuOYxsyJ/v//a52HBqQbvf
         gZfFuIVFzMtp1+gIDj1bD8uxvxYeAio6sPBaxQnxIKR1ba+rUNWffSww49V+mZ+5/HEk
         yvvA==
X-Forwarded-Encrypted: i=1; AJvYcCU5lhIr6NKUMXbNJhYKRq/lRG5di6bmyVxr7jjPFrjXBcsDZeBoSWUItyaa316c0Hs5xGw83MRPz9kS0v0eWThq8Um1z7X/RpClgIHvcdlO74zhTyDHIymCmn7TroHoINA+1Wol
X-Gm-Message-State: AOJu0YwNZV376iKWSxCuaV4Sb107NfRFvQxRc639D6ZuQItg6zzYYzci
	3uGxEUD6ikfxf92fnh0ifmMii6vz0/vmKfiwcsFjjdJ1izxQx5W8
X-Google-Smtp-Source: AGHT+IG9L+YxJlNmGM7H3N4HeGBKfiDWeTH8NtLnM3OaLsUznhnmeDvZOltK31ipxfYzBQr9lTpeeA==
X-Received: by 2002:a17:907:c306:b0:a45:f866:4bd8 with SMTP id tl6-20020a170907c30600b00a45f8664bd8mr199026ejc.60.1709903372731;
        Fri, 08 Mar 2024 05:09:32 -0800 (PST)
Received: from skbuf ([2a02:2f04:d207:f600::b2c])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709063b0700b00a43e8562566sm9229267ejf.203.2024.03.08.05.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 05:09:32 -0800 (PST)
Date: Fri, 8 Mar 2024 15:09:29 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 07/16] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20240308130929.4kgctmtzecbpajao@skbuf>
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-8-paweldembicki@gmail.com>
 <20e792ad-33ce-43a6-8ed0-8db6e1a25c27@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20e792ad-33ce-43a6-8ed0-8db6e1a25c27@gmail.com>

On Tue, Mar 05, 2024 at 03:51:11PM -0800, Florian Fainelli wrote:
> On 3/1/24 14:16, Pawel Dembicki wrote:
> > This patch implements VLAN filtering for the vsc73xx driver.
> > 
> > After starting VLAN filtering, the switch is reconfigured from QinQ to
> > a simple VLAN aware mode. This is required because VSC73XX chips do not
> > support inner VLAN tag filtering.
> > 
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > ---
> 
> [snip]
> 
> > +static size_t
> > +vsc73xx_bridge_vlan_num_untagged(struct vsc73xx *vsc, int port, u16 ignored_vid)
> > +{
> > +	struct vsc73xx_bridge_vlan *vlan;
> > +	size_t num_untagged = 0;
> > +
> > +	list_for_each_entry(vlan, &vsc->vlans, list)
> > +		if ((vlan->portmask & BIT(port)) &&
> > +		    (vlan->untagged & BIT(port)) &&
> > +		    vlan->vid != ignored_vid)
> > +			num_untagged++;
> > +
> > +	return num_untagged;
> > +}
> 
> You always use both helpers at the same time, so I would suggest returning
> num_tagged and num_untagged by reference to have a single linked list
> lookup.

vsc73xx_port_vlan_filtering() calls vsc73xx_bridge_vlan_num_untagged()
but not vsc73xx_bridge_vlan_num_tagged(). Doing as you suggest, while
keeping the code otherwise the same, would imply adding a dummy
num_tagged variable in vlan_filtering().

Though I agree it is generally confusing, because "port_vlan_conf" is
assigned based on inconsistent conditions in vsc73xx_port_vlan_filtering()
vs vsc73xx_port_vlan_add() vs vsc73xx_port_vlan_del(). Namely the number
of tagged VLANs is taken into consideration only on vlan_add(), and of
remaining tagged VLANs on vlan_del(), respectively.

Maybe something like this could help?

struct vsc73xx_vlan_summary {
	size_t num_tagged;
	size_t num_untagged;
};

static void vsc73xx_bridge_vlan_summary(struct vsc73xx *vsc, int port,
					struct vsc73xx_vlan_summary *summary,
					u16 ignored_vid)
{
	size_t num_tagged = 0, num_untagged = 0;
	struct vsc73xx_bridge_vlan *vlan;

	list_for_each_entry(vlan, &vsc->vlans, list) {
		if (!(vlan->portmask & BIT(port)) || vlan->vid == ignored_vid)
			continue;

		if (vlan->untagged & BIT(port))
			num_untagged++;
		else
			num_tagged++;
	}

	summary->num_untagged = num_untagged;
	summary->num_tagged = num_tagged;
}

. and use what you need from the summary.

> > +	}
> > +
> > +	/* CPU port must be always tagged because port separation is based on
> > +	 * tag_8021q.
> > +	 */
> > +	if (port != CPU_PORT) {
> 
> Please reduce indentation here.
> 
> Have to admit the logic is a bit hard to follow, but that is also because of
> my lack of understanding of the requirements surrounding the use of
> tag_8021q.

It's not only that. The code is also a bit hard on the brain for me.

An alternative coding pattern would be to observe that certain hardware
registers (the egress-untagged VLAN, the PVID) depend on a constellation
of N input variables (the bridge VLAN filtering state, the tag_8021q
active state, the bridge VLAN table). So, to make the code easier to
follow and to ensure correctness, in theory a central function could be
written, which embeds the same invariant logic of determining what to
program the registers with, depending on the N inputs. This invariant
function is called from every place that modifies any of the N inputs.

What Paweł did here was to have slightly different code paths for
modifying the hardware registers, each code path adjusted slightly on
the state change transition of individual inputs.

This was a design choice on which I commented very early on, stating
that it's unusual but that I can go along with it. It is probably very
ingrained with the choice of the untagged_storage[] and pvid_storage[]
arrays, the logic of swapping the storage with the hardware at VLAN
filtering state change, and thus very hard to change at this stage of
development.


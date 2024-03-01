Return-Path: <linux-kernel+bounces-88640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DDE86E4B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFE7287362
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8B70CBE;
	Fri,  1 Mar 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYYzBIUr"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E15070CAE;
	Fri,  1 Mar 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308203; cv=none; b=lWbBd+maU8eV6EncGB8FVpkpM7eJVsU9tIhm1nw89KN6zkWuiB32Ifa8hXmgllUSpe0lex1IRIOs+sQO+O8DAeS5YeO1W3K06WqqSvixJrl9WkImWTSfvkboAPPqAeiJuUYydK+26walsnE+djbnuyca3XKWC/c5p2b0/C90Ie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308203; c=relaxed/simple;
	bh=XItwrjtV3hvnmFR69chzCPc6dcE/80sccqPKn/LdoS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQaOOqPJNYEcmAtIYyR5ucQ9ff8+reTZlqckEZvbS+GydHk4x0O5BsE7tz5fOfQeuCGIyv6uZNiThBJDzML4VvekgC21KTdU8tkfA66Zs+f0Y+ZYfIurq5hWRaBosePOcNDiH4uQ0AiPInzuncEVZqRHLyl5Jdh8/b0fk8TqhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYYzBIUr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3e552eff09so313340966b.3;
        Fri, 01 Mar 2024 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709308200; x=1709913000; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KjS+ikwQmfyolO6cKdEt9cJp/PblUq1A5JzypvMz5Ok=;
        b=DYYzBIUrJ1BTZxFy8LNV2tf0g8k6Ey0do0lmSv+Us9bkbG5QdrOrBm5r+qQ3sw1ACL
         kmk6ZGsiqjNil0Sk0vy6g6VZg0SSY6+S3YMzo4zFHJ4mxk7oBHtIpaXxpd6XFXvcga4d
         8USvGHf+1QO7YYxEG6E4IN1/Pq2rKzGLZxxTcw0WYHqu+oWKhEVkCyuHr4V+qVQV/Lcy
         5iQuhOQ+JTTr4uvB6gJVAXLRtERs/lcBpW7B6ZxKdKnfTZKYoEGqkadfkDso9HWyb/g3
         NCOnxc5vimpoCA3J57CVtP+9UhHVmmXqOzM14tx4WLa3R7/NOqrLMvpbYJXACj7nN423
         1D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709308200; x=1709913000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjS+ikwQmfyolO6cKdEt9cJp/PblUq1A5JzypvMz5Ok=;
        b=PHZLGXGdiUhHSgr9xv+iOG9UyuUb2SiyzxpQBtlZhLC3ewJQOJhC9YBUpphjT+10V0
         0UTGprBFd4Q2sMFfK2WZ4MZSllPu+IcNXyRgKSlcAJypBtRSPaQhr9Q98TmfZ+SYJu8S
         mAjSxh0iYHl0VQ7ZZGI67ep5Fq9Cw/3FNUAZYOhJ85xvq2tfveOLdrYRenUl8ImnY2MM
         le8LTaslLtZfjHn1BTa6XHRRzDtWHwF1uFWxvdv7Q0MXUPQ7uxZr6SkyBNyTXWsYXfl0
         aLr34ShNBY5RNn5osmM+ujeV5YSktaselscuHoXTxaVdwubVexdAOmvCyLcSp/aeLiz7
         HZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVihyljcfJa8ubj6RTxJTcJfnNXrk0UFpZsIO9zMtt6LoBWqbORy5O05h6BYWeq4TAaHKc3yPVVpJpeHkNCmZUGnj3PNS/F1eUD0JncwAwko1Xw0mOjUCZ82Hq1+nwI3pjdCHNE
X-Gm-Message-State: AOJu0YztZEjpkOjiBzvRT7X4tu+XfBU+ClteD4ik7BEvFSUH4Vgc4yLJ
	vOvqtJUhMk87BMj5n43RK0Vx/jLvU421ZAiqWS3q71gbToLTNUJA
X-Google-Smtp-Source: AGHT+IHvm1GBJ8J2+MUD2LNgnzmTnjkDC0xWxpm5RSn9D5dRqN7kFFuEijXRx7sXSMyV1bT5OsJxYA==
X-Received: by 2002:a17:906:e08d:b0:a44:731c:bace with SMTP id gh13-20020a170906e08d00b00a44731cbacemr1824851ejb.35.1709308199989;
        Fri, 01 Mar 2024 07:49:59 -0800 (PST)
Received: from skbuf ([2a02:2f04:d207:f600::b2c])
        by smtp.gmail.com with ESMTPSA id ty24-20020a170907c71800b00a42eb84c7c2sm1821478ejc.142.2024.03.01.07.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:49:59 -0800 (PST)
Date: Fri, 1 Mar 2024 17:49:57 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	=?utf-8?B?U2FuanXDoW4gR2FyY8OtYSw=?= Jorge <Jorge.SanjuanGarcia@duagon.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"s-vadapalli@ti.com" <s-vadapalli@ti.com>,
	"rogerq@kernel.org" <rogerq@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net RESEND] net: ethernet: ti: am65-cpsw: Add
 IFF_UNICAST_FLT flag to port device
Message-ID: <20240301154957.xex75zuijptswcf3@skbuf>
References: <20240228111300.2516590-1-jorge.sanjuangarcia@duagon.com>
 <20240228200516.1166a097@kernel.org>
 <03bf515c-9f90-487c-ecfa-90d407dc5d86@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03bf515c-9f90-487c-ecfa-90d407dc5d86@ti.com>

On Fri, Mar 01, 2024 at 04:39:50PM +0530, Ravi Gunasekaran wrote:
> On 2/29/24 9:35 AM, Jakub Kicinski wrote:
> > On Wed, 28 Feb 2024 11:13:23 +0000 Sanjuán García, Jorge wrote:
> >> Since commit 8940e6b669ca ("net: dsa: avoid call to __dev_set_promiscuity()
> >> while rtnl_mutex isn't held") when conecting one of this switch's port
> >> to a DSA switch as the conduit interface, the network interface is set to
> >> promiscuous mode by default and cannot be set to not promiscuous mode again
> >> from userspace. The reason for this is that the cpsw ports net devices
> >> do not have the flag IFF_UNICAST_FLT set in their private flags.
> >>
> >> The cpsw switch should be able to set not promiscuous mode as otherwise
> >> a '1' is written to bit ALE_PORT_MACONLY_CAF which makes ethernet frames
> >> get an additional VLAN tag when entering the port connected to the DSA
> >> switch. Setting the IFF_UNICAST_FLT flag to all ports allows us to have
> >> the conduit interface on the DSA subsystem set as not promiscuous.
> > 
> > It doesn't look like am65-cpsw-nuss supports unicast filtering, 
> > tho, does it? So we're lying about support to work around some 
> > CPSW weirdness (additional VLAN tag thing)?
> 
> CPSW driver does not support unicast filtering. 

Then the driver can't declare IFF_UNICAST_FLT.

Why does enabling promiscuous mode cause Ethernet frames to get an
additional VLAN tag? 802.3 clause 4.2.4.1.1 Address recognition only
says "The MAC sublayer may also provide the capability of operating in
the promiscuous receive mode. In this mode of operation, the MAC
sublayer recognizes and accepts all valid frames, regardless of their
Destination Address field values.". Absolutely nothing about VLAN.


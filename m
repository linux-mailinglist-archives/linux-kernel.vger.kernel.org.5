Return-Path: <linux-kernel+bounces-133583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE09189A5FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F21F215E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584D7175543;
	Fri,  5 Apr 2024 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGFEWxMz"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4EC171072;
	Fri,  5 Apr 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351709; cv=none; b=Qgr7yKnEIM3CLNuByuuNlNSoAJEf/CPsicNCKvi+OeSws0c5govcw/JkqF1vPRpCnwTaNOHJraSyY9KrgGYk1kelbPamHh5vxPJKOf2/Kc8tf87bJkYPfhMyNDBvUT3oxtIVeR/C/5297kSuW9bPd5rSV08PPl9Qp+Z//FnD3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351709; c=relaxed/simple;
	bh=HeNEhIGrzcGEZrocdkVTvsddhLnVgsVIbEn+zKxLMn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/migCLxZDl/p0UBlJlVCKaawu5U87Dp101ANqzh1oGDeiho0TkIAGRdmNmbLazEIsGOcv6iMn/lLP55h0tqKwYBBQyIZhTGVHccFnBBwgbWrce9MpgRsmZQrZc+pPJqTw9FJjwvB43n8366em54Kq2I6O5j3r22sx/4OM3gFfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGFEWxMz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d82713f473so45028801fa.3;
        Fri, 05 Apr 2024 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712351706; x=1712956506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2vV+ljPu+LnmovF94XbYF/3sqJWOm/WOolsuT6CmUg=;
        b=PGFEWxMz4tQcFt2BYityYj/xUahJMbYAefJcDE2F9KDpTvIaLc0I40iksU14ciSkOR
         iRmR0+EAzxQzRamygaE++qg0RB3LjRia0QaaR+0DItadnws7oO3gQFoXbuBoDBgKLi9l
         JkRWFb0jlJ0zNiwjKOMciRx2ro1iuA4y377pb6Ls3/clh4FLxVz1/tIuGIQACwdj55wV
         Pgli/GHyDYgOjNrkhNTKZfDVkLhBt9+v186m/5+svVvJxMbcKppiqauAJaKY2BqbuPrP
         6qcnpX6fdwA1VYNkK46EIidKc0sr2nzblzHU/mbeK/uRnt2PzqNlUH18euVmtcrm0MqN
         m+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712351706; x=1712956506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2vV+ljPu+LnmovF94XbYF/3sqJWOm/WOolsuT6CmUg=;
        b=JNkCAX2TU9vo6Gp1E3gw/4XZkz9Ulnel0AvvvqPxRe6ocX5ISKypbqvcrn3ZlrwNPJ
         Pw99jc3dXRdI/hbZYWezlpQcKX6M3mmVozzlWZIwQkE7Q2zQEnXaaodmT4Slx+5iOUZf
         Hu5ZbaYmh8b+nRFY+SLWY9RSPwdPyIIKdSpk+21ASSte06T4D2H00n0GtHZ1xhnaOQNW
         E3WiKPf2V+v+vyzc5cwBr72uC5/noXhTBCIa8rpHDc2nFWc7QmYy4Q8sKjn/MIw8CTsN
         lWOeLuu+gvx3d1L5/4b8MyeGFXszySUnOca8bIzKvkr4ZmDp0h5RBDE1P2CPUHSyWHk4
         Qfbg==
X-Forwarded-Encrypted: i=1; AJvYcCXS/72+27TeE7RuwdOd+NdROj6BiE5cvjLUnHiBauO5C4axLVYAKAOlNCF9ddK6J6HVL/DVM9SAQ0JOYiXUR0QalilhYe9LBi2H5DREqnIBtVGzfpR3TUXiNGfuLI5qmPVWCi1i
X-Gm-Message-State: AOJu0YxGb5qweokLB7PTae3j4inL3g08cg9EbUW6LEK8OQx3H88yi1q3
	sx26TJOcsnFyZ/dnyhYczZ2clV9NCJ5TJvhh7MjoeHuMaBlyTnXY
X-Google-Smtp-Source: AGHT+IGvqldN6HhRWWnSY5+EnUP2pam16riYtoUm7Q1wDs8Ky3sSiGU3pUJdfw1lLyEvKoUGXAwYHA==
X-Received: by 2002:a2e:8ed5:0:b0:2d8:6b3c:1eb8 with SMTP id e21-20020a2e8ed5000000b002d86b3c1eb8mr2430875ljl.4.1712351705883;
        Fri, 05 Apr 2024 14:15:05 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id de26-20020a056402309a00b0056c1cca33bfsm1169683edb.6.2024.04.05.14.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:15:05 -0700 (PDT)
Date: Sat, 6 Apr 2024 00:15:02 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Message-ID: <20240405211502.q5gfwcwyhkm6w7xy@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
 <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
 <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
 <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
 <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
 <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>

On Fri, Apr 05, 2024 at 04:22:43PM -0400, Joseph Huang wrote:
> Like this?
> 
> bridge link set dev swp0 mcast_flood off
>   - all flooding disabled
> 
> bridge link set dev swp0 mcast_flood on
>   - all flooding enabled
> 
> bridge link set dev swp0 mcast_flood on mcast_ipv4_data_flood off
> mcast_ipv6_data_flood off
>   - IPv4 data packets flooding disabled, IPv6 data packets flooding
> disabled, everything else floods (that is to say, only allow IPv4 local
> subnet and IPv6 link-local to flood)
> 
> ?

Yeah.

> The syntax seems to be counterintuitive.
> 
> Or like this?
> 
> bridge link set dev swp0 mcast_flood on mcast_ipv4_ctrl_flood on
>   - only allow IPv4 local subnet to flood, everything else off
> 
> ?

Nope.

> So basically the question is, what should the behavior be when something is
> omitted from the command line?

The answer is always: "new options should default to behaving exactly
like before". It's not just about the command line arguments, but also
about the actual netlink attributes that iproute2 (and other tooling)
creates when communicating with the kernel. Old user space has no idea
about the existence of mcast_ipv4_ctrl_flood et. al. So, if netlink
attributes specifying their value are not sent by user space, their
value in the kernel must mimic the value of mcast_flood.


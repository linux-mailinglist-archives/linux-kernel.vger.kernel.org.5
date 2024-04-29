Return-Path: <linux-kernel+bounces-163060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879878B6461
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BFE289A96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF65181B83;
	Mon, 29 Apr 2024 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Loc7/Yiw"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81A3C482;
	Mon, 29 Apr 2024 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425292; cv=none; b=E5CihwSefPWHHgG34RedLV3JsleDDNgugzh/kUn/nsT0aO0NxkTJYuImMS8vACLVVBD6rjRZVNo09p3o/DM7MUXvrwwkf+csl3OGKdRznE76KMA3TCNt98ANLapaBu8s5zvRe62HRegQI+E+HZjERcbCfKglDlfN82u/JgIAspE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425292; c=relaxed/simple;
	bh=tiMvJprnoucEZ2mGwOGpl8nwGTZ2AMZh8ljot5HUHYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=honBJkeQVMokNTqYBhVWG60KmYGxWMkbsxaWc+wu7NIe7GCHZpmm2u/R2X5utdYWK7hI5Xkw54pix6IPN5o0AkqpLmlTPJtdSeNbLA36C1qPd6eBtFDriTH8dilTS8KVE1TcddI+AIajTFhdxwXhVe9yb/806k1TDJcxIwp53Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Loc7/Yiw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a556d22fa93so540426966b.3;
        Mon, 29 Apr 2024 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714425289; x=1715030089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GInBtKS5qcKC98Fjt9JiRdmtAQLI0mcNnSpjf6/+G2Q=;
        b=Loc7/YiwLtnwAjHAO3HzkeVUPdO9zyZj5Gdb6c3ppRPq/yE4WPdWOxuo5a5+mIX2jD
         zHon350BJWCg+FcHjg+oJs9E6VS421AjfWRVG5l874M3LlaDQvHNTX88ZGwBRWMTmjiP
         8J1GC0eQZoNL9Vosgi5v8xjszqgEcw72xzBcTeuXPCiyqPLJfhAHxLTd70nbz+FLjE2T
         1AzBqvB8+udKh1IMI3nuqq50XneJzYtqVjyS/7tYFppzPAAiV+BXdHezoc4gNlI0JVdM
         egFhvagezenz41QZCEtC1b9/kMjMPdpw/hcieRFY3Q2OJyYTJTHSg9QaHfks2UMPRAIL
         UuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714425289; x=1715030089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GInBtKS5qcKC98Fjt9JiRdmtAQLI0mcNnSpjf6/+G2Q=;
        b=Tk4wotHF2ScbrQLCPtjNAddM1AdTnlUnJ7x11gAMVEsWZ2JMB8TeR2qK+4062djeP8
         jdTcHFy+zkjuBs5zDdrkidnm54oDQZxR/UJEfIFO286wCfidRHTr8u5WgoXXv7RfsaFs
         0JRK63pDnEJKuuwms50r4WbyA7UtqpJk12Wl9BBPhinlunrWRHguTy3U21fN8GNVQ9E1
         G7ZZ7vNxX1ZpN8Iq2URgdr6IAuFjcp57st6Nx8bB8OUbOUkRNNYi/5VJ54M2M3voqY/y
         eVtWHis8WlsoLuxEyJSolsJPu4jVAoHM3XG6O1nt2tkMtGLTfR7ol6j1Oyd1hGW4lQGa
         k1fA==
X-Forwarded-Encrypted: i=1; AJvYcCX+oPh37jZxwsnAvdYD5CfbyWxpnnpFYRaVhd7loyZSgbspny74crKXlQKnF8RrPQEsZJj+lLwEuyg5L7Hm+pLAQ7oiQFVWN2HZHxdsG/NOyMpDYnM1DQqquE0GWFlTZQOGukN7uy502GPwiUm4JZce8U7KrLxruhJY9Ip1q+D/
X-Gm-Message-State: AOJu0YyFqp71BsKWzc9afXq9vCqTBT6Pp21S7c1FPsdwnNpTqKcppoKl
	stuFSyoInrO0hsiNx2pXT2tnsvP16CuoX0MgfliheNVb8Cg/3oCF
X-Google-Smtp-Source: AGHT+IHF6pToBPXo1Tqa6vaxgqz49Q6gw8+6m3MaTXwNMNGTW1Vb68P41g2q4nGT68Bk2JZLrqKs2A==
X-Received: by 2002:a17:906:19d6:b0:a58:bd52:38e3 with SMTP id h22-20020a17090619d600b00a58bd5238e3mr525055ejd.57.1714425288919;
        Mon, 29 Apr 2024 14:14:48 -0700 (PDT)
Received: from fedora (host-95-248-171-25.retail.telecomitalia.it. [95.248.171.25])
        by smtp.gmail.com with ESMTPSA id m16-20020a1709061ed000b00a51c0c0cb86sm14286735ejj.22.2024.04.29.14.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:14:48 -0700 (PDT)
Date: Mon, 29 Apr 2024 23:14:45 +0200
From: Francesco Valla <valla.francesco@gmail.com>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>, fabio@redaril.me
Subject: Re: [PATCH] Documentation: networking: document ISO 15765-2
Message-ID: <ZjANxXyipBxBeCkY@fedora>
References: <20240426151825.80120-1-valla.francesco@gmail.com>
 <20240426151825.80120-2-valla.francesco@gmail.com>
 <CAMZ6RqJ8x1=SeZRyR8PBCHzOy7qjB4xPs2Uk4mHLHOm_Usy91A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJ8x1=SeZRyR8PBCHzOy7qjB4xPs2Uk4mHLHOm_Usy91A@mail.gmail.com>

On Sat, Apr 27, 2024 at 10:39:11PM +0900, Vincent MAILHOL wrote:
> On Sat. 27 Apr. 2024 at 00:23, Francesco Valla
> <valla.francesco@gmail.com> wrote:
> > Document basic concepts, APIs and behaviour of the ISO 15675-2 (ISO-TP)
> > CAN stack.
> >
> > Signed-off-by: Francesco Valla <valla.francesco@gmail.com>
> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> Two typos/grammar nitpicks (see below). I am giving my review tag in advance:
> 
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> Thank you!
>

Hello Vincent,

thank you for the review!

Regards,
Francesco



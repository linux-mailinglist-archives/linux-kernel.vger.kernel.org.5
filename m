Return-Path: <linux-kernel+bounces-48725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F35684605A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50318B2EA58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154D184055;
	Thu,  1 Feb 2024 18:47:47 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44384037;
	Thu,  1 Feb 2024 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813266; cv=none; b=nGUJ/P5Gw30O+qNDM20AJxKf9J849zO+Rc+UyKltxgS7zHahKRXY9K6K7+mWa++eeY0JDDDl6vOzyBYOYk5ZDgV7Wi3NO01HxBT4iEF+Ego17rKJFQ4h53va/d1IcqsybQmFSyrK4J+0yiTXSbdrp+TW6UEYk4z/LSNEByYmseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813266; c=relaxed/simple;
	bh=KzRG5/3+Zn4ylwEgNyG7fzr3cu5fSayPuglX8fgaZS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qt6bY++5D+5pb1IQBAusBnn0z96AU4YvjDgsO0g1I5TZJyO6jPPc3b5l1CYq0VdLqAt+0tQ15OwZqRTxLgn3vUPYYf7MrPbuy2X31NjFLch2DSOIoJs4S9S+rUw9QhV7zyzWA1XOWR4ybhnFua4zLroOUpDQGPT4MneWrlhcOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3651c87ebbso173326466b.1;
        Thu, 01 Feb 2024 10:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813263; x=1707418063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/+inzAO8J/bfgRV8xpEV2w9a4Nnu18b5n0d28ScrYg=;
        b=DF1NdOdeyMLhAQXwoi51pRRs5UBRqjrgf0U0o6DtT5osCMO2F04HAYf31uR3Z/aTVd
         quPhY5zQYEQRlB4iguml21WsZ5oMvSOHJWhdzOXcB+NK2PCRfSCGlcPONfFfhg+FTJ2r
         32HOVdltZcInNnv5mBkWxtDiDOThL04uzcJNrX4lJhdS6JzoB5elb1/g8OjhG6F796Ok
         VEoXuLfWhEkYgx5f6SYlrim5kF0ZTqJtNMZA0z2OQqG5VKM+gXF+C/LrlZsYafX81VfJ
         Ob8pF994tzqiG83fD2u6GsswXZ3clNvGKSDk1OXjto20JKveuWSDnDd05bdVxh50fpKh
         ww8Q==
X-Gm-Message-State: AOJu0YwbUwQ8bwZHeZjuscFAzpFVu7MvEWl+xW02QGgDgjPAUtmkWkNF
	aSXhHV2tsEV/YcEK8VyzAZsDf/LlpE+/IrlefUjt6IxZK6g9GvAn
X-Google-Smtp-Source: AGHT+IEuFNJ0um8lJmtLaUTkidfM6Oxtvg6qL3kZQ0jq9J5nBg9kWGeSq8f054sNz1dH28D7gpk+ZQ==
X-Received: by 2002:a17:906:b754:b0:a35:fd93:8be3 with SMTP id fx20-20020a170906b75400b00a35fd938be3mr1907295ejb.2.1706813262948;
        Thu, 01 Feb 2024 10:47:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW+ZLGBpv9fEz87eWTaRL2IT4g6iN61e4loLKV0zAgiOa1Gcqxmf4iqacBGqZypDZoSPZwsdJM7fzApFCt8ptYxjxL0/NlT9tbHUf/CToNk/VudaY0QZfEWQpsaq6zLPfkiqrBI7+6BMsiwiNm25gTpnjILAnv6yVQXU7zkEDPJqpcgGF2OauEnxgFTYg==
Received: from gmail.com (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id pw8-20020a17090720a800b00a349d05c837sm55033ejb.154.2024.02.01.10.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:47:42 -0800 (PST)
Date: Thu, 1 Feb 2024 10:47:40 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net: dqs: NIC stall detector
Message-ID: <ZbvnTNT28EpoGSdU@gmail.com>
References: <20240131102150.728960-1-leitao@debian.org>
 <20240201081432.3fa70c6c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201081432.3fa70c6c@kernel.org>

On Thu, Feb 01, 2024 at 08:14:32AM -0800, Jakub Kicinski wrote:
> On Wed, 31 Jan 2024 02:21:48 -0800 Breno Leitao wrote:
> > Breno Leitao (1):
> >   net: sysfs: Fix /sys/class/net/<iface> path
> 
> Let me take this on in, but the other one is not a fix,
> so it has to go to net-next.

Sure. I didn't know how to split the dependencies. Maybe I should have
sent both of them to net-next, and you would cherry-pick the fix to net?
Is this a better approach for next time?


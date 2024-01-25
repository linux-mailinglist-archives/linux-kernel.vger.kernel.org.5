Return-Path: <linux-kernel+bounces-38352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FFD83BE36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D071F24553
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2311CA80;
	Thu, 25 Jan 2024 10:01:13 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61AF1C696;
	Thu, 25 Jan 2024 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176872; cv=none; b=TqJFfdVQbGk7R3oHsDrfCkAQdyac/5Ttj4lfpkoRvRJVD0R4JGL5cVJwWWM7VYnCgybxvXBppGlJDDQqI5Eb8/UTYaLf/rYrOpC4g/pN0wK4BoZ2IXpsij/pdRDXZSWvaSFH9zI3Dm7tY6ZMtM3ONg3SY+ouHcERsslS1HKOSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176872; c=relaxed/simple;
	bh=+s8uT2U1rJ0L9rQpMPQrQHHgk79B6+peobCM8mVFSHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsFI8FWuAL43tgmNCeEKOREz69qIXnrLFu7TyXHF3XxTyzuX8kp7dGxqgDjrh7P6wn716Yi+9N5HFR6fPh8TZymIjboeyaXD4xXbgjDIzUvv8tWYnB1wqhz9vttbn15p+Gr5T4nm1tQDy9+AY3QqXFyQTJNYQuAffo3SprfRdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so8022994a12.2;
        Thu, 25 Jan 2024 02:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176869; x=1706781669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGv4xyNT9XM8KOh4SVQvuRvopYGtVSujqzpR+SSidcI=;
        b=mj/v+nnOMcUNsEVCMeWenx4+mvbxS048dUxKapu87/U9cQFkPw6VpRCIFmt3V/TjE6
         jDLtaDQclXnmxhicRQiidi5VEKUeDN6CZwr50IgTGKzLegY3nJH925iLaiYOo/AEDmpQ
         1vpKsX32kZlGqSXtsWfqj2fvkojGGtTQK5RWe/R8dgZ3530NnkRxx5W2zfEjyMQZf9/L
         Bv21bzX2K1rn10QiK3IC5qL9zly+Nag8DLdy1MnUdC0xwV007aNW7c+ZEGwJm56u5NcK
         hqVMeZ20Qx4MZalRQFbMMw2Q+sKYxu0zOVU2DCrBh4zVnC2TvP2TmCEI+S7ciPpW1l9x
         qNHQ==
X-Gm-Message-State: AOJu0YwzIw5cWnEby+OCve4B3zKRuqlIGNHLmDNhn2YoPi7+YtPhaBX9
	/efHQhbGwptMYgdHPORFFLrRXxyl/5jYdgVZJiiiww3RO1hUO6hHMnQbPAWb
X-Google-Smtp-Source: AGHT+IGCUvY9IYqF17ayGlcWq3X/gd4k/ledT4kTug2vugo1hXLVNqcGIU8jCYLtIPFXNcmVqcZUnQ==
X-Received: by 2002:a17:906:99c2:b0:a26:b86e:2b0f with SMTP id s2-20020a17090699c200b00a26b86e2b0fmr347032ejn.127.1706176868802;
        Thu, 25 Jan 2024 02:01:08 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id tl15-20020a170907c30f00b00a3186c2c254sm338950ejc.213.2024.01.25.02.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 02:01:08 -0800 (PST)
Date: Thu, 25 Jan 2024 02:01:06 -0800
From: Breno Leitao <leitao@debian.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
	edumazet@google.com, Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Paolo Abeni <pabeni@redhat.com>, dsahern@kernel.org,
	weiwan@google.com,
	"open list:IEEE 802.15.4 SUBSYSTEM" <linux-wpan@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 02/22] net: fill in MODULE_DESCRIPTION()s for
 ieee802154
Message-ID: <ZbIxYnEbFXi6NBMU@gmail.com>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-3-leitao@debian.org>
 <20240124175158.7c8b9490@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124175158.7c8b9490@xps-13>

Hello Miquèl,

On Wed, Jan 24, 2024 at 05:51:58PM +0100, Miquel Raynal wrote:
> Hi Breno,
> 
> leitao@debian.org wrote on Mon, 22 Jan 2024 10:45:23 -0800:
> 
> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to ieee802154 modules.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> 
> I just see the v2 now. Please use "v2" in your commit title using -v or
> git-format-patch.

Sorry, I am not sure I followed what you meant.  I've sent the v2, which
contains the 'v2' _tag_:

https://lore.kernel.org/all/20240123190332.677489-1-leitao@debian.org/

I didn't include the ieee802154 fix because the maintainers asked me to
split the patchset in a maximum of 10 patches[1], and I am doing it by
area (net, wifi, ethernet, etc). That means that this patch was not send
on the first batch, that is prioritizing Ethernet drivers (which is
described in the cover letter of v2)[2].

Anyway, let me know if I missed something here.

Thanks!
[1] https://lore.kernel.org/all/20240122105708.52d33fa0@kernel.org/
[2] https://lore.kernel.org/all/20240123190332.677489-1-leitao@debian.org/


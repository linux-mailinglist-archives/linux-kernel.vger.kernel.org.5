Return-Path: <linux-kernel+bounces-131607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F2A8989FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD00B256D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D912BEAB;
	Thu,  4 Apr 2024 14:22:10 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5A1272C0;
	Thu,  4 Apr 2024 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240530; cv=none; b=uaMd7ObcyVFpSb0EvoOpjFuvNqeeepZM6wEQ5YiBdNneo+tBkGpSYkYugyftWoqo0/MuBY0p+9WVNPjEdCElwHKRSsKyCkDmmoLUehSDuLdmPoCxtcxshjYUvTEzubsmVVsBJJ+91fV3H1v2xhcuaLiLN13PTdg4JrRj3tlRpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240530; c=relaxed/simple;
	bh=l4Ofb1VLHToYWmBhudFDJCjLPC4aC/WwScVhizSxGL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxyqFg8bzxIU02yUwvn1quxhGKvq0v5Il04lwcp/dSAaEZAGir0yG8DJR0pnmBXbaeuUKfNMZO6j/VMvxE70pykgk5Q97Ry+k3T25qi+PWRr8PmxNl8dAmXAd4aL0ikr8M4uotRzTS+B3SBsyGqH1SLnVodaRdrRRkRnis7JbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51969e780eso40960766b.3;
        Thu, 04 Apr 2024 07:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712240526; x=1712845326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVyUlV+3sDAiGX1EZuWoigVBp+zRmpt7JVsfIU0B7GI=;
        b=hEDjlO91lwpvRCkVyXfpgCy69TgbqvK+LOET/zaDzGGgnhaVak0nAyAc5iuzOrBG55
         yWrfSi796RqOG5ttYIKJaOS2H9VWAxsV+PpPB1rMm9pGtNAA6o9PKa1tG8Dhtw5OKgHb
         iVmh19Yp4rNFDgzM7LwYcVb/GfIoJiGlCezhZHUjZGEH0D2HDH60e8iAN8Quh5kbhchw
         8tgumx/OF4pmCHkr6LnA0mK+LDm4+mccZKkC9YLvrb0r9VcP0OJMuIWh2xLzjkpzKym+
         b+bsJf5PUj43auYrbQlLNRHZ02J/YIHp+yDKEBkDXnotN1Dto0sGlXJ6GKWBHIi1QbDx
         f/cA==
X-Forwarded-Encrypted: i=1; AJvYcCXnykzQ7mnbIcDAsvgQ+rFEmHFkDr1rFmbI+RQGeG73u10wmQZ+JF27jMsVGefhHc5sqILDOZ5L3dsVAvhLB20mDc2MtccEgXzm5OTGp1VtMdmUpCA0zgXEeBWfv50OHlx5bxlNK9Ei6BxAZ+q18tzUNHP5nF42ctG+
X-Gm-Message-State: AOJu0YwETexZj4ZSfRHTX8DsB5t68fWNWNbx+VlycNUgAHaJxkwegrkK
	Hdz5vzwHf+g5L5J05kBcSgpo5eFHrlWkAFy0kGCWp/oEwObJG8H4
X-Google-Smtp-Source: AGHT+IFEAzsGI4DJHhKL+bYgqHldQtzLWBNbrwkKIk9EHS3URioNQOJVyi4uwzCL2HY+yQHKnE8VLg==
X-Received: by 2002:a17:906:a208:b0:a50:9190:b751 with SMTP id r8-20020a170906a20800b00a509190b751mr1908287ejy.10.1712240526426;
        Thu, 04 Apr 2024 07:22:06 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id jw19-20020a170906e95300b00a4e26dfc7fdsm8738908ejb.29.2024.04.04.07.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 07:22:06 -0700 (PDT)
Date: Thu, 4 Apr 2024 07:22:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: aleksander.lobakin@intel.com, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org, taras.chornyi@plvision.eu,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	quic_jjohnson@quicinc.com, leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/5] allocate dummy device dynamically
Message-ID: <Zg63iwvtTMlZSGcd@gmail.com>
References: <20240404114854.2498663-1-leitao@debian.org>
 <87plv549ts.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plv549ts.fsf@kernel.org>

Hello Kalle,

On Thu, Apr 04, 2024 at 02:59:59PM +0300, Kalle Valo wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> > struct net_device shouldn't be embedded into any structure, instead,
> > the owner should use the private space to embed their state into
> > net_device.
> >
> > But, in some cases the net_device is embedded inside the private
> > structure, which blocks the usage of zero-length arrays inside
> > net_device.
> >
> > Create a helper to allocate a dummy device at dynamically runtime, and
> > move the Ethernet devices to use it, instead of embedding the dummy
> > device inside the private structure.
> >
> > This fixes all the network cases except for wireless drivers.
> >
> > PS: Due to lack of hardware, unfortunately all these patches are
> > compiled tested only.
> 
> BTW if it helps, and if you have an ath10k or ath11k patch already, I
> can run a quick test on real hardware.

That would be very much appreciated! Thanks!

I don't have them ready yet, but, I will work on them soon and I will
send it to you probably tomorrow.

Should I send them as RFC, or as a regular patch, and we iterate over?
What would you prefer?

Thanks!


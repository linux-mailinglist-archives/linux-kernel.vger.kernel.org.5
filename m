Return-Path: <linux-kernel+bounces-135876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBF289CC81
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CE51C21D7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED1146587;
	Mon,  8 Apr 2024 19:34:02 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9E14387F;
	Mon,  8 Apr 2024 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604842; cv=none; b=uX0Li5Q9As6UX+1fnOqVid2ZF/elATIfMMLifG/3mHLYqHsCisNB2icIXV+CR44RIx5JW6hP3RTcgOFXjVO1OwPhRHIUoHfjM5G8i3q3q49QD/13QKju4CoMVL6JaPGkS1j7T+Dl12ZZ2mZPfDU5B1IoZOdtblj5zYfd/oORXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604842; c=relaxed/simple;
	bh=fhTOyovmsXgPXGnig9m9cYnvr/otUXH7CvXA+mxyvug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUck2iiDy5AQo3BtidAxkv9jL+V9uGKxSS/bJcWq2LwFACLq3vqZknJRwtKXblXGAi/qWYOP0o57j17CLKwJ5i8X7v9KqwcVeMhYdqMc2ti8ZogOTSNZWupkK1YgaKLQOm3UtAjtFGJGRkXJcxzIC8nmlD80C3OS5tzhhwLDir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51d83fafa8so159761266b.0;
        Mon, 08 Apr 2024 12:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712604838; x=1713209638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfCVjviWJeub0v2MSTKXDx11MJAse5lPODUz+n33hmU=;
        b=EJxSSiArc5mTADi/G1z8W6qz7WoPHA08tzvOD8toJkxEpjHTUhSnbDBuGEu9A2gTrw
         FnaJUVIYEVFBb+m+Ioeys0ET4YEPkjaz9+7OglvsgeATNdPs6+/sINctlZY4Jq92+EMk
         zX+GTpQSh0Q21saju5Hb61UaHl+9lzad6i2nCN8iQ/8r+Xq0U7fvxkmGw73T48zJWqHr
         QT9N8WAgYikuibkZpgBlnE8ZTUVxmV5On+zzEXiPoCxrmxu5GtoxHz+hruverYM0wr+J
         eMQbGAiz1aFwlYtEQWwclzyo/btE/m2aWxkfewFSAFRKdMmuS7uVEPvaV8mU7RH79YN8
         zHqg==
X-Forwarded-Encrypted: i=1; AJvYcCVwTyaqcu9wsOWAFWuPoYqpvg1aATzSaKzhRQsTpQggQxZBRvZsw4KmOI3Oo9dcCJxg9/Bt7qoOCdpuCGCcu3rfFxspYgRR65Rqz2UF/oHmBu6uIqkKUlknwV4aLUL4bviEVTwCPoG3kdiX2rD60Q3dc+KSoSPuk4fAvHL2+KyyBC+aYno=
X-Gm-Message-State: AOJu0YzhUxF0BVL3d7J3kxxMoX/OjcmvzD2M1VsmCeJycOHD1mzFNC7y
	KR/F5236PpY8lqxOWcid6bd8yjYvpc+YlyXbWe0vVobcnw2QafSLsydvqGTD
X-Google-Smtp-Source: AGHT+IFVHHOuNQdDkgTThZIsOIA2O31M9s6h62JAwb2e7rIFNi7t+6i8asIMrJ5fM6Dg38+17TsPPA==
X-Received: by 2002:a17:907:7213:b0:a4e:609c:3985 with SMTP id dr19-20020a170907721300b00a4e609c3985mr8079720ejc.52.1712604838302;
        Mon, 08 Apr 2024 12:33:58 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id gs44-20020a1709072d2c00b00a46a3ad035esm4804743ejc.179.2024.04.08.12.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 12:33:57 -0700 (PDT)
Date: Mon, 8 Apr 2024 12:33:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: kuba@kernel.org, ath11k@lists.infradead.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, imitsyanko@quantenna.com,
	geomatsi@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] wifi: Un-embed ath10k and ath11k dummy netdev
Message-ID: <ZhRGo3I57rXxsMV/@gmail.com>
References: <20240405122123.4156104-1-leitao@debian.org>
 <87y19r264m.fsf@kernel.org>
 <ZhPyRHHlVot+a8Xq@gmail.com>
 <87pluz24ap.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pluz24ap.fsf@kernel.org>

On Mon, Apr 08, 2024 at 07:43:42PM +0300, Kalle Valo wrote:
> Breno Leitao <leitao@debian.org> writes:
> > On Fri, Apr 05, 2024 at 06:15:05PM +0300, Kalle Valo wrote:
> >> Breno Leitao <leitao@debian.org> writes:
> >> 
> >> > struct net_device shouldn't be embedded into any structure, instead,
> >> > the owner should use the private space to embed their state into
> >> > net_device.
> >> >
> >> > This patch set fixes the problem above for ath10k and ath11k. This also
> >> > fixes the conversion of qtnfmac driver to the new helper.
> >> >
> >> > This patch set depends on a series that is still under review:
> >> > https://lore.kernel.org/all/20240404114854.2498663-1-leitao@debian.org/#t
> >> >
> >> > If it helps, I've pushed the tree to
> >> > https://github.com/leitao/linux/tree/wireless-dummy
> >> >
> >> > PS: Due to lack of hardware, unfortunately all these patches are
> >> > compiled tested only.
> >> >
> >> > Breno Leitao (3):
> >> >   wifi: qtnfmac: Use netdev dummy allocator helper
> >> >   wifi: ath10k: allocate dummy net_device dynamically
> >> >   wifi: ath11k: allocate dummy net_device dynamically
> >> 
> >> Thanks for setting up the branch, that makes the testing very easy. I
> >> now tested the branch using the commit below with ath11k WCN6855 hw2.0
> >> on an x86 box:
> >> 
> >> 5be9a125d8e7 wifi: ath11k: allocate dummy net_device dynamically
> >> 
> >> But unfortunately it crashes, the stack trace below. I can easily test
> >> your branches, just let me know what to test. A direct 'git pull'
> >> command is the best.
> >
> > Thanks for the test.
> >
> > Reading the issue, I am afraid that freeing netdev explicitly
> > (free_netdev()) might not be the best approach at the exit path.
> >
> > I would like to try to leverage the ->needs_free_netdev netdev
> > mechanism to do the clean-up, if that makes sense. I've updated the
> > ath11k patch, and I am curious if that is what we want.
> >
> > Would you mind testing a net patch I have, please?
> >
> >   https://github.com/leitao/linux/tree/wireless-dummy_v2
> 
> I tested this again with my WCN6855 hw2.0 x86 test box on this commit:
> 
> a87674ac820e wifi: ath11k: allocate dummy net_device dynamically
> 
> It passes my tests and doesn't crash, but I see this kmemleak warning a
> lot:

Thanks Kalle, that was helpful. The device is not being clean-up
automatically.

Chatting with Jakub, he suggested coming back to the original approach,
but, adding a additional patch, at the free_netdev().

Would you mind running another test, please?

	https://github.com/leitao/linux/tree/wireless-dummy_v3

The branch above is basically the original branch (as in this patch
series), with this additional patch:

	Author: Breno Leitao <leitao@debian.org>
	Date:   Mon Apr 8 11:37:32 2024 -0700

	    net: free_netdev: exit earlier if dummy

	    For dummy devices, exit earlier at free_netdev() instead of executing
	    the whole function. This is necessary, because dummy devices are
	    special, and shouldn't have the second part of the function executed.

	    Otherwise reg_state, which is NETREG_DUMMY, will be overwritten and
	    there will be no way to identify that this is a dummy device. Also, this
	    device do not need the final put_device(), since dummy devices are not
	    registered (through register_netdevice()), where the device reference is
	    increased (at netdev_register_kobject()/device_add()).

	    Suggested-by: Jakub Kicinski <kuba@kernel.org>
	    Signed-off-by: Breno Leitao <leitao@debian.org>

	diff --git a/net/core/dev.c b/net/core/dev.c
	index 2b82bd1cd2f8..5d2cb97d0ae6 100644
	--- a/net/core/dev.c
	+++ b/net/core/dev.c
	@@ -11058,7 +11058,8 @@ void free_netdev(struct net_device *dev)
		dev->xdp_bulkq = NULL;

		/*  Compatibility with error handling in drivers */
	-       if (dev->reg_state == NETREG_UNINITIALIZED) {
	+       if (dev->reg_state == NETREG_UNINITIALIZED ||
	+           dev->reg_state == NETREG_DUMMY) {
			netdev_freemem(dev);
			return;
		}


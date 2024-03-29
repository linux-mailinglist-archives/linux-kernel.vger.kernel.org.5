Return-Path: <linux-kernel+bounces-125234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEFA892292
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1A91F24D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2BF12D1E8;
	Fri, 29 Mar 2024 17:21:59 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63591C0DC0;
	Fri, 29 Mar 2024 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732918; cv=none; b=rtyRAUkUqKXJWfUvLoeIloX5PlSsLxSAqJsyX0DmnUmO2Km+NooadmqbGLxKW6DYBRO7oZ4TfhobWgkUCsjj89bGnZ1XFk1YvsFPvsMQoFd4hDP9U+gaPwQiencu/LiFpsEWW9nlQXVpJm7SM/sXqhBjXX3ahEKB7addjBKkx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732918; c=relaxed/simple;
	bh=VAZUIHroRXLR2qYb54Uc+5XzuFX5yye1KGM0aNQugsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUej3Svlus2KP2Oz0u8Liw4aihVkCrfaYW//Yp34g5fDgtDzHKpB1/+oMrcwR8+X/GthbuD8mMICgV5NFqsiKLGbruQhoqKaC6eohZWLgchrmGryU8Wn9QefMjnUdgUohESab2tt9ATrPhD1fGnPSEMX+HfnBAP9jDCuExceEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so297350066b.0;
        Fri, 29 Mar 2024 10:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732915; x=1712337715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWTNK+PNnGTgTs2Ks00fI39OgjfjTZnHwFsoUqKid1M=;
        b=izXeBXbcP7pm+veWDCBVKzdNKF9mqovkkUrQuwwxYWmCnPrLVkSLlC/iOwoVtv9ulg
         JOtvA2p++RihUChVbhRkuMu+dqzc13pWX/IWwInuQIbin8MMrKl+XzwkaYwr5W0ZDkwa
         9nCMBtjKTSv98an0JUqsmKeTjTi6j6GcAVbwnyiA26imwcwhXd3WouTdIM0Sf/NICDAJ
         I20wv2/SbbV/+gSCsd2PtJUnnUiMHe23lviyVGtr6EWheYilITy3tgiH7V6w+mw3Vu8C
         z/9eX9619Dw0yzGaSlcgOKJby4CTx1CYzPkUI0XK5xY1xGT8LyhMOdEVyMSFRSElxhZo
         MtXg==
X-Forwarded-Encrypted: i=1; AJvYcCVIq7q/z1RYGtRhSyaQsLIl2IHg1OmzkvPK2OFTjY19StdwwKmbi/K0nmHTsCAv6neGZp55VeuTfyUTdCYTmOOcIMTJKsjwPMqXeCAFSdPIByLXLtzGfjKun2tXVPo1icF2JlLG
X-Gm-Message-State: AOJu0Yy/9fo2Y3FZb7Umr2s5uw5Rl3/BayDuQF5CHJFG0oqMEEatzrxK
	wBUZ+RyazmL5bXGOQdJ67DLk3ueFWwbQevAiz+tj/QUSTo4b2CTC
X-Google-Smtp-Source: AGHT+IFb3iL3O2NxVjWyzZ4px7Ly4wOtUDl0HQjLybDZpYINkq1QmhOuo8RjXUBcBXho+E5uh2P1lA==
X-Received: by 2002:a17:906:3a91:b0:a4d:f555:fd6 with SMTP id y17-20020a1709063a9100b00a4df5550fd6mr1723080ejd.29.1711732915068;
        Fri, 29 Mar 2024 10:21:55 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id h18-20020a17090634d200b00a44b90abb1dsm2132929ejb.110.2024.03.29.10.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:21:54 -0700 (PDT)
Date: Fri, 29 Mar 2024 10:21:52 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: aleksander.lobakin@intel.com, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Taras Chornyi <taras.chornyi@plvision.eu>,
	quic_jjohnson@quicinc.com, kvalo@kernel.org, leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/5] net: marvell: prestera: allocate dummy
 net_device dynamically
Message-ID: <Zgb4sEmsiDkNtvJG@gmail.com>
References: <20240328235214.4079063-1-leitao@debian.org>
 <20240328235214.4079063-3-leitao@debian.org>
 <20240329085633.2cfae5e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329085633.2cfae5e5@kernel.org>

On Fri, Mar 29, 2024 at 08:56:33AM -0700, Jakub Kicinski wrote:
> > @@ -682,6 +690,7 @@ static void prestera_sdma_switch_fini(struct prestera_switch *sw)
> >  	prestera_sdma_tx_fini(sdma);
> >  	prestera_sdma_rx_fini(sdma);
> >  	dma_pool_destroy(sdma->desc_pool);
> > +	kfree(sdma->napi_dev);
> 
> Why kfree()? Let's use free_netdev() consistently, in case one day
> we have to undo something alloc_netdev_dummy() has done.

I should have used free_netdev() in fact. I will update.


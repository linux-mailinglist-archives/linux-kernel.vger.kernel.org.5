Return-Path: <linux-kernel+bounces-94275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A2C873C62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C8F1C24834
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759061361D4;
	Wed,  6 Mar 2024 16:35:25 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1875FB95
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742925; cv=none; b=sMtey+gqMnl1oH7chAwYJ8tTmYbdeuJyw5G4Nk63E68RQNjzBA2s6PkCOHRrsYYzw8jNzuurWtyf7UH48PMb8EyMQ14tApvZRMGBb4Ys9OVioTJKQpGLCjnwYrpiVlmGkSU+FEp2Nvdh55bkTle5wNAOs/fKs6Fqlf4Rpg1ezJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742925; c=relaxed/simple;
	bh=SVvWdNGpY/CIYt+MhM5laWQNaxntm3Tz6Wsa6jb+nnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLxqBHw6MbWvxwOw73Op7HLe2ELTFOGjRA1o8zCxckzluAQpA9/NSb6DyXbJkrs1P/22FYF/LUhQPInt8LwemVHRtwg53fTDh1IjHy6vxNtzobyu/kPDkDmmGFaEnUW8Z3aOawTVvoQLTTigHRvge9fbbz6DC7sQF8uqAN9sd20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-RSHPMtiyNbORLwcOcr_Qtg-1; Wed, 06 Mar 2024 11:35:18 -0500
X-MC-Unique: RSHPMtiyNbORLwcOcr_Qtg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 971DF8007A6;
	Wed,  6 Mar 2024 16:35:17 +0000 (UTC)
Received: from hog (unknown [10.39.194.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D31737F6;
	Wed,  6 Mar 2024 16:35:16 +0000 (UTC)
Date: Wed, 6 Mar 2024 17:35:15 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, horms@kernel.org, dsahern@kernel.org
Subject: Re: [PATCH net-next] net: macsec: Leverage core stats allocator
Message-ID: <ZeibQ3Uychp8nWAN@hog>
References: <20240305113728.1974944-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240305113728.1974944-1-leitao@debian.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

2024-03-05, 03:37:27 -0800, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the macsec driver and leverage the network
> core allocation instead.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina



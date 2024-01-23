Return-Path: <linux-kernel+bounces-34971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FF5838A11
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1301F25F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77B15811B;
	Tue, 23 Jan 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ojH8FY9k"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0071858114;
	Tue, 23 Jan 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001319; cv=none; b=teJDWCKgf8ycMGXNtvkxVIp4DvSRE5dWUeGrQT+abc+UjtyTe1xlU6e5bb1N8JyhXi59H+RnWH0dkV5qYBxphpiTAnXQKvYiiCK7+vlgsGn0839pvR6EBw/m410M+64sBO86sDl8SHt/A3N//Q47oHQjjtghTRtrFdOkhFyTxsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001319; c=relaxed/simple;
	bh=Mu4jvDM/Gpa3jYnWKBrbmxafetUa+cgrJwz8QwpT7fA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FT1KIpMXDsNypZqprSQ1hQwimA8CHctvDVTLz25f3CictB5r1z/bdHMiw2b98VdBtbhbO0lyE15wZuBZW5P3llf9V0unn3j/wsuYjrOpSJJNBA3qpqRMMOpA9PJHZx9/DFwaPBPtOlS0kXwvhTV57I0UdtIsy9xCy2MAgPlTa9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ojH8FY9k; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDE9C1BF205;
	Tue, 23 Jan 2024 09:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706001309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+BnTNr7Ae3D9xLmTYxlT4lRtHyTsNW6UydqPcRonqs=;
	b=ojH8FY9kBTCiD+oqrC7vRrSbmndmiEFW96aDb/yp9vB/b3sxUnSFgQgOlUmDKatTcdc36O
	ZJiqcJFzRmX1CK0jlQ+k0KTEf/JvcdiL4abM4wJD57w/AYt/8iLQVB1r8DS+W5PvpKkGYx
	uP1sxalpwp9uCUDWUPKQNLuB/g4r8PyCBm6XVGcnb9+ybJP2fPQ2Thz5s/vtB47g2ctzOB
	r9I625VzLtxiOk6paGRAsVZDHQDFmM0CqC1JTaI1vrO41A/6CXomvPf0iQVt9iUIVW3hpI
	5SNpZL6HsXsOhquLC53AGIk32vG5VozUsAZjs4GlrqkZsEPTH99wjRi6Zt9L8Q==
Date: Tue, 23 Jan 2024 10:15:07 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Jenishkumar Patel [C]" <jpatel2@marvell.com>
Cc: "marcin.s.wojtas@gmail.com" <marcin.s.wojtas@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Antoine
 Tenart <atenart@kernel.org>
Subject: Re: [EXT] Re: [net v4 PATCH 1/1] net: mvpp2: clear BM pool before
 initialization
Message-ID: <20240123101507.6ae730bd@device-28.home>
In-Reply-To: <PH0PR18MB4543B5E92792ECD5D3683861EC752@PH0PR18MB4543.namprd18.prod.outlook.com>
References: <20240119035914.2595665-1-jpatel2@marvell.com>
	<20240119150451.476d6ba2@device-28.home>
	<PH0PR18MB4543B5E92792ECD5D3683861EC752@PH0PR18MB4543.namprd18.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Mon, 22 Jan 2024 06:02:07 +0000
"Jenishkumar Patel [C]" <jpatel2@marvell.com> wrote:

> > > +/* Cleanup pool before actual initialization in the OS */ static void 
> > > +mvpp2_bm_pool_cleanup(struct mvpp2 *priv, int pool_id) {
> > > +	unsigned int thread = mvpp2_cpu_to_thread(priv, get_cpu());
> > > +	u32 val;
> > > +	int i;
> > > +
> > > +	/* Drain the BM from all possible residues left by firmware */
> > > +	for (i = 0; i < MVPP2_BM_POOL_SIZE_MAX; i++)
> > > +		mvpp2_thread_read(priv, thread, MVPP2_BM_PHY_ALLOC_REG(pool_id));  
> > 
> > ... I think you didn't answer Antoine's comment on that loop from the V2, regarding what this does exactly. From the other sites this is used, it seems to perform an allocation from the pool, can you clarify how safe it is to do so here, if for example the BM was never configured by the firmware beforehand and is therefore already in a Stopped state ?
> 
> Reading the register provides a pointer to buffer that is already allocated during BM initialization. When multiple reading is done on the register, it will drain all the pointers that are stored by previous firmware. Also reading this register does not perform any allocation as it is only performing register read operation, thus when the BM is not configured earlier then it will not lead to any stop state.
> 
> > And are we not risking any leak if there was something in the pool that we don't release ?
> 
> The data on the pointer given by register read is written after the read operation is preformed, which means the pointer does not contain any data, thus there is no leak.

Thanks for your answers, I think that's clear to me then.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime



Return-Path: <linux-kernel+bounces-39890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B622883D844
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8CDB32894
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC2E61667;
	Fri, 26 Jan 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="qhQ+aznB"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC860ED5;
	Fri, 26 Jan 2024 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260134; cv=none; b=e15QsUn5GXgw0Zld4O4x90xB+wmZUl0aV0ABTpcXEnU4Sjoh+OrNLaG6kXmiLpZTiO57+7qpIs7KyOlMjZy/gJ37OSlkhWjJa3a9e+PFIrPjsunt/Ux9Zn7vUwA+Wih9vhlmVE7XigFSqURlU9SG4g/P+2h+j53h10YbpOyeHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260134; c=relaxed/simple;
	bh=+iBdilf2oAlb3QWslakRcDz4Slj2S/vo74OJbOpf7io=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u+AS+h6e+EB6kzV+2NBhUL8CsyW36hXqgqG0oVd0hiOPutyNizo8iZ/+ULEBPVagOJyF9mIN23mHmuC11Wg+xobX9wrdxLJiG3cCW24ApN0fqxiaggdZrZIfblbJKRs3lBUAeH2kuTLwDiH6feBDtyWxFzSU18kW8aBhWkGP4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=qhQ+aznB; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PUfxJlZFVfmPhNLMt5rpstbfpKShoNxijw+jhoG4IIQ=; b=qhQ+aznBBExDH5jZPmD78Y4aEl
	8AGLUycpgv2X48qKwFSdTpu0TvBGX9DeIgtBi5WsujLd4bS2Zhk4nuIPMCzzn6BV6Rq/1n/gIHCm9
	nKxz8qwTLQqzd7B/VcTl/eteW1uBuGjqqU86wiZHpJmgO0casflUaxMcIU4jm2gSgiQ9k/F9z0d3d
	Vt3wBK2LJbhhJQMrLaTejZOB+mnXokTB0YMlfid+Gur3Yke93LIfiRTEYkVfO3nvd7PPOKVtIpRUo
	5kpwVCPRUpwGSjB6tJoQv7rr4mBywoyWdNKNRQyqDzmlOqPzNONvwV8T24J3sjRxSEY1OvewUg1KY
	476+OxDA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rTHoA-000CBk-GH; Fri, 26 Jan 2024 09:43:30 +0100
Received: from [87.49.42.9] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rTHo9-000Kqi-0v; Fri, 26 Jan 2024 09:43:29 +0100
From: Esben Haabendal <esben@geanix.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Rohan G Thomas <rohan.g.thomas@intel.com>,  "David S . Miller"
 <davem@davemloft.net>,  Alexandre Torgue <alexandre.torgue@foss.st.com>,
  "Jose Abreu" <joabreu@synopsys.com>,  Eric Dumazet <edumazet@google.com>,
  "Jakub Kicinski" <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Maxime Coquelin <mcoquelin.stm32@gmail.com>,  Rob Herring
 <robh+dt@kernel.org>,  "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Giuseppe Cavallaro <peppe.cavallaro@st.com>,  "Serge Semin"
 <fancer.lancer@gmail.com>,  Andrew Halaney <ahalaney@redhat.com>,
  <elder@linaro.org>,  <netdev@vger.kernel.org>,
  <linux-stm32@st-md-mailman.stormreply.com>,
  <linux-arm-kernel@lists.infradead.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <quic_bhaviks@quicinc.com>,
  <kernel.upstream@quicinc.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: TBS support for platform driver
In-Reply-To: <92892988-bb77-4075-812e-19f6112f436e@quicinc.com> (Abhishek
	Chauhan's message of "Wed, 10 Jan 2024 12:19:29 -0800")
References: <20230927130919.25683-1-rohan.g.thomas@intel.com>
	<20230927130919.25683-3-rohan.g.thomas@intel.com>
	<92892988-bb77-4075-812e-19f6112f436e@quicinc.com>
Date: Fri, 26 Jan 2024 09:43:28 +0100
Message-ID: <87r0i44h8v.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27165/Thu Jan 25 10:51:15 2024)

"Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com> writes:

> Qualcomm had similar discussions with respect to enabling of TBS for a
> particular queue. We had similar discussion on these terms yesterday
> with Redhat. Adding Andrew from Redhat here
>
> What we discovered as part of the discussions is listed below.
>
> 1. Today upstream stmmac code is designed in such a way that TBS flag
> is put as part of queue configurations(see below snippet) and as well
> know that stmmac queue configuration comes from the dtsi file.
>
> //ndo_open => stmmac_open
> int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;(comes from tx_queues_cfg)
>
> /* Setup per-TXQ tbs flag before TX descriptor alloc */
> tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
>
> 2. There is a no way to do this dynamically from user space because we don't have any 
> API exposed which can do it from user space

Not now. But why not extend ethtool API to allow enabling TBS for
supported controllers?

> and also TBS rely on special descriptors aka enhanced desc this cannot
> be done run time and stmmac has to be aware of it before we do
> DMA/MAC/MTL start.

Isn't this somewhat similar to changing the RX/TX ring parameters, which
I believe also is quite difficult to do at run time, and ethtool
therefore requires the interface to be down in oroer to change them?

> To do this dynamically would only mean stopping DMA/MAC/MTL realloc
> resources for enhanced desc and the starting MAC/DMA/MTL. This means
> we are disrupting other traffic(By stopping MAC block).

Yes. But you would be disrupting traffic less than by requiring a
complete reboot of the target which is needed if the devicetree must be
changed.

> 3. I dont think there is a way we can enable this dynamically today. I
> would like upstream community to share your thoughts as well.

Hereby done. Could we investigate the possibility of using ethtool to
change TBS enable/disable "run-time"?

> 4. I agree with Rohan's patch here and want upstream community to
> accept it. This will allow use to configure the queues where TBS needs
> to be enabled as hardcoding in the code unless upstream has better way
> to this using userspace.
>
> Please let us know if you think otherwise. 

/Esben


Return-Path: <linux-kernel+bounces-38555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6983C178
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3561C230E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2B436122;
	Thu, 25 Jan 2024 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="wg+onJv7"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD6B45950;
	Thu, 25 Jan 2024 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183938; cv=none; b=pSXh1mv93iQUajJBz0XWQjvuOXlsdR09eNUOCiDpVINzlVNOCWCR5gCVFQtfpDA5RhTwr/mAfVnZls2mPGYas+ibDqyfnW2/cjmckbfEx8vhCj/j1NFvx63m5Ir7fLrXXde+Pl2gPRWibqhmGSY13mr5k/5IcVDb2fkrJoCbyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183938; c=relaxed/simple;
	bh=kkF3b7McPBdvVoiztKPiGvKZ6z3mXMy71vLk9BtpZeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nu16tEy1Vi3PTnkmehSICITaB4UIh/WYTP6lwvEd8ECY4bQGsQ4KbujMlPLwOgAJ/gYU2k5o5dlEIblWRCs4RqOjXuxDQSa3aggUbG1PzpKB0iQS1XxXsiD/62XT4b6Dc4cvD9ygSKHHJt5c9mixeRofzGaez/b0TcvmP7hKieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=wg+onJv7; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Hf6tipOHSadECgsUIyxzcnBsKwPZNts6tZDoPvTRG2c=; b=wg+onJv7knX2ZGhToWqlNLRkF5
	RIWOo89gho7iVAXbECltAjM2vUXLPMFwFn+2CgWvDqrxcPmmLQ+oo2Hzo9apD46BvH6qtd9MpMTHy
	h/rNj0wGZvoM/6FF0OO64NKQrE5vMrGZXa2AtfGyWsEfdsCupeyYsRL78NJX+Pq8WIDEp3fAXI7mC
	qYYC6034h+Eu6HuI3Z3TIt+xyuU0I57snSnPhe7rkZCz/OOSc/g4Gnc1ItJOsYwVvmdlOJRtColw5
	uG4P8lJV88alDM6NiFA0szTjOtaAjpeAtWAgb9qjyTk/KL+pyVh+UY2AlJz1VAoZ9mrYSUV+e0Me2
	vpiN5dCg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rSyNh-0000nH-18; Thu, 25 Jan 2024 12:58:53 +0100
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rSyNg-000K8S-Bp; Thu, 25 Jan 2024 12:58:52 +0100
From: esben@geanix.com
To: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc: netdev@vger.kernel.org,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Jose Abreu <joabreu@synopsys.com>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>,
  linux-stm32@st-md-mailman.stormreply.com,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: stmmac: Time Based Scheduling support for OF
 platforms
In-Reply-To: <8734ulekuj.fsf@kurt.kurt.home> (Kurt Kanzenbach's message of
	"Thu, 25 Jan 2024 12:03:16 +0100")
References: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
	<b807c2a70dba9711376b265b6da5fb5ff14589aa.1706105494.git.esben@geanix.com>
	<8734ulekuj.fsf@kurt.kurt.home>
Date: Thu, 25 Jan 2024 12:58:52 +0100
Message-ID: <8734ulhber.fsf@geanix.com>
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

Kurt Kanzenbach <kurt.kanzenbach@linutronix.de> writes:

> Hi,
>
> On Wed Jan 24 2024, Esben Haabendal wrote:
>> This allows enabling TBS for TX queues by adding the
>> snps,time-based-scheduling property. You should check for support for this
>> on your particular controller before enabling. Typically, TX queue 0 does
>> not support TBS.
>
> More a general question: Do i see that correctly that Launch Time does
> not work for OF platforms (such as an imx93) at the moment, because the
> tbs_en property is not configured? Or why are these patches necessary?

Correct.  You cannot use etf qdisc with "offload" on for OF platforms,
including imx93.
Doing that will end with "return -EINVAL" in tc_setup_etf().

I am working with imx98mp, but there should not be any difference for
imx93.

/Esben


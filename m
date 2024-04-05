Return-Path: <linux-kernel+bounces-133419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94CB89A375
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AACB24BF6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0047171675;
	Fri,  5 Apr 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="r7ruMBWK"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2F171669;
	Fri,  5 Apr 2024 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337763; cv=none; b=J87OXRROZlmEMeieVWqTZCUpQw8QSfZPTqgJVn/PKY2qRkHUbOPUhCEwZF2n5IqI/Gbxk8R+6hVWRvwcnuCfhTjt9OqUg6ou9KEpLGK2qIvkzdGfeZrbsdkUBMiYJKJYA0OtZ4uGhhKZ9T9O0Td/TYNYg4JwCQKIlliL7rdmuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337763; c=relaxed/simple;
	bh=5hYVwiWSjbv96A9s1mJhZLlHI2GEC3GTRQLN8L9D9Fc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G94W6hO4EQaYtgZI0yvCxEBESGy1yY2hrleoNxTItYsovtvssy12pJlVwULpZCA41ScMpDBrpm9IFblU7QcdS5EP74Kj12ev7jcj/N2hi/v0AeL67ZdhwGybbJQQVVas23ISC9ysdKhpBwvRLBrGtTq+AKTAXLApK0B9o/xNBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=r7ruMBWK; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=z5kw8S1d0O+kbtMV3WpOV18jW8JeNQUYGvp6yd2nOjE=; b=r7ruMBWK2t4byQ/tWq+mVPyoR3
	DUadbdRQCqVVj02I++Pispo9rh03jOwYaZmSz5rpKgnkQp++P2EvgchTKPOVazI02mnplXXlN0q62
	fQgWpbiKKFccVCs/YA3/cVOpfF+QwA6mvkfB8fmZYNxpn5lMUQFeI1QPq9kgNgzQBNdcgJhN6kz9U
	KRedOntEW1LC2o10ieVX85YCmiCLnPAvEaYo17nXB5QQIqIrMI4rDyY+/T5GE/3o37F/r9jr1s6Wa
	1txLZ8T76Io0+sZnB8OK6hqyiZs0OqW14b0HBSWsyC8Xmskv2yYrvncCzp04mgCASN1h0FOMgrpFG
	nbA4AjNg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rsnGo-000JAo-QN; Fri, 05 Apr 2024 19:22:30 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rsnGo-000CO6-0S;
	Fri, 05 Apr 2024 19:22:30 +0200
From: Esben Haabendal <esben@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Jiri Slaby
 <jirislaby@kernel.org>,  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer
 <s.hauer@pengutronix.de>,  Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-serial@vger.kernel.org,
  imx@lists.linux.dev,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] serial: imx: Introduce timeout when waiting on
 transmitter empty
In-Reply-To: <20240405-impurity-emerald-f67dc37adf9b-mkl@pengutronix.de> (Marc
	Kleine-Budde's message of "Fri, 5 Apr 2024 11:49:50 +0200")
References: <76cf9ce9cbf9dcdf78bc00ce7a919db1776ebce1.1712309058.git.esben@geanix.com>
	<20240405-impurity-emerald-f67dc37adf9b-mkl@pengutronix.de>
Date: Fri, 05 Apr 2024 19:22:29 +0200
Message-ID: <874jcf67xm.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27236/Fri Apr  5 10:26:04 2024)

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 05.04.2024 11:25:13, Esben Haabendal wrote:
>> By waiting at most 1 second for USR2_TXDC to be set, we avoid a potentital
>> deadlock.
>> 
>> In case of the timeout, there is not much we can do, so we simply ignore
>> the transmitter state and optimistically try to continue.
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> Where's the cover letter and patch 2/2? Have a look at b4 [1], it's a
> great tool to help you with sending git patch series.

It is left out on purpose.

This patch is a stand-alone patch as it is. The other part of the series
you are talking about is not going to mainline for now. It needs still
quite some work, and will only go in after all the other printk stuff.

I hope we can merge this patch as it to mainline now, instead of piling
up more than necessary in the rt tree.

/Esben


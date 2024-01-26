Return-Path: <linux-kernel+bounces-39899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF7683D72A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB2C1F2A030
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E17664C6;
	Fri, 26 Jan 2024 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="lIcsnqVZ"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478F62A07;
	Fri, 26 Jan 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260303; cv=none; b=eLPZQF5O8HhNzJnlyFzztvSfUOU2Wu1/Yk+lF1IkHVsFByO5dNYDoVj8cDr5/5Otenfekocsw0I84alkGQMTirun+5ysjzWQqGTi8fJoYFyqb8Sagdqd7pcpuFiQq97mYe1hF/nXTcF53L/iNk2NCiU+b035gKWyXYvTsOYfAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260303; c=relaxed/simple;
	bh=HQvA7txAM0VbjWGr4LJphGRjOmXxRxHM+67/LKlzezU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgOF25uYsoNfMmlhMh2a1cWs+XbiMqcYOoURu2UW+B0pmTMadyMHOJ/KgufyD1jhouVJ2Y/2Yc9oCE0WXNgNBZTSlf2KvquKJg1wWUYR14ovd4x6XiLxaS4Ifp4FqFO87DxEdoB/hSzfFSEtj5WFybWp2zmgO7yn/+He0LqNnqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=lIcsnqVZ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4D2AA20842;
	Fri, 26 Jan 2024 10:11:39 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CndKI7aQloY4; Fri, 26 Jan 2024 10:11:38 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E66BE207D5;
	Fri, 26 Jan 2024 10:11:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E66BE207D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1706260297;
	bh=5zl+RvElPeyXc8dtCAn1Ij7w5kurFf0vU0RzJY2hrgU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=lIcsnqVZMLCHUu2wiQl7KF3cC+kRpjkze2orphN2eMPN1VstOVPHOCA/lI+qVIMCr
	 +qichnp9QpCbPtnlfZ7WouykS/C025RqrNWfTUKYLvGaQhchb0OPV/b4+Wb5b1O5PO
	 XpqQVmDUJEowEij6i/8rm01kL5WguFPViKn/6ZFCMq3U5PpepQFa7ulzGXEF3mn2cX
	 fe/pNmIANdVFT8LqpWagz1vbSn1kjjBF6W4A6k83BqBpPBtd/fvwI/HABHZZgHjZPO
	 qSein44YaUmQXo7aS5V5QMywKlrWQH84FdqxUJvvQUc5yaskaSnHSH8vmoIHpuPq21
	 1GHiyG3vEKCPA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id DD878800050;
	Fri, 26 Jan 2024 10:11:37 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 10:11:37 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 10:11:37 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 100123182D6D; Fri, 26 Jan 2024 10:11:37 +0100 (CET)
Date: Fri, 26 Jan 2024 10:11:36 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Kunwu Chan <chentao@kylinos.cn>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec-next] xfrm6_tunnel: Use KMEM_CACHE instead of
 kmem_cache_create
Message-ID: <ZbN3SOlsVN0dbL/m@gauss3.secunet.de>
References: <20240124063150.466037-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124063150.466037-1-chentao@kylinos.cn>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Jan 24, 2024 at 02:31:50PM +0800, Kunwu Chan wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Applied, thanks a lot!


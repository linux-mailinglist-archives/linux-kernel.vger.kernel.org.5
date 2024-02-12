Return-Path: <linux-kernel+bounces-61148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B513E850DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45547B2620B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF8E7489;
	Mon, 12 Feb 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Ki19R64H"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88B622;
	Mon, 12 Feb 2024 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722551; cv=none; b=mbyIJ9pAJMwjUu5eic0CpRmuE/YauJZvNZSWLa42YvdkGYFYfl9YLB3epoLIoIVMSuuesALDfvfL76BdMRj9/G0tlA45zAChmZvIJRd4zxRbJtCvpHYpWLqDyaUjgp3q9Wqal29szklEktG/7egY3xlUK+kJz0C0tWYFe4ZWEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722551; c=relaxed/simple;
	bh=lwrRp5G19JyIvm+Wrsx+NBHF5BsWVaBmX8TSM9AxBlE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzbtLiDYxfuTiFljyQkuncz8wHqLbxnfrjM0grbhUIlQEuPV7qDa+u/SiPO/MiuO2sHJdmpeMezjskEkil62+v2B8Nww7tyYyqhRN9P6lEpv/pRynahbtMUHUX1wKqqynWUQAlI6ex5zmGgStK/gN6qofLKWwQFHlg4ZWZCiD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Ki19R64H; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id F18D62074B;
	Mon, 12 Feb 2024 08:16:03 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HBs_BmY_KVZ0; Mon, 12 Feb 2024 08:16:02 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 0780A201A0;
	Mon, 12 Feb 2024 08:16:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 0780A201A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1707722162;
	bh=3t1gV2cOKgnUmqc2SniMGhWo502DwVW3SrQpMQqI5eQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Ki19R64HiBZPTaiMDw5Tje364b9bNijS+2P9LIx4worDUFdeQ2lsHiHCsyUK8OJJd
	 rrOTaylF5yLuEwSd/AdsIreG6sdXFezK8uEZ6X94XpARoqng2cRfzEF4QHPS17hm3T
	 iCGJIjq5u2csxCx7tAf1UybHgQL4ly/bavwGWPq1r3nLeyb9g6ft0PnmgLNTlGPm1m
	 5B2SWSFac2Lju/Lobc114RYzomZmrekqKSH+OeX3DlYovrUUA9x+hlTyttuEgT+nZx
	 ULl/SP02jsUz6qIvuQgwrKwOkPG6vLv2Qr+CviJmbTJFeSOctatcFHKz3J8ocUT7Ej
	 duoMI61b23fvw==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id ED4BE80004A;
	Mon, 12 Feb 2024 08:16:01 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 08:16:01 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 08:16:01 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 473D9318299F; Mon, 12 Feb 2024 08:16:01 +0100 (CET)
Date: Mon, 12 Feb 2024 08:16:01 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Kunwu Chan <chentao@kylinos.cn>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec-next] xfrm: Simplify the allocation of slab caches
 in xfrm_policy_init
Message-ID: <ZcnFsXQ72b/P2BLd@gauss3.secunet.de>
References: <20240130081411.58246-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240130081411.58246-1-chentao@kylinos.cn>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Jan 30, 2024 at 04:14:11PM +0800, Kunwu Chan wrote:
> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> introduces a new macro.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Applied to ipsec-next, thanks!


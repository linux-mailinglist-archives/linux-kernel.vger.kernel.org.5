Return-Path: <linux-kernel+bounces-99597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D5878A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38121C20F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B45730A;
	Mon, 11 Mar 2024 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plfarEhs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC2C5730E;
	Mon, 11 Mar 2024 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195254; cv=none; b=cztF3YTEN0EqQGu2t7u6zGs3b+8X9npX72R8OUxKiGPeyXiAO1bgtrrZVe0UsIK1mlWw1ELsNqa4B6nxQZiRfKmUEmhXhJQB/9qpBqt0jyLenWE8KCI8DkadbsKSGsJTONW9EQX3z827wWgk/dIQrs4lDisEFwvfit2DIN4Wnp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195254; c=relaxed/simple;
	bh=DyXVd2erYi7cgFiInrXLteo7vDevNRgbCpZy7RFr1ew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqQcwKZIMBErbDEnRpcQccNfdvUdY23G6srXoURd54+1eruFFv3KjSHzBPjxLi56LPiH3hdYzAi7znplwyM1YTe/573zxnvMe/ypoJzA9O7xzWbfaDZHzJ8sFZ72GscjQBO0JwJjWVyxOpWCz5p8QDFUTsO0SLG5tO3JxxuMoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plfarEhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1608FC433C7;
	Mon, 11 Mar 2024 22:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710195253;
	bh=DyXVd2erYi7cgFiInrXLteo7vDevNRgbCpZy7RFr1ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=plfarEhsZ+V6nU+mwwfWbYvl9TSYKzDpwMZWwpoCykLBWg83q669C2uAsv2SMEgeq
	 X7FV3G33g5NMhUQIfXbtimciUgGcUdFAZvCb5cm+PJ6Cl1dWno4nic+2ojeKlHQ9Ze
	 vayphPSD6Anp3yJG4GGgt6ws1jMMIFJsOVc08jbT9nrgKLG4SVHTZ7O+62Axh3AN7w
	 /m+OTjrtJc7fLB1dbi3q7ZJld9g6/P7DtBC1gIk1UaKDMlruy9td5Gc/APJRSTXQue
	 baXMcWPZy1LI9FuCV2xTBxHGRTAkgvVlCj1ysnwxsSENT6THhWW7JyF/V6ecu3qsfh
	 cTbZi3tjhOJiQ==
Date: Mon, 11 Mar 2024 15:14:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
 <sbhatta@marvell.com>
Subject: Re: [net-next PATCH v3] octeontx2-pf: Reset MAC stats during probe
Message-ID: <20240311151412.18639483@kernel.org>
In-Reply-To: <20240308181544.806928-1-saikrishnag@marvell.com>
References: <20240308181544.806928-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 23:45:44 +0530 Sai Krishna wrote:
> @@ -3048,6 +3065,9 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	otx2_qos_init(pf, qos_txqs);
>  
> +	/* reset CGX/RPM MAC stats */
> +	otx2_reset_mac_stats(pf);
> +
>  	return 0;

Looks suspicious, all sort of resets should be usually done before the
netdev / devlink instances are registered. As soon as you register those
they may get brought up and used (including synchronously by an
in-kernel user).
-- 
pw-bot: cr


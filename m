Return-Path: <linux-kernel+bounces-91786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0293787169A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC80A1C21074
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A827E7E110;
	Tue,  5 Mar 2024 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="phRzA5j0"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7504C637;
	Tue,  5 Mar 2024 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623085; cv=none; b=t07Qrl8MIxfCZBy2e2u34v74of2gG3KitRIRr/q/nN2GYoh97SobYwa4QnStit2zdqUrBdcLdoTLGShbeNjJgtPzRCxpKYw5c2h70jBQCIGvpOwkxg5jg48UGgMdipPvtrVxdjm+g7/QcDRuMVioo9kwZusz+lI66TtE9M1kd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623085; c=relaxed/simple;
	bh=Ixi/76JR1Pv31+3D5ECr3XuT5VyFkR/xNTnNK8sh2Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWLs3gqwj9uzOpWu4PDisvnFtXazalubuiqRJC2e8HXUo98MCHW1VCU8WGHvCnD+GmMR+Z24Q/R6o63dYg3sQioFsQ1KfbqJ/SaECpSLHICB63g81P73xjEp8RB18uDfYqfWe96IyTs3kMQoX8IN1fXl8V1XmT+ikQYRGwWeQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=phRzA5j0; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9793B20002;
	Tue,  5 Mar 2024 07:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709623080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nh+UsJveD1Ecym5lcFf+LilE3aXKcM7NsG4y2GIHCgw=;
	b=phRzA5j0/oSjNsnnn0j/EbWetXZsK1SKRUc5jRbru3IRKlGhfw/Ixl5MOzKc38yngt0T9W
	lx9u3Fxk00/uHGcHc1HP8L4S3XGv2xWOYXD/M1HifH3Em+K+O978NmmjNVVLp8IiLTwpwQ
	BwgwAWWx+QNYA7gj7simF+3mWgwXDQg2y7QI72fKLz6raikY6hk0NZsEaWEbDJqwFGz5JI
	HCpaCsP2fQnm2KZM2dfWDAbYzLNvyRo26T+e2x0RccDk7sao8vctkDf+kFa/UDPhdq0iKU
	oo0dnEW948LYRfd+vZup5EPOvwS9fgva5ZPN6/aOGaVqjV2I1qisqR1N6WZ9ZA==
Date: Tue, 5 Mar 2024 08:17:57 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>, Yisen Zhuang
 <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Loic Poulain
 <loic.poulain@linaro.org>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net: wan: framer: make framer_class
 constant
Message-ID: <20240305081757.00474e37@bootlin.com>
In-Reply-To: <20240304175246.GO403078@kernel.org>
References: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
	<20240302-class_cleanup-net-next-v1-2-8fa378595b93@marliere.net>
	<20240304175246.GO403078@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

On Mon, 4 Mar 2024 17:52:46 +0000
Simon Horman <horms@kernel.org> wrote:

> + Herve Codina <herve.codina@bootlin.com>
> 
> On Sat, Mar 02, 2024 at 02:05:58PM -0300, Ricardo B. Marliere wrote:
> > Since commit 43a7206b0963 ("driver core: class: make class_register() take
> > a const *"), the driver core allows for struct class to be in read-only
> > memory, so move the framer_class structure to be declared at build time
> > placing it into read-only memory, instead of having to be dynamically
> > allocated at boot time.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 

Thanks for the patch.

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé


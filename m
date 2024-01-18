Return-Path: <linux-kernel+bounces-29701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE58831202
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D67828396B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24DD63B5;
	Thu, 18 Jan 2024 04:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="hjqGPt+t"
Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606679442;
	Thu, 18 Jan 2024 04:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705550802; cv=pass; b=CLdiBuRpmCSKclhgQ9cbpoypkzWnLamjDkYiyZcSF8/pywR0f51zs4zNZ26yPfSgtD13hR9r/BU7z+cAdlvpogpVunzakuic2cOAhFnOGfcMG4Fuk89ZzNkjyNbOjZSBfuErd8BTSOoTy+ZUCePtYzPn/+bA67Ev5beKWNSlRv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705550802; c=relaxed/simple;
	bh=qIGaO+tVgnh7Dkk4Xt328KM7qEKSMW/pudvfRdDrPFo=;
	h=X-Sender-Id:Received:Received:ARC-Message-Signature:
	 ARC-Authentication-Results:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Cooperative-Coil:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent; b=NoUmspFeZnj7GRDFLPBih9B9cuCRf4v3z/sVNOhCIgY/iN2eOhY+3JIj2JLBhl6wZsXRnkG8DxJbK/nQmgS04y/ybQvgIUB5bI4N5OtH5ALzNHjzv8eoyFa2Wpqy7CmRjB5LgYQDI5aaoruVBos3HA6mZQ9Qa/S0Kd+iqKgWEYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=hjqGPt+t; arc=pass smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1B934941335;
	Thu, 18 Jan 2024 04:06:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a270.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 886DB941E03;
	Thu, 18 Jan 2024 04:06:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1705550792; a=rsa-sha256;
	cv=none;
	b=JRUx7qOfVuUnI3e1dofKavoADUTb+OmWLMDRquPkBoy0IdW+yyrYTehFx83CraNnW/oNmC
	rBL/6icm2zdv1Hj1ClfqZjekMGiuZ5rPYPjW8sV884bVDb9UKoMaQPgYoz6HNpP3KfjkFT
	Dkg913d4K6Ul5hj6MoNg3PEmY5Wlt1NonVWnIR+t8EPn3YlQeuM3ptSJGmr4s8FK8j3t8d
	CLz4zwYhlUDwoP0wp2ey511TCv95a8aj7jGpUOmx+dLjQ/PwnYoQ/tr6ACv52zymmfeaUR
	0sjDtT4qd41sWEtthxj/OtsJv+Y2xAHcCWlgvN0cZlJsEfClGnwuzs7ZUAUNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1705550792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EJOE4oWc7zcPOVUmVEWhBrFQsdzfb6SMOjZRrmacEJ8=;
	b=PoxWxYybVD7EfIN+Rg00oABHCttBPbYdQcsmaWr8jVLhAoLW++zMkPDNW5H6NyI4qxSF8G
	CRbaGpKOlTIZKJPf6IpDbeM3XU0UlkhYW0ztRF4lC7Z7cmBAJ5ZeJaIc1oYIyp1lTGjNxK
	wAHLqOHCf0eNIVb8DkyBhXHnqX8P9JHdvRMO5fTc3BlqnpfziKkuONefvrHXjQ1REpWpPG
	DMmDrkuoW/6ttZ7jiiDy1jhi99gqzXWtf1xPb/fuS78eS9fXyN9VuZxH8YtSccsAg0JliR
	KHGU9ElNpf2sGrcpJhlUyiCkXmG16Lwbvh6ig/12zCllDk8Lard6H1heilU3TQ==
ARC-Authentication-Results: i=1;
	rspamd-568947cb6c-w8h7p;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Coil: 7dbfad8f0b06d083_1705550792933_2243798975
X-MC-Loop-Signature: 1705550792933:1660421329
X-MC-Ingress-Time: 1705550792933
Received: from pdx1-sub0-mail-a270.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.114.161 (trex/6.9.2);
	Thu, 18 Jan 2024 04:06:32 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a270.dreamhost.com (Postfix) with ESMTPSA id 4TFq1g5QzGz71;
	Wed, 17 Jan 2024 20:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1705550792;
	bh=EJOE4oWc7zcPOVUmVEWhBrFQsdzfb6SMOjZRrmacEJ8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=hjqGPt+tOJ8do4jmDlqsIQiQSztq48Lw89F5AcA72hJ7GPuJT1OAeNwzX7F+0mCmy
	 Yym6VT7H5ovd7/gqxxEzRnwgxp+iSNXXfVAH3JUCQiNf/7UXmji4rBzkxEnHHoSg2Z
	 LoF3F1waICIx+VzUJJSJnoli3rBH9yFEgvnHbCt8r2c38o0dtAfaoFX3P9P4M9Yhsa
	 +fWT+7U6j/GQKFQvblDwwN+arKLgUmOtsMJiyDfOmy454DmIEP4s7M9w1phmo61cO9
	 r9UhwNQEurid62sjzlG8e0yLeQwHXeMxMQvBmVDxx6TN9csdGC0zs6sIHMWhuu2d/P
	 8pi2+YgdN+zsA==
Date: Wed, 17 Jan 2024 20:06:25 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Larsen <davelarsen58@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v2] cxl/pci: Skip irq features if MSI/MSI-X are not
 supported
Message-ID: <t6wkohozmtchuzzabjigr66tx6576nni54ig7lu2orlvqwmt5o@r52mxzei7uxs>
References: <20240117-dont-fail-irq-v2-1-f33f26b0e365@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240117-dont-fail-irq-v2-1-f33f26b0e365@intel.com>
User-Agent: NeoMutt/20231221

On Wed, 17 Jan 2024, Ira Weiny wrote:

>CXL 3.1 Section 3.1.1 states:
>
>	"A Function on a CXL device must not generate INTx messages if
>	that Function participates in CXL.cache protocol or CXL.mem
>	protocols."
>
>The generic CXL memory driver only supports devices which use the
>CXL.mem protocol.  The current driver attempts to allocate MSI/MSI-X
>vectors in anticipation of their need for mailbox interrupts or event
>processing.  However, the above requirement does not require a device to
>support interrupts, only that they use MSI/MSI-X.  For example, a device
>may disable mailbox interrupts and either be configured for firmware
>first or skip event processing and function.
>
>Dave Larsen reported that the following Intel / Agilex card does not
>support interrupts on function 0.
>
>	CXL: Intel Corporation Device 0ddb (rev 01) (prog-if 10 [CXL Memory Device (CXL 2.x)])
>
>Rather than fail device probe if interrupts are not supported; flag that
>irqs are not enabled and avoid features which require interrupts.
>Emit messages appropriate for the situation to aid in debugging should
>device behavior be unexpected due to a failure to allocate vectors.
>
>Note that it is possible for a device to have host based event
>processing through polling.  However, the driver does not support
>polling and it is not anticipated to be generally required.  Leave that
>functionality to a future patch if such a device comes along.
>
>Reported-by: Dave Larsen <davelarsen58@gmail.com>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>Reviewed-by: Fan Ni <fan.ni@samsung.com>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Yes, I suspected this might come up at some point.

Reviewed-and-tested-by: Davidlohr Bueso <dave@stgolabs.net>


Return-Path: <linux-kernel+bounces-163122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7A38B65FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A2C1F22820
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9D77624;
	Mon, 29 Apr 2024 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="je7bNo/T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNvWvhMO"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6A1E886
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431813; cv=none; b=HOoUS8wWaGagtS7ny0xlhhlxcjijc2VpZzMQMc70YHSgEvNxfNNF3ghPknioVoViUSViks2ClZ/axlSvOwBJp/2Ekfp76sujexHK51A54u3yX+YJK7rdY77vx0DZ7lQF4qEW3VkUL3fsgcAforzmdVw9lWgnS6Gq52CKhfmzhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431813; c=relaxed/simple;
	bh=b5H/VjQSCuBApd1csKcty6lRhLKn0UhY+UToUwXJ7N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqMEmNw1kohbYDk0FSf4TeLEQPZA366ZqycrO0PH0RGw5nvufQ3vyxsWinHNmqz/DZSWIodvfq3DcmlR6PZ3XnOlE/VEHiGZXUuvn76T1bsesbO0SqoBUqwgMQcRIysHp46RYYevtxZQh8pziLRYMivMvXSczXFAO05pIKD74Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=je7bNo/T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNvWvhMO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 30A3D1380198;
	Mon, 29 Apr 2024 19:03:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 29 Apr 2024 19:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714431811; x=
	1714518211; bh=K+c+sH63BiPGJ2Wmw3IsKpfMFV4YwbVEQrdKejkRx6c=; b=j
	e7bNo/TF9nS0qc8RPQJ6B2DHFjEwMGsn6dDCMd9yni8kkHE9L8DGc2IpjoG82PX7
	g4N8FPStaNPfgCXsULN6ZiV9+U5VhO3gP8tMw+slcUUEznQLf5FWH9D8qkdmJPs6
	7/XOnH+LmLdiqx8UM8d94roq1QycfUr3eGzzE4KYd76bMbD1ICPQJVaOX1G6AweK
	HfMWDrkCE2mBL02GMnRu0saRBq+dZ21zDt9B4AJjmijMGnRjMiieL1zgf3IzWRu8
	NX2Yu/69JY4jvQmqoyLDD4ZoodhHxK0O74IYsc9rZi5a984uwnFVedDW9407Y4bp
	OSMkQ1RDzjbaBHfXAxdjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714431811; x=1714518211; bh=K+c+sH63BiPGJ2Wmw3IsKpfMFV4Y
	wbVEQrdKejkRx6c=; b=TNvWvhMOW1ESaDNWK5eVynB5Jn+ON01UcLFu3aUAjIo4
	TCXg512RBA7Kn2EW7UwrMSxLW2W3jzHNYlBAn1hjagLuYCFrWPeG+1yD9VJO+mS1
	GNcLk1i6VSGwdJgDi/VHjCuJcEREbj2dMLvukrShhw+1gekxf+7h08E45QaLSaPR
	B37NICXnRKfnNGBDLDGkoI1Zy7xUW5MgYA5Y27I+kaKCiAkPTnwJUwQBWe28bR3f
	sy8VjY2GmnC0v1RzQAhWX8svHiHtWP6X5CefGkbUQ+TYg56w5lvXRQkOMhAx9a3X
	ktI6yAA7Jqllcz48TqNO3re5E1L6rT5jHKTb7uBB4w==
X-ME-Sender: <xms:QicwZpvqcIT8Z3Nq0mgBledsP6nErmKBMT7xupHLJVbnDwUDb4OgCA>
    <xme:QicwZidCtc-ba7WOwMP7-uYKBiu07g3jnptOnZRzs0ymoD7HV1zWDrBdKMZj17yq1
    w_VjbGL_NGqV59kNP0>
X-ME-Received: <xmr:QicwZsyM8A4jGFHfy-c-90_DZw64T-a2PyJPdbZyyKXdhFg_9IyC0N95k9l8gXiUOcc05rcs5nO3JkQJIyITHGiKNb-HDxYJyyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevieelhf
    dukeffheekffduudevvdefudelleefgeeileejheejuedvgefhteevvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:QicwZgOn3nPTZzfHhIry0SXNMyCDp9EmntvwZDdcdTyzWKkt_cIceg>
    <xmx:QicwZp-S4Sx0UTQEUVjMrfKVv5Q5chm71mlCS_wDzvGQWDKqQg5xfw>
    <xmx:QicwZgXkQFOqodGsoP8CYP7xkhQ-OcOQ84Be44nRDLPnyc4Yc1HnHg>
    <xmx:QicwZqclt7wVGrtil--pbZdyltaonBuZ2ACxtPZSLImpg0rpbZnRvA>
    <xmx:QycwZrK06pEAtsUwGCLUnSyEr3RrKrc2VCydvgk6gePVD2ikE0L39u_V>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 19:03:29 -0400 (EDT)
Date: Tue, 30 Apr 2024 08:03:27 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] firewire: add tracepoints events for asynchronous
 transaction
Message-ID: <20240429230327.GB714896@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240429043218.609398-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429043218.609398-1-o-takashi@sakamocchi.jp>

On Mon, Apr 29, 2024 at 01:32:13PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> The series of changes in this patchse is to revise the previous RFC:
> https://lore.kernel.org/lkml/20240418092303.19725-1-o-takashi@sakamocchi.jp/
> 
> In a view of IEEE 1394 bus, the main function of kernel core is to
> provide transaction service to the bus. It is helpful to have some
> mechanisms to trace any action of the service.
> 
> This series of changes adds some tracepoints events for the purpose.
> It adds the following tracepoints events via 'firewire' subsystem:
> 
> * For outbound transactions (e.g. initiated by user process)
>     * async_request_outbound_initiate
>     * async_request_outbound_complete
>     * async_response_inbound
> * For inbound transactions (e.g. initiated by the other nodes in the bus)
>     * async_request_inbound
>     * async_response_outbound_initiate
>     * async_response_outbound_complete
> 
> When probing these tracepoints events, the content of 'struct fw_packet'
> passed between the core function and 1394 OHCI driver is recorded with
> the fields of header and packet data. For example of the outbound
> split transaction:
> 
> async_request_outbound_initiate: \
>     transaction=0xffff955fc6a07b30 generation=5 scode=2 dst_id=0xffc0 \
>     tlabel=18 tcode=9 src_id=0xffc1 offset=0xfffff0000984 \
>     header={0xffc04990,0xffc1ffff,0xf0000984,0x80002} data={0x81,0x80}
> async_request_outbound_complete: \
>     transaction=0xffff955fc6a07b30 generation=5 scode=2 status=2 \
>     timestamp=0xeabf
> async_response_inbound: \
>     transaction=0xffff955fc6a07b30 generation=5 scode=2 status=1 \
>     timestamp=0xeac2 dst_id=0xffc1 tlabel=18 tcode=11 src_id=0xffc0 \
>     rcode=0 header={0xffc149b0,0xffc00000,0x0,0x40002} data={0x81}
> 
> Takashi Sakamoto (5):
>   firewire: core: add support for Linux kernel tracepoints
>   firewire: core: add tracepoints events for asynchronous outbound
>     request
>   firewire: core: add tracepoints event for asynchronous inbound
>     response
>   firewire: core: add tracepoint event for asynchronous inbound request
>   firewire: core: add tracepoints events for asynchronous outbound
>     response
> 
>  drivers/firewire/Makefile           |   2 +-
>  drivers/firewire/core-trace.c       |   5 +
>  drivers/firewire/core-transaction.c |  93 +++++++-----
>  include/trace/events/firewire.h     | 211 ++++++++++++++++++++++++++++
>  4 files changed, 276 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/firewire/core-trace.c
>  create mode 100644 include/trace/events/firewire.h

Applied to for-next branch.


Regards

Takashi Sakamoto


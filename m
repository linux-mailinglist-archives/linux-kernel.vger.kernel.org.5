Return-Path: <linux-kernel+bounces-135090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD8E89BB09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C456A1C21E92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321F3AC01;
	Mon,  8 Apr 2024 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="EfCgZy5X"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2412C2E64C;
	Mon,  8 Apr 2024 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566645; cv=none; b=hwpfrIqZ0gMp8bmc8fZdGMGw5tPFsIm+hk6mhtFxNscjHy7NvPg4SuEN+NL6CJa6S5TKEZf/V9LoZDotTTPOZJvgfPPi0VbNOLMldA7CWyTp4N2KtF4Z/VjSfFB43I7cAHqbwtZAzfFIVS3B/SXehRboDVfqRMa6JneMrcK3mOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566645; c=relaxed/simple;
	bh=CHwhXvWRJJdiCjRhQWA5o9DaXlliync0A7Xrh78tZBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=opYB1hGNvDdlYR9lKFM2dcyBWrxz9Z+c+wlezpZBQbj1DNMK7dmsw/ne1sE4eDNpkj0nd3kD57r9l2ifQhU1qz4ZNB0/A3SodNjjUUTtJBQmFLED7dGqpAOavcAJ7QsNCo6sW0pXR9zzoQ2PwLx1pIkfK4U0dP2/9/p7W2bwTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=EfCgZy5X; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8DlgyS2RFXSZ+8hHtM+5mTRKoe9iS0/P7ZZC+brmRb0=; b=EfCgZy5Xp4rB7Au+0+X/V2/3oh
	UFx+5H8hHnSzQk5OBFc9V/xl6frSjzSbaMGYNmbbN+I+/u6VtKDl9jEcgDaBCVZPXVaUHImlmnhxf
	ff5bWNVw2gWty5tdonPd47Q9lu+zKN2ypUf78CVkC4dirV7AdO3G0GMOG4ypOMAubuX6hn1VU6v94
	w1V7uqb/tqS71n2733Jt0AvbnOrt2N543HVvFOZb/by2VckDhUVnIYZnl6fEzAHdacEK214PQpVOr
	JtPESUbECJXxSw8d2w/saWeUY5r1Og7XFnlFbKMUC/f6nE/8EGLfUmlH8t7KW+mwHaLIRlPgdCPRx
	VrpMFeuA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rtkob-0007Yw-6j; Mon, 08 Apr 2024 10:57:21 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rtkoa-000MKe-Fg; Mon, 08 Apr 2024 10:57:20 +0200
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
In-Reply-To: <20240405-amused-cascade-0801f31c674a-mkl@pengutronix.de> (Marc
	Kleine-Budde's message of "Fri, 5 Apr 2024 19:33:50 +0200")
References: <76cf9ce9cbf9dcdf78bc00ce7a919db1776ebce1.1712309058.git.esben@geanix.com>
	<20240405-impurity-emerald-f67dc37adf9b-mkl@pengutronix.de>
	<874jcf67xm.fsf@geanix.com>
	<20240405-amused-cascade-0801f31c674a-mkl@pengutronix.de>
Date: Mon, 08 Apr 2024 10:57:20 +0200
Message-ID: <87plv0kz9r.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27239/Mon Apr  8 10:26:06 2024)

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 05.04.2024 19:22:29, Esben Haabendal wrote:
>> Marc Kleine-Budde <mkl@pengutronix.de> writes:
>> 
>> > On 05.04.2024 11:25:13, Esben Haabendal wrote:
>> >> By waiting at most 1 second for USR2_TXDC to be set, we avoid a potentital
>> >> deadlock.
>> >> 
>> >> In case of the timeout, there is not much we can do, so we simply ignore
>> >> the transmitter state and optimistically try to continue.
>> >> 
>> >> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> >> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> >
>> > Where's the cover letter and patch 2/2? Have a look at b4 [1], it's a
>> > great tool to help you with sending git patch series.
>> 
>> It is left out on purpose.
>> 
>> This patch is a stand-alone patch as it is. The other part of the series
>> you are talking about is not going to mainline for now. It needs still
>> quite some work, and will only go in after all the other printk stuff.
>> 
>> I hope we can merge this patch as it to mainline now, instead of piling
>> up more than necessary in the rt tree.
>
> Ok, then send it as patch 1/1.

Sure. Sorry about that.

/Esben


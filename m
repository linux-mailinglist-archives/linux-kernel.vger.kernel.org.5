Return-Path: <linux-kernel+bounces-90581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505B8870195
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0722A1F26334
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295113D3B3;
	Mon,  4 Mar 2024 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="idTVtYf/"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ADF38DEA;
	Mon,  4 Mar 2024 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555558; cv=none; b=aTF3137tz5KBRS98MtG+rY8RKBjQtW7NXOobiWgx6lEmWTaWmfykkpElQfjj82SLwoel/BFV95lbcTlEMYO9hB9ks1ShMLTGEaHdZAAxb9hA5b1RWnRkx1kNLhVpRJVBqxo9ooPldp3RuCE56TwkGx83bveqP8x/BaAsKfsjKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555558; c=relaxed/simple;
	bh=di4c4mREnB9k5kEq9w5dk3pY2MZiD+6QT9eZNjhDu4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuA5GaWLksV3Na3rGcItY4UO/6mFvglhdmXhsadtzHj4T/eKi9inEkueTbaeQhS/MkV3Z60XSaBhoVn3oMS14hBkU9CmbpJJzfRv+9sNX4ZrkQNrPTwdUpS6JlRRnxcMLOKw7WNQJX+apxwGb46uJbqsuTiuS1/aLYdjsE2Yecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=idTVtYf/; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709555507; x=1710160307; i=markus.elfring@web.de;
	bh=di4c4mREnB9k5kEq9w5dk3pY2MZiD+6QT9eZNjhDu4o=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=idTVtYf/zbwHYQoEQSmrMqo8POAzdk9xYUYecKBUyVeqwAVFpxAKKVfkeJ+XSR5J
	 ADtLS5nbKBGAy6+YswKLIthBlVlp7S0jGeGGBk0Buw7Mgt+j/GhmGN6lfPf/dQUZf
	 UsZx0bI8EAIeltqDlveSumNBRVDIsZkJutM5Qh2pv3twPyLnCaJXooF058kKp9JaX
	 RkeOs8+IwNPfvMyBkQrrtHSQOwDVCYTXpgJxqB527iVKCoi21MitTIeQef8uP77gg
	 ZtsxrP6U1CaBbPhh41BjedZMBJRvy08uxtsb0p/ll5sXYq2RJG9/Y3gcEsOSq3fks
	 Bg5gdV3vwfOHiIlzGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8kX-1qsAcl42OH-00tJYz; Mon, 04
 Mar 2024 13:31:47 +0100
Message-ID: <ae1a88d8-2c7d-4d1a-9ade-ec8c6b4b13eb@web.de>
Date: Mon, 4 Mar 2024 13:31:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Input: iqs626a - Use common error handling code in
 iqs626_parse_events()
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeff LaBundy
 <jeff@labundy.com>, linux-input@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 LKML <linux-kernel@vger.kernel.org>
References: <8a7607f8-d634-415e-8269-e26dcc0f9fdc@web.de>
 <ZeU8ENmnPj3sKxAv@nixie71> <ZeVOPSt0L1D4BxuZ@google.com>
 <11e5db31-2a8f-458d-a249-7205e37aa20f@moroto.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <11e5db31-2a8f-458d-a249-7205e37aa20f@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dWWuhieQn2ltbceIa2J3okqIXFlEceqale7urOiL33IgAP5AdOb
 ukSSFWgsxiveF29HzREbMe/hWax++JLv0Ezq1ovbyrRT7KnAJvhb4I0/1eZF/64/3VfdOlU
 xHShmCEVqdTfA4t8YxSty1zf0hUC3tLaenXijBC5ctCYJgYxm8OnpNtjhlcbt3MT46D2/fX
 j9o462CRckriYePWXAZ9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jv8M8nYNTj4=;ji6CCsnWNMQia0Ua0J4XG3nAc2d
 QP7Gu8RP5eie815ZA/XYAKWzBA9VjyCTm8sT8qXAHYJKcTwAyC1IKi/gSWLV4/YdZbck9Q2wJ
 UCUJm+i/hWivJSxABu/OQ9YeSknnT/ffGHAoEU8++uU4gJBKvc2OorWcAzwzUTArtTx4KpNAM
 0c5uQc2rd0o3f8ODPWReAe56FCfqVeTCOb+9pxJq1Ag3ntbviaZrN2V+Hi7132QtL1/18OFw+
 us60/PfOjmRpj2FXH+zCqFORae4E1M12Jxg9WR3ghHbEyMkO3+YcaQgtJGSSJfU910248m/rB
 1bYJNBpLjGlqnkn1X//tSysMLJ10G8aC+czWornumktProQm+lpiVhXy2szxq/JjIqGQQqnW1
 6ESN27AeXQ4m1DC2Z/cw1tkSC3ePVF9MJC8VnJN8rBmgkR4oe3bJGiVRksn4159ZkMLdFjEfm
 hfgzD6KV+j1S3/UQBbsa9rx0ss6Cd33PYZvAUfHutwZnVOWSp0o4qTOv4tB4QsMiPJP6eWJKL
 HTgMsN2jIxvfNclWJ6dzRf2s7hE7U89CVmehW2aQ/3Hsmu3HTLwvWgAODc1+chJVqAQ0q5l5K
 Yslw6Al3RZm9S9NQeadxMsV74ZIVGp8p7El0IvDNNHFyg16qeiWSUvzOn0Lw1xURtTGdKOb5P
 aRukp+k30QY6lqAP3ycGpKfc8wc0S175hXBpgQLKb++rQIVr/om54XniT4wESn63yrvEBL9il
 Ga5t3tFh4rnQ+NdSXnQs421kJmoyk3FvJ8guTYkA4kW4Odo4Mjd/39k8e1x32hs4KdGU6xiGX
 3537NbffgQvlC3MTIL2WqrmcS/+e392WQ5BWtf89Jc05A=

> DEFINE_FREE(fwnode_handle, struct fwnode_handle *, fwnode_handle_put(_T)=
)
>
> I can send a patch for this.  You need to be a bit carefull to move
> the declaration into the correct scope for this to work.  I should write
> some Smatch rules for this...

I became also curious how available development tools will evolve further
for improved handling of scope-based resource management.

Regards,
Markus


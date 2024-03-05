Return-Path: <linux-kernel+bounces-92751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10364872584
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4264C1C21CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE075256;
	Tue,  5 Mar 2024 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YhMrLrNY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z34JRypL"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A913FE0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659091; cv=none; b=iXWAS5IA35w4RKu1dEKfA1VdsStoTzBUy4AuoDLoZh/zGqEIr/R1oaVje2HqUULqV7QWrviOKV+knnJhl4lrMS2ol4LT9jyAqcDTro553YGogTK0vjBafdECS+I7gUJ3EoAa8w3IylagR0qWxiQVl5EBGXST+VO4ZO9JY4ofvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659091; c=relaxed/simple;
	bh=qKGXNp6adDAyRl3esXjlOtVPpPC6y+p2J82LI4SlQi0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Kb+6AWIbjQepq0RXfb0WUeDBXch4gj26k7v+J7vXD1g7cTHkm45JAXBxOJ8V7NnlhGeVHm4t1wNUFPD82xsKR7GyH65V54Pvzq4qfE2pfCkWGqah6T4bO3pdoVlwUkZ9Xn8q1BXN4U5cw76MAK3NGRS606d0Hbwdfr9rPNBJ1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YhMrLrNY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z34JRypL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 18D1713800CB;
	Tue,  5 Mar 2024 12:18:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 12:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709659088; x=1709745488; bh=w++g7aHIMZ
	Ldmtuh1Wj3Mc3nyL1x07JT54IB2NOuQNQ=; b=YhMrLrNYorhuGEkGQr9tWJ9KPE
	t7WrHITfCKs4clrG6zHpekssVU8lxQjqWKWOSjTChoDS+a+zWfFtSs6bgpHlWkqF
	ufJb+CyIfkxJNnwOIsBmCxooyLnxijKcgH4Zo1UOm1MPlxlyUzzsVSOadgFwBstl
	vwW14xZepbTV5twjB3rtLECUZaxZ9y7WV+ihjWoHDFYXvF9FMaKtlWDSFIpJpuWt
	c+sLzTsalZH5Yx3P0UHb3TVolfpyaEkAqw2x9aBKymYhd73q15WRt6lp7ox1xtea
	M7/0wHY/qcf3Gm3OxVeMiX08Cg1JmiCz0I34wyeOnD1UWY+yQan/DW6Y2lxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709659088; x=1709745488; bh=w++g7aHIMZLdmtuh1Wj3Mc3nyL1x
	07JT54IB2NOuQNQ=; b=Z34JRypLDsegQrtgLXZBgyxel8X7gvZbeO2+P4hix7BT
	JfHou4jGIXSaq+Na/wGGqnkCYmmyIR8dFw83jssLtb3T2swTrNQi08qmiBowTxoe
	vn0NfFkiSFJNHzSiXPZcK5g6WfmQhrf8OIZ/KJoP72RqCumCzbQ+l/noSJGS5M3a
	J3XR4NMdR3LcRQjpJC66QebO+Y6VsstqUlhXus1Um11oW//jJkAbEtLN2mujNtsg
	Ph+/trG3PDP3XHn/TZVvuW0gnOOYeWOXF9ntHirxTwxdER7fCBaXP7gm8zRETaW2
	f2K+LAICQ59gBTwdMgTnVCoF6my7OclO0ttAQU2Ekg==
X-ME-Sender: <xms:z1PnZdp5YVu_CuJz3EqX36F4XuXenEKDlZXjgaAcowaGvC7FecvlxA>
    <xme:z1PnZfrZ6CROLlQEcPnTGereJ-TUn3H5__vqsuGmLf9SAaYx95Dt-EIQsDOF9XU5O
    2Bmm33tSfK2snZtB98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:z1PnZaPD06A7SQcGPuSQndNBATC4ir9uD_XJXyUisDAFsGiyIK_U6w>
    <xmx:z1PnZY4qFrXrm29xPqn5Rbjj7AzcfZ_qnJ-cNMQI1w2uyLfK3oROsw>
    <xmx:z1PnZc5215_vF_8j7aQv7C9PU9ZgzuPK2UK3tuWZUBQMnglXI5zntg>
    <xmx:0FPnZZsJ6ZhI_CZMyp0rWJ_SPVMxtwSC0eAwNdDl-PlT8EtabC1BeA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 512B6B60093; Tue,  5 Mar 2024 12:18:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4de9e676-74e7-4bd0-b821-4e3270487dbb@app.fastmail.com>
In-Reply-To: <ZedSJcBGj89-XQWY@smile.fi.intel.com>
References: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
 <20240219195807.517742-3-sakari.ailus@linux.intel.com>
 <ZedSJcBGj89-XQWY@smile.fi.intel.com>
Date: Tue, 05 Mar 2024 18:17:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "Hans de Goede" <hdegoede@redhat.com>,
 "Tomas Winkler" <tomas.winkler@intel.com>,
 "Wentong Wu" <wentong.wu@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] mei: vsc: Don't use sleeping condition in
 wait_event_timeout()
Content-Type: text/plain

On Tue, Mar 5, 2024, at 18:11, Andy Shevchenko wrote:
> On Mon, Feb 19, 2024 at 09:58:06PM +0200, Sakari Ailus wrote:
>> vsc_tp_wakeup_request() called wait_event_timeout() with
>> gpiod_get_value_cansleep() which may sleep, and does so as the
>> implementation is that of gpio-ljca.
>> 
>> Move the GPIO state check outside the call.
>
> ...
>
>> +#define VSC_TP_WAIT_FW_POLL_TIMEOUT		(2 * HZ)
>> +#define VSC_TP_WAIT_FW_POLL_DELAY_US		(20 * USEC_PER_MSEC)
>
> ...
>
>>  	ret = wait_event_timeout(tp->xfer_wait,
>> -				 atomic_read(&tp->assert_cnt) &&
>> -				 gpiod_get_value_cansleep(tp->wakeuphost),
>> -				 VSC_TP_WAIT_FW_ASSERTED_TIMEOUT);
>> +				 atomic_read(&tp->assert_cnt),
>> +				 VSC_TP_WAIT_FW_POLL_TIMEOUT);
>
> First of all, there is an API for such cases (wait_woken_up() IIRC).

I think wait_for_completion_timeout() would be the obvious
replacement if the wait_event is no longer waiting for the
gpio but only for the irq handler to complete.

     Arnd


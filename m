Return-Path: <linux-kernel+bounces-65209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580E85497A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B211C218CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9391852F91;
	Wed, 14 Feb 2024 12:42:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2853048CCC;
	Wed, 14 Feb 2024 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914579; cv=none; b=R3IbV7kY9g6gwj4heC1lirUolmvx6FZldRBOhir2Q7Zk7Nt5dAnFtxvYV4grkY6WpmrT20284t11gE9dhuRilPTTrqCMBRYf9ecXurQ1C6A2EAYR3aaMNw+/iEPL3Me/0E8lt96s//ULDPVqIaHlC9nFb4NEgfveBbw3CXt2Jfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914579; c=relaxed/simple;
	bh=jxmlOviVwF7abdnEw/5MzSSrj9/prgdLL0S3wz8HToQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBoyp6FLzxoy08MHQygwe6cs78bgFpODq8F1aLufxS83wjY9kafcVXBlSAyjXt6+q7t4JFuBFS4v9NpAiAYNS2E7+iglr4MCIpxv/x0hQO5Vv60KMIG7AY4pEK1tufQQSQQpOnTou//ZMcbW7zRtJ4kAHwg4rsbgvmS87IGzQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4CCC43390;
	Wed, 14 Feb 2024 12:42:57 +0000 (UTC)
Message-ID: <3e5b41c0-1249-4546-a146-7c832cbfff28@xs4all.nl>
Date: Wed, 14 Feb 2024 13:42:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: v4l: marvell: select CONFIG_V4L2_ASYNC where
 needed
Content-Language: en-US, nl
To: Arnd Bergmann <arnd@arndb.de>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20240213095555.454392-1-arnd@kernel.org>
 <24cbf7b2-a091-440e-92cc-5c9828d52260@xs4all.nl>
 <ZcyW8zn14iIbn45X@kekkonen.localdomain>
 <2027d488-a245-4492-bc17-27e17af575fd@app.fastmail.com>
 <6067898e-eaac-4266-b4a3-388db9a918fa@xs4all.nl>
 <7ec182c6-bd52-4433-bf06-dbc71f186184@app.fastmail.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <7ec182c6-bd52-4433-bf06-dbc71f186184@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/02/2024 11:58, Arnd Bergmann wrote:
> On Wed, Feb 14, 2024, at 11:54, Hans Verkuil wrote:
>> On 14/02/2024 11:48, Arnd Bergmann wrote:
>>
>>> It was definitely working before ff3cc65cadb5 ("media: v4l: async,
>>> fwnode: Improve module organisation") in linux-5.13, but it's not
>>> clear if that is the culprit. It's probably safe to backport
>>> to v5.15 and higher.
>>
>>
>> If it has been broken for so long, then should we bother with v6.8?
>>
>> I'm not saying we should, I just like to get your opinion on this.
> 
> I don't have a strong opinion either way, there is very little
> risk and very little benefit in backporting.
> 
> If we apply it to 6.8 at all, I think it should also be in
> v5.15+ LTS and vice versa, but only queuing it for 6.9 is
> fine with me, too.

OK, I'll just take this patch as-is for v6.9. I'm preparing a PR
anyway, so I'll include this patch.

Thank you for the quick replies!

	Hans

> 
>      Arnd



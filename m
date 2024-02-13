Return-Path: <linux-kernel+bounces-63341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5D3852DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9AC1F21B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB86022F0A;
	Tue, 13 Feb 2024 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YIcJJkru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q44GQUQD"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0074222626
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820041; cv=none; b=XtUMMuEsn1x61k7lHOR4laPnrcQW+SvlJ4u0yA43yQa/IiCA069qcjtMWx7tmfoeJVTiK0REyM5yuTgXGWWpSPxrYTtS5qFvSD28lxJf4GE7oNK0kHrJbVGnclBbN9LRxYR+jfjSrs1fqx9VcWuPBTSmJozXfpnqWd07E990BKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820041; c=relaxed/simple;
	bh=A+IPxMsDDumipnPJZLNtkthokaGfLGk97Mz9Ox7uIiA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=SEvHVoMkCoBSBtcqhmxdTEiuaWBiz/kWjmqnGuT2T/w6zFj3VVOXqV3KN45g0vwxOSYgkRMe8GW6DcgFD713gSMEUyu7Zi01F4KuTkKWjcciXOebhdDCIciysoTCN/YWjJo+ncVexsUtm5weyCXgXJYJXI5kGsrZRuzHg0/BxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YIcJJkru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q44GQUQD; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id C25E91800087;
	Tue, 13 Feb 2024 05:27:18 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 05:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707820038; x=1707906438; bh=mA+uWCPKsW
	Nzn6w+caTmw+9idey2YfNF4ai4GleOvOo=; b=YIcJJkruoWMHvFQqtEX01hfHeO
	Tzf07A2oG+/+fhDhXLSl3/9xV1uSKNxtOFSBDkDCDKId/ZbibmB24EqT3fuhXaXA
	3UfG7ZwiRXOylW7nPJz0qo+KcIbGesZ0GWWTQtGB8/5Fhst0s4ng++RJC9OuUTwj
	rGoJIJBz05R7oxhOXNugfFFwf0SjeIYUIN3lGgmjb8bQTC4l18CfZStz5Z8F6qCX
	gPEOhY4izP6MNO8EJDproFdcpqKOAvLl6Dky96HT0LEXjTp6uYgAZjKjuF+NExxx
	yeQpD/CssdxAJ+7PUGFcUHWWDagEkekQm7N5zFxQYbpv3m+L4yQyreZh8Mrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707820038; x=1707906438; bh=mA+uWCPKsWNzn6w+caTmw+9idey2
	YfNF4ai4GleOvOo=; b=Q44GQUQDZMBIGLjd/2iqMgQLa9EPm8FvUOEOf24eE0q7
	BczOnXPoT3WqD0N02W1KcyJXsiJbXZI3oZiZuktBaWyym1jYeOtl7VlREwLdM/8Z
	FPX1vZFee97Tu84eF5wrG90IwKSSCPy1RbEnYvXyTMnXvluPvNDKOol3Tvi9Z7eL
	IFH3TgDmiZk/TfBL1fPvnUUs3g3RUsfobiiCdU8orxjoAMRKPCFrd8gjCI5RcnB6
	AeODb+9WgbdfiJ1n/yr0AprjTE8YZkIqvIYPyuUS6Nfwz0LY6t1VGAAvvUkzkmu6
	7eVBQYZiHrwH3laJWCDyr4yV2sT3AQywCD9kL7Ii+w==
X-ME-Sender: <xms:BkTLZR-kmqzY5ZOIzgr_6jVw4-mvbx-2bqVbqUgSZ_c2UwdiLgTF5g>
    <xme:BkTLZVvX1eNOGmuCh737VAvU3VVOQMVd7x0ILNo7eSzbb2nAm7ZOkWN7pSUaL_JKS
    4f8Ce7uyerUGjKLzcc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtsehttd
    ertderredtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegr
    rhhnuggsrdguvgeqnecuggftrfgrthhtvghrnhepffehueegteeihfegtefhjefgtdeugf
    egjeelheejueethfefgeeghfektdekteffnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:BkTLZfDLzIrTd0erV5Kjoim08XyWGniRlZxIQdOJqfIxprsXHezYgA>
    <xmx:BkTLZVfhj34ni1fiGLdgSjb694_AEndGk9aP4cqCvaB0TiHdwuV1SQ>
    <xmx:BkTLZWPgLpKBJw0UZul2XBkM-9vW-pZ37_8IYtUsQMGNaux0CfB_sg>
    <xmx:BkTLZTq0NFWtNRX7wCrcMrQRsf4B3xWmUz7sWQk4dcFjY5DZHg93K9Z3daA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E8FFEB6008D; Tue, 13 Feb 2024 05:27:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3c76ba23-e4d7-49b0-b53c-b60772a25891@app.fastmail.com>
In-Reply-To: <20240213102139.gnfh5sq24rwu7wnp@quack3>
References: <20240213101733.461544-1-arnd@kernel.org>
 <20240213102139.gnfh5sq24rwu7wnp@quack3>
Date: Tue, 13 Feb 2024 11:26:57 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jan Kara" <jack@suse.cz>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Jan Kara" <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: avoid printing an uninitialized blk number
Content-Type: text/plain

On Tue, Feb 13, 2024, at 11:21, Jan Kara wrote:
> On Tue 13-02-24 11:17:28, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The error path of find_tree_dqentry() now prints a variable that is
>> never initialized:
>> 
>> fs/quota/quota_tree.c:674:8: error: variable 'blk' is uninitialized when used here [-Werror,-Wuninitialized]
>>                             blk);
>>                             ^~~
>> include/linux/quotaops.h:34:41: note: expanded from macro 'quota_error'
>>         __quota_error((sb), __func__, fmt , ## args)
>>                                                ^~~~
>> 
>> Move the calculation of the block number slightly up to make it
>> show a sensible number.
>> 
>> Fixes: 223bfb57631b ("quota: Detect loops in quota tree")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Arnd, this should be fixed in my tree as of yesterday and I can see that
> you've even based your patch on a fixed kernel :)

Right, sorry about that. I did a lot of fixes yesterday and
sent them out after making sure they did not cause any new
failures in an overnight test build, but did not check carefully
during rebasing.

     Arnd


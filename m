Return-Path: <linux-kernel+bounces-35935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F190F8398EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F82B1C28C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318D912839F;
	Tue, 23 Jan 2024 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="YkxcjYqP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E5nQUiK0"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401A481DC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035910; cv=none; b=Q7JP9tzqyfhwAjdpoWbOyKI5s/Stv2oZ56629PBNInGdFSzAAccnNY0FoIw/kIDAobP8FySEEBqnuqMEPwXbY0ouHqHVu6Y5+FBtvWPm3gAJx3+VLsZ/pS7Yb5epfkQ70PJJbl0Ys0l/0WI3g2J9+FP7ydbo0jTed8Kb9PCb0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035910; c=relaxed/simple;
	bh=0j+P7FwDXOaWAcO0QMs/fHV3AZl5bRkW41gWFJG8Ov4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DUhAj/luQThKNv8o/a2To6tPgtQDgIGDzkx8wViafb6teEvSSRLZklOBJDyXo8aIoNVp4uWaDim4WFq9BCBPaKH8HjyzTJNIlSbWSo4zajiOuSZ7SLyOGQpawT3gni6dEUk40Gm5jSvM6DHBCTj6qVTWwXAije55WYpVPN2Le/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=YkxcjYqP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E5nQUiK0; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 5EBD85C00EA;
	Tue, 23 Jan 2024 13:51:46 -0500 (EST)
Received: from imap53 ([10.202.2.103])
  by compute1.internal (MEProxy); Tue, 23 Jan 2024 13:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706035906; x=1706122306; bh=eIhN86Lh1o
	FbG7iEsTBql1sUGIAIhzr7pTidTH0KO94=; b=YkxcjYqP7zv1Q1UJo+u25buzs3
	65dwS+kWssYQqDc9bo6V2J5edttkZkg7zohFJum2+8X8XzCEUgEu2LTTx80Or0dF
	rf+HILcVuGSNM2zOg/IZ/Qlf/Gzm828mYhwpTIZFPFhzJZxVfCh+3UZuWjEAw6ol
	d6SD1iHSTwKhMW+BF03rLMDryBsoxvsfWF8lfTkaOGBiMmBLl58pNXzyPTnrJ6YD
	uaOMU9sO9Ler/D9bFhPNDVPtKYVZdb26XYQd+xA0IhN7ZizGcl5r+nlutGddTVab
	9gtCQl4HbXJ2GmQQNjxiDGY9ezHWbGefvKiDnB9rRmqcNYuhiKJr2gQhbqJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706035906; x=1706122306; bh=eIhN86Lh1oFbG7iEsTBql1sUGIAI
	hzr7pTidTH0KO94=; b=E5nQUiK0Emr6DnF9HINgIoD1V5bl1r+KqEiOLEvgfE59
	HjeEoA6KOy+E4aex9YAhf5PWev0oxqn+k9i/tOgVL+hA6dl9THjVyvDrizITGlBg
	78498S9KYalIBc/5ohOkj9oyx3wZtojEisiRUybtxk2UGRwiHZKiKP+gAREK14ia
	4GOiGBSsmgOXuOjwrq1O5+3B2xlZYNzJ1pJSZlHF2ft2VbBsp7BAUd7ZUmGYIEnu
	6rzE9dlUr9zdbijeBRiSmHOQ4U/9Ai+7eSFanR+pSBmakubdN3/z1gB4TASMYJDT
	w/zMeawbujQMg6slo9HQT0kpe0COnNzcb1de1Qlurg==
X-ME-Sender: <xms:wAqwZX_j8Llq0DrEzoo9SiA9WqQIVH6oXplVNbLzgdBYzwnCDjK_8g>
    <xme:wAqwZTsT_7o1tFNkll9XlpmmrXSyGLirEOks3QV4s_GeA6ZE_FdGv1zlgMbm5rLer
    YSc__8hLNhUGXIPckI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfl
    rghnnhgvucfirhhunhgruhdfuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtth
    gvrhhnpeejfeekgffhieevhfejgfetkeevvdehteejfedtiedukeefuedvkeehffefvdfh
    ueenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvth
X-ME-Proxy: <xmx:wAqwZVCKpqVkqZkjKkOU6nzeJgIr-wYQv7MUFfGU2zkO0YuL1-XSIA>
    <xmx:wAqwZTcw0E7Dwd0cxZyKHg8Fz9P42Vv3EZWhoYUNOsb8hZaf8ko7eg>
    <xmx:wAqwZcO17foPKjKFckFIU48eX6oKTTYE8UXCMCy5eshrjp7Vxofq2A>
    <xmx:wgqwZTfiD0IzojjKojg1p6O-Wu1S5mK7s7jMNMzO3FsDtXwCUlvp_w>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BE4A0364006B; Tue, 23 Jan 2024 13:51:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <489e3e5d-25e7-4e84-9e62-b6e52bf7455c@app.fastmail.com>
In-Reply-To: <3da403ff-365d-4cea-86f0-4009d1da6baa@app.fastmail.com>
References: <20240117104448.6852-1-arnd@kernel.org>
 <efebd848-c952-41f8-9422-fe2235d92259@app.fastmail.com>
 <3da403ff-365d-4cea-86f0-4009d1da6baa@app.fastmail.com>
Date: Tue, 23 Jan 2024 19:51:23 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Arnd Bergmann" <arnd@arndb.de>, "Arnd Bergmann" <arnd@kernel.org>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc: asahi@lists.linux.dev, "Hector Martin" <marcan@marcan.st>,
 "Sven Peter" <sven@svenpeter.dev>, "Asahi Lina" <lina@asahilina.net>,
 dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: apple: mark local functions static
Content-Type: text/plain

Hej Arnd,

On Tue, Jan 23, 2024, at 08:34, Arnd Bergmann wrote:
> On Mon, Jan 22, 2024, at 21:50, Janne Grunau wrote:
>> On Wed, Jan 17, 2024, at 11:44, Arnd Bergmann wrote:
>>> 
>>> -int parse_sample_rate_bit(struct dcp_parse_ctx *handle, unsigned int 
>>> *ratebit)
>>> +static int parse_sample_rate_bit(struct dcp_parse_ctx *handle, 
>>> unsigned int *ratebit)
>>>  {
>>>  	s64 rate;
>>>  	int ret = parse_int(handle, &rate);
>>> @@ -715,7 +715,7 @@ int parse_sample_rate_bit(struct dcp_parse_ctx 
>>> *handle, unsigned int *ratebit)
>>>  	return 0;
>>>  }
>>> 
>>> -int parse_sample_fmtbit(struct dcp_parse_ctx *handle, u64 *fmtbit)
>>> +static int parse_sample_fmtbit(struct dcp_parse_ctx *handle, u64 *fmtbit)
>>>  {
>>>  	s64 sample_size;
>>>  	int ret = parse_int(handle, &sample_size);
>>
>> thanks, patch included in my dev branch and will be in the next pull 
>> request I'll send to Hector.
>>
>> I suppose the recipients are generated by an automated 
>> get_maintainers.pl invocation. Is that desired for out of tree drivers?
>
> I was wondering about that as well, as I don't usually send
> patches for code that isn't at least in linux-next yet.
>
> I ended up using what is in the MAINTAINERS file for this driver
> in the branch as that is is all I have at this point:
>
> APPLE DRM DISPLAY DRIVER
> M:      Alyssa Rosenzweig <alyssa@rosenzweig.io>
> L:      dri-devel@lists.freedesktop.org
> S:      Maintained
> T:      git git://anongit.freedesktop.org/drm/drm-misc
> F:      drivers/gpu/drm/apple/
>
> I left out the drivers/gpu/ maintainer addresses though.

oops, answered to the wrong patch. The strscpy one has the drivers/gpu/ maintainers and the question. I replied here first assuming it has the same recipient list. I'd consider the recipients for this mail reasonable.

Janne


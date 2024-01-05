Return-Path: <linux-kernel+bounces-18377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10292825C30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB07285896
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52989364AA;
	Fri,  5 Jan 2024 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Nn4xRmtU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IXjwhail"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AB364A1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 3C9735C02B0;
	Fri,  5 Jan 2024 16:43:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 05 Jan 2024 16:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704490993; x=1704577393; bh=sJfYyAfMGM
	BF0Xlv9um+ifOfxBm2UMnyXbgZ0FGiTu8=; b=Nn4xRmtU/lGxURPoNCcuELQSt4
	8JjN08ObTdMgJTA+fK1+4G1O7PPw6FpCSVN2M+lEIT9I0yF3yhK8xCVAbMc5HtV7
	NhkGxtXzF8id6G4fZYPoTqHJtXVUQ0IRX0KEC5QCNXjSf1zQVxhGnJF06/fHjL1r
	t8l6FgXhfoLtuDaxnta6mcZfO1TZF1EECoCVbElqH/aZaPaeYpZULoF6E6Rjjhol
	fekJxD23Q2q+/XwBBxB5qUluNowcvAVKdUvD6LXTJbD0PJbU562RO6P8MtFi96vn
	VAr9yl2HYA11+EdI1C0PH/0f5ZCiNQndCcOF4GHElk2aMoZdiFp3WZGTLlrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704490993; x=1704577393; bh=sJfYyAfMGMBF0Xlv9um+ifOfxBm2
	UMnyXbgZ0FGiTu8=; b=IXjwhailbUZHc6COqA5JVscOjtbTdWcDKGlnyHlzAs+Q
	FcB7u4pDeOEu11CeZPXXOkP7pxt8Hv59FOFgF8u1WyMwrozcIKzMyGpIk5NWu+IQ
	qb+WRNBcdw/CrqQUCfgu8nYKgMAnHivbkpAMqQnPwngtlxjlkYWdFW5g3GlmDDni
	wwFY3AgujLiUaHH6Z9lw+IkyKQr2nSevO20pM+qOgPF/l7xKtHazZd/d4OE8MEqM
	D37hPZ6+yZPmKYjFvz8kM5yYWEho4CF08on0gRr9jzLMouX/mEnyb8g0uMFRi+VD
	chp/6fJdLDlGLQH8QibuEjYHcwRG/eH58SE4G1DjWA==
X-ME-Sender: <xms:8HeYZbtfBjRZurX8JNVXJcSpeDqhkQN8I2lCmMNOKEwK8U3vcZLGUg>
    <xme:8HeYZcfgEpNzPjUUv7PQg4jDpDWhWWNkIKHRCdAqFdSIw0DO1xXc6PGVMmNu30dM2
    L8BMX_YiHH-OgSzlp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegledgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeeuhfejgeehhfefgfffhfdvjefhueetjeegffeuhfdvffelfffgtddvvefh
    ledugfenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8HeYZezW0FX8WOtZfRXYv0BLefpPEGy1_22EHFD1fZxmhpUhvb5ZuA>
    <xmx:8HeYZaP2djl1uED8fytDl6WmsFEMS88pUYQ28R9aFhQZ_4S6-sgZBQ>
    <xmx:8HeYZb85xU0UqJYMkazVJbN_M4UeFS7gHRRY8jtrM9SA48ZBu-IxFg>
    <xmx:8XeYZbwph26eXHguKtVc2ZKO0H0a9uYns7C-4It7S5zs7XIbtvlBgg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 840ADB6008D; Fri,  5 Jan 2024 16:43:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <44c39a85-a1e8-4c3f-9416-b1f17e5bc36f@app.fastmail.com>
In-Reply-To: <ZZhtK6vjk5UD7pxi@kbusch-mbp>
References: <20240103155702.4045835-1-arnd@kernel.org>
 <ZZhli2FWXwP1XSRG@kbusch-mbp>
 <20508695-b9e6-4aaa-9c78-84891c1a8f9a@app.fastmail.com>
 <ZZhtK6vjk5UD7pxi@kbusch-mbp>
Date: Fri, 05 Jan 2024 22:40:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Daniel Wagner" <dwagner@suse.de>, "Hannes Reinecke" <hare@suse.de>
Subject: Re: [PATCH 1/2] nvmet: re-fix tracing strncpy() warning
Content-Type: text/plain

On Fri, Jan 5, 2024, at 21:57, Keith Busch wrote:
> On Fri, Jan 05, 2024 at 09:36:38PM +0100, Arnd Bergmann wrote:
>> On Fri, Jan 5, 2024, at 21:24, Keith Busch wrote:
>> > On Wed, Jan 03, 2024 at 04:56:55PM +0100, Arnd Bergmann wrote:
>> >> @@ -53,8 +53,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
>> >>  		return;
>> >>  	}
>> >>  
>> >> -	strncpy(name, req->ns->device_path,
>> >> -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
>> >> +	strscpy_pad(name, req->ns->device_path, DISK_NAME_LEN);
>> >>  }
>> >
>> > I like this one, however Daniel has a different fix for this already
>> > staged in nvme-6.8:
>> >
>> >  
>> > https://git.infradead.org/nvme.git/commitdiff/8f6c0eec5fad13785fd53a5b3b5f8b97b722a2a3
>> 
>> +       snprintf(name,
>> +                min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1),
>> +                "%s", req->ns->device_path);
>> 
>> Don't we still need the zero-padding here to avoid leaking
>> kernel data to userspace?
>
> I'm not sure. This potentially leaves trace buffer memory uninitialized
> after the string, but isn't the trace buffer user accessible when it was
> initially allocated?

I'm always confused by how the tracing macros work exactly, so
I don't know either. Looking through the other tracing headers
with string copies, I see that about half of them use the padding
variants (strncpy or strscpy_pad), while the other half use
non-padding strscpy.

     Arnd


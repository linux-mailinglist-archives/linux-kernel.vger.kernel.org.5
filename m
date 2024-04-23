Return-Path: <linux-kernel+bounces-154661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 366B68ADF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D4CB20FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764A04CDF9;
	Tue, 23 Apr 2024 08:11:12 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821844C8F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859872; cv=none; b=CsG2RpP7O6zDRSmuCNhnNGFXcWeT+mkWq/zDIawIA+gv/WXHQy3qYELAGSq6p5fEGEhmUkQjISyNKGLao4ryvNP7Zo2A2VL5Pv2ITfBl9glBtROP2dWZfWqB34Iq1oGNYD+6LQBBlSA8kleHHjpGPQA49F0QusS+j/nuA2GaS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859872; c=relaxed/simple;
	bh=PMfy89R+1zueDcez+T8fuS2gCg5z0xhHRL2bNInR0Ew=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hX5ubmUeTt9UnspSDpLBbS5+0VE4rlNrXOxTeXfUaXlG1zfNFWtLgvSzH6HvhgbVaRVGjt9Xz6j7lMfGzoTvYA+pmvhmpOkW18grCeFYvJ5H+6qwBFG0/Ax6iyGG4BTQw+QhkFbmqWs+COZ33Pdx9J7dDk+YHEkx3K9+rqfVD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8F901647A83B;
	Tue, 23 Apr 2024 10:11:04 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id gstg3scYW05B; Tue, 23 Apr 2024 10:11:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D933C647A83E;
	Tue, 23 Apr 2024 10:11:03 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gvF2eYIkDevt; Tue, 23 Apr 2024 10:11:03 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id ACD99647A81C;
	Tue, 23 Apr 2024 10:11:03 +0200 (CEST)
Date: Tue, 23 Apr 2024 10:11:03 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <539232323.17201.1713859863502.JavaMail.zimbra@nod.at>
In-Reply-To: <15d5da65079d072856ef5e8d88040df2095bb6b7.camel@huaweicloud.com>
References: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com> <1743ad022502d64042fa7db4d847a988bb90cbdc.camel@sipsolutions.net> <15d5da65079d072856ef5e8d88040df2095bb6b7.camel@huaweicloud.com>
Subject: Re: [PATCH] um: Add winch to winch_handlers before registering
 winch IRQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Add winch to winch_handlers before registering winch IRQ
Thread-Index: qqHtS+MauW85VnvROeFWmuL67kgQcQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Roberto Sassu" <roberto.sassu@huaweicloud.com>
> An: "Johannes Berg" <johannes@sipsolutions.net>, "richard" <richard@nod.a=
t>, "anton ivanov"
> <anton.ivanov@cambridgegreys.com>
> CC: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-um" <linux-um@l=
ists.infradead.org>, "Roberto Sassu"
> <roberto.sassu@huawei.com>
> Gesendet: Dienstag, 23. April 2024 09:22:31
> Betreff: Re: [PATCH] um: Add winch to winch_handlers before registering w=
inch IRQ

> On Thu, 2024-03-28 at 09:25 +0100, Johannes Berg wrote:
>> On Thu, 2024-03-07 at 11:49 +0100, Roberto Sassu wrote:
>> > From: Roberto Sassu <roberto.sassu@huawei.com>
>> >=20
>> > Registering a winch IRQ is racy, an interrupt may occur before the win=
ch is
>> > added to the winch_handlers list.
>> >=20
>> > If that happens, register_winch_irq() adds to that list a winch that i=
s
>> > scheduled to be (or has already been) freed, causing a panic later in
>> > winch_cleanup().
>> >=20
>> > Avoid the race by adding the winch to the winch_handlers list before
>> > registering the IRQ, and rolling back if um_request_irq() fails.
>> >=20
>>=20
>> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
>=20
> Thank you! Richard, are you going to pick this up?

Yes, it's already in my local queue.

Thanks,
//richard


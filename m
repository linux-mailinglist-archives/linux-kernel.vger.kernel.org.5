Return-Path: <linux-kernel+bounces-8815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD8981BCA4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE20286E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7715990E;
	Thu, 21 Dec 2023 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Yac28OFU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2635990D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Fl656nZZDE1bzTHnjfrI+HAFV79Ab/+I2n1SZm4Qt7M=;
	t=1703178621; x=1704388221; b=Yac28OFURqnvIpwrhbHVniC3cFiicDrRtWOwkhkP9Epn0hS
	HxkrmBYGXLb4qrQsAe4vZ2TKMBY/z9F8iEXZANvWiilLkGZcXxiGO4uUnWvKN11QrA2LoXTtWZ7b/
	J7feqAy2bAiVYgGwIy7a5NirCW6QKbUf/B2kcYjQlrii7fY/ODxY9gmcubmN4Fjtggq+8nGvHv6n3
	osjT2NF7/425gnUB65V3RFGk4e1V6v0lOvGFT77vZiwneVh7xRSjewRiryJCEIlVjzAZkd7YBjxbs
	eIp5OLxSZUnfq0SZsKxo10lX5NHPhbETvonbaaZlYSech6Kd62R7hEzFysUbP4Sw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rGMYs-00000002zud-16G5;
	Thu, 21 Dec 2023 18:10:18 +0100
Message-ID: <4b2fbac42345acb21ac2bdfe6abd4fb4a00bb8c6.camel@sipsolutions.net>
Subject: Re: [PATCH] debugfs: initialize cancellations earlier
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Tetsuo Handa
	 <penguin-kernel@i-love.sakura.ne.jp>
Date: Thu, 21 Dec 2023 18:10:17 +0100
In-Reply-To: <2023122129-seclusion-qualm-3084@gregkh>
References: 
	<20231221150444.1e47a0377f80.If7e8ba721ba2956f12c6e8405e7d61e154aa7ae7@changeid>
	 <2023122129-seclusion-qualm-3084@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-12-21 at 18:05 +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 21, 2023 at 03:04:45PM +0100, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > Tetsuo Handa pointed out that in the (now reverted)
> > lockdep commit I initialized the data too late.
>=20
> As the patch isn't in any tree, what is this against?

Hm? You mean the lockdep patch? It's not relevant, but I then
continued and wrote:

> > The same is true for the cancellation data, [...]

and then the patch goes and changes the cancellation data
initialization?

Or do you mean the patch mentioned in the fixes?

> > Fixes: 8c88a474357e ("debugfs: add API to allow debugfs operations canc=
ellation")

That *is* in Linus's tree, as of -rc4.

Not sure I understand the question.

johannes


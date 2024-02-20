Return-Path: <linux-kernel+bounces-73391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566FE85C1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895241C23410
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAA776906;
	Tue, 20 Feb 2024 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBgyeaSA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9772F626C6;
	Tue, 20 Feb 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448249; cv=none; b=LRjWdQvQeiMSnqlBa/ILdwa0ghZuL9qpUD/s2Qp2P1grg7rtvYa8eEk9bsthgtxyiu48JcRDj+n1A9H8LS9zQoNSksZDzaSsBCBEDzgTj0OlXvw4QDXXGzJrh6JEaYMSZl1z+PiGsSHrVat2k5Ivqlg7jbK27T4fNjSbFglQp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448249; c=relaxed/simple;
	bh=YGl9x29jGpzkziMIHTukmt+se9fYrpUh5ZH5J6+7Ibk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IM1hQoTgAzEOfMFnTCpTQf3GRPCY1ovqBitex8W+75c9mh+emWz63fudBXWhkETYLdw9JEq1BPPzD/cE9k/zVWBwcLA5dH88ubGPAfl4xjMdedqjZddUuBYsI0Z0y0XAg3K2JQZAcwejSlVNqt3ZIUAFUs3JeOwdIJ6AWP5aQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBgyeaSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077A8C433C7;
	Tue, 20 Feb 2024 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708448249;
	bh=YGl9x29jGpzkziMIHTukmt+se9fYrpUh5ZH5J6+7Ibk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=IBgyeaSAngzJK7RL9VGax3Zpj1aZuHcPmoGxvscxh/OGe4UMNaIQLQoTzU+yifdY5
	 HdwujxhGcO+lit2/2/sOqxPbCY3Mqgat8WhqF+ndOFwf/H/c240wwVWxG/Gk3Q4the
	 ifKAdWkz7pd0eQZLOUO/BCjibmrfoTMIrlwkDpVll4lBlfhDO2yYmBTbesKGWswt+X
	 +DbYZCaQBBy6a1AJ7DxWBeNP3SxY8oglaANnujb+GWA5kpPEPmSMRwKjpFEA1IDHfp
	 xXZuumSDmQNLG4UOtivGRlMPgnoTxEO6xry4KPzpvcLvKL5yLFO45Ugrr5U2d2hUUM
	 ElZsEbwjOmNBg==
From: Kalle Valo <kvalo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,  Johannes Berg
 <johannes@sipsolutions.net>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] wireless: Add KHZ_PER_GHZ to units.h
 and reuse
References: <20240215154136.630029-1-andriy.shevchenko@linux.intel.com>
	<87wmr5d4lh.fsf@kernel.org> <ZdS2dRBPY8mj58rX@smile.fi.intel.com>
Date: Tue, 20 Feb 2024 18:57:24 +0200
In-Reply-To: <ZdS2dRBPY8mj58rX@smile.fi.intel.com> (Andy Shevchenko's message
	of "Tue, 20 Feb 2024 16:25:57 +0200")
Message-ID: <874je3m5u3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Thu, Feb 15, 2024 at 07:23:06PM +0200, Kalle Valo wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> 
>> > The KHZ_PER_GHZ might be used by others (with the name aligned
>> > with similar constants). Define it in units.h and convert
>> > wireless to use it.
>
>> wireless patches go to wireless-next, not net-next. But no need resend
>> because of this.
>
> Aha, thanks. Note, I still don't see it in wireless-next tree. Is everything
> on track?

Yes, it's queued in patchwork:

https://patchwork.kernel.org/project/linux-wireless/patch/20240215154136.630029-1-andriy.shevchenko@linux.intel.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


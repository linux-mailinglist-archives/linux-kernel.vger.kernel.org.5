Return-Path: <linux-kernel+bounces-149961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBCB8A986C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5062F2827C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797DE15E5B9;
	Thu, 18 Apr 2024 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skBB0CGx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61E15E214
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713439207; cv=none; b=ehWWKZgSDRn+yZxpdnxSz9bEV8nlnYtfDziFsMpW81S5fq2M7enlXFybEl2FEbl5oScoAbzivYi52oGEqf4K8fmxciO/caJPPtSWTAy+fT0BNIjVBg8BZpiFzfcpfxNSEAjLPODfwp9NYf6vt7zw55QFswv7hXyOi8y6O5oVQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713439207; c=relaxed/simple;
	bh=pTH4AMFIX/a1mvllVA9nEz2QdISSpNcl3msKV0Ms2qE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TFaIG8DxDaC67OIxlaOMUlaMYRSHhr7RBGTnDK0aHX9JgDAJNXW4anjRSbrem3d7jxiSBUGf2611KOyoISs/gO81DPDMiLSeVU7k2rDqPi1Tj+Ztl+UYqaASWv+6qPFrjaJWZzDbq+1e5M+J+JFw0M2rjzLtOi3HGhMt75ihDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skBB0CGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E862DC2BD11;
	Thu, 18 Apr 2024 11:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713439207;
	bh=pTH4AMFIX/a1mvllVA9nEz2QdISSpNcl3msKV0Ms2qE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=skBB0CGxR8U4BMU3oTyatlqb+Ux82gAo1aQ91iF9dBoWU+MxdKF360YJOFinq+Clp
	 09Hr9I3Gx6k8kOiUdpttSRQEZuEwPAff4N2g39HYYsqay39X9GNlwwizN1pVkU/b/T
	 zZdGelMgN5wIyfq9oi92tjVvsNcyr22i+aznxes++L7lPJHUBz4eWEm9AKSl+rFBMA
	 K5YpqSDFXOO+dpnYjnpUIgsJokRR8HlfchHOtjgixQ36yinzCrM79G1+O5k7SDbxdO
	 vcUiQKf1EqcN39oS4XzPtoV4VdKbMak7kJjd2dooXFnX7whHqO9YZ8rkJhPbfzfn2v
	 ewcREo8XVKPog==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Pratyush Yadav" <pratyush@kernel.org>,  "Tudor Ambarus"
 <tudor.ambarus@linaro.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>
Subject: Re: [RFC PATCH v1 6/6] mtd: spi-nor: introduce support for
 displaying deprecation message
In-Reply-To: <D0N5QYQMX1X4.831Q9SEANU4S@kernel.org> (Michael Walle's message
	of "Thu, 18 Apr 2024 11:57:27 +0200")
References: <20240412134405.381832-1-mwalle@kernel.org>
	<20240412134405.381832-7-mwalle@kernel.org>
	<mafs0jzkw6oq1.fsf@kernel.org> <D0MHEH8OOS44.2PPBZ3LFU4QG3@kernel.org>
	<mafs0bk686l67.fsf@kernel.org> <D0N5QYQMX1X4.831Q9SEANU4S@kernel.org>
Date: Thu, 18 Apr 2024 13:20:04 +0200
Message-ID: <mafs034ri7w9n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 18 2024, Michael Walle wrote:

> Hi,
>
> On Wed Apr 17, 2024 at 5:52 PM CEST, Pratyush Yadav wrote:
>> On Wed, Apr 17 2024, Michael Walle wrote:
>> > On Wed Apr 17, 2024 at 4:36 PM CEST, Pratyush Yadav wrote:
[...]
>> >> I like the idea in general. Do you think we should also print a rough
>> >> date for the deprecation as well?
>> >
>> > Might make sense, any suggestions?
>>
>> How about a simple string to flash_info?
>
> Ahh, I was rather asking if you already had a time frame in mind.
>
> Besides that, should it be a date or a (future) kernel version?
> Roughly about two/three kernel releases?

I think kernel version is better.

I don't base this on any real data, only on gut feeling, but I think
three kernel releases is a good time. Should add up to about 6-7 months.

[...]

-- 
Regards,
Pratyush Yadav


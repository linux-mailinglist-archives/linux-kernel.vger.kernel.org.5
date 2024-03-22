Return-Path: <linux-kernel+bounces-110900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F75B88656B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AAB285F97
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146F353A6;
	Fri, 22 Mar 2024 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEo8yWMT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578A4A07
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 03:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711077810; cv=none; b=qrV/ld/PxTMSlKGzDbFXBqfJAtAJy8uEjUpBhltwPCJKvQLNsSUQv0wVh4bInhNbQEkEye9TBudhjjHA8vynTPQVeXJ+KNIJKKEHLFm+5gQlHvPel5MpL4ytouuyMdJ5rgCDu4vq1UNgT2FWtB1jottTX19llgF2dz39VNbMAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711077810; c=relaxed/simple;
	bh=BLuLTf+ciQ9mI5NJSHdV0Rd2SFWl4DrJlE4kXjN++sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJ37nn3Mf1T1CYh3bUed4F02O6OM8UPkRSJ45oW3EXzOoiBltU4DQ0bHN01hskLXMHOrHSHSlturWL9SglHpz5RYrCskujRldDf8IcGiZz3LQoKkhrTXLdL2eiV/bzBJLqwsrKLI6IzTf8mTtZgymFKYUMLkpp2q1U6xdC73SS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEo8yWMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32778C433F1;
	Fri, 22 Mar 2024 03:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711077809;
	bh=BLuLTf+ciQ9mI5NJSHdV0Rd2SFWl4DrJlE4kXjN++sA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZEo8yWMTYm0hnEMucDmwaWCtvKSIsvQ8rmlj4G2ufalUnqUBbJNEgL3pC9fvgMoow
	 U8inoW2P5ruL4tHiYDG6QfH1sMRoj1BWJMSN/D7ojv0VIxBbJcRAbM+IrsziM1r+u7
	 0+x/fnQvUAYhunt0Tf1Pso0BYeEbwGKpPdPRzxMeeGsaG3d6yGlXNMn5rMeRhgGsw3
	 275A613qNY9Cx1rCMTNhah2lM+s1ujhml8+VoQlD+O6JsA41NmEEP7lPmGQcO6iEzx
	 ztcgQX7MlLzUSnjigKbq0mmBqI9hIkBebfju8XUCyKNn1zKHzFKgxORrHPOje+vvbV
	 HAtwPjV1B4ytA==
Message-ID: <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
Date: Thu, 21 Mar 2024 21:23:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
 Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com> <20240304160237.GA2909161@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240304160237.GA2909161@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/24 9:02 AM, Jason Gunthorpe wrote:
> On Wed, Feb 14, 2024 at 01:57:35PM -0400, Jason Gunthorpe wrote:
> 
>> I also like this, I don't want the outcome of this discussion to be
>> that only mlx5ctl gets merged. I want all the HW that has this problem
>> to have support in the mainline kernel.
> 
> To this end here is my proposal to move forward with a new
> mini-subsystem to provide rules for this common approach. Get the
> existing tools out of hacky unstructured direct hardware access via
> /sys/XX and into a formalized lockdown compatible system. I've talked
> to enough people now to think we have a critical mass.
> 

It has been almost 3 weeks and no response (to this and other proposals
in this thread). I have been around Linux long enough to know that
silence is not acceptance.

To me, this seems like a sane start for a new subsystem addressing
challenges with complex, modern devices. To that end:

Acked-by: David Ahern <dsahern@kernel.org>


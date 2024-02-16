Return-Path: <linux-kernel+bounces-67927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59332857324
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE2B1C21782
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40DDDC1;
	Fri, 16 Feb 2024 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCqteF2K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB16E8F55;
	Fri, 16 Feb 2024 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045248; cv=none; b=T35SKdWDwGM7rrhW5yASyNWn57YZqrQBj1dYPVIxXrvBnSn5LoAn2tyXrKRSgU6ombTqz8ClRN1neCe5Gs2pyfJvZAY7M8Mj5/MXzQM6SIe2we6f5KW9IsDyqnSCy88EbEiWjRg330L1n3MTSNLmz3WMvfz748/5B8uMHtQgP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045248; c=relaxed/simple;
	bh=+dDgnU3ZkrjHe2f8ANYZEXxyh3W3/N5+qFKaHROFQjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hR6tp7xY4lLeceN5QlLarKBHN0uY/dmNszCK3QwOQD0TnuTgnQhl/Q/duhuOwcop6XRFZxkxoV1++h5MVqq9GUQ5g0NWIhAZJQkc3SRc6WHTRT3a5bVTCU1WBBiCm8NU+qAlewW8ghXiGHaFedNP8SZg3q1tMLE+O126r+gQti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCqteF2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693EEC433F1;
	Fri, 16 Feb 2024 01:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708045248;
	bh=+dDgnU3ZkrjHe2f8ANYZEXxyh3W3/N5+qFKaHROFQjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BCqteF2KZkBD/XMzhKjjbxKUtvLqdkGNuCWI6A6kWgqy+syTndaIHpsbIhS4pxbAp
	 UmMEkDDCao9xjdSYkDm918Pe9jerH5dLqNeZecLL9epIYcUVa2Wh9XaqOa8Q0wJChH
	 LyNbx57nXbkJWKvWX9aYrj3gMnnlnsHnwYGzv5Hs1lHC49ajycJ38Fk/pwZJZJ3uNY
	 WmSIxelgEKaoYY8p2UUD2trduuEQ49XwsN6zBKl6fh3Nr785Q8CQEGszFEn2+UTMJc
	 z4vwAs/mm5M+FkBxUtOsZ+CB8h99b4zHz5aX7TXxka3YG+Msx94e84uU2yTu2fVxgY
	 yVC2AwsLICM9g==
Date: Thu, 15 Feb 2024 17:00:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Leon Romanovsky
 <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Itay Avraham
 <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, David Ahern
 <dsahern@kernel.org>, Aron Silverton <aron.silverton@oracle.com>,
 andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240215170046.58d565ef@kernel.org>
In-Reply-To: <Zc22mMN2ovCadgRY@infradead.org>
References: <20240207072435.14182-1-saeed@kernel.org>
	<Zcx53N8lQjkpEu94@infradead.org>
	<20240214074832.713ca16a@kernel.org>
	<Zc22mMN2ovCadgRY@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 23:00:40 -0800 Christoph Hellwig wrote:
> On Wed, Feb 14, 2024 at 07:48:32AM -0800, Jakub Kicinski wrote:
> > Overreach is unfortunate, I'd love to say "please do merge it as part 
> > of RDMA". You probably don't trust my opinion but Jason admitted himself
> > this is primarily for RDMA. RDMA is what it is in terms of openness and
> > all vendors trying to sell their secret magic sauce.  
> 
> Common.  RDMA has two important open standards, one of them even done
> in IETF that most open of all standards organizations.

While I don't dispute that there are standards which can be read,
the practical interoperability of RDMA devices is extremely low.
By practical I mean having two devices from different vendors
achieve any reasonable performance talking to each other.
Even two devices from _the same_ vendor but different generations
are unlikely to perform.

Given how RDMA is deployed (uniform, greenfield/full replacement)
this is entirely reasonable from the engineering perspective.

But this is a bit of a vicious cycle, vendors have little incentive 
to interoperate, and primarily focus on adding secret sauce outside of 
the standard. In fact you're lucky if the vendor didn't bake some
extension which requires custom switches into the NICs :(

Compare that to WiFi, which is a level of standardization netdev folks
are more accustomed to. You can connect a new device from vendor X to 
a 10 year old AP from vendor Y and it will run with high perf.

Unfortunately because of the AI craze I have some experience
with RDMA deployments now. Perhaps you have more, perhaps your
experience differs.


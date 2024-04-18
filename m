Return-Path: <linux-kernel+bounces-149656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A208A941D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11348B21D17
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792C74435;
	Thu, 18 Apr 2024 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="KKFu+8iC"
Received: from smtpcmd14162.aruba.it (smtpcmd14162.aruba.it [62.149.156.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770C36B01
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425614; cv=none; b=cLORjvuZ1YgWuY3seuKCw7zY24/D60bDpe04xwedB2id3dPdMJNUnIDTSiSXtwThzqPhhMhlI2ozORFw7lGX+0ApRaneWt2a0T+XYHXQJows5D1UEzgNIuB80xKjkaDUydrUTmdT3iDOxjVlAg9cALWxIwbZ1ZIe40VWNVWv84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425614; c=relaxed/simple;
	bh=QjDsPauPVvETjdDUqVUtGoBEtOicY6rA+B+E3Pa/tIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9wr8P7KGgyoTiOfz2Cx/MIxQLqa5pKXsekJoh6x9U1M7d5FEnfE7Fr0KUG+R5nZL6Uf575+SNYCG1f5iq2+bOGOsqoIu1Mm7rjOUEoEq6C/Q3R5VbmyhtDa8k6NEsZVjpasGTFTrGodhXkmd8TsbP7/JDxiMUyuL3VCCIee1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=KKFu+8iC; arc=none smtp.client-ip=62.149.156.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([146.241.28.123])
	by Aruba Outgoing Smtp  with ESMTPSA
	id xMA0r2HrjjEwexMA1rCLye; Thu, 18 Apr 2024 09:26:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713425182; bh=QjDsPauPVvETjdDUqVUtGoBEtOicY6rA+B+E3Pa/tIg=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=KKFu+8iCRp0A4zk+iLwfqMUjAUFPhEZugyZw0GpYZxpul4HlhdFpUehgi5llQpiNc
	 gQJ6O5jahEk0+VVi614/3HvzRIo5uUZJqh87iTvwNW1RLbg81/PvVsF96F+xwlzI+C
	 SBL7Inqg8OorN+qbDKborDmZUuzGv1hPpMTtSPY55yPQ2KwTDwpPKGUhRSFXWFrcxt
	 C5AmOEqXvZKfwzmrmTsvIsKGRr8EH2/QNf++CXcRAuK0cpGbWmQxh6G0+9T5Rkc+XY
	 UM0sBlbDOlSppts9yVhju7us5gxFYAlijYvk2ZHr4FjwJ7hL4ofZODAcUyX/52pHIk
	 Z0Uut/LVfFlpA==
Date: Thu, 18 Apr 2024 09:26:19 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH 2/4] regulator: dt-bindings: pca9450: add pca9451a support
Message-ID: <ZiDLGzJymI4W+LII@engicam>
References: <20240417153528.7838-1-fabio.aiuto@engicam.com>
 <20240417153528.7838-3-fabio.aiuto@engicam.com>
 <ZiBrbghc510G02tx@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiBrbghc510G02tx@finisterre.sirena.org.uk>
X-CMAE-Envelope: MS4xfBz44pDssyOg9TqbSc5MDfBh5D8WhSxeCJhJX37EgF1N/qzG/L7rZwwFPltMRjeHtI4EcG34jlBQYAgpAwfHmdgim7KrBa3KewvI5hLdsqaMS5aCvBdP
 IvQqxK9hAW1AoUI4QUU/yqy6XuWyYb5cFJIjTNWY4Uw4twBH7mTkC95EWe3LXYyiYwxdRVbmpaec4WmvgA5gTDAQ3fPFM1jN+pcqrSmcFQxDU3WO09DVqlec
 VnKC6wRLhcTpUtY4Y+JHHb9k6lC/e2Bahtrevmhljyjxc2Y0bCLxoIK/PfEzeJzWy+uckkaHe8iOxIgfvJc0YNt0H9QqnfUfVTFy7Y4/ByNi788fcgVKaDK7
 cX0lqtkHmV/NjmCGTQy+SDKy+XM2ug065m9TzepVMv9RTfGpX3ltJ2m75fTHFZBB5Qw5RoZIQUDivJ5BegEFAgT8KvVI89I6svKBKccjmKHAhrZQIy2twP25
 EWVuQDnyWUOddC9SDaAlPLza92rKItw77DJg0TTxS/t3VgqjusA81ri7wNRKyCOHcY8USP4+CrSEt/5JgvJLEAQVNPyri2SKmVdd0wzRO5AN30h51+33ewcV
 Hb+97l7UtJ2nIF2amU1px/SP

Dear Mark,

Il Thu, Apr 18, 2024 at 09:38:06AM +0900, Mark Brown ha scritto:
> On Wed, Apr 17, 2024 at 05:35:26PM +0200, Fabio Aiuto wrote:
> > Update bindings for pca9451a support.
> 
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

thank you, I was in doubt because I did the whole job based on
shawnguo's repo where the patch isn't applied yet.

Maybe this approach was not good, should I have considered broonie's
repo for this single patch, shouldn't I?

Anyway I'm dropping this patch for a v2.

kr,

fabio


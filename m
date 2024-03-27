Return-Path: <linux-kernel+bounces-121439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7A988E7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD77929381F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA20137761;
	Wed, 27 Mar 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubQigRy6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3EA12F386;
	Wed, 27 Mar 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549833; cv=none; b=OtNJlkhBpGreeBJ6j4R8Iy8wiT7l4mzTpYF+0uxrVLCE2uVQPG8EWzVbxT8pj3lxwD/fsPAMDJQcS5L67+2sSfuu8sS2nCYzf71Gpwq8ook0ZpN7vSlG53/YXIZGrM5IWn+qzKYmfsUWo+si42WS8JUZh8MAciRhEEKZpxjjliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549833; c=relaxed/simple;
	bh=mMOTUGPRyDA8kg6xQyOpkb2HcIYmZ5EYpD+EVgw6RX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfIDoGRLcGWPz0ZHoRJX+l/DCZyZq2mdDX3l3PPQMSOPhv6pIPylirj4tDrdGc1ekdlcTNC20BRA1/RzeAO076NNQ5W/T6nKIHvbrIoPb5Mpudkhg+rlHIBV+uYt5TeaX2YF6v3nURLPCZeq6fEd+Pxbb1I5dI/OSm352VHN0aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubQigRy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5075BC433C7;
	Wed, 27 Mar 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711549833;
	bh=mMOTUGPRyDA8kg6xQyOpkb2HcIYmZ5EYpD+EVgw6RX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubQigRy6ROJg46ZCx3AkKmlQ3J5igarOiZoVxoPSZieYvGrs9cbH3RRSLcLRlESAs
	 I7pbqfvLgKqTJs4W+iCIMoZ+5DIn1oNYfkiJEfqrFaMTXPhbjgINls8wYk0G4CHSbo
	 61LYCu8HhAR3mU1817uvoGbVTAVBJW6HU3zIichCvDcf3fu/2pwGXeA2dgzNfGFJe/
	 wyOw5a/IODppne6rbdNw9bFyyEZVqcbV7Jb02hkehT396TYPju+cijIs4P1GBCwrh7
	 ZeR9CYPVq3iAEyBnQ5FC6U7HKLet67yP6ckkAOs+aMKclivF88gvm3FHGXLFI6FkVc
	 fz0MMa0cP9+rw==
Date: Wed, 27 Mar 2024 14:30:29 +0000
From: Simon Horman <horms@kernel.org>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V2] net: lan743x: Add set RFE read fifo threshold for
 PCI1x1x chips
Message-ID: <20240327143029.GJ403975@kernel.org>
References: <20240326065805.686128-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326065805.686128-1-Raju.Lakkaraju@microchip.com>

On Tue, Mar 26, 2024 at 12:28:05PM +0530, Raju Lakkaraju wrote:
> PCI11x1x Rev B0 devices might drop packets when receiving back to back frames
> at 2.5G link speed. Change the B0 Rev device's Receive filtering Engine FIFO
> threshold parameter from its hardware default of 4 to 3 dwords to prevent the
> problem. Rev C0 and later hardware already defaults to 3 dwords.
> 
> Fixes: bb4f6bffe33c ("net: lan743x: Add PCI11010 / PCI11414 device IDs")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>



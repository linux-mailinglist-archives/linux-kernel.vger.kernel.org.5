Return-Path: <linux-kernel+bounces-44654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D09184258B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C58B2906E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291FF6F073;
	Tue, 30 Jan 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8ehWSMb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB16A358;
	Tue, 30 Jan 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619271; cv=none; b=V+geR1/4a3KpWDkAuYbhtaJoEEDQPqAh+UMW6YWnOsJ8njgkkBXWxz0U7Aa0IS2j14WRN5NzhKH1FRYaRV/vp0oCLWGdZxgfKbc0vfZ/gd+RTzYLgw20Y198c7R2xIVKj8beM9lKhYuEVTaBjGDph6kC1B2lI0Op1mMHIqMNXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619271; c=relaxed/simple;
	bh=6vo7FvUQHTzqjILs/LLq8FUpPcpbRTX+rPznUSEtmcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgFHSZ8z7SXt46EtSpc+gqnWld3h63lzx8KvvPxmiMN52p0lAvq35QQ1G1hHBx8eVYrciAffH6PTd416Jqx7uJJWmqRkTju1f1Rtwe1EcOespz/n4Qo4nXqx0XkcdkFomwi0ZgbeMUoXf9N6RDPouho842DTuIk6lAL8x19LwQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8ehWSMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066DEC433C7;
	Tue, 30 Jan 2024 12:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706619270;
	bh=6vo7FvUQHTzqjILs/LLq8FUpPcpbRTX+rPznUSEtmcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8ehWSMb+wwIT0UrfxX3n5vC0oicE7lD86UeIGvti6L9lT6FIIHtgn9Gw27WsnhJj
	 iIuQbaYzyCvdFsDNI8IzCXN3EUmEQuJ29ErJS/KQHBQtgO+qGRAiJIrM6m4No5RB9g
	 KsbgOnVNASc+H9B7SvCBfj1ghlzVJ+JrOx9XPs6woCWkZjadFQBPBzjAc6uQBi1gYR
	 gt7z+v77H5QaoKoYs+mie3FGNFAeeUdgEC9TYusjdza4ZwZpeyTbwVvOWuZSSXLZnS
	 ZoDojb+DH6Eb0l+QvCbtvwa6/yTjs9a8mGRyFHE9hxCRK1cIsQalMxi8HmnLKBuDkl
	 iqn6tIvwHZi8A==
Date: Tue, 30 Jan 2024 12:54:25 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 01/10] net: fill in MODULE_DESCRIPTION()s for
 encx24j600
Message-ID: <20240130125425.GA351311@kernel.org>
References: <20240125193420.533604-1-leitao@debian.org>
 <20240125193420.533604-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125193420.533604-2-leitao@debian.org>

On Thu, Jan 25, 2024 at 11:34:11AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Microchip ENCX24J600 helpers driver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>



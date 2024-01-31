Return-Path: <linux-kernel+bounces-46347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E62843E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21E428E17D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C174E3E;
	Wed, 31 Jan 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0gCeLCd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E1745E7;
	Wed, 31 Jan 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700615; cv=none; b=Gs8ostKOZqyh5P1xvZqoKOgrNM4VMEIRnqOk3wGRyn0ry/WHOfdTBYKVpcio3jE23+GOt4XE4+9m0+8fwEw2/yRVEMljDLTAjsQ7KxMI/rI+MInK/RW3FuXh4ztwjVpcG6y9hcAvYnzvJ0ZP8dRxdBuYIaaq/NMYkkLv7Urgcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700615; c=relaxed/simple;
	bh=nNzF25X2sIvT0hqpP89bdhwWjnLWrqd80rHVE60frVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWl+GvE9/4yrjeUVNqQZhGwPYLRpTUJP79VkkmhRF03kAHIfwpP5wgtk328fZvXdtsGvvPPribf1s90gJD006BpOI3uJcHWduY7Nk8cOSE+vcyYttSw7vI1Sp1oZ3xt09x+aWb+vvLssSi9I2+dvC+jVkEveFxLgoJHg0Ke1P0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0gCeLCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD35C433C7;
	Wed, 31 Jan 2024 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706700615;
	bh=nNzF25X2sIvT0hqpP89bdhwWjnLWrqd80rHVE60frVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0gCeLCdQvJWbw3c4/NfKdR7VhhvP+j+w34Elkhx0miHeno+xdWFW8rqNDweQRKLB
	 IpPifhcxComQI/BVF5RysuaWuRK3v9JoACmBMsbjDsOn+DWbDwrbf++0HgtTCOlhe4
	 RNFdWRHMdc7XvMFya1ntb1WVyFKmdb+oZXjeMZ9KAkZcEarfksCkkcBhXRBXjNcJ6y
	 Y7kJEZA+zKt/AagfCOtT1uWMttOOEWIUbq9uogAokh1k8+I0DjA+yXKMRhsCxlKV4n
	 8jP+bK9B/mhIHzlLdEovl8FrQ1ZtqTckTPz/A0HoIu3dJVACZPOPRE3nov04eGAWsh
	 fJZ1aO41o4/+Q==
Date: Wed, 31 Jan 2024 12:30:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH v2] ahci: Extend ASM1061 43-bit DMA address quirk to
 other ASM106x parts
Message-ID: <ZbovQFan0KBTItwr@x1-carbon>
References: <Zbj37-5aAB_6R4m_@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbj37-5aAB_6R4m_@wantstofly.org>

On Tue, Jan 30, 2024 at 03:21:51PM +0200, Lennert Buytenhek wrote:
> ASMedia have confirmed that all ASM106x parts currently listed in
> ahci_pci_tbl[] suffer from the 43-bit DMA address limitation that we ran
> into on the ASM1061, and therefore, we need to apply the quirk added by
> commit 20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia
> ASM1061 controllers") to the other supported ASM106x parts as well.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>
> ---
> Changes in v2:
> - Add Cc: stable@ (requested by Damien)
> - Fix commit reference style (requested by Niklas)
> 
> Link to v1: https://lore.kernel.org/linux-ide/ZbjgTmR5FbAnb-Ua@wantstofly.org/
> ---

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.8-fixes


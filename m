Return-Path: <linux-kernel+bounces-65495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8659C854DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C21F2A722
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A1F5FDD4;
	Wed, 14 Feb 2024 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UebVZdfJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5EF604B6;
	Wed, 14 Feb 2024 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927131; cv=none; b=HyohgiaWeWFFY5vvqe5mL2FC0qRacg1yz8qlRo2rtWt+jGg00lehMEwyjdZK+hK93obwFhnbZJ+PgWKaL/oP+5TFjW7+2iz74L/q5xR2WFUCxCTrfXrUGHiKqPLOLZoTCpHWtXhQ91wE+tEgr8to7DNUzCu1cEsQ5I1KngVaR5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927131; c=relaxed/simple;
	bh=gSThZwejcTydlpa5yt9Mu7vqKpHzCMm1GI7XI1eporY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou0T1F/noLnC9Qz3NWymJx+jhzLPiKVJ6kuW0fOcO7zgVlmqMRjQE6usXLTTXio2ANDO0sGfZxtLouy7lS6qrcD5qOE1EYgqoTKg59vIbPLG+YV5+eT7w7x6sSqnh3PEHIOT4mZbq6Jd05SVKsULB2UmfXb0FFvL4PSD4g4J0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UebVZdfJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B27F640E016C;
	Wed, 14 Feb 2024 16:12:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UwAYWp2wEcKO; Wed, 14 Feb 2024 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707927124; bh=8p8+PjeYQWOHmY4XijZVp9W+Tfjle55KoxOqokZR4dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UebVZdfJFD52AOX+YSF2fFQFkyTHssd/MmL4XMlUa+E5iKvj9pzOyBLfNhbfyUkGE
	 0VRsqxIkX8P/n9sv0pp/r4eAHHpwK/Iy77uYMfvCTwjjjejwEcjO13/EWzr2ZDOZKN
	 4OS5/jITCp7Gt8g1s3zUq1ELXhRdwX6R5FQ5JvUcJZpdH5ZCx/+x9cptclReOx/9X8
	 OmBDEwtxa2yUnaNYa/ipjdW3OBqnEFdlnifprLzJxYie3myJ8+hHtEvFJDfSmAS9yo
	 ROxTtq0zavHPnuMhQooZEe/64phvu1/6yT0u/PgFuD92PbCmLrBWJ1REXXvse74QLH
	 Qy2SS5HYD3rNIXrRpz/8hqtH4tXpPwY1C/8WQ9IAqQ4izfh/5sr/1I9Du+LM+muIzX
	 sokCLNFmsTNpDqdCcQjZC6DftNKCaAoew5sCWE9R0nID7eg9N6aLiDIwakav0EpcAn
	 q0Xg1bYMKqlsGE6v+LF5fKa8Ged36f5r7oW08yU9GOk8GnFmB5dYoUYwCuxvXWTlMG
	 Gsi3e8kDc5EYljriKKpd/h5V2AUP/4OGznNWCGM8fYeYmoItdsV1DraI+6TL+zZkJl
	 Y0khj2w+2EwaNda89/JBpIYecyuz71NTI8YzjTNBfcVd/5Mkb/Z7X5/1zK+fIXr5FM
	 +PNJTb6Ag9HAITUVOGiQncGo=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 045AD40E01BB;
	Wed, 14 Feb 2024 16:11:54 +0000 (UTC)
Date: Wed, 14 Feb 2024 17:11:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214161154.GEZczmStsolnCCP080@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214090630.GAZcyClhFloQfHEqrC@fat_crate.local>
 <9a82e9af-24c0-4277-b4d0-a708bba2cc88@amd.com>
 <20240214154909.GCZczg9Zfb_PXu2qV2@fat_crate.local>
 <4107582e-03e7-4edf-8c50-6bf693f2d18e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4107582e-03e7-4edf-8c50-6bf693f2d18e@amd.com>

On Wed, Feb 14, 2024 at 11:01:36AM -0500, Yazen Ghannam wrote:
> "then be" -> "then"

Fixed.

> Otherwise, looks good.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


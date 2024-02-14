Return-Path: <linux-kernel+bounces-64858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B608543CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577C4B251DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C3B11CA9;
	Wed, 14 Feb 2024 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HIj1aOUd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280911CAE;
	Wed, 14 Feb 2024 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897918; cv=none; b=B6AMN6en00aEN3nS66HDvGTl57xJw27Ks5x9a3eQSpZO/hlYMorYrKKNSLSau+LAKERkYguBfQ8z+K/zSe4/YbZAiY7i6IlFG6HzJOoIT2yte8ORurL0X3KZdPwmlE3ToIa3y4Lr/cKYimp7VZG2TgpBqBcwig7kY7+0hZ8O43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897918; c=relaxed/simple;
	bh=SxLL66KI2Rdgt4DQ2amvwkz/bwGfcJljx07IEjRYabw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9fibC5cwW130VPPhCtHDdmQTrk/R8E+EByFvic3PaiwIVZ3flpKlLjWr4BXK/niXOCQcPA3ZfdZNZdgWFzMRmys2/v+D5xtR2UHKUwPrA99h8hnN+tLDHEb3Z7zzA4eYtDndYJsmSUQzkBJtczpUlefvFc+L2w0pZ986adaaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HIj1aOUd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2221D40E023B;
	Wed, 14 Feb 2024 08:05:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8Md-vuCYqU9g; Wed, 14 Feb 2024 08:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707897911; bh=qzGqNBXybCl6E1OOEmCbLF/cWN/TtS0WFUma9rI8APw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIj1aOUdL9YCVuPfBR5G1tr55pVcDG48HB/VtwVWIf7L/uZZjPnioSO+oieE1lZF6
	 MBPTepQ+862TugI1zZspCSCeS4H81jx6BpVMZGbgZvQ83bN/19MSeWAnjxCTAeCy4D
	 jgMUU6PYJHAw/Acs6QJOzDQ/jTINI67DSEnKKNkcAF0OCO14EUQ//nJL2vQPKQTe/E
	 Y+nzES3JJ+RkWWpGr052Gb9Eiql+Q6l/HkLjCksU9WPmvoVAvrn4hFl4Nutn4jihKK
	 GFdXk9Yz4mGuYqHhv/RpSSxYGe6WzzOKIJGBxlyQf8G66F3GPJNiht0dkgOXQw+yGO
	 aPlH4f+jm+dp9dkG/OXGKycqgM+aRFqFLy4RR2tOPjcsOZdjetWfgHgEDjfy8vYm7e
	 0onXxc/+PZ4GCznhONM/0f8GIEk4+lb3yMEztvwkZu7ekrLbknAoiYrKL9gERGTmR7
	 NHBZU7pN0qv2I+WAfNR669B5Z08XK9D3uAv+2hcnUEZY42qrBrP7MrsJQiXyT2ZTJo
	 ADoWt5ihdUFIUrwq44ODoZacS+uvOqK5TQGrzJj+YJYJseSYIrlwgB1mXNuURw+RWL
	 9BWHnFdN72yxwBeMYfW0ndq+8f3fHAQ/sDI+xJQaS9C3Xr5+JFy+aONGSSAunMhlWh
	 0VQWuDu1xtLer1+ihQw46OvQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB25640E0192;
	Wed, 14 Feb 2024 08:05:02 +0000 (UTC)
Date: Wed, 14 Feb 2024 09:04:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>
Subject: Re: [PATCH v3] EDAC/versal: Make the bits in error injection
 configurable
Message-ID: <20240214080456.GBZcx0KPuNdoD0dQEf@fat_crate.local>
References: <20240208094653.11704-1-shubhrajyoti.datta@amd.com>
 <20240213183439.GDZcu2PwWnFxsRp7x2@fat_crate.local>
 <BY5PR12MB49024FB7BAC0CF996726E366814E2@BY5PR12MB4902.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR12MB49024FB7BAC0CF996726E366814E2@BY5PR12MB4902.namprd12.prod.outlook.com>

On Wed, Feb 14, 2024 at 05:33:25AM +0000, Datta, Shubhrajyoti wrote:
> Thanks tested it working fine .

Thanks, now queued.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


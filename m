Return-Path: <linux-kernel+bounces-121709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC9D88ECCF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728E21F28D53
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305E914D2B4;
	Wed, 27 Mar 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="j1liQETL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4AB14A60E;
	Wed, 27 Mar 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561242; cv=none; b=hT1h3bemIsj5f7fj8pptLwXeGsB+YEIFE0VJtV5vFxNI37a9PaFS4i5umqjrJch0l2tjXKczn+/kxjA+J60/IxBnUhw1cYvW35M8Wiw6HsNFirsD4DKuZbtJQpuvdvM1jKQ8Qy/Kr7XHvqC7ABuqlXKxeJvH5HeQeLcrid7Z97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561242; c=relaxed/simple;
	bh=srgctdpBr0p3tnZe1+I+kGnQ9airdU7dZhtChNsf194=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvduotWDjY4kRtAeq6YPVufNoUp0Z9heIO3CMan8NPLuV6vwInFu4fDAz/8WDYdA+cXB57eFJMEhTm00T8xIYOFiaiVOcSFd8hmB5q/9NFu6GExuPuoFt1X/k/KdRbpHlMuMeb/6v8mP36QlIKqgSN+xGoJbQkBqr+SQiptagDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=j1liQETL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2506940E024C;
	Wed, 27 Mar 2024 17:33:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NEGRHPZY1Udy; Wed, 27 Mar 2024 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711560795; bh=7hJcNztbvoltbNYuqLlcZ4eKB+PYom08C1n5dtPK9ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1liQETLuNzbUZlMOehHIkqvcM36uSsIEz0qIYPLwz1LbPguT7XuBKfkQf9Ru3SX4
	 F0hT16k3/m42OBUpKM8wvfmxs1rteeSEvO//NHexUdyUv8dU/g60vZpVZLnU8j75+d
	 mo+KYYwTKsoSq7bgIpxQB+4See5S4BFVBXzV++BDOUy+1fIgfhIEgeFHWO6ryoaFel
	 THmDopG604QqctncHRO3kHX/bAXpfAJY9yLTbu6jsmknQzNj+mABleokKcMVyGCiWp
	 uI+8RgPWjuEnjHdblwtjo8aNuNQ7q/LLig1yPyjQgapTwXk7+WOiTBVL8j9/X7R/wq
	 tvkgn2VfSsNfrzMBb07IP9AgIzkwWO8HJGe98cFbDyJUBYDdkkLqoQkvyf2BnXmYBS
	 lrxpqbvD5c5Aqnpww+oGWFHHFb505nnDXExvSI6UkdL01C5cfgL0vRmbYiro+EX92q
	 4goMCwx0e0F8uLKswzFS35E6L0rlaT0goFGyAHztVd5ByXn7jwx1BS+p+CF5tWcfMw
	 rhQPE+KvUpIhy6cCrQBaL9XRlDKuHXdLHk06469C562e3fUInsClQIXOa6XXVB5Wgp
	 1suToznxeCdRprNsMhOX7YgIWco2HEPOfL6zc70I7rjY6BiE6xpbi7UCaZvppLMNjH
	 4KNy9KDl6A8BK85o5QhAu0jk=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4318140E0028;
	Wed, 27 Mar 2024 17:32:52 +0000 (UTC)
Date: Wed, 27 Mar 2024 18:32:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Douglas Thompson <dougthompson@xmission.com>,
	James Morse <james.morse@arm.com>, Jan Luebbe <jlu@pengutronix.de>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-edac@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Robert Richter <rric@kernel.org>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 0/7] EDAC: remove unused structure members
Message-ID: <20240327173245.GFZgRYPTetxzmNZFAV@fat_crate.local>
References: <20240213112051.27715-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213112051.27715-1-jirislaby@kernel.org>

On Tue, Feb 13, 2024 at 12:20:44PM +0100, Jiri Slaby (SUSE) wrote:
> Jiri Slaby (SUSE) (7):
>   EDAC/amd64: Remove amd64_pvt::ext_nbcfg
>   EDAC/device: Remove edac_dev_sysfs_block_attribute::{block,value}
>   EDAC/device: Remove edac_dev_sysfs_block_attribute::store()
>   EDAC: Remove dynamic attributes from edac_device_alloc_ctl_info()
>   EDAC: Remove edac_pci_ctl_info::edac_subsys
>   EDAC: Remove edac_pci_ctl_info::complete
>   EDAC: Remove edac_device_ctl_info::removal_complete

All applied, the last three squashed into one patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


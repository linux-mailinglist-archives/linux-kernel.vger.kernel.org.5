Return-Path: <linux-kernel+bounces-71780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B3585AA5F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7C11F23A39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3528346B9F;
	Mon, 19 Feb 2024 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hnQo0n6l"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDE84594E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365098; cv=none; b=jPxsE/yGbr+T5I+557LKbFUT2yq+04bHH3XV4wUuvgB00rC46MudITop0uL3xiGeRH7qowduHUFV8TkKzqr5e+RHWAHAnEDs1RLs9DXj+blw5FX4EkzQXVPmNk0lpG8sr/k29Mi4NrQfChnhtmRl2mKu7PxB73TNS1cW3gZ1TLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365098; c=relaxed/simple;
	bh=wszlg/6UbbXXamtux+VN6yTNaWZkhNexVwTr5oXN7As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk0WW4KVPkAgBLO6tI3ygsH4/85Hgs4yD27uSOMr/UeITSEJgnXUuNUont6d9s1oXXjldBeKlrtvLpx0GRwXeMBqQoh1wlCWdVO+IlF9jGcTNvZq28tKsmViEmrIHYm1qTCv4FFRe+GmpuCLpkQ928P8TW9lAXqlJfcwyIIijFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hnQo0n6l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 87BEC40E0192;
	Mon, 19 Feb 2024 17:51:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HYUoA1beuWMC; Mon, 19 Feb 2024 17:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708365091; bh=KaT0QdTbAnL4p4+2f8mugU92/960QRKaLA/3MM3QqL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnQo0n6l1tEepUnqFsm79L+a5sjiw1zM2yOkLmipB+IT6EkMa0uUMPRl+MrV89m9/
	 Lixny+CITejK+HQkBtB5m0Ua71wuEFRAJlBJRSNJR7fP7WvFl7dRGwTJqpybM4rU0t
	 D/8iVUU9nxunGwUJorgfeb8kxbQkg9Fm8rPJ4VdLhyjUum46t5J2X70gK28Q4hfupc
	 LdeUtvi36cPrdfJILwPwenLqtvbkb9XIixT+tUqwXw443xwRytOW7zxqg18E626K/e
	 bVrocPGDXsKMjzPBYI+noeRY1ladI73fV3DTBrgCDFTiU0SKRq34tUXTdu91fadqPR
	 Ci2xFuI70Z9hYMXGuLJmxHAGLGaTnhbOT6d+wtgmxQjErt1QvbjRvygzPQSNLSiDig
	 GkAc/GQ4ywnX9rP696lE6Irozv1PRFEeOnJ3GGvZHtcJNySbyUx+vMa+W9EQOxVF2K
	 RPipzlZDC6CL+XLYv1lnPD6bs2rudyExBjDRRQqeD9/KWATNzYGVzjVuJ7Z+XPxgyS
	 tWWoBs1x0YAINHObl6Q+EZecyEd710fdsLgAOgKNGhWK0tcMcjEb8BWH6pjPUmrpEr
	 gDngTGPH1k5YeETcEY/KZlosZ8NhIdq30pabM9fRDq4qO93fae8sdX57W6DdYK7YUO
	 XBpjkdtrTE/8t1oXrTBD147w=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E28340E0196;
	Mon, 19 Feb 2024 17:51:09 +0000 (UTC)
Date: Mon, 19 Feb 2024 18:51:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: James Morse <james.morse@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Message-ID: <20240219175103.GFZdOVBz8tcXVbjwkV@fat_crate.local>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local>
 <87zfvwieli.ffs@tglx>
 <66a54c8b-2013-48d9-8114-6f3f72cd2871@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66a54c8b-2013-48d9-8114-6f3f72cd2871@arm.com>

On Mon, Feb 19, 2024 at 04:53:38PM +0000, James Morse wrote:
> Thanks - I'm just putting a v10 together to fix this.

No need - I'll fold it in.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


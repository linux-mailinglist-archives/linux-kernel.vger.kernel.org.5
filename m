Return-Path: <linux-kernel+bounces-81164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D16867155
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DF128993F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D704853E05;
	Mon, 26 Feb 2024 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T7kI/UOW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB41BC4E;
	Mon, 26 Feb 2024 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943408; cv=none; b=TfE9CmFWaz0cy3kaoea65Jwa+p/lTreFzutV6KZokVfMSBE0+yLapbRkunjhH5Gtzg2unkmNg/VwGq678yZ3SjRtAODSMdkQ+xKIsedEN3mQbpCxyj5qCtur2vHjluBar75CCkeF0PAihzMbM9xnQzIjI3v2Y0iiSkLgUS9tXBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943408; c=relaxed/simple;
	bh=1gssGLDWBwd5TR2GbXCEaXghJw5mSrwpLhPlGUk3dTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLLwiqGa+m8Z9rdbXp5u0cTR2q0epIvVamxJ0sHP9//cdylxCrYGuZd8Obqo7iSllsm0XM/EYnJ444fnRwJXTxNF9wMjLoj2/wml8zWnTyZzWX5OpwUBJ/PkiNwt9uhoE7bv+nHM6IP4I6xbspdLIqx7AIugkUaidJKS0VyY0q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T7kI/UOW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C88E40E0192;
	Mon, 26 Feb 2024 10:30:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3hwmnnfbHmpR; Mon, 26 Feb 2024 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708943400; bh=Uk18MAnYeobpuZAlHZy8fLU6VFT+yZHRPdSaWvS7J0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7kI/UOWE8N3GaTFewiJhglD8ljyhWOM2j5YbFSLN0p49b34AZNO+BLYA4zsOEkyO
	 itjl0w0A0oFcdGnU7x8bXJtNLJ6z06cPrtC+MHPeRlK6faoX/XFJf2kY1sXTChcehH
	 PTcjKMMDESMAa8qTNaRtyX34ejT5yONemI5jv6BQsSjacnDu9b+xBuYQCu7RIGAUEO
	 WccwpfWnEt8e50ocFo3GJpCF+v8S+ozCaX2YasQegHwsEomEbT3CFv6Ng5qYFJJjPM
	 M3l4HcdyFMchU7zmd+8tHxIUXstADLz6zl8kGHWRAKaCmICTSbbROgh9yM0AeBBJiZ
	 Y4UdFtaf8x23++dzKM5RqNsZZ7Tegf6YFzPRk7K623NnkFOl8dI6cgLnkZ4sVVKUqj
	 ZdOMafPgQGr76rBAlb7M6mkZgHs8I4iBYi8yY47MNyklCWReHLZNS3LHrUYm+pKStR
	 ugG1zW2pLOQ0DaHJOEVQleUq+UWkxL1akaW0gB5ijK5TZnIkg2iSGoI3pLPLaLNOUm
	 x+lMQFrd2nRpzRpEKgMOk75x5n14jiJ7sUYJgvcCtsyoKa7gT/F5b5OPrZE3vGfnEA
	 m2yVc0e5MK1q7AuYqu5ph+pX6sQzBXYLUMa62wkb10Nc5f8Lq3TndaVNbrMLjDMVhO
	 RZ/sgkb6VP37z5cNy9TLDIQM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE6AD40E019E;
	Mon, 26 Feb 2024 10:29:24 +0000 (UTC)
Date: Mon, 26 Feb 2024 11:29:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	"james.morse@arm.com" <james.morse@arm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
	rafael@kernel.org, wangkefeng.wang@huawei.com,
	tanxiaofei@huawei.com, mawupeng1@huawei.com, linmiaohe@huawei.com,
	naoya.horiguchi@nec.com, gregkh@linuxfoundation.org,
	will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, linux-edac@vger.kernel.org,
	x86@kernel.org, justin.he@arm.com, ardb@kernel.org,
	ying.huang@intel.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v11 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Message-ID: <20240226102918.GBZdxn_v0NbVjs2XMB@fat_crate.local>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-2-xueshuai@linux.alibaba.com>
 <20240219092528.GTZdMeiDWIDz613VeT@fat_crate.local>
 <bdf15819-46e0-498f-97e1-a0183f257086@linux.alibaba.com>
 <65d82c9352e78_24f3f294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240223120813.00005d1f@Huawei.com>
 <20240223121701.00004bcf@Huawei.com>
 <00126cf9-bb59-4c05-8046-478d0d7f4297@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00126cf9-bb59-4c05-8046-478d0d7f4297@linux.alibaba.com>

On Sat, Feb 24, 2024 at 02:08:42PM +0800, Shuai Xue wrote:
> @Borislav, do you have any other concerns?

Yes, this change needs to be further reviewed by an ARM person: I have
no clue what those "abnormal synchronous errors" on ARM are and how
they're supposed to be handled properly there:

- what happens if you get such an error when ghes is disabled there?

- is that even the right place to handle them?

James?

-- 
Regards/Gruss,
    Boris.
 ttps://people.kernel.org/tglx/notes-about-netiquette


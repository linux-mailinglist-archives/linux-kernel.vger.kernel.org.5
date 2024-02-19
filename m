Return-Path: <linux-kernel+bounces-71027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC415859FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EC22862B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E66023772;
	Mon, 19 Feb 2024 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xf0cdP2x"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94C22619;
	Mon, 19 Feb 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334779; cv=none; b=VoMInItOIR0wPrKuhwYZVkyheUgICFY1m5ybMzhfgiPA8u9G4elNr5XahWDYnSHDO/lcNWr/ZfQgevogvZkH/sYbPybTchlkshkUaUVt3pXsUhxLcUsQb++kz/1XFK3XDzKy8K5aPvxCLgKoknSk0VJqUQxK5sKKLNGVmrjhsNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334779; c=relaxed/simple;
	bh=JvAKRCTepAOVOrEHkC52aYvy+39kprUzUC+lxvHxVgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0rQwQMx7YDoadPksGpzXi39mj8dg+RLqPQOZB0iN1DC8Nqa0MIAoWRKv/SxWU2sV0N6LNs2jerzYLrTVQgHBHg9GLeYClKPHCQrKMS+y9v37PaWYHk59VbFDI4HSgVa24Vv0zRZNE2kqOELtmSwZpv37NAeFlXL9XTCP07dsVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xf0cdP2x; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7366540E01B5;
	Mon, 19 Feb 2024 09:26:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Mq1WMaf5Uafz; Mon, 19 Feb 2024 09:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708334770; bh=UeyP8KcF7dj4h57hjnNyWpdHtLUCNmmBLKlm/tndrmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xf0cdP2xgYwE7kk7NPoncwRQ2vWHPuBzFiX9Tp/dkKOkz7smCwncVf0nzi1Na0lVi
	 x6ujl4Eih/C97YDlmeLExPqrbjN3/aaspiUhEbhnXTW1mcnIxZm2GBmz8Vm+MttUNx
	 718loAEebT/uwngmUFn2ICrqZyBj/QciEgICYjPGkDAsJ1k3JF11Q8g83P4umT5v5H
	 jNENwJiT4B5rbIChpoeAM/XQN3VTlBnlLBOS0P8iEDUciphLLIs5Ur52B23krqy4Ky
	 QWAjTpPWG5pPWTs4C91do1EZTp92qFN5LpX5M2Fww5TuYARes6D/UiQ6Yr/p/yzMhD
	 5nWN2iSpsbO3TDbHOv6sRHTUUhXtsdnA19VmQMa1qBhGGYxsgygmL84WdtsQal30w3
	 oGn4Mfo7Ite08xAMz5y+ziPRCJuKMN9sIKEOnT8Ja/9D5z8EIWx1tiYtBFJ45fVLd9
	 ByPPRpVoiiUHKhjBj01J6zSM1PuJmriXQv6SHiGlIKAyK8iJLYinVBmsQm8Z6OrCIg
	 +T/HT9O+/gLpixmCRHqIZcgxS/JYamyKfclw2ziFb4x1K2+HqVdbV3opVQtZYxnHw4
	 WrBcLblJm6zCeGMNmCRCHfSm/hWAaKzFiHZwPJ8ohAebLAsnqG/RI+NufsbkjC6zrf
	 l+T3vQ8Jaw0ElXahzouG/fww=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 13EB640E0196;
	Mon, 19 Feb 2024 09:25:35 +0000 (UTC)
Date: Mon, 19 Feb 2024 10:25:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
	mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
	naoya.horiguchi@nec.com, james.morse@arm.com,
	gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
	ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v11 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Message-ID: <20240219092528.GTZdMeiDWIDz613VeT@fat_crate.local>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-2-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204080144.7977-2-xueshuai@linux.alibaba.com>

On Sun, Feb 04, 2024 at 04:01:42PM +0800, Shuai Xue wrote:
> Synchronous error was detected as a result of user-space process accessing
> a 2-bit uncorrected error. The CPU will take a synchronous error exception
> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
> memory_failure() work which poisons the related page, unmaps the page, and
> then sends a SIGBUS to the process, so that a system wide panic can be
> avoided.
> 
> However, no memory_failure() work will be queued when abnormal synchronous
> errors occur. These errors can include situations such as invalid PA,
> unexpected severity, no memory failure config support, invalid GUID
> section, etc. In such case, the user-space process will trigger SEA again.
> This loop can potentially exceed the platform firmware threshold or even
> trigger a kernel hard lockup, leading to a system reboot.
> 
> Fix it by performing a force kill if no memory_failure() work is queued
> for synchronous errors.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 7b7c605166e0..0892550732d4 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -806,6 +806,15 @@ static bool ghes_do_proc(struct ghes *ghes,
>  		}
>  	}
>  
> +	/*
> +	 * If no memory failure work is queued for abnormal synchronous
> +	 * errors, do a force kill.
> +	 */
> +	if (sync && !queued) {
> +		pr_err("Sending SIGBUS to current task due to memory error not recovered");
> +		force_sig(SIGBUS);
> +	}

Except that there are a bunch of CXL GUIDs being handled there too and
this will sigbus those processes now automatically.

Lemme add the whole bunch from

  671a794c33c6 ("acpi/ghes: Process CXL Component Events")

for comment to Cc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


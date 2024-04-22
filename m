Return-Path: <linux-kernel+bounces-153610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AF98AD05C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5ABF1C2214C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C0815251B;
	Mon, 22 Apr 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iiNJ4ti9"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFAF152168;
	Mon, 22 Apr 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798751; cv=none; b=V784d7dNEpzuncGBpKvefv/lBaNIVL7EKK1dC5LTE0xLQOrP/wmlv44+3+Wt2tfncEV1Nn4vc5x0rhmI7IrP5N7qFSUBWm9zLJoluP56YiHvlE28g5ERb0ebpnVG6jI0M8hm8JD3Vilyl23s5SQWWVW+apmDlHIhgxQLLsSRzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798751; c=relaxed/simple;
	bh=n2QljjJIxPxXYwFqyVO0pm8jMVl5uWaqpEKlS07dSKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBDb+bazNnbULdvWqxqZyD0ETl2KIatLnGOWWPX5hzqEvNcgbketnRUox2FyXKKHwPR9K4L60HFJY6bW2tOygLmc+9TTBiGiBDWrr23JkhPhPmO25uUiJ55NU7BsoKb8xdCnW8HEjDnDU0WRJyuiHR2RTRKHZhzECyo+n25jGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iiNJ4ti9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=55qjHqIZitfTw5V8j2PoWpsRdoXOQTx60fjmhVXBN3o=; b=iiNJ4ti90zPQUh9KK7F1pVBY9W
	Z4ifwzEOGTd2q+GwBf/Gh4kjLs9PKJ4hBMJb7oiRAJqpAe39gYL7uUkF+50XgrcXeFvYAop0WGspi
	MrSWkPyI48x4tIVb85jXCNl4DeLYXuSRi7bUnfGvG44t0VMKY7ogFKZ4UFt0fg2mXGWa9SjMIrnId
	L2CCnpGej3nH0PNiVgXWtzLw39G8huLiE0SzQONbfsA442oq9lrxARCNMDkcDGR/QvQNq1CHnR1pC
	ZxFvhjd/wbGMoSOQoon6OomaS4pIfLRVVtTMykwkQDo368KUg79gmy357hiFT5p9yA7XKcfrmiJgL
	Ks+zOQ5g==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryvLH-0000000E4Pf-1m44;
	Mon, 22 Apr 2024 15:12:27 +0000
Message-ID: <7aa0e3ca-ec2c-4da7-a6f3-94163edb54c9@infradead.org>
Date: Mon, 22 Apr 2024 08:12:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/MAINTAINERS: Update my email address
To: Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net,
 elena.reshetova@intel.com
Cc: cabilbao@amd.com, bilbao@vt.edu, avadhut.naik@amd.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240422133726.129074-1-carlos.bilbao@amd.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240422133726.129074-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/24 6:37 AM, Carlos Bilbao wrote:
> In the near future, I will not have access to the email address I used as
> maintainer of a number of things, mostly in the documentation. Update that
> address to my personal email address (see Link) so I can continue
> contributing.
> 
> Link: https://lore.kernel.org/all/BL1PR12MB58749FF2BFEDB817DE1FE6CBF82A2@BL1PR12MB5874.namprd12.prod.outlook.com/
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/security/snp-tdx-threat-model.rst           | 2 +-
>  Documentation/translations/sp_SP/index.rst                | 2 +-
>  Documentation/translations/sp_SP/memory-barriers.txt      | 4 ++--
>  .../translations/sp_SP/process/code-of-conduct.rst        | 2 +-
>  Documentation/translations/sp_SP/process/coding-style.rst | 2 +-
>  .../translations/sp_SP/process/email-clients.rst          | 2 +-
>  Documentation/translations/sp_SP/process/howto.rst        | 2 +-
>  Documentation/translations/sp_SP/process/kernel-docs.rst  | 2 +-
>  .../sp_SP/process/kernel-enforcement-statement.rst        | 2 +-
>  Documentation/translations/sp_SP/process/magic-number.rst | 2 +-
>  .../translations/sp_SP/process/programming-language.rst   | 2 +-
>  .../translations/sp_SP/process/submitting-patches.rst     | 2 +-
>  MAINTAINERS                                               | 8 ++++----
>  13 files changed, 17 insertions(+), 17 deletions(-)

Maybe also update .mailmap ?

thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html


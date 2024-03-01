Return-Path: <linux-kernel+bounces-89014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAE786E976
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C4C1F23E20
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0906A3B296;
	Fri,  1 Mar 2024 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MlKMqM1A"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28225623;
	Fri,  1 Mar 2024 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321080; cv=none; b=nJLeW3r4GoRzPzbXm5JyasaszJoTJbeTYRpLu9uPX8Sf5qK0N+C8DrXIgXps9+eQkcKTJdbfvABhN2skAedsvMHdqeqzNadshjff2fUK1DKLNM34qhY7irsPELYd2l7Hd5bR3fEcR0OzSI2pqi9QnTz7fiHK9IsDumZMWtvOsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321080; c=relaxed/simple;
	bh=U7Zc0jq6K4qFO334zIUMtRqbn5pmAPrPPZHfTnCwR2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSO9JgOOswRcWTh5Uo10AufCgIIagpSXM5zfLRuJC7hDU4ul7y6eU7FMIhyCVHcGK6nwVyYhZa5q8EEMbGyufaMhxjwKFV5T+h6jH67j5UkQf+PNPVa11O9VTefo72N0m+tMcx2ubWO+4jRnR7bvTe5RfB8y/1//zNYZcvZQ+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MlKMqM1A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=bZHkpnTkZV3pyVK5JanyWDiipM0alfudJxvxB4RV0Is=; b=MlKMqM1AsKtHCzF4YS3XbVnlcs
	2eCoFYfTCLiLK+3xmgkHcGXAIAVYlmr284BZ7ajOlUHLaZSFKjglSp5cBhDZO/zL9OQ+tuGWC+Myr
	btPtQsE07GW5kIBwO3Kr0R99OE2PiFGucd6f5roo9kYFgMy/8S50hKGYErUMH3tlpbbGQpHPeDB2V
	E1vBCkgrKX57GV9Wx5Mb7GkutMeAlDQwJZb2yanA5eMW4XUaTC/HpbZwhpkrZRRJWByTiKyfhfa7b
	Zt6dKdmTU8YQklpmf/jmn5lYaJS/6e+CEkt9k7aDXw8N5d1aAfqTOauTQXaxjLj1IfBcCLa+GEKTE
	qL+LS3jQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg8Ul-00000001hrn-49nA;
	Fri, 01 Mar 2024 19:24:36 +0000
Message-ID: <df67c46b-26a3-44da-8404-1bf445cb6efb@infradead.org>
Date: Fri, 1 Mar 2024 11:24:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] powercap: dtpm: Fix kernel-doc for
 dtpm_create_hierarchy function
Content-Language: en-US
To: Yang Li <yang.lee@linux.alibaba.com>, daniel.lezcano@kernel.org,
 rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240301081802.114308-1-yang.lee@linux.alibaba.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240301081802.114308-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/1/24 00:18, Yang Li wrote:
> The existing comment block above the dtpm_create_hierarchy function
> does not conform to the kernel-doc standard. This patch fixes the
> documentation to match the expected kernel-doc format, which includes
> a structured documentation header with param and return value.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/powercap/dtpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index ce920f17f45f..f390665743c4 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -522,7 +522,7 @@ static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
>  
>  /**
>   * dtpm_create_hierarchy - Create the dtpm hierarchy
> - * @hierarchy: An array of struct dtpm_node describing the hierarchy
> + * @dtpm_match_table: Pointer to the array of device ID structures
>   *
>   * The function is called by the platform specific code with the
>   * description of the different node in the hierarchy. It creates the

-- 
#Randy


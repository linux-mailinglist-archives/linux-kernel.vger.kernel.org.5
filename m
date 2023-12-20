Return-Path: <linux-kernel+bounces-6282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F348196B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF69DB221F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4718813;
	Wed, 20 Dec 2023 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yAvZzdkw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443EC79DD;
	Wed, 20 Dec 2023 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0uJT5gTIpGFqVn5BDA+jA6ZegGHjTIiqXuV3kQHOKvc=; b=yAvZzdkwIn63b04Z6f4uZW2h/D
	+1ftbdo1MCv7BJq6ZQJ8bXx0V6Gr3soCIeS0vXq9XZy8h9bIIAILJmQILjKYAxHlVWveRmNDDMAcY
	5Fk1I+pma4h++A2doMPEyAICamKGL111P0OfoAC/cacCdiwWZDqq3xrcuL/Elr0kfoeCovdp5UHTI
	7U3o2Lg+acCCHDXC6SHYua8vpqfCsD2ZBpIPIAmREF/WXPtXirq5cD/hnilrUue9X2jqC/b07zUJ/
	c8PKKMLZ6bS0Sm/uHnybu4/z2N+orzi+1ZYoSYXwDxA9Lf6qjORUwwU8idpg+sjm4qOzg2HveJKii
	PQYCwjpg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFm1k-00FxUJ-2E;
	Wed, 20 Dec 2023 02:09:40 +0000
Message-ID: <f5e1641a-3d92-4822-9ef9-202e6f5b8981@infradead.org>
Date: Tue, 19 Dec 2023 18:09:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethtool: reformat kerneldoc for struct
 ethtool_fec_stats
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <87v88tg32k.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87v88tg32k.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 15:55, Jonathan Corbet wrote:
> The kerneldoc comment for struct ethtool_fec_stats attempts to describe the
> "total" and "lanes" fields of the ethtool_fec_stat substructure in a way
> leading to these warnings:
> 
>   ./include/linux/ethtool.h:424: warning: Excess struct member 'lane' description in 'ethtool_fec_stats'
>   ./include/linux/ethtool.h:424: warning: Excess struct member 'total' description in 'ethtool_fec_stats'
> 
> Reformat the comment to retain the information while eliminating the
> warnings.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  include/linux/ethtool.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 689028257fcc..77c7a9ac0ece 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -409,8 +409,10 @@ struct ethtool_pause_stats {
>   *	not entire FEC data blocks. This is a non-standard statistic.
>   *	Reported to user space as %ETHTOOL_A_FEC_STAT_CORR_BITS.
>   *
> - * @lane: per-lane/PCS-instance counts as defined by the standard
> - * @total: error counts for the entire port, for drivers incapable of reporting
> + * For each of the above fields, the two substructure members are:
> + *
> + * - @lanes: per-lane/PCS-instance counts as defined by the standard
> + * - @total: error counts for the entire port, for drivers incapable of reporting
>   *	per-lane stats
>   *
>   * Drivers should fill in either only total or per-lane statistics, core

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html


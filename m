Return-Path: <linux-kernel+bounces-92833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C667887269D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A86285751
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC4199BC;
	Tue,  5 Mar 2024 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPCF1SzI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A814A89;
	Tue,  5 Mar 2024 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663685; cv=none; b=TbhaKKvJLaDtctCc4tNof2LZQWPhOYtQe4ROO4C+Au5ykWGavZFvz5esCGMLDIQTIMCCxRDFp9vvvOrDSutaIXI6FmTpD+Jgjpa4MiRs9wFWXExSUTVxyEs/9/0Bpi2FC1R7VFqk3KNzQd0Hfg6kABALWRf1gmCCWdh3gccLnR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663685; c=relaxed/simple;
	bh=7Y5PRGDd3DbEB+kbePurEXliBR8uj4hnZjuQ5yw7JB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZC4TtJ5oxawiI8aDxkIUr/b7xOYHjodKzQbaKAXlpuNz9AuhE5/93VyXqqgHTcWavpY3L15cYivUti7asGkSvyvcdIW4JWJrUac/SnDFhf4FPPUVuJZWAunE+nOplLzOyO8k7l4kgnTONZMQfrdr/jJH6FW3E1vcrl+U821adY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPCF1SzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93D7C433F1;
	Tue,  5 Mar 2024 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709663685;
	bh=7Y5PRGDd3DbEB+kbePurEXliBR8uj4hnZjuQ5yw7JB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OPCF1SzIAnjbI7quNW7xp8leOBA87Q/iPoF46n2xgeiI4a1Cos87Wb0VDkruHdU04
	 bsZuU419RoPh0Di5UcpCARYEYYHRHCutJQwfmVa8pRPyFgh+JuK3/NzDqGQ7HXZpnq
	 I6b/rDrnqf6Zjd120gqjXOOIFystR4LvUG6GpEV2TXqrPW+w7q9FqhEVYH+QcZR2Df
	 o3dOtjocT6lAOW0LwLLHAgTApREV4tuPm590hYkD2Vljl8iiDXM5IkhvpoiJjYQ4xa
	 825Pgx8io/8/akG5j5Zsuv7NwKrF41RzTVjbJi5wH37oEU3NHBQmsHGv1ibjrChncp
	 dT92okxBd1CHA==
Date: Tue, 5 Mar 2024 10:34:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Thompson <davthompson@nvidia.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Asmaa Mnebhi
 <asmaa@nvidia.com>
Subject: Re: [PATCH net-next v1] mlxbf_gige: add support to display pause
 frame counters
Message-ID: <20240305103443.70e1f619@kernel.org>
In-Reply-To: <20240305151851.533-1-davthompson@nvidia.com>
References: <20240305151851.533-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Mar 2024 10:18:51 -0500 David Thompson wrote:
> +	/* Read LLU counters only if they are enabled */
> +	if (mlxbf_gige_llu_counters_enabled(priv)) {
> +		data_lo = readl(priv->llu_base + MLXBF_GIGE_TX_PAUSE_CNT_LO);
> +		data_hi = readl(priv->llu_base + MLXBF_GIGE_TX_PAUSE_CNT_HI);
> +		pause_stats->tx_pause_frames = (data_hi << 32) | data_lo;
> +
> +		data_lo = readl(priv->llu_base + MLXBF_GIGE_RX_PAUSE_CNT_LO);
> +		data_hi = readl(priv->llu_base + MLXBF_GIGE_RX_PAUSE_CNT_HI);
> +		pause_stats->rx_pause_frames = (data_hi << 32) | data_lo;
> +	} else {
> +		pause_stats->tx_pause_frames = 0;
> +		pause_stats->rx_pause_frames = 0;

Counters are not enabled, meaning we don't know how many frames were
sent? Or pause frames are not enabled, therefore we know it's 0?

If the latter we should add a comment clarifying that, if the former:

 * @get_pause_stats: Report pause frame statistics. Drivers must not zero
 *	statistics which they don't report. The stats structure is initialized
 *	to ETHTOOL_STAT_NOT_SET indicating driver does not report statistics.
-- 
pw-bot: cr


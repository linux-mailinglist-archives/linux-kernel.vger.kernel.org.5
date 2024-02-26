Return-Path: <linux-kernel+bounces-81898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B907D867BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAF91F29C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067C312C812;
	Mon, 26 Feb 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsPN+TZD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED812BE95;
	Mon, 26 Feb 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964665; cv=none; b=T9hg2I/ITK6+PV6IvD0pZz9rqSbN4Cf0ojDu1QWSd2ED7sPVajtwbgeT91Zs67CEMOh2bzhPMS7wv7OEcOY/F77OFn39v8sBTNS0s3O4ewtneKRyhHRsU1uYMfvTOT51dWGcEqytnTBIeu7L0SuyDrvgNgw1B0iQWHra4z0NOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964665; c=relaxed/simple;
	bh=WDfGU6WF08sQICSXOzLivnCh9xD4e9M6P1fXsK1l/Po=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKGJKcZPI6yFKzMLWhSdg+o7t7yakNKFS0u5X06xiz1ohqbRwEArL9vqshTGhhAeQIZfN+td2csuCO4KsoCl86Nq3+PJZFmZih8l2xm86FENqwslaLR6CWsOqKOVuQKFa+lG6LkZmGLemwa6zwmTeKxrPfTtZqfcS857SE05h7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsPN+TZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94431C433C7;
	Mon, 26 Feb 2024 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708964664;
	bh=WDfGU6WF08sQICSXOzLivnCh9xD4e9M6P1fXsK1l/Po=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CsPN+TZDv3SDYpow+0YMxyg4LGDLL/hI6iLOA2WxW3um0du8XnAjbE4KHOFpXHdD/
	 Sm9/yD1jEsoWqgrE+c8a1sLVgh28uneb7tXNH7CSXSOtLnaDn15PlEWWZMLfTPM8D1
	 EgwVVMsMIwyfrPIypXTtC0dsN3IeDhvDNBK4irfG7shA9FwVOXlJ6JijV72WewdDRh
	 8lxombDPqFLnfgr4mkXEHzriXKkZwh+AkfnaWkCuJM+5y3Gde8jNS3wD97G6pKRSsy
	 JQkSUAxAFVTiWbbDAYAjLzXPt8QOd+xNNDDS2YieaWWsDdP0St/ZcLBayB9SytuVwV
	 dOWF1wNAApZuA==
Date: Mon, 26 Feb 2024 08:24:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyue Wang <haiyue.wang@intel.com>
Cc: netdev@vger.kernel.org, lixiaoyan@google.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org (open list:DOCUMENTATION),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net v1] Documentations: correct net_cachelines title for
 struct inet_sock
Message-ID: <20240226082423.324b7a93@kernel.org>
In-Reply-To: <20240223120215.2300560-1-haiyue.wang@intel.com>
References: <20240223120215.2300560-1-haiyue.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 20:02:12 +0800 Haiyue Wang wrote:
>  =====================================================
> -inet_connection_sock struct fast path usage breakdown
> +inet_sock struct fast path usage breakdown
>  =====================================================

You need to adjust the length to the markup lines.
-- 
pw-bot: cr


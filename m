Return-Path: <linux-kernel+bounces-32043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EB08355A2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CC8281EF9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F1036B02;
	Sun, 21 Jan 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="GakjS08x"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C56273FB
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705839722; cv=none; b=F2T0wvVylWYY4PmmV7IoLqYZU6CH8m97/PtZA/Cd4c7OSmgKLzMlUVyN6qasJPTrwm2vSDKtGD8XOJvyrvk5Pb2z6Nk9WlyE1OA8eEDBHoWcQgtO1uyYTvtFvd4oX/DVuWBvADQK6u6KtZGQv/e3QOVpNVZCLFTaCKKigDx+HCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705839722; c=relaxed/simple;
	bh=o1t6NlrqghyU9rGMUDhTLRcjKyBZkUM9u1OELKMcUQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp6UGI6KDXrs/mVzOTIKFGwl5EAkq9zETN9cc01AQ0+1QAeu/Z5THtOpKrdcxFwrFNsFABJwwuzBk3QA7mc4ioiRjyTFLz/0iOtXqqgd66WE3FUnMNLXQKARykSPl6CO0DLPDYBxb6rTIDUqYU6Sf7YsBxM4UT59PruK58YAUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=GakjS08x; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 30448 invoked from network); 21 Jan 2024 13:15:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1705839317; bh=xTrv3uIUbt6UuXd8Zd/SNP2Yl4s8u6K1/Z6BTJI5wkQ=;
          h=From:To:Cc:Subject;
          b=GakjS08xiD3ByYQHOhS491W/hV1pCZ0oyXWx5lYFdSbHZaxa0gC1shzQh0dLP9evs
           tAOTN0CcpJ5XUc+7OkBCLF7fpV80V4MTt0vhyUO0Nq/E70irZ4m2z4EdlWr4ZWkb7g
           jQ1R5RsThmRD4jqKpOx7Be1ogz4bE8C6p+u/YU0k=
Received: from 89-64-3-131.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.131])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <erick.archer@gmx.com>; 21 Jan 2024 13:15:17 +0100
Date: Sun, 21 Jan 2024 13:15:17 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Erick Archer <erick.archer@gmx.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlegacy: Use kcalloc() instead of kzalloc()
Message-ID: <20240121121517.GA52639@wp.pl>
References: <20240119171655.7740-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119171655.7740-1-erick.archer@gmx.com>
X-WP-MailID: 7942f6e91f609b762a6db31f482acad3
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YQPE]                               

On Fri, Jan 19, 2024 at 06:16:55PM +0100, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> Also, it is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not change the
> former (unlike the latter).
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>


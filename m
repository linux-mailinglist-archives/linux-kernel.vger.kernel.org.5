Return-Path: <linux-kernel+bounces-38536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C670583C12C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637CD1F273DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D812D630;
	Thu, 25 Jan 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEqL56Hb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0202C68A;
	Thu, 25 Jan 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182887; cv=none; b=PKqW/SB3yaUgBFQOF3LPVdbLQMTN1LTq0ba94y4fYeJKaHzizJNKph2MitxTkRLyTowhJNPt4/cXAOJRGnMIEZMh0KgpyJwotE1qoymslgVrwikvMNIFRrYorC3gr0XbXOFkDqGbOHoAjY/tkqcWIgzYHSa6zsjMFclqMZVvdf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182887; c=relaxed/simple;
	bh=2UzSqM8F9c6/TN1nA4iesswlEyFVZxzf7xU7GhWbgpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK7AuAnfxyId+L4kYOGJwCYCBQrTPHhxAxn8z61quwuefGNFs9D007Tb0l9fIFKLdumCbdOnM1JYFCeH/HCeHgFBEdftzkx4to8Sym6+DY40IrFD28Cwzf+eV7LBYlRjCIpxL9oVj57fcPkGR1X3CJyVgLO7wKXUbKiNJDwJ/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEqL56Hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8FDC433F1;
	Thu, 25 Jan 2024 11:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706182887;
	bh=2UzSqM8F9c6/TN1nA4iesswlEyFVZxzf7xU7GhWbgpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SEqL56HbfgFWQYZWtFveo2Asmt+joabM+0CwoMkWkrKE7g8dZLIdFnsb3R8RXi1rF
	 shsYXpKCw0dGfMbiICEALxlUUW8U2LwWBP8lIH2RUX0KQQRMbprWNV0AgFL0K9yMYb
	 svhpmElf4DYufeqyU//Qfz8CVaYiifEOiRK3KpmpUrppYJVg5yGCnq5SVwpiY9f1jU
	 V/xp49v90bSVjsnbWtAK/ooKHytdJO8pS4eDRa1Q3c4SeJPVVpqxfvIgaBKehtMMEn
	 8rEGVhiXgUVSX9d1tzfLYlPfSLIWelonaI+kUTUNdAfD4EMby9q0B8UFlWdjMealeK
	 /Y3w5OvB3VlLQ==
Date: Thu, 25 Jan 2024 11:41:22 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sbhatta@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, bcreeley@amd.com,
	sumang@marvell.com
Subject: Re: [PATCH net v1] octeontx2-af: Initialize bitmap arrays.
Message-ID: <20240125114122.GA362264@kernel.org>
References: <20240125063414.3930526-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125063414.3930526-1-rkannoth@marvell.com>

On Thu, Jan 25, 2024 at 12:04:14PM +0530, Ratheesh Kannoth wrote:
> kmalloc_array() without __GFP_ZERO flag does not initializes
> memory to zero.  This causes issues with bitmap. Use __GFP_ZERO
> to fix the issue.
> 
> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ChangeLogs:
> v0 -> v1: Removed devm_kcalloc()._

Hi Ratheesh,

sorry for missing this in my first review,
but perhaps it is better to use bitmap_zalloc() and bitmap_free()
as suggested by Brett Creeley.

Link: https://lore.kernel.org/all/cf035125-d7fb-4423-8f64-a5be7505243d@amd.com/


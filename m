Return-Path: <linux-kernel+bounces-146448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CB38A656E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E901F22DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723A84FCF;
	Tue, 16 Apr 2024 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cn65QYWc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399C7FBC4;
	Tue, 16 Apr 2024 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253893; cv=none; b=YaIfLgKhr1pzn3V6vRcvvfd6cSvqXAX3UvmeBD+YDJpH9dKYMaK4cXoWXHF0cbR9+oVOitjgX1Ut6ZKy3y7q2y6plIH3P+VP/ofWo02Y4Bel7MTZBiq2jFvEIX7dmLmm9EvbUFihvO941XxDsGm7FoupO2h9bRzIt4lOj/TxkdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253893; c=relaxed/simple;
	bh=0h12jKHwF4Q23zJdnmkVEYsybpaUrdzSGB8yYNi/mbc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dikQqXzhPOb2TS//htyBoO8FnF9I0v7nNhFxLKolMz85bj553lvKVs942hsnkx6F9k4CcAFIqce/2Agpkk8ZvwinhkXu0vj9HEgxNBrtTnJ16i69wr7CajDTT0A4vez9FvwQubCUj+Embl+6qV2zk9tyzRtqGoZ24RNi03qtUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cn65QYWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FE5C32781;
	Tue, 16 Apr 2024 07:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713253893;
	bh=0h12jKHwF4Q23zJdnmkVEYsybpaUrdzSGB8yYNi/mbc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cn65QYWcvAf+A9z2AnF8wbV2JvipO90GBBtQIGzJ7jkMarMz6lSrtFLPkkWZlNzxP
	 8wlzInThxoqhkr4NQzGfxeyMPmuy6HS1KIZ36umOzETP7Ukk6efcuLgaw+/XyPwRa3
	 dDnkFxTa+Kj5JdtGncwobVcX87wEHcjFwLv2pQK/EJpKJR3suFaceu891cz9AFhITr
	 X+KIPgmXol+hIsBE2OTrcsvmLJyzwIKpxiE8+9JVPaJbMV0e6Zm/Is/Js9KrHmM5Qm
	 /xi1GnjRVpuI4VW4jWCAibTu152/Y7XZBufWxRX6wX+lYzKjnOJC/bhDKk3WoteIu8
	 EwAukX25HWA/w==
Date: Tue, 16 Apr 2024 09:51:30 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc: akpm@linux-foundation.org, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH RESEND] HID: sony: Remove usage of the deprecated
 ida_simple_xx() API
In-Reply-To: <9b7684381f9d09a7cd5840caa2a160d7764d6403.1713088684.git.christophe.jaillet@wanadoo.fr>
Message-ID: <nycvar.YFH.7.76.2404160951040.5680@cbobk.fhfr.pm>
References: <9b7684381f9d09a7cd5840caa2a160d7764d6403.1713088684.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 14 Apr 2024, Christophe JAILLET wrote:

> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to hid.git#for-6.10/sony.

-- 
Jiri Kosina
SUSE Labs



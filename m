Return-Path: <linux-kernel+bounces-44660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73584259B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9201C25537
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F356BB53;
	Tue, 30 Jan 2024 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDhKELIF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359226A329;
	Tue, 30 Jan 2024 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619459; cv=none; b=pjWAfh+Om0JlemZ26muwgVpD2Ny0DITQM7qjnMhhkvns/jpEKBc0R1jCQtY9kkexmIPJ6RrUM2tG1A+AddJ1CwJcydWndBOKa6Jdl67Unyu4llLL/bwgETWDI3EeUCUzNJhNEmBxKOndi6Cda/QPZimqfBKc/qBhivuVZUuvAZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619459; c=relaxed/simple;
	bh=0I6bP8y3LQnOILvJKi2xaaxW9feNtDCmHiZomlMRo/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njLr56+X3l4+SHoktOdC4OwnjS1KIMX7fh2rlLd4UCpClgcE18FRb6Hg341F8P4LsQnmBmCXLaAczSnPkh9DQAan7YumPlXfPeHq/q1JD9oR6sf6bEcGcibRY32hR9Am0ns0t07IOn3hBDnUDchfNL9YER9BDHFo5c7gCOwFL3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDhKELIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA24C433F1;
	Tue, 30 Jan 2024 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706619458;
	bh=0I6bP8y3LQnOILvJKi2xaaxW9feNtDCmHiZomlMRo/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDhKELIFiY9SstQVult3F/fZGQh66KAO4a9xDBfX5580dC6kRfPBTPE7D4L/GPwg5
	 L9blUdhIPsDQ+0PNSrmkee5G02x5I/FDuYA8K4nnIte2XYMlR4Y9CffY4gPGXDCS/0
	 XhsyCKDxOxaxSK0LCN3iIK2IbR857LTRgbB9MkpMRdxiTkDlrBR0HXclQzybvUUgwT
	 +CGbrBtGJrYV4Db1j5ddN80FerCL4Me/Ptn9bwmEz4e1PQXN5SKHbP6QkiN59aRgjO
	 WRlCxLg82VkmUvxUnLo1BqyspMCO2OhFZ8pMv5VHWuxaT+/zklWwR3Uj7O572TNKLG
	 wdB7RaiZNsGsg==
Date: Tue, 30 Jan 2024 12:57:32 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Dariusz Marcinkiewicz <reksio@newterm.pl>,
	dsahern@kernel.org, weiwan@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 07/10] net: fill in MODULE_DESCRIPTION()s for ec_bhf
Message-ID: <20240130125732.GF351311@kernel.org>
References: <20240125193420.533604-1-leitao@debian.org>
 <20240125193420.533604-8-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125193420.533604-8-leitao@debian.org>

On Thu, Jan 25, 2024 at 11:34:17AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Beckhoff CX5020 EtherCAT Ethernet driver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>



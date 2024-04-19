Return-Path: <linux-kernel+bounces-151403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B2E8AAE5F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F941F21E71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945985632;
	Fri, 19 Apr 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVOnq3iH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615B7F7C7;
	Fri, 19 Apr 2024 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529559; cv=none; b=dnMu5FK34VKwCclav6CB9eag+wJX2opGAu0hZ+iU9livpA030HOtByImPpQpmndbJCbPO1qdQTsRMmEV5En4BgpWRfHNkwLNHMEAj4Z4Xf3XAWjUVTUXfSYax13TukrRtiqucPqKWT9SWPZBXmoakqxzBfPYB26s1i1U/M2pKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529559; c=relaxed/simple;
	bh=aNT6Y/Xt7MC+J2M7UeIANbRkSx6dQV+zx46InVO37JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHjz8asqofXkso95PHJSWGFjyaq8aM27jlyatRXKJwx5ijQaOlDNY4QDpiTjV/JS2G1mH5OEjvxKsdTXhP7JAjyRA8smIibtldHvCb1J71sxZVl8wcjrE7jRMkRR42pigaaQgeNkkwQzKptOr2j5+UA1bbmQ9Fixz4uSUPLmrzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVOnq3iH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C05C072AA;
	Fri, 19 Apr 2024 12:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713529558;
	bh=aNT6Y/Xt7MC+J2M7UeIANbRkSx6dQV+zx46InVO37JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVOnq3iHBHsZyHnICpIF8td3agRFAUFGhEF/b+DyrwF+BuU9Moz4FttY6DSXZc2rS
	 okYaqIeb/MmMKrZgtTAoEFDjWFA2by7oqhTVCWtfYDpBYh4Zl7X9zryV+sGNLiBQCl
	 KGg9DrcfD2yCTONwtr9Mvqv1Zp9OFEdgANS3QCDtH1Zw+pK9GpKCGhHE2ZI6S1Ggtf
	 8meMKrFLtaKhK0i2X/1PRiURZaAtTZ9r7Ew8/RZB77WHgL4PzlDt3ExTGJzEKOboSs
	 FtPQxllyRVMaez6RaoI+Li/7lgjeMx/d1FSRxMHkvUCevJfK7ujMv1bd8MSRh15x9Y
	 neugzmu1b/ZRQ==
Date: Fri, 19 Apr 2024 13:25:53 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH iwl-next] ice: flower: validate control flags
Message-ID: <20240419122553.GX3975545@kernel.org>
References: <20240416144331.15336-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416144331.15336-1-ast@fiberby.net>

On Tue, Apr 16, 2024 at 02:43:30PM +0000, Asbjørn Sloth Tønnesen wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <linux-kernel+bounces-49070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B6846580
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D6828A5F8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD498824;
	Fri,  2 Feb 2024 01:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP8eCE0K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6BE6AAB;
	Fri,  2 Feb 2024 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838173; cv=none; b=EhnUHUwcGo3ThG88gTS7q5lF3xgLevmFlwUOWG8tps1K2Q42EAbeYmscRecEEY5de6vjGVG0I1W6tvlzw9oH5eUoIJO46oJHxWPxsPHdeAkVT+WYlOi8htZ2d4I56gUMmys+0BR26IyGOu62oFIpiap1aLGc7//Nk3pZxoHslAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838173; c=relaxed/simple;
	bh=xknzaMag2fCqoNkrvN7IIBRCKRuhmXWZUa22lppRh8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPA2BSG5xNii6gaojjQXw/oa0eOm0RIrh1TVShd+rxkbSiDzsURXRrN49SBbKjUWPy49Y1XhAU1zPO6MSxmOo4lOqoueum5n7qsSVCqPInT77aayNkYOT0ZwfRfADosPo35drtv9Z81yDo/4TPJK2qvkxLaJ6y0ra0XzA1nZTT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP8eCE0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34D4C433C7;
	Fri,  2 Feb 2024 01:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706838173;
	bh=xknzaMag2fCqoNkrvN7IIBRCKRuhmXWZUa22lppRh8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fP8eCE0KOmsWSUtVp2DEVsfAkBCmpGQni85nCkRU56qov54y+lKxDuFbX7MijgbXO
	 W2esKeSse4JScex9hMR6HC0TxQkgTjN6HKkNSvVIICJ570ggv5JLEKpo9e7qnfVp8f
	 200UMHfG7rW0uvrVLKPtFMLcQTKGGkN0jDESneHKr7yB6jgKckPCgyA3H9keinVn08
	 /TOm47Zvf+WWcZzuZCKIuhXmnL9Hfzg/ghOgPyCfyN+rfHFURXDUZ+VUKgxbUORF6d
	 kOqNk6QcLY+8CJJarZbCuCh3U2Bt924gu0+9uGXCTYU7dEC8YmcDlN3EqNSw7RuVbO
	 pQD9jUebKHgNA==
Date: Thu, 1 Feb 2024 17:42:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 netdev@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/8] Intel On Demand: Add netlink interface for SPDM
 attestation
Message-ID: <20240201174249.5d55324c@kernel.org>
In-Reply-To: <ea0ae8ac-41bc-4aaa-87b6-af31002e6ce0@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
	<ea0ae8ac-41bc-4aaa-87b6-af31002e6ce0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 08:53:37 -0800 Kuppuswamy Sathyanarayanan wrote:
> On 1/31/24 5:07 PM, David E. Box wrote:
> > This patch series primarily adds support for a new netlink ABI in the
> > Intel On Demand driver for performing attestation of the hardware state.  
> 
> Try to add some info about why you need new netlink ABI?

Since netdev is copied it'd also be useful to give us a high level
intro into what pieces are involved. Assume we have heard about
SPDM/attestation in context of NIC FW but have little understanding of
x86 platform stuff. 

grep -i sdsi Documentation doesn't say much, the first Google result
for Intel On Demand reads like marketing fluff :(


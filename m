Return-Path: <linux-kernel+bounces-162381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C518B5A43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65731C208F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BE77442E;
	Mon, 29 Apr 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHLZpOkO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B70548EC;
	Mon, 29 Apr 2024 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397982; cv=none; b=m1naApDuhRCH6mUp00F4G3jLG7mgtcYITOHVWPZrYfsHSOyvzkyr17gXilxvXojhId7vahW0Bx03hYUIC+OFhYsL5RPgHYAbMq1J8mEqWLudu6vU9RGZCYOtHihCzQn6RiJr1+rmMz+Z10oMF0/21wjYv59pNGZFpL/n1Iw1mxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397982; c=relaxed/simple;
	bh=OdRWes4V1rB1HFp4jNQlIYQB1lX5Zq/dgt1PKwLXt3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiyMHUZRW9TOQTCnFC4CYtS9CDr7G3D/LukSQpmMBikij3GsAe03k4IR7vTDD92NVwsxoPlnbwUnaAQ3PJhdo35CsHS9Gq5gFHsR4zQ3IqYXkRhlP8N+4aWFXLLg35qaVqRVtIMZi9xaWPpv/CffsiaWIwFNtVT07vgAHKsUJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHLZpOkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C114C113CD;
	Mon, 29 Apr 2024 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714397980;
	bh=OdRWes4V1rB1HFp4jNQlIYQB1lX5Zq/dgt1PKwLXt3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XHLZpOkOQqKYst9bkZyzDwJRAu2VS/rmfP9U6y8GCJYOXlZtXv2+TWeCoEnUbTwlg
	 fjbJgRgUStLuLeAhQTmfyKl+qxoTRwS4pF7aSArBoj8NyUWnnsA5H4EwZaEILw4t0+
	 U+2RIGILrqhxg8+vXwV32NzS7CQetraK9q0GZpC6noq7RPecRdtCC1fEtXQyRvvMqw
	 Ci828yXHd/N5HaQvOC2ihn80liReG4X6fu2bQe3PF9Yk0D1Mg2qwtgCYjG2/33MM6H
	 1b9llP2G4QJpVFVfroEu8JduhGbSGRDf3Y+eOND0oqc9tl+V1TfMss1eURQRyQrvD6
	 CeUO8IsDaE3PQ==
Date: Mon, 29 Apr 2024 14:39:36 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: remove unused niclist structure
Message-ID: <20240429133936.GY516117@kernel.org>
References: <c40be4fd791658bf9e9099237f2b37aa8c51f396.1714310206.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40be4fd791658bf9e9099237f2b37aa8c51f396.1714310206.git.christophe.jaillet@wanadoo.fr>

On Sun, Apr 28, 2024 at 03:17:04PM +0200, Christophe JAILLET wrote:
> struct niclist was added in the initial commit f21fb3ed364b ("Add support
> of Cavium Liquidio ethernet adapters").
> 
> Apparently it was never used.
> 
> So, remove the structure definition now. This saves a few lines of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only

Reviewed-by: Simon Horman <horms@kernel.org>



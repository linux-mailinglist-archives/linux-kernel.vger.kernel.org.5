Return-Path: <linux-kernel+bounces-4558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 806ED817F46
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A851F23FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B3717CF;
	Tue, 19 Dec 2023 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D8qiBgm/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ACA15AC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Dec 2023 20:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702949363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+2lN3dxvu7LEkdLrAg6MbL3/i/2eiwYJm2xRVYEtng=;
	b=D8qiBgm/y4+/+VFA7Y6CB9YD5OTNXu73nKS+7ONO4Dn4ru4YR4iPT9ppe2QTOaThNAoBGU
	c1oSF5bkGyho/w4bex0/mNUN6OcfrJkfT/zAYNATrLlllkhjsLUFFZkRoZkGfkb//Frx1a
	oSrF4aWWGgyXMjvp2COreukKF6SfIgA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: Use array_size() in call to
 copy_from_user()
Message-ID: <20231219012919.cpxuybc5mfozlpvp@moria.home.lan>
References: <ZYDjMgyrFYhOsazc@work>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYDjMgyrFYhOsazc@work>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 18, 2023 at 06:26:26PM -0600, Gustavo A. R. Silva wrote:
> Use array_size() helper, instead of the open-coded version in
> call to copy_from_user().
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied


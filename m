Return-Path: <linux-kernel+bounces-130090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804388973FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E0F1F23ADD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96F314A625;
	Wed,  3 Apr 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUiqq/DG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCC149E0D;
	Wed,  3 Apr 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158098; cv=none; b=FmiDINVTWDSydq+eM+4egKea+vR/WCNr6PaapJn4xkgPPEYdfpIQwkLdkCKDTLFZlTfS1fqIOAmipbcObZHiiiZWu/MZTrA/+LifR9l+v4iMAiqW09vQd8rRJKHZV9JEZcYQZb8IfvdAJczSsjK5i7B1vjhUreuiip8ZMx+e3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158098; c=relaxed/simple;
	bh=9ERRkxXQP69jitxNYS1cXjQmH07XlkMPiy+u7m2Nu1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfIYXtNU0tf5AMuF7op4wiC0RIVDYrHw5scu6TrYiW/VmWWd12DwA6ICIwX5mIRLlPfuGtrgnenu59zbesHBF/imJmvomV6HaV+AgHv5NR772i2gBqomExfjgvS2YQ5kRotQKFwOVA7bZePUR/vh8V9LO7xeEDWYWNymHdKqdy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUiqq/DG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81366C433F1;
	Wed,  3 Apr 2024 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712158097;
	bh=9ERRkxXQP69jitxNYS1cXjQmH07XlkMPiy+u7m2Nu1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WUiqq/DGggi9rqgz/ExMcvf72xnXgqEk44rp8m6EJtBWZLULstZ4/atnbEsyJxcjm
	 S1ldXle8P6hS/KfEKgYQqvE+g0JP1mTwB5W/2s3zamyB/zp0AFTSunPU0V4yHR9rfS
	 8Q0cFbJ8Y9D8Nf5g7S+WlFeqSoyOxWRQSb1bimvZbaduaTng+BkMGmiHT+O5vHc16C
	 QIXzZth00hI6HrXW7AyNJtU+ghl1roPVQy6wnNtnHqRUG7SeDXynejKwoupeQcM3Dt
	 1NkqE43x1efmEFRUsmpd0hdTqdyajjMTH6+J2zfDmTAkNjKScHXEIRJ97Qd0ijnRQ2
	 WjHXSOaW8Y8iA==
Date: Wed, 3 Apr 2024 16:28:13 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: fman: Remove some unused fields in some
 structure
Message-ID: <20240403152813.GM26556@kernel.org>
References: <425222d4f6c584e8316ccb7b2ef415a85c96e455.1712084103.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425222d4f6c584e8316ccb7b2ef415a85c96e455.1712084103.git.christophe.jaillet@wanadoo.fr>

On Tue, Apr 02, 2024 at 08:55:50PM +0200, Christophe JAILLET wrote:
> In "struct muram_info", the 'size' field is unused.
> In "struct memac_cfg", the 'fixed_link' field is unused.
> 
> Remove them.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>



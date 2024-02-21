Return-Path: <linux-kernel+bounces-75244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6457F85E525
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C96E284745
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467E684FDF;
	Wed, 21 Feb 2024 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkZlqsNb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA7384A40
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538657; cv=none; b=rlqQbaTROzy16l95VC/zL8DdvVmarjYtW+Ej9nxJvg9KdijvQj+wIRNZqHyuhZEVNrBwPLIQnY9UQpZ6F2WZJyV5NBF5WdHV8UdL5aJZqIC52nVicDOA6I4e2E77Pr5mM3sTySXgNGwEy8LcswSUhNFyZJLNnyY2Ep9Q+0Ehpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538657; c=relaxed/simple;
	bh=CZQzgLXnK0wfVh9AjBPaaAYevg83M6W8YPFqFEIq3Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxcXS2n87qC8FUSxOzRldE+9JLdJmLgb2RkqroyyTJG661VUE0hCN7JKl2on6vCc8cY7rvHsUjjWUV9wig4RlQ0Hzw5aC481sRDkqoQBf9gXKVVDCWUhzzDQc+sXiX143u8X9eVU5Jn+8rLnwUdQBqgYR15GQXnHGyeVbtHmtFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkZlqsNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBC0C433F1;
	Wed, 21 Feb 2024 18:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708538657;
	bh=CZQzgLXnK0wfVh9AjBPaaAYevg83M6W8YPFqFEIq3Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HkZlqsNba/I8LjXS72j+mE53PIhJqcBnBnNysOlWO4TQc11r3BekpgSQjEinuCuFO
	 xtgFu/YKINPsAdHUGhmyS1EbdxarffVXg6N6MiuD6K3nrXKWapbSf+UQE0bLZwO21+
	 0VoZ6ic0UfcfX0KwYXcy24cm1hTMooIqRSnH5EpHLMl4inWycugFO/bZL4w4FGtLY1
	 AUg7ueCGOFIaLVCoLI5FpqzWdATYupWBVlBypqOekY62AdTqVdQloEtPbzoS7yhnxP
	 poCvEI7GIJD9ruNHmq6j2TRBn+Y1dn1I6cl+AtjmzPFSojG/hu5A5rZ/eV6ml6tacR
	 h/Ae47EqUdHlg==
Date: Wed, 21 Feb 2024 11:04:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] nvme-fc: fix blktests nvme/041
Message-ID: <ZdY7HavMstT3KbHe@kbusch-mbp>
References: <20240221132404.6311-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221132404.6311-1-dwagner@suse.de>

On Wed, Feb 21, 2024 at 02:23:59PM +0100, Daniel Wagner wrote:
> As suggested by Keith I've merged the new flag for nvme-fabrics with the last
> patch. I also added some information why nvme-fc is handling the initial connect
> attempt differently as requested by Christoph.
> 
> The new flag is called connect_async and the default is false/0. I've tested
> with a patched nvme-cli/libnvme version and all looks good. When this series is
> accepted I'll update nvme-cli/libnvme accordingly. Note, that even with an older
> nvme-cli the blktests (especially nvme/041) will pass with a newer kernel.
> 
> (nvme/048 is still fails but this is a different problem. On my TODO list)

Series looks good to me. Sounds like it's not fixing any regressions, so
I think this goes to the 6.9 branch. I'll wait till end of week for any
other feedback before pushing anything out.


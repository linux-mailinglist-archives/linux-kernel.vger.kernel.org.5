Return-Path: <linux-kernel+bounces-155222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A158AE6FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0306E28699E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C305136672;
	Tue, 23 Apr 2024 12:50:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE4B12A14D;
	Tue, 23 Apr 2024 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876617; cv=none; b=qBNunZp5gs9PqM0CUSsnYdYb8LJHEXXfAv00d1NcrioXH/fJHi1i6rgLhEJKU6jkcEPWVEaL3BWjhT3WyQ/5HHSSbtJ/7HttRTeqZ2Hcl5SvBrV8XOGgLoLbj8I006+ghjabEw1jBxJf3Bly1jBadJWmzxQ0PMzgBNFBLNiJSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876617; c=relaxed/simple;
	bh=DN8u1fezfiV+bCBhk0BjAUKzEYybbF/hhjMf9bWbb7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEBGgEjLYjQobBvoPcSAp1xT7aqAp1dUGlEJQHtsUziRrqnJfb0QVdbj3mfnv8MLwZoEpxDV/C5DDfHRp8Xj109ZkKCKtq4U8daUwR7YTn9M1Pj5P0ACvVgxaAutx/HLIAIdZS0A0wnNOK3Y+XzTfm+UKUaDDEPjcwi4kMnSORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE68B339;
	Tue, 23 Apr 2024 05:50:43 -0700 (PDT)
Received: from bogus (unknown [10.57.84.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EBC73F64C;
	Tue, 23 Apr 2024 05:50:14 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:50:11 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mike Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the clk tree
Message-ID: <20240423125011.tjyvkzns7fqpdsl2@bogus>
References: <20240423103934.399e2a6e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423103934.399e2a6e@canb.auug.org.au>

On Tue, Apr 23, 2024 at 10:39:34AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the scmi tree as different commits
> (but the same patches):
> 
>   87af9481af53 ("clk: scmi: Add support for get/set duty_cycle operations")
>   fa23e091236b ("clk: scmi: Add support for re-parenting restricted clocks")
>   c3ad1d0a7ef2 ("clk: scmi: Add support for rate change restricted clocks")
>   a1b8faf8784c ("clk: scmi: Add support for state control restricted clocks")
>   2641ee13c449 ("clk: scmi: Allocate CLK operations dynamically")
> 
> These are commits
> 
>   ca82ded0e3dc ("clk: scmi: Add support for get/set duty_cycle operations")
>   3a0501ad6fd4 ("clk: scmi: Add support for re-parenting restricted clocks")
>   4562172e3ec2 ("clk: scmi: Add support for rate change restricted clocks")
>   6785c6c261bd ("clk: scmi: Add support for state control restricted clocks")
>   4196d89b2393 ("clk: scmi: Allocate CLK operations dynamically")
> 
> in the scmi tree.

I will drop them from the scmi tree.


-- 
Regards,
Sudeep


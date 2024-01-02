Return-Path: <linux-kernel+bounces-14484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC60821DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710BA1C22280
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69311708;
	Tue,  2 Jan 2024 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDTVqxY6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED21171B;
	Tue,  2 Jan 2024 14:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C300C433C8;
	Tue,  2 Jan 2024 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704205881;
	bh=ppOaBt0nrxUHlSNRMZ7HMYb/m9Qv65WWZBMvgTCv6tQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lDTVqxY6zGzv+IqoKKpclzUd+3gWQOsOYzlAzHi+KI4Io36sxjLr86wBrdgrnXqCd
	 zg5vVLxaV/jxQeIosWR0/+59bC5VInOilfMV3ZMQVVVGNdoWkGcJZ9XB4Ma3gVbzrf
	 gY9LbcmnBebmZN607dDBMeAmOhSocGzhldwfu0HH90d6kDVbYvWntaWKuUcuYe/Udx
	 6bptlGJWk8DTYoFUpcUfICh7a7WVyyXYBpbbTqof1YKPIKiAIuSjuzRUK/S6XaDBK9
	 1BcQXttBg9Kl+6jZTPjC11Yc/9lFdBoBI1iIs+VA16KfzA+N+hG1eM1CoNgVUsJMyV
	 s7SEv2BNsl71A==
Date: Tue, 2 Jan 2024 06:31:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 1/5] ptp: clockmatrix: support 32-bit
 address space
Message-ID: <20240102063120.63f9d3c4@kernel.org>
In-Reply-To: <PH7PR03MB706457106BF922439573DF38A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>
References: <PH7PR03MB706457106BF922439573DF38A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 10:24:11 -0500 Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> We used to assume 0x2010xxxx address. Now that
> we need to access 0x2011xxxx address, we need
> to support read/write the whole 32-bit address space.

Not entirely clear to me why but this submission was marked
as Changes Requested in patchwork. Please repost.


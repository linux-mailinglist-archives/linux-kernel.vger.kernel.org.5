Return-Path: <linux-kernel+bounces-17342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C83E824BF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8696E1C22682
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2332D61A;
	Thu,  4 Jan 2024 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6Mo89nu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DBB2D609;
	Thu,  4 Jan 2024 23:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6799DC433C7;
	Thu,  4 Jan 2024 23:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704412441;
	bh=yDSEIi5SyeEeFsYYJWGXLsnS3bH9i6QgcWBFNWDqxFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r6Mo89nutYc2Jo0CntUhi1/QPly8Ygzz8Hpn3qvpZYt/eDJR2sbWjD3/ZIM5mYQz9
	 0uS9vVzpSut/TQxmmqRY+8TTPXraFoZJZ1kYgKG+R65GdNz8mIV0grimAKb9sTC9m5
	 ZAeO3HDjRb7oEHLajCUD9kZFLfS6/T67lTE/DoPdKprKVMJLmMHMyoBV3buavfwZFi
	 Q7qk+mQGIMh4chYl9tBHJTyf6oyDRJrmIELdOV8d5yg7pGNPtgV5xCC0t/XknDhQwN
	 HYtS4DjEeI/hpOBjpHbknQmxEB+rCm63hlBI0y7m7w8Oq4w3BOOoq8eAqtX2JHaFsa
	 d2L3efbaX5x6Q==
Date: Thu, 4 Jan 2024 15:54:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v6 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Message-ID: <20240104155400.19368743@kernel.org>
In-Reply-To: <PH7PR03MB706440BA6291AA1346D599E9A0672@PH7PR03MB7064.namprd03.prod.outlook.com>
References: <20240104171212.16906-1-lnimi@hotmail.com>
	<PH7PR03MB706440BA6291AA1346D599E9A0672@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jan 2024 12:12:12 -0500 Min Li wrote:
> +#define SYNC_COUNTER_MASK		GENMASK(51, 0)

the masks > 32b need to be defined with GENMASK_ULL
Otherwise 32b build will breka
-- 
pw-bot: cr


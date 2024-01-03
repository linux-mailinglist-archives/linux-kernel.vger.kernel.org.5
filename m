Return-Path: <linux-kernel+bounces-16043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F82823766
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4911C2427D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B834B1DA3E;
	Wed,  3 Jan 2024 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL8mZ3z7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114521DA2F;
	Wed,  3 Jan 2024 22:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374C9C433C8;
	Wed,  3 Jan 2024 22:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704319244;
	bh=k5CUGvrfHkGy1Lx9icYwgm7BQoMqdETOkUMcv5h2qeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OL8mZ3z7zmPQUkuQWkDdkgBgCtn3j3s5osigBPmqq3EBCVCI2OgKnH/8NASp7sHH/
	 fWiV6v31CTvyYw7vy5r21GVTHZzLJuYZhoU/nuZpniJ6tnYex/bmSbacXmJj5giYij
	 Kstx2P3fwjD/HxdlTn3292Pum2OfJmFQYcPtcRP6b21nHyO1WRjDbQ93544OGWqhOk
	 B3N9vsqCXuN1kf/UBFpeSDlZvmMwH/WEl+Buu+1zT2+7ptLVZd7wdeQv+PTvxrxXVv
	 EqPUqsSSU4MtV3S9TttCbch25lUBQjW/8qKKlyMQtBSEc8NihTtLZEFB/QxZF/Z9mI
	 88d8Y2PL2rQFA==
Date: Wed, 3 Jan 2024 14:00:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Malkoot Khan <engr.mkhan1990@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp: fixed whitespace trailing error
Message-ID: <20240103140043.1b402839@kernel.org>
In-Reply-To: <20231228164250.106433-1-engr.mkhan1990@gmail.com>
References: <20231228164250.106433-1-engr.mkhan1990@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 16:42:50 +0000 Malkoot Khan wrote:
> -		rtx_delta = tcp_time_stamp_ts(tp) - (tp->retrans_stamp ?: 
> +		rtx_delta = tcp_time_stamp_ts(tp) - (tp->retrans_stamp ? :

Don't insert the space between the ? and :, tho, please.
-- 
pw-bot: cr


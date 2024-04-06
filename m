Return-Path: <linux-kernel+bounces-133806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CEA89A8F7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A456282B5C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF531DA21;
	Sat,  6 Apr 2024 05:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmTecpYr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E181FA1;
	Sat,  6 Apr 2024 05:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712380535; cv=none; b=pdY8AXawrjKbhZAVHHheuFZeOxHhuDOXuXQD6NWMJ1Uo6iv9U+vj5MSsi2UGCKRlnCDvNgTcp6fCIJdFr7i9v9zZJkZ61KooFhqj3FSLyGubSBTBciynoZWGYrF01dqcJwsY5JVfDW5dsxND0Jv52Xk16QCPPW8Wp1KGZK6sqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712380535; c=relaxed/simple;
	bh=oZDIG0cheoYdBflbk/QHSFcJ9PNvJLk8GoHxlQ8BcNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnc/cfCuiqMRCe2DvDBet6Omf+ZpAE9g7WoEeiuQ29nuzh56+jbB0oIt3kjs2sqxJUpC0yyj6fEty0lLLij/dWSBkoUcSH0m/7o/L61uxUe+ueePwGXchsClohovqdlXm3aN/u7/4ZfccvITUtfOZEZx3zQsXVmbryAlsCdSrdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmTecpYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4592FC433C7;
	Sat,  6 Apr 2024 05:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712380534;
	bh=oZDIG0cheoYdBflbk/QHSFcJ9PNvJLk8GoHxlQ8BcNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HmTecpYrlhsgruh3BBOnWqrFRMvHAMKFTJR3Yg3W8joSchbsKvfedqpblZV7nV6uy
	 7uTVkppXyw8Tg+6tO3RXzBnTqX2DQGXLQ5H0DYGt9i95gm5lOqw6Aq0gOqUqhxZKpJ
	 i1QiGZa4uVO/SynKZOmjcKht3XWf0f/egXf3rB7LeMHkVt1vjWhkv6RhC2hkGsnsfe
	 VoA0lZ+4V4wwq1Q0QCtunYo13yB1gNUdPD8U9O7VnKXfr7t/w+b1xOUV1oYXn4d32p
	 9MQTpCCPWo9m6XEZWs0NLk8j6lQb8ci2pj7zJO0UF3+kWkqICw5HmaOtTMkTfLTquO
	 /kxBfTaWyDxHw==
Date: Fri, 5 Apr 2024 22:15:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net 1/1] ptp: 82p33: move register definitions out of
 ptp folder
Message-ID: <20240405221533.56b5774d@kernel.org>
In-Reply-To: <LV3P220MB12022BEFC410BCBCD52DD891A03D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
References: <LV3P220MB12022BEFC410BCBCD52DD891A03D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 16:05:16 -0400 Min Li wrote:
> Subject: [PATCH net 1/1] ptp: 82p33: move register definitions out of ptp folder

nit: if it's not a bug fix the tag should be [PATCH net-next]

> Relocate register definitions so that other multi-functional
> devices can access.

Please point out the driver which you have in mind.
Is it already in the upstream tree?
-- 
pw-bot: cr


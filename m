Return-Path: <linux-kernel+bounces-99374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8008587877A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5C4B22569
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5AE56B63;
	Mon, 11 Mar 2024 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yTvUHCex"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81A56759;
	Mon, 11 Mar 2024 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182180; cv=none; b=gBZKQ0m1baVXJEbB0z31LlBBnkEotZkVxyBI1pnTqj+r8+I+bizKDK3Cevv/Hrgtr04szsA9nxi9LExB7FDasioQNSb9i7Svekj0mIts9TAJgKdQ2Ai1OzkDePEPqO5sVcowi1+L7R3BHLKmDgABcmzOWr62xkrV1jB+wGGDPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182180; c=relaxed/simple;
	bh=GGP9dkOMn7NjqKnSGVDYA7uXq5GZEvq5XwnmvgikHwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOW3aJPdlZvIOmi9d/UA8Z8pzwQcOulT2hKJp4cSXOW1bCFLqXI42Fg6OqoCOEZeSnSqfhMEUn0RgvGmd0eorWaRq7j3tjZ0f8AoJJcfJ/LhBxqVyYrSQ88dRPc3inegI9CGfQ8dwP7X+gXmXvOeUawcrUXUvHTnl+PvlvAKtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yTvUHCex; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Ttlpp26jVzlgVnY;
	Mon, 11 Mar 2024 18:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1710182176; x=1712774177; bh=GGP9dkOMn7NjqKnSGVDYA7uX
	q5GZEvq5XwnmvgikHwE=; b=yTvUHCex4ZvpdYjwJJ3bW8Dv5DMfs+s/RKBMynBJ
	ymiedxpMzbBHYePXn0CGbe88sEUTqEqNj3MxVigAI8VbjrH/JXbfOoIlvAtuGiQ3
	Fv10NMbIRCdAsqmvHwhMod0rK1vJ9sFtMCIBQahFTSFiFSW8bFevrhQi0opRk91Q
	BcV7UTmEGP4yU+Hadc2XfPxkZqZrtYxSZbdIhFfzj7KiG562NpgIZ8X+Orrr1PxT
	uEZNzsXI+wMKDCO4UQmOorT2SqM9HLUVZ+8Vborc1HJAWlSInCwOrVZpGT29MX0a
	LMp6mILCsSbAWnKzubviHcDpUN8b6c4MblnwJElnq3y9YQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6-a2RneE38P9; Mon, 11 Mar 2024 18:36:16 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Ttlpl6q2kzlgVnW;
	Mon, 11 Mar 2024 18:36:15 +0000 (UTC)
Message-ID: <df836fa9-f6fc-4163-8abd-5dbadc1a99f4@acm.org>
Date: Mon, 11 Mar 2024 11:36:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] scsi: ufs: Re-use compose_devman_upiu
Content-Language: en-US
To: Avri Altman <avri.altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bean Huo <beanhuo@micron.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240309081104.5006-1-avri.altman@wdc.com>
 <20240309081104.5006-5-avri.altman@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240309081104.5006-5-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/24 00:11, Avri Altman wrote:
> Move some code fragments into ufshcd_prepare_req_desc_hdr so it can
> be used throughout.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>



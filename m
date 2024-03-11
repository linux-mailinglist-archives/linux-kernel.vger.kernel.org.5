Return-Path: <linux-kernel+bounces-99373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC5F878777
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8B3B224B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1356C55E75;
	Mon, 11 Mar 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KDm0NJ3M"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913654FB7;
	Mon, 11 Mar 2024 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182151; cv=none; b=Q2O7pK+cLwiiTDolpSSPLxMs1Dcdi+rrD6EiBxkMn+/EENTc0HBjjJNLNHrh8LukFM46M6zyJgfO58RxSShFiubnxmxsURxXxFclk6rYw215CKNX6mEas1ocwuGsDoNZ3wevM58BWfe+Cf0gGeW6+5VOTFRytRFlApUyZ9ffFhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182151; c=relaxed/simple;
	bh=1qqTjwiqgN85QvoiAJaeXNcYRAKfZNdrXjznxqp5uzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNs1my3/1UPM9dZegF/nKiL0xYef1zpokhSv4Osxsowx7S10EYqg3mhdqY6zyIZWCmlK3LNekdYGBMXQC/0JRUaoOMeZQz71LjfNY4G8nLiujrzOqh+UgtcEHVH7SI41+rEOD8tz5RjGDmk8usA33s5bgFjDAa1O8TwCqT7rHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KDm0NJ3M; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4TtlpF2QrLzlgVnY;
	Mon, 11 Mar 2024 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1710182147; x=1712774148; bh=Jei4j646X+qAfUBer/BW9QqC
	wZVGvbPajQsPIyjkMCg=; b=KDm0NJ3MH7y4Eu4RVntOJLioFNM+2UQI28pqbztV
	zT2lNOLbQjyr12SLe1aiIFHe/D+ih3IBIIcnEKL9UT2Kjo94tboz+XyzHyRFrIcG
	l8NQcE+q4s8nBU2ZJPWeDU0+W331sDDxN3hMr0ZxV47bWR5Wiy1lOsa+aF3CLfn7
	iweVQpK1v41BLCWbQ9KDJuKaEzE405jNecUjl19EpqgB+CHA1CqGomUWmElY15pe
	JZE07RcR840GGUvcYrM3+UoyJfQSTmQoOTFSlXZCVvee7uH2sKGnyp79Iw3ppRNs
	4IGOt8ZdpZgTrJDp8LVDxuX6Vqk6FV9Lt1Kb6EnNYj/Ufw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8AVUPSADpCp8; Mon, 11 Mar 2024 18:35:47 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4TtlpB6fD6zlgVnW;
	Mon, 11 Mar 2024 18:35:46 +0000 (UTC)
Message-ID: <0aca7640-e6e1-4ab6-93a1-d4fea1683c6f@acm.org>
Date: Mon, 11 Mar 2024 11:35:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] scsi: ufs: Re-use exec_dev_cmd
Content-Language: en-US
To: Avri Altman <avri.altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bean Huo <beanhuo@micron.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240309081104.5006-1-avri.altman@wdc.com>
 <20240309081104.5006-3-avri.altman@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240309081104.5006-3-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/24 00:11, Avri Altman wrote:
> Move out the actual command issue from exec_dev_cmd so it can be used
> elsewhere.  While at it, remove a redundant "lrbp->cmd = NULL"
> assignment.
> 
> Also, the device management commands that are originated from the
> ufs-bsg code path, are being traced now, which wasn't the case before.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>



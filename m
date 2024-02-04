Return-Path: <linux-kernel+bounces-51715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5AD848E8B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCC4282DB1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C6422EFB;
	Sun,  4 Feb 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ApSE4Iec"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308E225A9
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057596; cv=none; b=hTacTNqA0rVn3rAa65KZG3orql1Tow2n1SezV/10xpOyzUF7gOe1WcR82c61F2vo0QHej5b9ZuLs6z6pxcQjGVDzOePqRksYnCUovvWx5WKPsdOJqlPiVs/ghPlzOeuZSMEOZUXwMDZ3odilFL/02uBMejHMqVBG2/b/40mXU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057596; c=relaxed/simple;
	bh=BL/x9orUY4Qx6/R/opi/OiQWicq/Bdzd8RXJYTHUSLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zw60G8Nkw3LM6O+XaxJQBwwtEo5r9DafQVWL15/Friom0MD7onYipHVhgM7xCI1BUGf6/fw6rpfNSLN7S+NCCN/kJzmzbx+R3tODqgCLogFCdvzAVt5Ll1dSRCBuQjTHZC3DVzw9byAeneV+YJ7F0qvSUi9zxxi+KARQ8DLxcKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ApSE4Iec; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6b88bdc3-37da-423f-a665-308ac519a256@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707057591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y80CdJjL2kWlKWe2vMEsTFd6tb84k4wJ4sCbchotmMI=;
	b=ApSE4IecJ9joafKTB6l39BAFgHUNTXfhO+zwHvK0cYzw3KXqKm+QQ7mo6MuLlPqVWstEEm
	WWFxpRtF6mHexGCbpGKdOdF8uq421EBc0jz5dsGlQHnAlmVxU07jESxrbRVqFg3zpvl7bu
	RLyqjfTA+IF1u1PGlIBJlsI5SvYT/MQ=
Date: Sun, 4 Feb 2024 14:39:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] ptp: ocp: add Adva timecard support
Content-Language: en-US
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com, vadfed@fb.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
References: <20240117114350.3105-1-maimon.sagi@gmail.com>
 <8a6c5297-6e86-4f0d-a85e-1a93b2215d68@linux.dev>
 <CAMuE1bFEbrY2PiDB6OdZGzDNijPAhoGBircTpqiyVs0Qq6bOig@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAMuE1bFEbrY2PiDB6OdZGzDNijPAhoGBircTpqiyVs0Qq6bOig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 04/02/2024 11:31, Sagi Maimon wrote:
> Hi Vadim,
> Sorry but I was on vacation for the last two weeks.
> So What should I do now:
> 1) Do you want me to set my changes into the main linux git tree:
>      git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>      and use  use '[PATCH v6] ...' prefix
> 2) Or
>      set my changes into the net-next git tree:
>      git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
>      and use  use '[PATCH net-next v6] ...' prefix

Hi Sagi!

Option 2 is the way to go.

Thanks,
Vadim

> 
> BR,
> Sagi
> 
> On Wed, Jan 17, 2024 at 11:23 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 17/01/2024 11:43, Sagi Maimon wrote:
>>> Adding support for the Adva timecard.
>>> The card uses different drivers to provide access to the
>>> firmware SPI flash (Altera based).
>>> Other parts of the code are the same and could be reused.
>>>
>>
>> Hi Sagi,
>>
>> Thanks for adjusting the code. One signle still have to be
>> adjusted, see comments below. And this is treated as net-next
>> material, but net-next is closed now until merge window ends,
>> you will have to submit new version next week.
>>
>> Please, also use '[PATCH net-next v6] ...' prefix for it.
>>
>>> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
>>> ---
>>>    Changes since version 4:
>>>    - alignment fix.
>>>
>>
>> Please, preserve changes from all previous versions for next submissions.
>>
>>>    drivers/ptp/ptp_ocp.c | 302 ++++++++++++++++++++++++++++++++++++++++--
>>>    1 file changed, 293 insertions(+), 9 deletions(-)
>>>
>>
>> [ ..skip.. ]
>>
>>> @@ -2603,7 +2819,44 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>>>        if (err)
>>>                return err;
>>>
>>> -     return ptp_ocp_init_clock(bp);
>>> +     return ptp_ocp_init_clock(bp, r->extra);
>>> +}
>>> +
>>> +/* ADVA specific board initializers; last "resource" registered. */
>>> +static int
>>> +ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>>> +{
>>> +     int err;
>>> +     u32 version;
>>> +
>>> +     bp->flash_start = 0xA00000;
>>> +     bp->eeprom_map = fb_eeprom_map;
>>> +     bp->sma_op = &ocp_adva_sma_op;
>>> +
>>> +     version = ioread32(&bp->image->version);
>>> +     /* if lower 16 bits are empty, this is the fw loader. */
>>> +     if ((version & 0xffff) == 0) {
>>> +             version = version >> 16;
>>> +             bp->fw_loader = true;
>>> +     }
>>> +     bp->fw_tag = 1;
>>
>> Please, use fw_tag = 3 here, other tags are for other vendors.
>>
>> Thanks,
>> Vadim
>>
>>> +     bp->fw_version = version & 0xffff;
>>> +     bp->fw_cap = OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
>>> +
>>> +     ptp_ocp_tod_init(bp);
>>> +     ptp_ocp_nmea_out_init(bp);
>>> +     ptp_ocp_signal_init(bp);
>>> +
>>



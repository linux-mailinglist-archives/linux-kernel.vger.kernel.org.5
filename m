Return-Path: <linux-kernel+bounces-106285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263CE87EBF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDB328404A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9A250A78;
	Mon, 18 Mar 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G44S9rz7"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A13E4F896
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775137; cv=none; b=p+cZPCcWuGl4gtDel2hr0K5Jz2oTAZyBJfR4CRX4ZoGNilvarvG5lDN5V+bdKbG4QKw7C7i63i6rGidYIsDnxUYlcXqKiHGHemp7Pg1cR78xoKPMTEl6v+svu0hDuzZ4HN7cgALzc/T/TUk3OT7iBdaYjlkNxCCoXwJ+Tay/C+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775137; c=relaxed/simple;
	bh=AJTNSGdqCb/MYs6kLDwo1nXBehIzhW5FGxiURNhZaxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekv6BcJ+HTD9QtBnLH46Wvgp7rGsuucOVcTOniXzHkcrB3C4iqTSmbHMpKlsfiGrKfn0W8kWkjBG1TyatGWoNc6qsUwuXmObBiRh4okS8AV3hfc2GUYIrPRe5s/HjRYY+fe8m/sbdhqPpIyfNjrhYlX9xRBj63r/75i8ca9GSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G44S9rz7; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7ee83f15-88fc-4530-84b7-b8ee31663dbc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710775132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/LBCZpXEzTm4MM2i9sGH7zXGwfRc046vG/VKiVhS10=;
	b=G44S9rz7aGFTfjXfLqORGfSZ5m5pRsZx1B9adACcubKdxn+wRbMgI57vlp065MuU8Z1lb1
	hha7vNWNhJKJG5fSjG7uqRxAhu/dLzv8mASrjSRMgDcsXIH2JJv5W1pLsu1QzxDewzvhX8
	R6aOmPygzVJrwqpkH5+y7MJGjucL0Q4=
Date: Mon, 18 Mar 2024 11:18:43 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
 scan_mask
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: "O'Griofa, Conall" <conall.ogriofa@amd.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
References: <20240311162800.11074-1-sean.anderson@linux.dev>
 <20240314154824.37150a54@jic23-huawei>
 <a9ed95ec-aafe-49f6-93dd-c94c73620de2@linux.dev>
 <DM6PR12MB4217EAA1049F815F234EE6D18B282@DM6PR12MB4217.namprd12.prod.outlook.com>
 <3b481539-0c9c-4110-ad03-bd252e80efb0@linux.dev>
 <20240316133627.5d2bf585@jic23-huawei>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240316133627.5d2bf585@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/16/24 09:36, Jonathan Cameron wrote:
> On Fri, 15 Mar 2024 13:47:40 -0400
> Sean Anderson <sean.anderson@linux.dev> wrote:
> 
>> Hi Conall,
>> 
>> On 3/15/24 09:18, O'Griofa, Conall wrote:
>> > [AMD Official Use Only - General]
>> > 
>> > Hi,
>> > 
>> > I think there was a fix for this issue applied to the version that was running on 5.15 that didn't seem to make it into the upstream driver.
>> > Please see link for reference https://github.com/Xilinx/linux-xlnx/commit/608426961f16ab149b1b699f1c35f7ad244c0720
>> > 
>> > I think a similar fix to the above patch is may be beneficial?  
>> 
>> These patches look functionally identical to me.
> 
> Because there are no channels with scan index between
> 22 * 2 + 16 (that patch) and 22 * 3 (your patch) that is
> the effect is indeed the same. But given the issues is the
> 64 limit on maximum scan index, 22 * 3 = 66 is an ugly value
> to compare with.
> 
> I'm still very against the use of scan_index for anything other
> than scan indices (which is why partly how this bug wasn't noticed
> in the first palce). So the check should be scan_index != -1
> and uses of those values elsewhere in the driver should be fixed
> (which looks simple to do from a quick glance at the code).

OK, so how do the sysfs files get named then?

--Sean

>> 
>> --Sean
>> 
>> >> -----Original Message-----
>> >> From: Sean Anderson <sean.anderson@linux.dev>
>> >> Sent: Thursday, March 14, 2024 5:30 PM
>> >> To: Jonathan Cameron <jic23@kernel.org>
>> >> Cc: linux-iio@vger.kernel.org; O'Griofa, Conall <conall.ogriofa@amd.com>;
>> >> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Lars-Peter
>> >> Clausen <lars@metafoo.de>
>> >> Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
>> >> scan_mask
>> >>
>> >> Caution: This message originated from an External Source. Use proper caution
>> >> when opening attachments, clicking links, or responding.
>> >>
>> >>
>> >> On 3/14/24 11:48, Jonathan Cameron wrote:  
>> >> > On Mon, 11 Mar 2024 12:28:00 -0400
>> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
>> >> >  
>> >> >> ams_enable_channel_sequence constructs a "scan_mask" for all the PS
>> >> >> and PL channels. This works out fine, since scan_index for these
>> >> >> channels is less than 64. However, it also includes the
>> >> >> ams_ctrl_channels, where scan_index is greater than 64, triggering
>> >> >> undefined behavior. Since we don't need these channels anyway, just  
>> >> exclude them.  
>> >> >>
>> >> >> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
>> >> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>  
>> >> >
>> >> > Hi Sean,
>> >> >
>> >> > I'd ideally like to understand why we have channels with such large
>> >> > scan indexes.  Those values should only be used for buffered capture.
>> >> > It feels like they are being abused here.  Can we set them to -1
>> >> > instead and check based on that?
>> >> > For a channel, a scan index of -1 means it can't be captured via the
>> >> > buffered interfaces but only accessed via sysfs reads.
>> >> > I think that's what we have here?  
>> >>
>> >> From what I can tell, none of the channels support buffered reads. And we can't
>> >> naïvely convert the scan_index to -1, since that causes sysfs naming conflicts
>> >> (not to mention the compatibility break).
>> >>  
>> >> >
>> >> > I just feel like if we leave these as things stand, we will get bitten
>> >> > by similar bugs in the future.  At least with -1 it should be obvious why!  
>> >>
>> >> There are just as likely to be bugs confusing the PL/PS subdevices...
>> >>
>> >> FWIW I had no trouble identifying the channels involved with this bug.
>> >>
>> >> --Sean
>> >>  
>> >> > Jonathan
>> >> >
>> >> >  
>> >> >> ---
>> >> >>
>> >> >>  drivers/iio/adc/xilinx-ams.c | 8 ++++++--
>> >> >>  1 file changed, 6 insertions(+), 2 deletions(-)
>> >> >>
>> >> >> diff --git a/drivers/iio/adc/xilinx-ams.c
>> >> >> b/drivers/iio/adc/xilinx-ams.c index a55396c1f8b2..4de7ce598e4d
>> >> >> 100644
>> >> >> --- a/drivers/iio/adc/xilinx-ams.c
>> >> >> +++ b/drivers/iio/adc/xilinx-ams.c
>> >> >> @@ -414,8 +414,12 @@ static void ams_enable_channel_sequence(struct
>> >> >> iio_dev *indio_dev)
>> >> >>
>> >> >>      /* Run calibration of PS & PL as part of the sequence */
>> >> >>      scan_mask = BIT(0) | BIT(AMS_PS_SEQ_MAX);
>> >> >> -    for (i = 0; i < indio_dev->num_channels; i++)
>> >> >> -            scan_mask |= BIT_ULL(indio_dev->channels[i].scan_index);
>> >> >> +    for (i = 0; i < indio_dev->num_channels; i++) {
>> >> >> +            const struct iio_chan_spec *chan =
>> >> >> + &indio_dev->channels[i];
>> >> >> +
>> >> >> +            if (chan->scan_index < AMS_CTRL_SEQ_BASE)
>> >> >> +                    scan_mask |= BIT_ULL(chan->scan_index);
>> >> >> +    }
>> >> >>
>> >> >>      if (ams->ps_base) {
>> >> >>              /* put sysmon in a soft reset to change the sequence */  
>> >> >  
>> 
> 



Return-Path: <linux-kernel+bounces-51561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED23848C84
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85BE282C15
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6F718C36;
	Sun,  4 Feb 2024 09:39:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7118AF4;
	Sun,  4 Feb 2024 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707039598; cv=none; b=Zsg7jVCESv7128wpSoKkNSUj2B3ms0LzSk1bXks3xF/CnJ2U0eZY4kRlqk6rSeEhgcAgAVmPUxk/2k9usal1yUYWPLPC62OoH8xUpH2GRFIgSxUOjlby3MIxZyCs0fV4VXLa0iDqtwrlHB/tTBuJmocJFMDa/71o9wmQw3BWUyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707039598; c=relaxed/simple;
	bh=PdA1mnfSW14Bg2XhjSaEUQ9BkxujDuI3oGTdddVhwso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4CpzbmIpsPI0qtMGV9Rvm3/tFsWppyVTQz6v2ulDjmtfoqEA3zjY+PJvSpWVtWKysJoXNwSazG3/VtVuQEiXtuUQNqvBr+cnprsw8lSnrPItE4S5+kc4zUKJAJKw9CT7JRHg99v4R7LF4gMXx3EKBmivdLM5Sx5elXP4g9fYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316F7C433C7;
	Sun,  4 Feb 2024 09:39:55 +0000 (UTC)
Message-ID: <f539a53c-0ede-4c70-8e53-9eed131c581d@xs4all.nl>
Date: Sun, 4 Feb 2024 10:39:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: cec: make cec_bus_type const
Content-Language: en-US, nl
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240203-bus_cleanup-media-v1-0-33e8feeab912@marliere.net>
 <20240203-bus_cleanup-media-v1-1-33e8feeab912@marliere.net>
 <20240204084740.GF3094@pendragon.ideasonboard.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20240204084740.GF3094@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/02/2024 09:47, Laurent Pinchart wrote:
> Hi Ricardo,
> 
> Thank you for the patch.
> 
> On Sat, Feb 03, 2024 at 12:31:26PM -0300, Ricardo B. Marliere wrote:
>> Now that the driver core can properly handle constant struct bus_type,
>> move the cec_bus_type variable to be a constant structure as well,
>> placing it into read-only memory which can not be modified at runtime.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Hans, I assume you'll pick this patch. Could you also pick 2/2 from the
> series ?

Of course!

	Hans

> 
>> ---
>>  drivers/media/cec/core/cec-core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
>> index 7e153c5cad04..5a54db839e5d 100644
>> --- a/drivers/media/cec/core/cec-core.c
>> +++ b/drivers/media/cec/core/cec-core.c
>> @@ -93,7 +93,7 @@ static void cec_devnode_release(struct device *cd)
>>  	cec_delete_adapter(to_cec_adapter(devnode));
>>  }
>>  
>> -static struct bus_type cec_bus_type = {
>> +static const struct bus_type cec_bus_type = {
>>  	.name = CEC_NAME,
>>  };
>>  
> 



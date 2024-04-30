Return-Path: <linux-kernel+bounces-164198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD918B7A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C1928255C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF1770E0;
	Tue, 30 Apr 2024 14:49:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E8152796
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488597; cv=none; b=HCt9n9Fm+hEEQNqUgXrh4rtV0BH0TB3Br+Rgvroms1SdnqyyQQmjsADgC6Hwgw+wC9VuEeZFfBXLAoG1gHu7Q2jm8W9LfagkZJPtfS2OACOi1Sr1zz2er4FiRNHilfcpCk1CU4IoTqAhKy+g7D2FrQDDgVCXZK30QxajSsfx1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488597; c=relaxed/simple;
	bh=bmVbTFrcBa1+AhtrVtIN1tbHKgNQUSMEg9aEZ1XolgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nadrs+yISHarOpTW4e5om5i5Bv9cAk4Uq/5j2IkubxlDbQG2ObE3Y+84UEXaQ3QCXB9zRyvgSYSeN90AiPrR/VSldZv+xDXGEsWvt8V5WWFvnggllYc9G3lbqPmseUF7TqTMciYWkFkPU+fR+hv9gHPe+VRB/AWz/X1FcGH5CVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.44.124.117])
	by gateway (Coremail) with SMTP id _____8Dx_+sNBTFmFHkFAA--.18206S3;
	Tue, 30 Apr 2024 22:49:49 +0800 (CST)
Received: from [192.168.0.107] (unknown [36.44.124.117])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx+90JBTFmsFALAA--.26672S3;
	Tue, 30 Apr 2024 22:49:46 +0800 (CST)
Message-ID: <3283ce46-86d8-ff87-440e-ee9811c9e77a@loongson.cn>
Date: Tue, 30 Apr 2024 22:49:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] firmware: dmi: Change size of dmi_ids_string[] to 256
Content-Language: en-US
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-kernel@vger.kernel.org
References: <1677030901-29326-1-git-send-email-yangtiezhu@loongson.cn>
 <20240429144442.472aa83c@endymion.delvare>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <20240429144442.472aa83c@endymion.delvare>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8Bx+90JBTFmsFALAA--.26672S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrWftrW7tFWDCw1kJw4DJrc_yoW8uw4DpF
	WYk3y0gFs2yr1DGr17u345XF1rZ3yrAr1UJFWFkr18C34jq3W5Za1xKF48Za17C348G34v
	vFW0gFW5uFn09acCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
	05UUUUU==

On 4/29/24 20:44, Jean Delvare wrote:
> Hi Tiezhu,
> 
> Sorry for the very late answer, somehow your messages slipped through
> the cracks.

It does not matter, thank you very much for your reply.

> 
> On Wed, 22 Feb 2023 09:55:01 +0800, Tiezhu Yang wrote:
>> The current size of dmi_ids_string[] is 128, the BIOS date
>> can not be seen if the total string length of system vendor,
>> product name, board name, BIOS version and BIOS date is too
>> long to over 128, it is better and enough to change size of
>> dmi_ids_string[] to 256 for most cases.
> 
> In order to convince me that the size of this buffer needs to be
> increased, one would have to provide a real world example with valid
> DMI data where the output doesn't fit. However...
> 
>> Without this patch:
>>
>> [    0.000000] DMI: Loongson Loongson-3A5000-7A1000-1w-A2101/Loongson-LS3A5000-7A1000-1w-A2101, BIOS vUDK2018-LoongArch-V4.0.05132-beta10 12/13/202
>>
>> With this patch:
>>
>> [    0.000000] DMI: Loongson Loongson-3A5000-7A1000-1w-A2101/Loongson-LS3A5000-7A1000-1w-A2101, BIOS vUDK2018-LoongArch-V4.0.05132-beta10 12/13/2022
> 
> This example is apparently taken from an engineering sample with rather
> "low quality" strings or invalid string indexes. Specifically:
> * The product name and the board name are the exact same string.
> * Both duplicate the system vendor name ("Loongson").
> * The BIOS version includes the architecture name "LoongArch", which
>    seems unnecessarily verbose.
> 
> So my feeling is that the issue would be better addressed by fixing the
> DMI data of your board than increasing the buffer size.

I agree with you.

> 
> Do you have any production-grade DMI table with proper strings where
> the buffer is still not large enough?

Not yet.

I did not find the string length of system vendor, product name,
board name, BIOS version and BIOS date in the spec, I only see
"There is no limit on the length of each individual text string."
in "6.1.3 Text strings", so it may be better to increase the size
to avoid the potential problems in theory at least.

https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.7.0.pdf

Thanks,
Tiezhu




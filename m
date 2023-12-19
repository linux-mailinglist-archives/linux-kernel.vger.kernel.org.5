Return-Path: <linux-kernel+bounces-5423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD2818A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B39287C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525371EA7D;
	Tue, 19 Dec 2023 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VteV89gq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D821C28A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702997670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5Y2xZW5TI9Ism45tSq8DBe2hbu4wS50L+AOx/+x/Kk=;
	b=VteV89gqrQH6flSoI+lthNnWh19JxHBkqhBkgG98P4vBn/7tL90AZZNLGz/Q7dQrfomjNG
	mxjKD9RguX+8sdOnFYNbaWcbEF8mDhg6j2BQpZ1SijDH1ka/iJIK/pmFTKJf0ktrtl1fdt
	R6p8HlPV/RW6lDMN2xt4uDCMCwHqkNQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-l7Aq2NzkNBWmsVt1ABXq3w-1; Tue, 19 Dec 2023 09:54:28 -0500
X-MC-Unique: l7Aq2NzkNBWmsVt1ABXq3w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d2f7007e6so1669695e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702997667; x=1703602467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5Y2xZW5TI9Ism45tSq8DBe2hbu4wS50L+AOx/+x/Kk=;
        b=VkAQgE3LToQAvksJUnWicz30bP1mS6c2/jOlhyu22w+grT7QMn+X9Wrg16kTgV1hWD
         K3qkaF7UO16ac0VTcWbpmk3ZtC8bd7nP65lIeLiBUYHAWgSDVZciq8D34qqdnd1ucZ1Y
         LtoleAEJntbWH3xsRy4R6q0qnNAoDsKXfWAko5XybPRIH8Z1viG4qDTPUecnVFfgdp40
         Q90FKH1QiJFA88zKo0T7kemAiPgQGE8LSytglpdnsIs+huhnVSPAq/khkeGIL6YLDf4E
         O3EbXFTDj42+3Uc8USgWMNpcLKFA+JTVVUL41AKsMszWP9fU6Npe7f68dEfOqSQrE17L
         l6TQ==
X-Gm-Message-State: AOJu0Yx+FWYwcjfJDastFFWu52qVMicaQv88QlTOtcGDVGesPfuBFmMz
	OHTL0ACcUB+zh0tMtQZ1YYxbyDmPVzoiC7iMPD9GIilC+75/FdGSI3iXNqYeUGNQdpa6RC9wQFf
	KXCujbTExYciQh0+PlfJkHKM=
X-Received: by 2002:a05:600c:a3af:b0:40c:2c36:2a23 with SMTP id hn47-20020a05600ca3af00b0040c2c362a23mr9011965wmb.180.1702997667445;
        Tue, 19 Dec 2023 06:54:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3c3lheHAtwAEgvx7hlLFQ0En+dHQTlbiEpBr68IGTakdWITs5nzxSzeTuNlBrwUdtuBU9ug==
X-Received: by 2002:a05:600c:a3af:b0:40c:2c36:2a23 with SMTP id hn47-20020a05600ca3af00b0040c2c362a23mr9011960wmb.180.1702997667106;
        Tue, 19 Dec 2023 06:54:27 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id bd7-20020a05600c1f0700b0040c420eda48sm3315708wmb.22.2023.12.19.06.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 06:54:26 -0800 (PST)
Message-ID: <9296941c-a3c8-4d55-9e52-f1277f1c3fc7@redhat.com>
Date: Tue, 19 Dec 2023 15:54:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/2] fpga: set owner of fpga_manager_ops for
 existing low-level modules
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20231218202809.84253-1-marpagan@redhat.com>
 <20231218202809.84253-3-marpagan@redhat.com>
 <2023121829-zealous-prissy-99cc@gregkh>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <2023121829-zealous-prissy-99cc@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-12-18 21:33, Greg Kroah-Hartman wrote:
> On Mon, Dec 18, 2023 at 09:28:09PM +0100, Marco Pagani wrote:
>> This patch tentatively set the owner field of fpga_manager_ops to
>> THIS_MODULE for existing fpga manager low-level control modules.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/altera-cvp.c             | 1 +
>>  drivers/fpga/altera-pr-ip-core.c      | 1 +
>>  drivers/fpga/altera-ps-spi.c          | 1 +
>>  drivers/fpga/dfl-fme-mgr.c            | 1 +
>>  drivers/fpga/ice40-spi.c              | 1 +
>>  drivers/fpga/lattice-sysconfig.c      | 1 +
>>  drivers/fpga/machxo2-spi.c            | 1 +
>>  drivers/fpga/microchip-spi.c          | 1 +
>>  drivers/fpga/socfpga-a10.c            | 1 +
>>  drivers/fpga/socfpga.c                | 1 +
>>  drivers/fpga/stratix10-soc.c          | 1 +
>>  drivers/fpga/tests/fpga-mgr-test.c    | 1 +
>>  drivers/fpga/tests/fpga-region-test.c | 1 +
>>  drivers/fpga/ts73xx-fpga.c            | 1 +
>>  drivers/fpga/versal-fpga.c            | 1 +
>>  drivers/fpga/xilinx-spi.c             | 1 +
>>  drivers/fpga/zynq-fpga.c              | 1 +
>>  drivers/fpga/zynqmp-fpga.c            | 1 +
>>  18 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>> index 4ffb9da537d8..aeb913547dd8 100644
>> --- a/drivers/fpga/altera-cvp.c
>> +++ b/drivers/fpga/altera-cvp.c
>> @@ -520,6 +520,7 @@ static const struct fpga_manager_ops altera_cvp_ops = {
>>  	.write_init	= altera_cvp_write_init,
>>  	.write		= altera_cvp_write,
>>  	.write_complete	= altera_cvp_write_complete,
>> +	.owner		= THIS_MODULE,
> 
> Note, this is not how to do this, force the compiler to set this for you
> automatically, otherwise everyone will always forget to do it.  Look at
> how functions like usb_register_driver() works.
> 
> Also, are you _sure_ that you need a module owner in this structure?  I
> still don't know why...
>

Do you mean moving the module owner field to the manager context and setting
it during registration with a helper macro?

Something like:

struct fpga_manager {
	...
	struct module *owner;
};

#define fpga_mgr_register(parent, ...) \
	__fpga_mgr_register(parent,..., THIS_MODULE)

struct fpga_manager *
__fpga_mgr_register(struct device *parent, ..., struct module *owner)
{
	...
	mgr->owner = owner;
}

Thanks,
Marco



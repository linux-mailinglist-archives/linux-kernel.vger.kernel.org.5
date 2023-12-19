Return-Path: <linux-kernel+bounces-5660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12BB818DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD0C1C24D73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F28131A71;
	Tue, 19 Dec 2023 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXG+lSD9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A872E633
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703006245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAt7JiXzmNfxd2b5RJ1nXcgqmfXVLO96NAc/uLDObCg=;
	b=PXG+lSD9jRgPMZ6kWS1vhM3FEL7GI1Dar/nht0h30XiSMd/9J1j1YPjmwT6bXn/emmQebv
	6zLA312jsfrOefDasfl7/n37Zk9VRjSNvwi5OlfzUYCH2O7wWy2Yh5SGVddpxuRnjRC4hH
	MJpG1QDoPLqa6wvvJeZ4UXTw/tTmBHQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-TpgW1-E9N1aFURdZ643y8w-1; Tue, 19 Dec 2023 12:17:24 -0500
X-MC-Unique: TpgW1-E9N1aFURdZ643y8w-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-425b4c1b67cso78175071cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703006243; x=1703611043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAt7JiXzmNfxd2b5RJ1nXcgqmfXVLO96NAc/uLDObCg=;
        b=S78qmSL2cC2lrzt3swDIgW4QUpdVhJ+SuOtMeox1ZmOfShECfIKFp2/xj16Fes/aE2
         Pq3Tk19wKO5PhDoAz4Kk4NjGSjLIruHH3TPl6cKB+IXH/01jjP2M1Y/Yl9a0m1D3YTvd
         3KfC6XlC8HAcelBu1CIJSfJ4mgzUhfz3vCWv5ysLXFaGWncQ3cvWQXPKQvBW+eCmq4h+
         BzSnycGaNakYRI+oKVsc/QdG06o3waaPLFtEXzy+fzk2E7MKoR75WLUh+x3NMnHPP2bc
         FoE6ethVSI/bnJdpvkWregk/GCph8k+0c7ZKyRLVXOs4VrexR1hWwy/VZH/91v2MtvSq
         gJzQ==
X-Gm-Message-State: AOJu0Yxj8NWue8voB0aY/hQWv2/F7e5lZZYnSCPiX9Q3L1Iud3rqG2Xi
	TGIpLu7iLa9EdACowFVudoUZT1IF+HyIPBhDIw+cdYNFlh4WPZM2tYfTHac2rYgwdqsHEH5tQBa
	GJrnfglQ5ozkwpgJ5i5FKDt6esSzFQHQ=
X-Received: by 2002:ac8:5ad1:0:b0:423:7a01:3a65 with SMTP id d17-20020ac85ad1000000b004237a013a65mr24793072qtd.35.1703006243642;
        Tue, 19 Dec 2023 09:17:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2jjva7fgBRdAJJJu+d1gf0zXdcO+LTHjJgogTJ6jzZZxlP11DghTwYQbZc4in6iLQonpjOA==
X-Received: by 2002:ac8:5ad1:0:b0:423:7a01:3a65 with SMTP id d17-20020ac85ad1000000b004237a013a65mr24793063qtd.35.1703006243352;
        Tue, 19 Dec 2023 09:17:23 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id o25-20020ac872d9000000b004258264d166sm10307046qtp.60.2023.12.19.09.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 09:17:23 -0800 (PST)
Message-ID: <b2d3d88e-840d-48b1-86d4-0a89d6143683@redhat.com>
Date: Tue, 19 Dec 2023 18:17:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/2] fpga: set owner of fpga_manager_ops for
 existing low-level modules
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20231218202809.84253-1-marpagan@redhat.com>
 <20231218202809.84253-3-marpagan@redhat.com>
 <2023121829-zealous-prissy-99cc@gregkh>
 <9296941c-a3c8-4d55-9e52-f1277f1c3fc7@redhat.com>
 <2023121924-extent-defender-fb06@gregkh>
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <2023121924-extent-defender-fb06@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2023-12-19 16:10, Greg Kroah-Hartman wrote:
> On Tue, Dec 19, 2023 at 03:54:25PM +0100, Marco Pagani wrote:
>>
>>
>> On 2023-12-18 21:33, Greg Kroah-Hartman wrote:
>>> On Mon, Dec 18, 2023 at 09:28:09PM +0100, Marco Pagani wrote:
>>>> This patch tentatively set the owner field of fpga_manager_ops to
>>>> THIS_MODULE for existing fpga manager low-level control modules.
>>>>
>>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>>>> ---
>>>>  drivers/fpga/altera-cvp.c             | 1 +
>>>>  drivers/fpga/altera-pr-ip-core.c      | 1 +
>>>>  drivers/fpga/altera-ps-spi.c          | 1 +
>>>>  drivers/fpga/dfl-fme-mgr.c            | 1 +
>>>>  drivers/fpga/ice40-spi.c              | 1 +
>>>>  drivers/fpga/lattice-sysconfig.c      | 1 +
>>>>  drivers/fpga/machxo2-spi.c            | 1 +
>>>>  drivers/fpga/microchip-spi.c          | 1 +
>>>>  drivers/fpga/socfpga-a10.c            | 1 +
>>>>  drivers/fpga/socfpga.c                | 1 +
>>>>  drivers/fpga/stratix10-soc.c          | 1 +
>>>>  drivers/fpga/tests/fpga-mgr-test.c    | 1 +
>>>>  drivers/fpga/tests/fpga-region-test.c | 1 +
>>>>  drivers/fpga/ts73xx-fpga.c            | 1 +
>>>>  drivers/fpga/versal-fpga.c            | 1 +
>>>>  drivers/fpga/xilinx-spi.c             | 1 +
>>>>  drivers/fpga/zynq-fpga.c              | 1 +
>>>>  drivers/fpga/zynqmp-fpga.c            | 1 +
>>>>  18 files changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>>>> index 4ffb9da537d8..aeb913547dd8 100644
>>>> --- a/drivers/fpga/altera-cvp.c
>>>> +++ b/drivers/fpga/altera-cvp.c
>>>> @@ -520,6 +520,7 @@ static const struct fpga_manager_ops altera_cvp_ops = {
>>>>  	.write_init	= altera_cvp_write_init,
>>>>  	.write		= altera_cvp_write,
>>>>  	.write_complete	= altera_cvp_write_complete,
>>>> +	.owner		= THIS_MODULE,
>>>
>>> Note, this is not how to do this, force the compiler to set this for you
>>> automatically, otherwise everyone will always forget to do it.  Look at
>>> how functions like usb_register_driver() works.
>>>
>>> Also, are you _sure_ that you need a module owner in this structure?  I
>>> still don't know why...
>>>
>>
>> Do you mean moving the module owner field to the manager context and setting
>> it during registration with a helper macro?
> 
> I mean set it during registration with a helper macro.
> 
>> Something like:
>>
>> struct fpga_manager {
>> 	...
>> 	struct module *owner;
>> };
>>
>> #define fpga_mgr_register(parent, ...) \
>> 	__fpga_mgr_register(parent,..., THIS_MODULE)
>>
>> struct fpga_manager *
>> __fpga_mgr_register(struct device *parent, ..., struct module *owner)
>> {
>> 	...
>> 	mgr->owner = owner;
>> }
> 
> Yes.
> 
> But again, is a module owner even needed?  I don't think you all have
> proven that yet...

Programming an FPGA involves a potentially lengthy sequence of interactions
with the reconfiguration engine. The manager conceptually organizes these
interactions as a sequence of ops. Low-level modules implement these ops/steps
for a specific device. If we don't protect the low-level module, someone might
unload it right when we are in the middle of a low-level op programming the
FPGA. As far as I know, the kernel would crash in that case.

Thanks,
Marco



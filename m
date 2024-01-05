Return-Path: <linux-kernel+bounces-17559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B6C824F62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACA31F22F3A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2089A20314;
	Fri,  5 Jan 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHHvwGDo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655262030C;
	Fri,  5 Jan 2024 07:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33E6C433C7;
	Fri,  5 Jan 2024 07:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704441456;
	bh=V3V2W7J4AM86dAZsYqK+bZMIPZaTuKTsNuwiXxImJs0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mHHvwGDoc6VnQkGd0dyn5r10CVvNnjeld4zTQvjOz3zLYobEK3XRC3UPjIBXmPHDj
	 BmBA/QU80p/wNXSgkxk9MxNDKon33bqN6q/LGUlc0XLF8xJhZ9wo7/svaEq5Dkw9qq
	 GkziBob0YH/RmWeTIWJNGH2iQqFVN9U6seMBqa4wVV7Pd9QTPub+Wv42gA02HXhKIU
	 QvneTNuh1ZB182vUse1SdwzjedPii3ztiMkZybAHA1xlbcmcTy965e0VIah37A9AKS
	 5x3swx31DzGVVssPUXXrsA+TV55PPvEUZZ4FpUd6geA66xnpWY0/UAhzDFV3eIVJp9
	 9DrD3azGqfFwQ==
Message-ID: <38346e99-857d-4cae-80eb-0190a27d4c86@kernel.org>
Date: Fri, 5 Jan 2024 09:57:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Content-Language: en-US
To: Javier Carrasco <javier.carrasco@wolfvision.net>,
 Dhruva Gole <d-gole@ti.com>
Cc: Jai Luthra <j-luthra@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com,
 nm@ti.com
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
 <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
 <e9e8dd9f-b11b-43fc-8d76-6734dbddb540@kernel.org>
 <20240104185242.tf2fvgf56ehajqd5@dhruva>
 <ee37ec0f-13e8-4eed-a675-94e315de7c15@wolfvision.net>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <ee37ec0f-13e8-4eed-a675-94e315de7c15@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/01/2024 22:15, Javier Carrasco wrote:
> On 04.01.24 19:52, Dhruva Gole wrote:
> 
>>
>> This series also broke boot on TI SK-AM62x [0].
>>
> 
>>>
>>> This looks like a correct fix to me.
>>> Could you please send a proper PATCH with Fixes tag? Thanks!
>>
>> Thanks for reviewing this Roger, the same patch above worked for me to
>> fix SK-AM62x as well [1].
>>
>> [0] https://storage.kernelci.org/next/master/next-20240103/arm64/defconfig/gcc-10/lab-ti/baseline-nfs-am62xx_sk-fs.txt
>> [1] https://gist.github.com/DhruvaG2000/326b5d7fab4be95f20cd0aac4125f577
>>
> Hi Dhruva,
> 
> I am glad that you guys found a fix that quickly.
> 
> it seems that you guys work for the device manufacturer (because of your
> email addresses), so I was wondering if you could explain (or provide
> the documentation) why the tps6598x should not receive the GAID command
> and a reset crashes the system. Everything looks exactly the same as for
> the tps25750, but in that case there are no complaints from sending a
> cold reset.

Looking at the kernel logs I don't see any crashes.
Looks like the baseline-nfs.login test failed due to some reason [2].
I cannot see why though.

[1] https://linux.kernelci.org/soc/ti/job/next/kernel/next-20240103/plan/baseline-nfs/
[2] https://linux.kernelci.org/test/plan/id/659561d445debed180c795fc/

-- 
cheers,
-roger


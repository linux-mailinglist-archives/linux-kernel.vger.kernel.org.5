Return-Path: <linux-kernel+bounces-24728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B082C171
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1731F2369B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9946DCE9;
	Fri, 12 Jan 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="io8SmW2A"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA3064AAA;
	Fri, 12 Jan 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.192.9.210] (unknown [167.220.81.210])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3973420B3CDD;
	Fri, 12 Jan 2024 06:19:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3973420B3CDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705069172;
	bh=Hf/1xwwBQuN1sfFBigN5QHzku0/GhLdtO5+o3Q14nPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=io8SmW2AsPSi33kTlc8853e86u0ggvFPZa+pTze/SEIO9PLniCuek13WIN5+ubJuc
	 rTrLlIuuYeIHmJbCpRexjaoLnjy7fswD/LK8ktayRNf9aT827Epn6TRnwllZZk4ID5
	 SIKWCqw7DtVBx41Kj38+ha+sOLSbpWXEQ+K7lkDM=
Message-ID: <bf1a84e0-bf88-41a1-ad0c-4270aaa5d3aa@linux.microsoft.com>
Date: Fri, 12 Jan 2024 06:19:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] acpi: Use access_width over register_width for
 system memory accesses
Content-Language: en-US
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20231216001312.1160-1-jarredwhite@linux.microsoft.com>
 <CAJZ5v0gZ39zJEGV7gQLg6Y0=ke1W7bctqtZ46K+SR9RT5Bx4Hg@mail.gmail.com>
 <6e7db718-65ec-4461-bab9-0ee4c96c25eb@linux.microsoft.com>
From: Jarred White <jarredwhite@linux.microsoft.com>
In-Reply-To: <6e7db718-65ec-4461-bab9-0ee4c96c25eb@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/22/2023 4:00 PM, Easwar Hariharan wrote:
>  >> @@ -784,7 +792,8 @@ int acpi_cppc_processor_probe(struct 
> acpi_processor *pr)
>  >>                                                          goto out_free;
>  >>                                          }
>  >>
>  >> -                                       addr = 
> ioremap(gas_t->address, gas_t->bit_width/8);
>  >> +                                       access_width = 
> ACCESS_WIDTH_TO_BITS(gas_t) / 8;
>  >
>  > What would happen if the platform firmware incorrectly provided
>  > reg->access_witdh == 0?
>  >
> 

Unfortunately, we have no hardware platform with this configuration to 
test with. What is the level of concern here? Were there previous 
changes that raised this similar concerns?


Thanks,
Jarred



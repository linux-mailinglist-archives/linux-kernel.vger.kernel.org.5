Return-Path: <linux-kernel+bounces-136567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9A89D595
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C23F2852D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33BB7F7F6;
	Tue,  9 Apr 2024 09:28:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282C57EF1F;
	Tue,  9 Apr 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654914; cv=none; b=U0KIrrcrAIyNSUh7zBXrGiys9U/brv6ZK57C0b4bEvvJj+U+o8AsdX7Y4inONLj9PPNvpeoW4LdTRud62gwOdVtbMFQhMiHtM3sY0clx9qFOI3WFaFdbphqEWed1/4t4ojTW+MWC4BUVbfE2J5C5ZehGyDJ7qtqioalSvhDiP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654914; c=relaxed/simple;
	bh=IyoxD0ITXsSHOPvcnDKknDm8b+HSTqMYls3i/cTrI9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eC3qNoQzwr8mml7q8wrJoUeb4nNIJsXlVF0zhnZiFs172lrfnENsIt8x0I3Mw1/V36fOvkoMy1BJcYVS/2X6+x/pGz1nIYCT/noBE5xPZ51W2ZWiuVIwU1Xxj7mXIFftYZ3l9BBZxN2e7rQqY4QWzSWiVcYHlJRuOYkPSlT3pWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB5EADA7;
	Tue,  9 Apr 2024 02:29:01 -0700 (PDT)
Received: from [10.57.52.202] (unknown [10.57.52.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CEBB3F6C4;
	Tue,  9 Apr 2024 02:28:29 -0700 (PDT)
Message-ID: <7f265f0d-7505-41fd-961e-a1d48bb368c9@arm.com>
Date: Tue, 9 Apr 2024 10:28:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] Coresight for Kernel panic and watchdog reset
To: Linu Cherian <lcherian@marvell.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 George Cherian <gcherian@marvell.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "mike.leach@linaro.org" <mike.leach@linaro.org>,
 "leo.yan@linaro.org" <leo.yan@linaro.org>
References: <20240307033625.325058-1-lcherian@marvell.com>
 <PH0PR18MB5002D016166F97E665BB0F39CE072@PH0PR18MB5002.namprd18.prod.outlook.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <PH0PR18MB5002D016166F97E665BB0F39CE072@PH0PR18MB5002.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/04/2024 01:10, Linu Cherian wrote:
> Hi Suzuki/James,
> 
>> -----Original Message-----
>> From: Linu Cherian <lcherian@marvell.com>
>> Sent: Thursday, March 7, 2024 9:06 AM
>> To: suzuki.poulose@arm.com; mike.leach@linaro.org; james.clark@arm.com;
>> leo.yan@linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org; coresight@lists.linaro.org; linux-
>> kernel@vger.kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> devicetree@vger.kernel.org; Sunil Kovvuri Goutham
>> <sgoutham@marvell.com>; George Cherian <gcherian@marvell.com>; Linu
>> Cherian <lcherian@marvell.com>
>> Subject: [PATCH v7 0/7] Coresight for Kernel panic and watchdog reset
>>
>> This patch series is rebased on v6.8-rc4 from coresisght tree,[1], since latest
>> changes are dependent on coresight_get/set_mode APIs.
>>
> 
> 
> Do you have any feedback on this version ?
> 
> Thanks.
> 

Hi Linu,

Sorry it was on my list, I'll take a look this week.




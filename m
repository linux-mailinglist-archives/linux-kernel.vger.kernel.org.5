Return-Path: <linux-kernel+bounces-47545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E7A844F33
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984061C23159
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E9239FFF;
	Thu,  1 Feb 2024 02:37:48 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FD1773E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706755067; cv=none; b=gwXJzcr6GzKan5p7Xf4p2m7fwPcR+0T+Ol1ABRbVk1Q4awTjnVzQX7bOUIx7k8bLJ1AukzXhnQ39+iHpOuN9vDy6svBWJYTopDbjzRgIDgo0CsIKtO/MaRARabrl4tUgM+hBXxFyB9/eB/XcQp9m+tcfV/CiSBXEkZ/nboFL8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706755067; c=relaxed/simple;
	bh=v9KFJ0/t9phT/0qcrC94uWpVsSJNz28sqabEjQ2Ec10=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bmVVj6h8DJZrblOSB0xd/2IfpcLUE38eQFxQd99bRbFeGSqaIs5rwkdVuo6jz9N601X224aL+QUxdjn6kVHCtw7yKWLb9L6sISs+mzSCz3Gw7Q38lSl/zzCEFRhfnU9nyCKTjMPqbgs40gnS1rRDNKhHE2mV9sMnsMjTfupqLLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1706755060-1eb14e0c7e333b0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id vybHdzObSTfvd8JI (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 01 Feb 2024 10:37:40 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 1 Feb
 2024 10:37:40 +0800
Received: from [10.32.57.248] (10.32.57.248) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 1 Feb
 2024 10:37:37 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <858b8c95-a0b7-4085-9ae4-824bec4d3c67@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.57.248
Date: Thu, 1 Feb 2024 10:37:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] crypto: padlock-sha: Matches CPU with Family with
 6 explicitly
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH v2 1/3] crypto: padlock-sha: Matches CPU with Family with
 6 explicitly
To: Dave Hansen <dave.hansen@intel.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <seanjc@google.com>, <kim.phillips@amd.com>,
	<kirill.shutemov@linux.intel.com>, <jmattson@google.com>,
	<babu.moger@amd.com>, <kai.huang@intel.com>, <acme@redhat.com>,
	<aik@amd.com>, <namhyung@kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	<GeorgeXue@zhaoxin.com>
References: <20240123022852.2475-1-TonyWWang-oc@zhaoxin.com>
 <20240123022852.2475-2-TonyWWang-oc@zhaoxin.com>
 <54d4fe7f-2e36-4bb3-8b51-4a68510010d5@intel.com>
 <40e74749-fa9d-4089-ae23-e9aefdd3549f@zhaoxin.com>
 <85dd3df3-9c0e-45e2-af8d-50dbc0cf40c8@intel.com>
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <85dd3df3-9c0e-45e2-af8d-50dbc0cf40c8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1706755060
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1244
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.120217
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------


On 2024/1/31 23:33, Dave Hansen wrote:
>
> [这封邮件来自外部发件人 谨防风险]
>
> On 1/31/24 01:45, Tony W Wang-oc wrote:
>>>>    static const struct x86_cpu_id padlock_sha_ids[] = {
>>>> -     X86_MATCH_FEATURE(X86_FEATURE_PHE, NULL),
>>>> +     X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_PHE, NULL),
>>>>         {}
>>>>    };
>>> Logically, this is saying that there are non-CENTAUR or non-family-6
>>> CPUs that set X86_FEATURE_PHE, but don't support X86_FEATURE_PHE.  Is
>>> that the case?
>> Not exactly.
>>
>> Zhaoxin CPU supports X86_FEATURE_PHE and X86_FEATURE_PHE2.
>>
>> We expect the Zhaoxin CPU to use the zhaoxin_sha driver introduced in
>> the third patch of this patch set.
>>
>> Without this patch Zhaoxin CPU will also match the padlock-sha driver too.
> I honestly have no idea what this is saying.
>
> Could you try again, please?


Sorry. It should be said that there are non-CENTAUR or non-family-6 CPUs 
that set X86_FEATURE_PHE,

and also set the new X86_FEATURE_PHE2.  For these CPUs, we expect to use 
a new driver that supports

both X86_FEATURE_PHE and X86_FEATURE_PHE2.

So we make the driver padlock-sha to matches CENTAUR Family-6 CPU 
explicitly.



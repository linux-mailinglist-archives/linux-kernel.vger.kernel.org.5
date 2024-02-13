Return-Path: <linux-kernel+bounces-64078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5146F8539E0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C221F25E67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAF5605D8;
	Tue, 13 Feb 2024 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Z3J4L5DJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D4604DF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848721; cv=none; b=ta3/JoO3KeiBPDUPNsSKUWknliKmCDLW/i5Bu/5OuNZJSbodEyFA3/0gdjsjlWO4TBxv+c0ctiKmK+X8QWzFEFDl1Df3gn1nfOOLe0LMCmkM7+Jl/PoSdKETDeIvratGHSzyNvsEGKmW1iHYsrAwGjCNi3mMjZxUcggmOd3DeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848721; c=relaxed/simple;
	bh=rocOyJn1TixS9ApVLtPgDT8swYAg5BQYD/SUm6bPV7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IQgHHmGB8fcUh5kb2bhxqLci/kvJy6BQP9299O4sdvTzSa8ETF9kAFrjqDiZGBcMjhe2c1MUnV5/F1lItBJZFjL40uSJq8r9hLAmT2w+APxDEV6jmh2nAEf6E9SfE4cuaecq/9FSre6eUcvLA19YIG4Gta+mMbA9d1z597ApJp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Z3J4L5DJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DHcmM9022982;
	Tue, 13 Feb 2024 18:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=FAus3T7IYJGqYhEvbtjq5U3jGAnExYhoc5wMuQZ18s4=; b=Z3
	J4L5DJZvuhDkpp5FqOWOBWN4fpBB2fD9XoAzturrWyuLg3ZKdBTl3ZpTFd8kctji
	mX2+zDtaoDkLKpwULCDSqhPShs8PRVNvJq2Z6Orp+4/gBZXWsVqK4oWLu8tvK49K
	2Ii3noHIXltgxJWC9bAqgEmODcAnXlHKLO7YREWvuJAlp1F83aTlQ5/iL4LeScOu
	x+OORMn44Tr64maNIvPpZcOuSwG+ugt1Mp2J9qSI/9GEz4TOLpwkTSCM6vxCxue4
	UJnKx8L2/k7wlkXyGLoFC9lnH87MPL6waAz/ijkP6e1xbjigbwKLdGIiQlE+5VD8
	Tt+302mbqLc03Q3YpxYA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7s392gfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 18:25:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DIP3aJ019374
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 18:25:03 GMT
Received: from [10.110.14.146] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 10:25:02 -0800
Message-ID: <fc28f615-eaaf-459a-96e2-fce104f77fe7@quicinc.com>
Date: Tue, 13 Feb 2024 10:24:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] firmware: arm_scmi: Implement Clock
 .is_notify_supported callback
To: Cristian Marussi <cristian.marussi@arm.com>,
        kernel test robot
	<lkp@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <sudeep.holla@arm.com>, <vincent.guittot@linaro.org>,
        <peng.fan@oss.nxp.com>, <michal.simek@amd.com>,
        <quic_sibis@quicinc.com>, <souvik.chakravarty@arm.com>
References: <20240212123233.1230090-7-cristian.marussi@arm.com>
 <202402131047.2NVZWHma-lkp@intel.com> <ZcstL8tRVKIUFoBr@pluto>
Content-Language: en-US
From: Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <ZcstL8tRVKIUFoBr@pluto>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JEWW0EYMlnqvOCxYIQU3thM012GTfpz1
X-Proofpoint-GUID: JEWW0EYMlnqvOCxYIQU3thM012GTfpz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402130145


On 2/13/2024 12:49 AM, Cristian Marussi wrote:
> On Tue, Feb 13, 2024 at 10:58:23AM +0800, kernel test robot wrote:
>> Hi Cristian,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on soc/for-next]
>> [also build test ERROR on linus/master v6.8-rc4 next-20240212]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
> Hi,
>
> this series, as stated in the cover-letter, is based off the current tip of
>
> 	sudeep/for-next/scmi/updates
>
> and particularly needs commit:
>
> 	9c5bc650031e firmware: arm_scmi: Rework clock domain info lookups
>
> from there, since it contains the missing scmi_clock_domain_lookup().
>
> Not_sure/dont_known if there is any way to convey this "based-on-branch"
> info to your/any CI at the moment.
>
> Thanks,
> Cristian
Maybe add supdeep's tree in MAINTAINERS and use 'base-commit'.
>> url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Check-for-notification-support/20240212-203727
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
>> patch link:    https://lore.kernel.org/r/20240212123233.1230090-7-cristian.marussi%40arm.com
>> patch subject: [PATCH 06/11] firmware: arm_scmi: Implement Clock .is_notify_supported callback
>> config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240213/202402131047.2NVZWHma-lkp@intel.com/config)
>> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project c08b90c50bcac9f3f563c79491c8dbcbe7c3b574)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240213/202402131047.2NVZWHma-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402131047.2NVZWHma-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>>> drivers/firmware/arm_scmi/clock.c:853:8: error: call to undeclared function 'scmi_clock_domain_lookup'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>       853 |         clk = scmi_clock_domain_lookup(ci, src_id);
>>           |               ^
>>>> drivers/firmware/arm_scmi/clock.c:853:6: error: incompatible integer to pointer conversion assigning to 'struct scmi_clock_info *' from 'int' [-Wint-conversion]
>>       853 |         clk = scmi_clock_domain_lookup(ci, src_id);
>>           |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     2 errors generated.
>>
>>
>> vim +/scmi_clock_domain_lookup +853 drivers/firmware/arm_scmi/clock.c
>>
>>     842	
>>     843	static bool scmi_clk_notify_supported(const struct scmi_protocol_handle *ph,
>>     844					      u8 evt_id, u32 src_id)
>>     845	{
>>     846		bool supported;
>>     847		struct scmi_clock_info *clk;
>>     848		struct clock_info *ci = ph->get_priv(ph);
>>     849	
>>     850		if (evt_id >= ARRAY_SIZE(evt_2_cmd))
>>     851			return false;
>>     852	
>>   > 853		clk = scmi_clock_domain_lookup(ci, src_id);
>>     854		if (IS_ERR(clk))
>>     855			return false;
>>     856	
>>     857		if (evt_id == SCMI_EVENT_CLOCK_RATE_CHANGED)
>>     858			supported = clk->rate_changed_notifications;
>>     859		else
>>     860			supported = clk->rate_change_requested_notifications;
>>     861	
>>     862		return supported;
>>     863	}
>>     864	
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki


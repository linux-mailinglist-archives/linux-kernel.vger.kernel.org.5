Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C35D7E6050
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 23:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjKHWGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 17:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHWGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 17:06:07 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62C2258A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 14:06:04 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8Log4F018204;
        Wed, 8 Nov 2023 22:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8XM3Il8HYsQ2qd9FOOZ30uZ5RS/gFPFqqAXbAdthgDQ=;
 b=ly2Noa/8ULMRu4h4oWInTahEucEFmtyfMuERD1tH6Mar4fY42O37dPefJGUS6zevDoU7
 VD084S1CnW+Q1AzH3lTWlC8pynTcVGr9lPNsaEEShI/sctit/tqVANLdSY9BqhxUnjrl
 cDbbAdwwmqpm0YGTUUvujKpLeFUOWFH0JmGDmVN+HXS6AFEtcwXXQIy9oMe6JNHI0sXE
 aOA2zK2t2lJnKZzSvQMiNZ3on3OezeJqgW1yxFQcjGR2aa2IMu8aSTHikdHI6wmSZsxd
 reTd/gNz4EKIEFQZkGOAC+GD5KrJ3d1kXSIf2H3bV+Aqu09NagH8hTd3tubKjNfOrkyJ sg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8jkpgcef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 22:05:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8M1ONT019231;
        Wed, 8 Nov 2023 22:05:58 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w23yte2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 22:05:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A8M5vMY18285170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Nov 2023 22:05:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A89EF58058;
        Wed,  8 Nov 2023 22:05:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58DAD58057;
        Wed,  8 Nov 2023 22:05:57 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Nov 2023 22:05:57 +0000 (GMT)
Message-ID: <b74ea810-5b6c-404d-8cee-7d3d3922205e@linux.ibm.com>
Date:   Wed, 8 Nov 2023 17:05:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] fix rootfstype=tmpfs
Content-Language: en-US
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
 <8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net>
 <f9d57ae7-6dd6-4854-b9cf-1eec4cfa2a92@linux.ibm.com>
In-Reply-To: <f9d57ae7-6dd6-4854-b9cf-1eec4cfa2a92@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6_4SsUENmoQ1-CKZyz2cZeGXN_vGFbTf
X-Proofpoint-ORIG-GUID: 6_4SsUENmoQ1-CKZyz2cZeGXN_vGFbTf
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_10,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/23 09:10, Stefan Berger wrote:
> 
> 
> On 2/21/23 16:04, Rob Landley wrote:
>> Wire up rootfstype=tmpfs to force rootfs to be tmpfs even when you 
>> specify root=
>>
>> Initramfs automatically uses tmpfs (if available) when you DON'T 
>> specify a
>> root= fallback root to mount over initramfs, but some people can't NOT do

can't NOT -> cannot

>> that for some reason (old bootloaders), so let rootfstype=tmpfs 
>> override it.
>>
>> My original code tried to do this 10 years ago but got the test wrong,
>> and nobody's corrected it since, so here you go...

I think this sentence can be dropped.

>>
>> Signed-off-by: Rob Landley <rob@landley.net>
> 
> I would like to be able to have this for some work with OpenBMC and 
> ideally it would propagate to one of the recent kernels with a Fixes tag 
> like this?
> 

Can you repost this patch or should I do it?

Regards,
    Stefan

> Fixes: 6e19eded3684 ("initmpfs: use initramfs if rootfstype= or root= 
> specified")
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>


> 
>>
>> See https://lkml.iu.edu/hypermail/linux/kernel/2207.3/06939.html
>> ---
>>   init/do_mounts.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/init/do_mounts.c b/init/do_mounts.c
>> index 811e94daf0a8..01d80fb828fd 100644
>> --- a/init/do_mounts.c
>> +++ b/init/do_mounts.c
>> @@ -665,7 +665,7 @@ struct file_system_type rootfs_fs_type = {
>>   void __init init_rootfs(void)
>>   {
>> -    if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
>> -        (!root_fs_names || strstr(root_fs_names, "tmpfs")))
>> +    if (IS_ENABLED(CONFIG_TMPFS) && (!root_fs_names ? 
>> !saved_root_name[0] :
>> +        !!strstr(root_fs_names, "tmpfs")))
>>           is_tmpfs = true;
>>   }

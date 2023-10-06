Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68327BB975
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjJFNoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjJFNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:44:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E77B6;
        Fri,  6 Oct 2023 06:44:06 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396DgJ55028499;
        Fri, 6 Oct 2023 13:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=j/AG//P4Bx8htSBN1sllurmbbh6m4O61QdheH9XyQaA=;
 b=f8L2W4xmLnh9vrnf3oJjjE6fMCcxcy6YADrkJQxhSTb4k8ZsYQkKNPhE9X7kMyg59Me5
 V/anx27NmkmfFcuzUWp3UPqSP2GtZSZ984sC1NPxt6Pss8B0+O4viDb7EbVU7JYUTNiq
 WS3IvVf2DndRoZb+xV7exE8ocXykH9o3EjdFe21DjpkwOwdRxbEJV1KAwDGYIN8kLqP1
 T2K9S+SY8ROmhsSIWd4ADVW6dwmWCAm14WrQ0fuEb5GK9kZuKtvGTPuSZic8dZb8yXHw
 RqZXih3huY3ikXl4GUS0AMmuieNyxEl7hebQT7E0BkG+8N9ThWlstHQJmuFZHfcNW3qV lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjkbur0ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 13:43:46 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 396DhkaY031843;
        Fri, 6 Oct 2023 13:43:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tjkbur0ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 13:43:46 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 396DE2OL007467;
        Fri, 6 Oct 2023 13:43:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3teygmvh0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 13:43:43 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 396DhgjK32309528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Oct 2023 13:43:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C0B45805D;
        Fri,  6 Oct 2023 13:43:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24F5158057;
        Fri,  6 Oct 2023 13:43:36 +0000 (GMT)
Received: from [9.171.83.242] (unknown [9.171.83.242])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  6 Oct 2023 13:43:35 +0000 (GMT)
Message-ID: <357397b0-8e87-dd88-7c47-fb457cc7e830@linux.vnet.ibm.com>
Date:   Fri, 6 Oct 2023 19:13:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Bisected] [commit 2ad56efa80db] [Hotplug] WARNING while
 performing hotplug operation on 6.6-rc3-next
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-block@vger.kernel.org, baolu.lu@linux.intel.com,
        jsnitsel@redhat.com, jroedel@suse.de, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux.dev,
        abdhalee@linux.vnet.ibm.com, mputtash@linux.vnet.com,
        sachinp@linux.vnet.com
References: <92db426f-4a31-9c2c-e23a-85a8d353fbae@linux.vnet.ibm.com>
 <20231006113644.GN682044@nvidia.com>
 <7ce42090-a768-ba3d-bd27-e86bc076ee57@linux.vnet.ibm.com>
 <20231006133936.GQ682044@nvidia.com>
From:   Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
In-Reply-To: <20231006133936.GQ682044@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nLE4iNGHcLJosVYVMuO3-4ONDA7DFVRp
X-Proofpoint-ORIG-GUID: fYOvrWE8LP4wm9SFS9pp8cLPXlA9fRkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_11,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=977
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060101
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jason for confirmation and the fix.

On 10/6/23 19:09, Jason Gunthorpe wrote:
> On Fri, Oct 06, 2023 at 06:50:00PM +0530, Tasmiya Nalatwad wrote:
>>     Greetings,
>>
>>     Thanks Jason.
>>
>>     The fix provided by you works. It is not giving WARNING's but i am
>>     seeing below logs. Would you please confirm on the logs.
> I don't know anything about your environment but those logs don't
> appear to be related to this series?
>
> Jason

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center


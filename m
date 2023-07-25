Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9557609DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjGYFyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjGYFx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:53:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF17F1FCB;
        Mon, 24 Jul 2023 22:53:54 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P5a4rn003524;
        Tue, 25 Jul 2023 05:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=73b5IEFhrpzhzei5MhvJ+VRozwcxxuRxmymx0ijdhRY=;
 b=PrzHE9MEpO1Ke5E3yIQV8a74GrE3iP+1Ymb/gUwsMB0m9NA1a1j/CPawkgkfG9gtSMjK
 a8HbNN0kQl3Kbia56E5m/pI6sysjktjen9wLjai3Qgccm5hi3IvmXeVNtwZgZSUz+t2m
 1yBpj2HTl6OBNhjR2w+CE8l5BThwIolN7fXLVnFL0m4Ht2lbgHvi2B3F2AAQiCFVBoeM
 HT3v9OgybWpDwChbj26nEWV5khnE5+okNaNbf1xkHIMXEGuF2uT28u/wKCO4q2c+EcBO
 5ZloYww3yQms815zkNdeQDAwGSXl4YT/cvXhAQ+fpdIbQJCRONyOO4T95SByKyNctaHY qQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s27shgyws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:53:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36P5GwO0016644;
        Tue, 25 Jul 2023 05:53:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0v510wc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:53:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36P5rb2t19989238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 05:53:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FA1C2004B;
        Tue, 25 Jul 2023 05:53:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9769E20040;
        Tue, 25 Jul 2023 05:53:35 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.73.40])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Jul 2023 05:53:35 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v3 00/10] Add sysfs interface files to hv_gpci device to
 expose system information
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230719061231.631410-1-kjain@linux.ibm.com>
Date:   Tue, 25 Jul 2023 11:23:23 +0530
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        disgoel@linux.ibm.com, linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D884EDCC-EC77-4C80-A4D4-06B50ABE4AF8@linux.vnet.ibm.com>
References: <20230719061231.631410-1-kjain@linux.ibm.com>
To:     Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
X-Mailer: Apple Mail (2.3731.500.231)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nRRJxsTU-PYSn6VfvkYHmfyIpzED52qG
X-Proofpoint-ORIG-GUID: nRRJxsTU-PYSn6VfvkYHmfyIpzED52qG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_02,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 19-Jul-2023, at 11:42 AM, Kajol Jain <kjain@linux.ibm.com> wrote:
> 
> The hcall H_GET_PERF_COUNTER_INFO can be used to get data related to
> chips, dimms and system topology, by passing different counter request
> values.
> Patchset adds sysfs files to "/sys/devices/hv_gpci/interface/"
> of hv_gpci pmu driver, which will expose system topology information
> using H_GET_PERF_COUNTER_INFO hcall. The added sysfs files are
> available for power10 and above platforms and needs root access
> to read the data.
> 
> Patches 1,3,5,7,9 adds sysfs interface files to the hv_gpci
> pmu driver, to get system topology information.
> 
> List of added sysfs files:
> -> processor_bus_topology (Counter request value : 0xD0)
> -> processor_config (Counter request value : 0x90)
> -> affinity_domain_via_virtual_processor (Counter request value : 0xA0)
> -> affinity_domain_via_domain (Counter request value : 0xB0)
> -> affinity_domain_via_partition (Counter request value : 0xB1)
> 
> Patches 2,4,6,8,10 adds details of the newly added hv_gpci
> interface files listed above in the ABI documentation.
> 
> Patches 2,4,6,8,10 adds details of the newly added hv_gpci
> interface files listed above in the ABI documentation.

Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira
> 
> Changelog:
> v2 -> v3
> -> Make nit changes in documentation patches as suggested by Randy Dunlap.
> 
> v1 -> v2
> -> Incase the HCALL fails with errors that can be resolve during runtime,
>   then only add sysinfo interface attributes to the interface_attrs
>   attribute array. Even if one of the counter request value HCALL fails,
>   don't add any sysinfo attribute to the interface_attrs attribute array.
>   Add the code changes to make sure sysinfo interface added only when all
>   the requirements met as suggested by Michael Ellerman.
> -> Make changes in documentation, adds detail of errors type
>   which can be resolved at runtime as suggested by Michael Ellerman.
> -> Add new enum and sysinfo_counter_request array to get required
>   counter request value in hv-gpci.c file.
> -> Move the macros for interface attribute array index to hv-gpci.c, as
>   these macros currently only used in hv-gpci.c file.
> 
> Kajol Jain (10):
>  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show
>    processor bus topology information
>  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
>    processor_bus_topology sysfs interface file
>  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show
>    processor config information
>  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
>    processor_config sysfs interface file
>  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity
>    domain via virtual processor information
>  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
>    affinity_domain_via_virtual_processor sysfs interface file
>  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity
>    domain via domain information
>  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
>    affinity_domain_via_domain sysfs interface file
>  powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity
>    domain via partition information
>  docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document
>    affinity_domain_via_partition sysfs interface file
> 
> .../sysfs-bus-event_source-devices-hv_gpci    | 160 +++++
> arch/powerpc/perf/hv-gpci.c                   | 640 +++++++++++++++++-
> 2 files changed, 798 insertions(+), 2 deletions(-)
> 
> -- 
> 2.39.3
> 


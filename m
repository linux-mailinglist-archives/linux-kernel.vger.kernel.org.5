Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1E178F8CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243945AbjIAG55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjIAG55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:57:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC23C5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:57:54 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3816atG6021685;
        Fri, 1 Sep 2023 06:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WO+fQsQ05tY3btwa2PEWRWLQbyphozhUzdhVtNswbAM=;
 b=ioK/y1loq1C0Ki02Ve+38Il6TZEASIgCmbPlJC4HC3I+U52qgbKGfqgw2RnEd8hzwDWu
 nEFd1DNsSrnYSibTb9YvylIUE5FRMevav2ukoFP00mOLUt07zq57d4Fb5E07YJq8fs8M
 wyguRXsGPmLG3VpoYbT3mQd8fWWnG1aFR1hc8r/qCFtFXfwlcyfoJIrIysC9elncweuQ
 YopwCa1VCdCO1jZSnSDHgwrAU7TyJOXBiluxpVivjGcGD7k/sIOVn3+tHYjzTrrvEh9U
 DnX+Dc0E1s2icrHGnY/JKoRYA1uMULsbGcEizpPD0cd/WmXnlqDqve9sfLzoquvCuMbQ Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3su9ksa6c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 06:57:42 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3816avOd021998;
        Fri, 1 Sep 2023 06:57:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3su9ksa6bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 06:57:41 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3815ONS4009855;
        Fri, 1 Sep 2023 06:57:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7m2mhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 06:57:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3816vdPl22676050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Sep 2023 06:57:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E7E358065;
        Fri,  1 Sep 2023 06:57:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 130E058053;
        Fri,  1 Sep 2023 06:57:35 +0000 (GMT)
Received: from [9.171.58.3] (unknown [9.171.58.3])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  1 Sep 2023 06:57:34 +0000 (GMT)
Message-ID: <70ac2967-1f53-2eba-08e2-2fad39630b2e@linux.vnet.ibm.com>
Date:   Fri, 1 Sep 2023 12:27:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org
References: <20230901065110.137185-1-sshegde@linux.vnet.ibm.com>
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20230901065110.137185-1-sshegde@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vib63OEsH3vqdde-uzBpABeiDpr2_shw
X-Proofpoint-ORIG-GUID: 7uHI9SCFmeYabRcKNaZ12PJT0fkQskIb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_04,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=563 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010061
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/23 12:21 PM, Shrikanth Hegde wrote:
> Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
> some of the architectures. IIUC its meant to either force rebuild the
> perf domains or cleanup the perf domains by echoing 1 or 0 respectively.
> 
Please ignore this mail.

This is duplicate of 
https://lore.kernel.org/lkml/20230901065249.137242-1-sshegde@linux.vnet.ibm.com/

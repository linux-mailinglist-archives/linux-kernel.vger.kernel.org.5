Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FF380A1D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573754AbjLHLIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjLHLH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:07:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA071710;
        Fri,  8 Dec 2023 03:08:05 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8B7bUC019907;
        Fri, 8 Dec 2023 11:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UH1x32KWNnsBPuKltqia0l/G4ekuXhNpvrm2Ci3Ini0=;
 b=NxZ6gxoGnDHuMyVfq48+5Lbg5bltE1vke28I2Bl9fBMeLuk8nfwbIH5Rvm1/BUH9CaJd
 6Ea2eChiiYmsA9+KFWjWL2ybcTs9Qz3bc7d18+MBYhJnuTJg8GVk3d9gqYafxP+ShB9p
 HuLtYcordpczr/2aGSq+TvB4X0lduWGp+O5MJCIJXymvkrxv4wpemSMkf5MQl2H1lqBB
 NhsNKS8h2H+TSyfrqyUCvZ+LlR3ZM6vK6fsRGfvHms0MAxz2MaGFEldHl2fCr02BLQ22
 yZqi/bmm6S91WZ9VcDiBvChamzD04v3EV/8/FlBGDGB5Nl5V3Pe58JrKZXXBIwm2Vip1 Pg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv20600ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 11:07:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B89VKht004687;
        Fri, 8 Dec 2023 11:07:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav4s7jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 11:07:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B8B7rYh44106036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Dec 2023 11:07:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A65020040;
        Fri,  8 Dec 2023 11:07:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3A652004B;
        Fri,  8 Dec 2023 11:07:52 +0000 (GMT)
Received: from [9.171.29.29] (unknown [9.171.29.29])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  8 Dec 2023 11:07:52 +0000 (GMT)
Message-ID: <de0dd86a-4c49-49ed-a90b-4890c82a7b2d@linux.ibm.com>
Date:   Fri, 8 Dec 2023 12:07:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Fix fails of perf stat --bpf-counters
 --for-each-cgroup on s390
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
References: <20231207125716.1947860-1-tmricht@linux.ibm.com>
 <CAM9d7cgJUgVGpQJ=KgH+3RzAJ8Ce50Acr=gSZh_ZLuiTa3-sEg@mail.gmail.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAM9d7cgJUgVGpQJ=KgH+3RzAJ8Ce50Acr=gSZh_ZLuiTa3-sEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eM37E9D4DmRt0lQkA7-nR5Z2BgvA6Krr
X-Proofpoint-ORIG-GUID: eM37E9D4DmRt0lQkA7-nR5Z2BgvA6Krr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_06,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/23 00:26, Namhyung Kim wrote:

> Thanks for the patch.  But I think it should support
> machines without systemd (or maybe with old versions).
>
> Also probably you want to reset the behavior after
> the test.  I think we can just run some built-in test
> workload like `perf test -w thloop`.
>
> Thanks,
> Namhyung

Thanks for our feedback.
Well regarding the use of systemd daemon-reexec the manual says
this command restarts the systemd triggered processes.
There is nothing to reset. All ports stay active while the command
is processed.

I tried your 'perf test -w thloop`, but that did not trigger
anything on system.slice.

I do not understand enough about cgroups and system.slice, but I am
under the impression, that the system.slice just increment counters
when executed by processes under systemd control. Maybe I am wrong.

The only other workload which always incremented system.slice counters
was 'ssh localhost ls -l', which involves local login and a running sshd.

Thanks for your advice on how to continue on this.


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


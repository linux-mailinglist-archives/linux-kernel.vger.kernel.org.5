Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63822804B01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbjLEHR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344522AbjLEHR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:17:57 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD70124;
        Mon,  4 Dec 2023 23:18:03 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B57GpM3003171;
        Tue, 5 Dec 2023 07:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=w7s5uPnQeAOXaXsUxQOrmvA9KHnUaXjaxqKSnCdyQIw=;
 b=CPRZYmhakiIMEMgoPt/MYG5oAcdDL5xmeFj+0gr5/Go7uJe9CTr19mKpQRNp1UUvengV
 6ID2L1LpqekhWO/liT1DwHViTR+ctxtLMXYaJpIBtTrp/xxpf9cGtNanj2c7M/7vgNDm
 kp3mvuzZNum1bxKbZomc53T3Q3NmKHGH8YQUBKdw5d5LnO1cYbDi1C68BkzIGYgmqMon
 twZBCSOc0anWbptBbyi7DduIVgpm/L+H6awbALRkdAkvLkR8jl4Q58EHAnSnwO+qXq5Z
 Oqnudr5tNiqVvIWzlpl0uYSXrEXXj4yRlpTylp7bOuqvGIabZD4ywC9kHIjXOrQdkUCt VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usxhs1qct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 07:17:47 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B57HI36006621;
        Tue, 5 Dec 2023 07:17:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usxhs1qbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 07:17:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B56Y5de009423;
        Tue, 5 Dec 2023 07:17:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urh4kcrwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 07:17:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B57HhbR41222800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2023 07:17:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73E3D20043;
        Tue,  5 Dec 2023 07:17:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 344712004B;
        Tue,  5 Dec 2023 07:17:41 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.215.218])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Dec 2023 07:17:41 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 36/48] perf annotate-data: Introduce struct data_loc_info
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CAM9d7cgdUfdMnhmMpqnkpJyV5hJE9dgGuwPetSNM0KfDuYfs6A@mail.gmail.com>
Date:   Tue, 5 Dec 2023 12:47:29 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A9408B2-46A8-45B2-BC0E-A4187F7AD462@linux.vnet.ibm.com>
References: <20231012035111.676789-1-namhyung@kernel.org>
 <20231012035111.676789-37-namhyung@kernel.org>
 <852644CC-CF12-475A-A7D2-84EFDCE9D248@linux.vnet.ibm.com>
 <CAM9d7cgdUfdMnhmMpqnkpJyV5hJE9dgGuwPetSNM0KfDuYfs6A@mail.gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: whYKbKwFFwRWzv8QG3yHaOtTYtkmXf3g
X-Proofpoint-GUID: y7LkMEuwxQ1rA9fqgBMoWaM-p1VIBX_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=851 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312050058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 05-Dec-2023, at 5:40=E2=80=AFAM, Namhyung Kim <namhyung@kernel.org> =
wrote:
>=20
> Hello,
>=20
> On Sun, Dec 3, 2023 at 8:22=E2=80=AFAM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
>> Hi Namhyung,
>>=20
>> I have a thought there. For the type and typeoff sort keys to work, =
we depend on Dwarf support in perf, right ?
>> If the perf is built without dwarf support ( either due to older =
elfutils or missing libdw.h ) , find_data_type will return NULL and we =
will get =E2=80=9Cunknown=E2=80=9D for Data Type and Data Type Offset in =
the result.
>=20
> Yes, right.
>=20
>>=20
>> Can we add a pr_debug line in find_data_type (which is in else part =
for HAVE_DWARF_SUPPORT) so that user can understand if =E2=80=9Cunknown=E2=
=80=9D is due to missing devel during the build ? Or may be restrict -s =
type,typeoff if dwarf support is missing ?
>=20
> I think it's better to add a warning if DWARF is not supported.
> Thanks for your review!

Sure, having a warning if DWARF is not supported will help

Thanks
Athira
>=20
> Namhyung


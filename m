Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E2B804B33
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjLEHdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjLEHdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:33:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6046CB;
        Mon,  4 Dec 2023 23:33:41 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B57Jwba025175;
        Tue, 5 Dec 2023 07:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=88QIzSmoE77AlK3/7os4EVND1aLypF6I6TOzuGTEaL4=;
 b=dnmFgDZZLCv2rxJy7y3kH9DD1dvbonl2XzQA4A3/o1Cb8HRNUqAWEAqEMnPdDNI8Wb9Q
 KhHCynceumu7WtGkLL6XIGitv+7nyhtnKsV4XjZnF/mPW/hi6h7Jl51oJW6irlpNfH+s
 InXGfaCNpAB/VXkjWdRdzKQrnwvC6sTk3DQZTlkC55AWRyMwFuwoAiJczefpRZ+hyf8G
 jZHiorBroMnT2FCTiGWa7rCcMvEEp9oLnL3Wo0jq/1H3xx3NhDGoI3wUTP8n0o7QYwAi
 3Md31vOtseXhNYMYIzPmdhQdFkzF7IyH8ONLa02dHmj2Lh8PULtzu1Sp22LBGtQujIYW CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usycegcvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 07:33:22 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B57K2AL025418;
        Tue, 5 Dec 2023 07:33:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usycegcuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 07:33:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B57IllY011345;
        Tue, 5 Dec 2023 07:33:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urv8b208d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 07:33:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B57XIm912190418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2023 07:33:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C23F320040;
        Tue,  5 Dec 2023 07:33:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9C8220043;
        Tue,  5 Dec 2023 07:33:16 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.215.218])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Dec 2023 07:33:16 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2 1/4] perf build: Shellcheck support for OUTPUT
 directory
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ZW4sRL0vPofcoS43@kernel.org>
Date:   Tue, 5 Dec 2023 13:03:05 +0530
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C33887F-8A88-4973-8593-7936E36AFCE1@linux.vnet.ibm.com>
References: <20231129213428.2227448-1-irogers@google.com>
 <CE3EBC99-B6B0-4DD5-A88E-26B28B1A4A46@linux.vnet.ibm.com>
 <ZW4sRL0vPofcoS43@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aGMfh_fzvvUVcN1N3kJzHcwFydMzWulY
X-Proofpoint-GUID: FV6jQcUfDmHHQgY13Rcu_O6VJQUTbMhH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 05-Dec-2023, at 1:15=E2=80=AFAM, Arnaldo Carvalho de Melo =
<acme@kernel.org> wrote:
>=20
> Em Fri, Dec 01, 2023 at 11:49:59AM +0530, Athira Rajeev escreveu:
>>=20
>>=20
>>> On 30-Nov-2023, at 3:04=E2=80=AFAM, Ian Rogers <irogers@google.com> =
wrote:
>>>=20
>>> Migrate Makefile.tests to Build so that variables like rule_mkdir =
are
>>> defined via Makefile.build (needed so the output directory can be
>>> created). This requires SHELLCHECK being exported and the clean rule
>>> tweaking to remove the files in find.
>>>=20
>>> Change find "-perm -o=3Dx" as it was failing on my Debian based =
Linux
>>> kernel tree, switch to using "-executable".
>>>=20
>>> Adding a filename prefix of "." to the shellcheck log files is a =
pain
>>> and error prone in make, remove this prefix and just add the
>>> shellcheck log files to .gitignore.
>>>=20
>>> Fix the command echo so that running the test is displayed.
>>>=20
>>> Fixes: 1638b11ef815 ("perf tools: Add perf binary dependent rule for =
shellcheck log in Makefile.perf")
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>=20
>> Hi Ian,
>>=20
>> Changes looks good to me.
>> Tested with make, make clean, make with shellcheck error, make with =
NO_SHELLCHECK
>>=20
>> Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>=20
> Next time please reply with your Reviewed-by to the cover letter, so
> that b4 stamps your reviewed-by to all the patches and not just to the
> patch that you replied to.
Hi Arnaldo,

Ok Sure.
>=20
> This time I'll take the plural in "Changes look good to me" to signify
> that you reviewed the whole series, ok?

Yes, please add my Reviewed-by for the whole series.

Thanks
Athira
>=20
> - Arnaldo



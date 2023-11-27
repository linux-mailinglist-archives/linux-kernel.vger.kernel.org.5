Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB067F9AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjK0HTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjK0HTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:19:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99471122;
        Sun, 26 Nov 2023 23:19:40 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR75i7x008786;
        Mon, 27 Nov 2023 07:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZC25i0ucH08wXwMAWmTMiJ+MH1UDzBh+RZ+RL/+21c8=;
 b=V3dDIYMg0k0opwtcgpqini96y93E7Be9UiW0yB+1Asf04J5naIXNkQz/1G2es6zEp7yf
 zwzPFak8JWntDAvYoQeOpDhti6u6HgcZ04CF9IpKzBKneKdCKQzQ+GueP+NvXn8swSPp
 ooKqV2laFFEOA3HXpSWNgHu4aXB04bfOkDTHf/galLtznWavHsEZ2U9lhueiVvrGxMwS
 335cMsCY5YXQI8PYmnRn/TjbHx/ZmxIzax2zDNJGECQOrimDcMy8pIOYTctG75E1wWiX
 hEiieCSwuLjorlJnARj/ogoTL2RKqfulNCCf6917zM8t56EKYHjGD09/gaqdS3PYD3bR dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umdd2t510-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 07:19:31 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AR6fB3x032128;
        Mon, 27 Nov 2023 07:19:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umdd2t509-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 07:19:30 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR44GbR029807;
        Mon, 27 Nov 2023 07:19:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumy7687-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 07:19:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AR7JRhP38535628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 07:19:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D41020049;
        Mon, 27 Nov 2023 07:19:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F07D20040;
        Mon, 27 Nov 2023 07:19:25 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.214.114])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 27 Nov 2023 07:19:24 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH 0/8] perf tests: Reduce inexplicable test failures
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ZV9cgN3e7jWcRwlu@kernel.org>
Date:   Mon, 27 Nov 2023 12:49:13 +0530
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tinghao Zhang <tinghao.zhang@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Message-Id: <5B01AC52-3A95-48E2-BBA8-EC499DFFDFC3@linux.vnet.ibm.com>
References: <20231123075848.9652-1-adrian.hunter@intel.com>
 <ZV9cgN3e7jWcRwlu@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ug47KixhMHkIAsuHNB6ZD-hFW0qfckcN
X-Proofpoint-ORIG-GUID: DBhmPLi-gWgL8TKkOys5wAwE_8s2wb9f
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_05,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 23-Nov-2023, at 7:36=E2=80=AFPM, Arnaldo Carvalho de Melo <acme@kernel=
.org> wrote:
>=20
> Em Thu, Nov 23, 2023 at 09:58:40AM +0200, Adrian Hunter escreveu:
>> Here are some small changes to help reduce inexplicable perf test failur=
es.
>=20
> Looks ok, applying to perf-tools-next, had to remove a patch adding a
> new test, by Kan Liang, then reapply it on top of your series, git
> managed to sort it out:

Hi Arnaldo,

I didn=E2=80=99t find this in either of these places:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=3Dper=
f-tools-next
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/lo=
g/?h=3Dperf-tools-next

Sorry if I missed checking correct location. Can you please point to git li=
nk ?

Thanks
Athira
>=20
> https://lore.kernel.org/r/20231107184020.1497571-1-kan.liang@linux.intel.=
com
>=20
>=20
> - Arnaldo


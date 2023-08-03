Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C155A76E133
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjHCHYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjHCHYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:24:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7782728;
        Thu,  3 Aug 2023 00:24:19 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3737CHr6020247;
        Thu, 3 Aug 2023 07:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=mQnhgyER8GBgfYUBL8z7TlFGJvwgG0B8IuItlBiT9ps=;
 b=N4n4DDN8rwPKRH84PLe7qFu3drAoHgrwS/7AJNPYb5FD4CTNZTImNirwZrS+LgISfrsA
 maIdH5zvnMFMTwluMqEcxX3T/AzxKjRLKfFJFQ/gjEpB2PvH6c+ZVYnqC1zaA1FMAW1H
 IQ0dSEafXqFoqM8FyTtSmwhuXrmrK9gPDpetonn3a5RVz3FSLFlncuUc3QfrD3HIS6OE
 pZ+rbel48Wq7DvRSTfN2S43ajaOGMWAmfRkc0KM2nVivp+meHLR+aCc5jglLdwXu/ugm
 vhwdIBbwI6qGWVhpqUzfNO7Eb1RL7DWdwM3AXq2ylLY7JwcCMNPzRPyQ9rJ3aXh2vPWa EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s87n20bwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 07:24:11 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3737DNws025675;
        Thu, 3 Aug 2023 07:24:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s87n20bvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 07:24:11 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37356u2Y006099;
        Thu, 3 Aug 2023 07:23:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5d3suyg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 07:23:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3737N74v43712786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Aug 2023 07:23:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1056A2004B;
        Thu,  3 Aug 2023 07:23:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B113120049;
        Thu,  3 Aug 2023 07:23:03 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.51.166])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Aug 2023 07:23:03 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 1/1] perf tests task_analyzer: Check perf build options
 for libtraceevent support
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <4qqzt2g2iuo2kri54jyr7tspfxfod4nzsuzajxk3butoxs2rww@rj4quuzpoeg3>
Date:   Thu, 3 Aug 2023 12:52:50 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD9DB9F2-B277-4CAC-8FA5-9B8F970A2F88@linux.vnet.ibm.com>
References: <20230725061649.34937-1-adityag@linux.ibm.com>
 <ZMPWk5K63tadmDlU@kernel.org>
 <CAP-5=fW1zkpJ4zr4ngz=6bZQuE6hOHo4AtXwUsVJK9oiDSc_mg@mail.gmail.com>
 <ZMQJKmV3XtwtZJtO@kernel.org>
 <4qqzt2g2iuo2kri54jyr7tspfxfod4nzsuzajxk3butoxs2rww@rj4quuzpoeg3>
To:     Aditya Gupta <adityag@linux.ibm.com>
X-Mailer: Apple Mail (2.3731.500.231)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CmvHsLTZrtxyX6UJU0ojm84U5aqh6M3O
X-Proofpoint-GUID: Jxt5LV32kCn4XDz3-m4Onv9wELHGeeNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_05,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 03-Aug-2023, at 8:33 AM, Aditya Gupta <adityag@linux.ibm.com> =
wrote:
>=20
> Hi Arnaldo,
> I am working on a patch for 'perf version --has', and will send a =
patch next

Hi Aditya,

I believe, it will be =E2=80=9Cperf build =E2=80=94has=E2=80=9D option. =
And not =E2=80=9Cperf version =E2=80=94has=E2=80=9D  ?

Thanks
Athira
> week using that instead of 'perf version --build-options'.
>=20
> You can skip this patch if not needed.
>=20
> Thanks,
> - Aditya G


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2324790BB9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbjICLyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjICLyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:54:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0470C11D;
        Sun,  3 Sep 2023 04:54:20 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383Bo8oM032397;
        Sun, 3 Sep 2023 11:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=U60Ko/vDXCR/KHZtcvfK5O0nVYP5xS42HAqoAERab60=;
 b=sqtJVB9iQHMW9toUroB6MONHtBCiFLO3IATD/BSaCKDS2yIFg+szKMfMdWqifjpospXm
 EBwu+ucLxSIPDrBVNrFPTL8lyhL9x3JGyvngParBH8R9By1Y2MmZKPJ0cVUE0fbG+qKH
 fpZuF0tvOPXd4+H8kkMcxBfT/edZq3rTz5CUu9S67E53zYmTFAd7sGt9IQc/gA3ikDYA
 RN9jUhavkCTCudm0fe8UghyqMV5m3Tl+WUvLwZXVs2CVcdutHZKqwskdZeWW/V9RnvIU
 r0+fkTVU1/Bil1Va0roVzOJHqwSZRoyCyZiiUVylFY6x+Wvt2AvQsMp0fwbJCmA3nqGj vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3svsm6r195-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 11:54:12 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 383BqDpA005301;
        Sun, 3 Sep 2023 11:54:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3svsm6r192-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 11:54:11 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3838uMOu012217;
        Sun, 3 Sep 2023 11:54:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkjajg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 11:54:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 383Bs8ed25428572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Sep 2023 11:54:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 325C62004D;
        Sun,  3 Sep 2023 11:54:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC9BD20043;
        Sun,  3 Sep 2023 11:54:05 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.171.15.154])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun,  3 Sep 2023 11:54:05 +0000 (GMT)
Date:   Sun, 3 Sep 2023 17:23:52 +0530
From:   Aditya Gupta <adityag@linux.ibm.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Introduce perf build subcommand
Message-ID: <u754ryppddl3rqhadhchgily7yb5idjuhriqzohjwfkzooeqoa@qxumwwhym555>
References: <20230825061125.24312-1-adityag@linux.ibm.com>
 <CAM9d7cgBJ1WHRuVcZ4FArm=pctbs-npLB2Q8PLZWmdfaK3dCzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM9d7cgBJ1WHRuVcZ4FArm=pctbs-npLB2Q8PLZWmdfaK3dCzg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jJpuN0uaI3HwO4G2-V_jT3OKlATsphXv
X-Proofpoint-GUID: -xXfUdUzqs38kRD5dK9wCWdOmJcQGI-Q
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-03_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=643 malwarescore=0 clxscore=1015
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309030108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Namhyung,

On Fri, Aug 25, 2023 at 10:07:28AM -0700, Namhyung Kim wrote:
> On Thu, Aug 24, 2023 at 11:11 PM Aditya Gupta <adityag@linux.ibm.com> wrote:
> >
> > The Problem
> > ===========
> >
> > Currently the presence of a feature is checked with a combination of
> > perf version --build-options and greps, such as:
> >
> >     perf version --build-options | grep " on .* HAVE_FEATURE"
> >
> > Proposed solution
> > =================
> >
> > As suggested by contributors in:
> > https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
> >
> > Introduce a subcommand "perf build --has", with which
> > scripts can test for presence of a feature, such as:
> >
> >     perf build --has HAVE_FEATURE
> >
> > The usage of "perf version --build-options | grep" has been replaced in two
> > tests, with "perf build --has" command
> 
> I'm not sure 'perf build' is a good name, it sounds like it needs to build
> something.  Maybe 'perf check --feature XXX' ?
> 
> Then we can extend the perf check command to *check* system
> settings like perf_event_paranoid, kptr_restrict, nmi_watchdog
> and so on, and possibly provides some advice or even change
> the values easily.
> 
> What do you think?

Thanks for the suggestion, we agree with it.
I have sent the updated patch series, but it's again from V1 since the subcommand changed.

Patch series: https://lore.kernel.org/linux-perf-users/20230903114721.190733-1-adityag@linux.ibm.com

Thanks,
Aditya Gupta


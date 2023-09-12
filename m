Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D914B79C650
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjILFqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjILFq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:46:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A63E6F;
        Mon, 11 Sep 2023 22:46:25 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C4kuO9011491;
        Tue, 12 Sep 2023 05:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=FZnZg6gWoWy1jLYwU44VIs9tT6pXXAg6VPZhyPwDgZ0=;
 b=rZUgcCk8Jj30YSSMenAM7MTQbiAf3lNUBLrd3H1s0yfEW7ndzORVrd215yoJ/AsB7uBo
 EQhSoFWOxsYVxjU/yvvscp/NX+4yEXmw3WF4rZLZcpr2ffze9bN4PzqXUfQmTqkg5moB
 rLn2p1PH+wcNkTBNqZqWuHbDGuvDaVY3YXKsPyVndDtOJZrxLMA1uQoUrX9X2vyxvEpT
 92aWQxeB0CmVL+yxR3vse7l6cUUvwofF2+HwRMCCsWAo9gSc0TkE0HubK8DEiCJHWZ0t
 6acns8oUYRu4yCNBve7an8K/agB4gG5IV1d7UbxeHuk865iow/m7UCbnzG3vaPzEZG9s fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2h8xsjnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 05:46:22 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38C5jSr2029981;
        Tue, 12 Sep 2023 05:46:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2h8xsjkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 05:46:22 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38C4t6fQ024034;
        Tue, 12 Sep 2023 05:46:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t131t0xvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 05:46:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38C5kDdc20972264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 05:46:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B37CD20043;
        Tue, 12 Sep 2023 05:46:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE9820040;
        Tue, 12 Sep 2023 05:46:11 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Sep 2023 05:46:11 +0000 (GMT)
Date:   Tue, 12 Sep 2023 11:16:09 +0530
From:   Aditya Gupta <adityag@linux.ibm.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf tests task_analyzer: use perf check for
 libtraceevent support
Message-ID: <kondzija2p2qdahlqib5mmmfda2ecogyhrpj7r7cyskj7vm6kb@4q6c7akd3kgz>
References: <20230903114721.190733-1-adityag@linux.ibm.com>
 <20230903114721.190733-4-adityag@linux.ibm.com>
 <CAM9d7chkvhnfhZo+Whypg40Vik3XiuvbKWZ_3jF0Zpsj+6JfqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chkvhnfhZo+Whypg40Vik3XiuvbKWZ_3jF0Zpsj+6JfqA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: avwWKvYsEwCx3G5wP8rb4-Le-9xMRaq6
X-Proofpoint-GUID: Nv_tR2yjRiK0D4JMh4-puUSidKbIlL-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,
Sorry for the late reply.

On Thu, Sep 07, 2023 at 02:32:22PM -0700, Namhyung Kim wrote:
> On Sun, Sep 3, 2023 at 4:47 AM Aditya Gupta <adityag@linux.ibm.com> wrote:
> >
> > Currently we use output of 'perf version --build-options', to check whether
> > perf was built with libtraceevent support.
> >
> > Instead, use 'perf check --feature libtraceevent' to check for
> > libtraceevent support.
> >
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >  tools/perf/tests/shell/test_task_analyzer.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
> > index 92d15154ba79..8fbc33c95025 100755
> > --- a/tools/perf/tests/shell/test_task_analyzer.sh
> > +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> > @@ -52,8 +52,8 @@ find_str_or_fail() {
> >
> >  # check if perf is compiled with libtraceevent support
> >  skip_no_probe_record_support() {
> > -       perf version --build-options | grep -q " OFF .* HAVE_LIBTRACEEVENT" && return 2
> > -       return 0
> > +       perf check --feature libtraceevent >/dev/null && return 0
> 
> Maybe we can add -q/--quiet option to silent messages.

Nice idea, thanks. Will do so.

Thanks
- Aditya Gupta

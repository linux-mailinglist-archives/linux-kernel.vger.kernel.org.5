Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC0D767CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjG2Hj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjG2Hj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:39:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C413C00;
        Sat, 29 Jul 2023 00:39:56 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36T7bW0Z017595;
        Sat, 29 Jul 2023 07:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2VfDGxCbb83n8VauqKQzoJjykpZeZRnflE5GwH/NBIs=;
 b=MCw5e/8XpaVEEARzwiYzNvOHVWPLaW8XnWOGPY+7hQLs32KVpHeWH0gwldojEPA3Eg01
 rPb1krXhKFnXthkGoA++9E/KBJaC9vN6bz5rfcHdsxf3eXLsIe4HYO1WPSr3rl90WLhI
 o8bKedgMtSgO8So/M4gvKWYaxhkiyv4m0iVTSbRCATKiaPuEQT37b4CwWiSf6UcDq1xI
 5SFqX25jPyQ69tTJ/GUMct0OHohiK+4un/X4I7iN2ZlOQkyoFaJUttEXkhA1XVgjqINX
 Rm2uwqag963nqaIc5ZlD0QgPdI9eBSKGuCMLB4SveVIHvezyYwztUHBy0W6QuOGl9ukO pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4w371hbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jul 2023 07:39:51 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36T7cKaU022852;
        Sat, 29 Jul 2023 07:39:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4w371h8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jul 2023 07:39:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36T5DQxs002381;
        Sat, 29 Jul 2023 07:39:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0txkvmp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jul 2023 07:39:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36T7dkfs28770998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jul 2023 07:39:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BF5F2004D;
        Sat, 29 Jul 2023 07:39:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7F4A20043;
        Sat, 29 Jul 2023 07:39:42 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.171.39.127])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 29 Jul 2023 07:39:42 +0000 (GMT)
Date:   Sat, 29 Jul 2023 13:09:37 +0530
From:   Aditya Gupta <adityag@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] perf tests task_analyzer: Check perf build options
 for libtraceevent support
Message-ID: <3gmwq3qbe3lpcpvzwfaliyipoe7qrmqbbwd4fhsv7dj6q3kwpo@4g226sr4pm62>
References: <20230725061649.34937-1-adityag@linux.ibm.com>
 <ZMPWk5K63tadmDlU@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMPWk5K63tadmDlU@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NK3UGcF_Ck9HkJYSzCM1FNV7-vZZh2DI
X-Proofpoint-ORIG-GUID: fRVJp-x3uciIRgJT9hqlmjRrAUrJN6QW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307290068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 11:54:11AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 25, 2023 at 11:46:49AM +0530, Aditya Gupta escreveu:
> > Currently we depend on output of 'perf record -e "sched:sched_switch"', to
> > check whether perf was built with libtraceevent support.
> > 
> > Instead, a more straightforward approach can be to check the build options,
> > using 'perf version --build-options', to check for libtraceevent support.
> > 
> > [...]
> > 
> > diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
> > index 0095abbe20ca..a28d784987b4 100755
> > --- a/tools/perf/tests/shell/test_task_analyzer.sh
> > +++ b/tools/perf/tests/shell/test_task_analyzer.sh
> > @@ -52,7 +52,7 @@ find_str_or_fail() {
> >  
> >  # check if perf is compiled with libtraceevent support
> >  skip_no_probe_record_support() {
> > -	perf record -e "sched:sched_switch" -a -- sleep 1 2>&1 | grep "libtraceevent is necessary for tracepoint support" && return 2
> > +	perf version --build-options | grep HAVE_LIBTRACEEVENT | grep -q OFF && return 2
> >  	return 0
> 
> I'll apply this, but please consider adding a:
> 
> 	perf build --has libtraceevent
> 
> subcommand to have that query made more compact and to avoid the two
> extra grep.

Okay. As you suggested in another reply, I found the code in builtin-version.c,
we can have a "perf build --has" option which can use the `IS_BUILTIN` macro
also used by "perf version --build-options". It can support all other feature
flags too.

You can implement it or I can work on a patch for that ?

It should require adding another 'struct option' to 'version_options', and
check for the flag in 'cmd_version()'. Will have to look how to get the string
passed after '--has'.

> 
> BTW, I'll change that to:
> 
> [acme@quaco perf-tools-next]$ perf version --build-options | grep " on .* HAVE_LIBTRACEEVENT"
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> [acme@quaco perf-tools-next]$
> 
> replacing "on" with OFF, so that we have just one grep.

Okay.

Thanks,
- Aditya G


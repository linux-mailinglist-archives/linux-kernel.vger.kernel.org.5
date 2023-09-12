Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E04579C65B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjILF5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjILF5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:57:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE6E6F;
        Mon, 11 Sep 2023 22:57:40 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C5nvLd006944;
        Tue, 12 Sep 2023 05:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=tiLlEW0hqey0fEnHiXksofOQBtxKFD6W0rRJdfJPtdk=;
 b=eYWeRwhWRWNyoEj9E0rAXtEG38M9Q2ziiBZeIpS5zvIdEtCqwWqiQbaREI5TuNZJ/2KS
 yUSPmm7RYeuujEpLv/QXSHgYltv8H2ZhB8IzDna0cf6hSZvsyMsGjFbR0JrcixVnBcne
 4ePSoMucmYJgR1uFh0Ohr10bXWddHzgmmAoVDAyuar2w0fQExC7qxziUXxjv5mt7JOfo
 LaZYLCmEFiwTQYRxAY9sjPMxOZ4r9iZ/88hmxD28MwlhqdzTwMVEL4HiyKHywzSltz3s
 sp45NqXZ0avwETosXlKwEpdpn0aRG+a15Y1sdq5LQrz3x/7nl/eAJ+YHfMIRVjubsGVF cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2j6er4qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 05:57:36 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38C5nwB9006973;
        Tue, 12 Sep 2023 05:57:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2j6er4qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 05:57:36 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38C3U68A023152;
        Tue, 12 Sep 2023 05:57:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t141ngnb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 05:57:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38C5vVkL26608150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 05:57:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B89CD20043;
        Tue, 12 Sep 2023 05:57:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6BF620040;
        Tue, 12 Sep 2023 05:57:29 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Sep 2023 05:57:29 +0000 (GMT)
Date:   Tue, 12 Sep 2023 11:27:27 +0530
From:   Aditya Gupta <adityag@linux.ibm.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] perf check: introduce check subcommand
Message-ID: <67yfeb4jl24db7ge5eav3ejmhroxdov34sbhppnwlmzm33o2gp@uluvdbfezg5d>
References: <20230903114721.190733-1-adityag@linux.ibm.com>
 <20230903114721.190733-2-adityag@linux.ibm.com>
 <CAM9d7cip5Sm9cJdJHN4gvC+9zBTDjywmdHLK2A457Z8K1Po0vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cip5Sm9cJdJHN4gvC+9zBTDjywmdHLK2A457Z8K1Po0vg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dBx9m_AMjNP0atCyo3RL1LditDhOCY-3
X-Proofpoint-ORIG-GUID: 7KB-e5KwTl4wyW8h8ma7j0Pgz_eBlhYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Namhyung,
Sorry for the late reply, was busy last week.

On Thu, Sep 07, 2023 at 02:31:29PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Sun, Sep 3, 2023 at 4:47 AM Aditya Gupta <adityag@linux.ibm.com> wrote:
> >
> > ...
> >
> > +/**
> > + * check whether "feature" is built-in with perf
> > + * returns:./perf annotate --data-type --type-stat -k vmlinux -d '[kernel.kallsyms]' --objdump=llvm-objdump
> > + *   -1: Feature not known
> > + *    0: Built-in
> > + *    1: NOT Built in
> > + */
> > +static int has_support(const char *feature)
> > +{
> > +       int res = -1;
> > +
> > +       for (int i = 0; supported_features[i].name; ++i) {
> > +               if ((strcmp(feature, supported_features[i].name) == 0) ||
> > +                       (strcmp(feature, supported_features[i].macro) == 0)) {
> > +                       res = supported_features[i].is_builtin;
> > +                       STATUS(supported_features[i]);
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (res == -1) {
> > +               color_fprintf(stdout, PERF_COLOR_RED, "Feature not known: %s", feature);
> > +               return -2;
> 
> return -1 ??  It doesn't match with the comment.
> 

Thanks for pointing this. Yes, it should have returned -1, I made a mistake in
this.

> 
> > +       }
> > +
> > +       return !res;
> > +}
> > +
> > +int cmd_check(int argc, const char **argv)
> > +{
> > +       argc = parse_options(argc, argv, check_options, check_usage,
> > +                            PARSE_OPT_STOP_AT_NON_OPTION);
> > +
> > +       printf("perf check %s\n", perf_version_string);
> > +
> > +       if (check.feature)
> > +               return has_support(check.feature);
> > +
> > +       return 0;
> > +}
> > diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> > index f2ab5bae2150..6683ea6d3b60 100644
> > --- a/tools/perf/builtin.h
> > +++ b/tools/perf/builtin.h
> > @@ -2,6 +2,52 @@
> >  #ifndef BUILTIN_H
> >  #define BUILTIN_H
> >
> > +#include <stddef.h>
> > +#include <linux/compiler.h>
> > +#include <tools/config.h>
> > +
> > +struct feature_support {
> > +       const char *name;
> > +       const char *macro;
> > +       int is_builtin;
> > +};
> > +
> > +#define FEATURE_SUPPORT(name_, macro_) { \
> > +       .name = name_,                       \
> > +       .macro = #macro_,                    \
> > +       .is_builtin = IS_BUILTIN(macro_) }
> > +
> > +static struct feature_support supported_features[] __maybe_unused = {
> 
> Hmm.. do you want it in a header file?
> I'm afraid it'd duplicate the entire array for any .c files that
> include this header.
> 

Hmm.. I agree that it duplicates the array in all those c files.

Should I define 'supported_features' same way in perf.c, and then use
'extern struct feature_support supported_features[]' in builtin.h ?

> 
> > +       FEATURE_SUPPORT("dwarf", HAVE_DWARF_SUPPORT),
> > +       FEATURE_SUPPORT("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
> > +#ifndef HAVE_SYSCALL_TABLE_SUPPORT
> 
> Do we really need this #ifndef?

Not really, will remove this in next version. It was this way in
'perf version --build-options' so I just kept it that way.

Thanks,
Aditya Gupta

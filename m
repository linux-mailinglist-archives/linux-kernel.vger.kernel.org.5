Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112D677DCFC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243219AbjHPJJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjHPJJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:09:00 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816761FC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:08:59 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G8vvVQ016284;
        Wed, 16 Aug 2023 09:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=m9NJXJg+PF9lp0cCAnigukkIHa2Iqv41yOUlO4r6Lio=;
 b=gd7m6+sJM/yTD9Mgm9a2nSXIufQuEfzvUIm3+tlrz3nRfsO6kXkjh1GOeMJ/GIx01kNf
 R2oiqtxLpDWeUCiTeNhGhdG3FbIdNQOTfLpwfGVw2MXhDuTwAX+xWbkmk7na+A0gJt5s
 W4ikaubv2woArpBsD3RJm+1hAAd4JR3Jk8EqIrkiSbW2l0v/RLxv96d3/4MKMbrIH3xF
 gpC3QIsvPH59ofNQ2CifLfppFB7/GkkVcy1xZGdWlzK1jlPBfVHv6buU0XBwDWWuHVQ4
 zpXH7UuyIJaIcmJWjpgQJ7ngGbm39TWyyQp60U4rQQAGQlk1Tk/i0ZIXgvJx2GsHNR5Q ew== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgude8eys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 09:08:57 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37G7IGRJ013240;
        Wed, 16 Aug 2023 09:08:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmjtpn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 09:08:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37G98quu15729396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 09:08:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99D622004B;
        Wed, 16 Aug 2023 09:08:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7607D20043;
        Wed, 16 Aug 2023 09:08:52 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 09:08:52 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] few fixes for synthetic trace events
References: <20230810060538.1350348-1-svens@linux.ibm.com>
Date:   Wed, 16 Aug 2023 11:08:52 +0200
In-Reply-To: <20230810060538.1350348-1-svens@linux.ibm.com> (Sven Schnelle's
        message of "Thu, 10 Aug 2023 08:05:35 +0200")
Message-ID: <yt9dcyzn9wwr.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HTJsd4y80ILPnZH-PQWGIm_iT7lAfZxv
X-Proofpoint-ORIG-GUID: HTJsd4y80ILPnZH-PQWGIm_iT7lAfZxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_07,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schnelle <svens@linux.ibm.com> writes:

> Hi Steven,
>
> I'm now sending these patches in one patchset, because the second patch
> has a dependeny on the union vs. cast fix.
>
> Changes in v3:
> - remove superfluous struct around union trace_synth_field
>
> Changes in v2:
> - cosmetic changes
> - add struct trace_dynamic_info to include/linux/trace_events.h
>
> Sven Schnelle (3):
>   tracing/synthetic: use union instead of casts
>   tracing/synthetic: skip first entry for stack traces
>   tracing/synthetic: allocate one additional element for size
>
>  include/linux/trace_events.h      |  11 ++++
>  kernel/trace/trace.h              |   8 +++
>  kernel/trace/trace_events_synth.c | 103 ++++++++++++------------------
>  3 files changed, 60 insertions(+), 62 deletions(-)

Gentle ping? We're still seeing a lot of KASAN warnings.

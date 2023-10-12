Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1403D7C6B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbjJLK07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjJLK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:26:57 -0400
Received: from qs51p00im-qukt01071902.me.com (qs51p00im-qukt01071902.me.com [17.57.155.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E251EB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1697106415;
        bh=Zm68BCMFb/hYtzGq5UaRnyX7k1qDLFhJZeNJbHCgEJE=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Nj7cKOfldEYblETNZbxkiuE/GWDO1mkPSt29lWUQ28dyqf/1YOTkgt5MZsrVJotCW
         dV8bg3rq4Y8oa9yd5qnq65ge4zQJYEEwPG9RuT/pwlGjuLSrtHavjp0mWQ0/VTSnrv
         EFfw/C60mD5apaVr5LKURwRJ0U1chIamST89LuK0/NgA6RwQS7f3mWuwaFPnKPW1dd
         woXVQNWvfAheYqmmr4+ZMOLX35f1yp8RhISSW+Iwg+7Gdy3UDJdnYyaVQQ7U19vRyv
         zjnGCPBZUMhWayorxg54dmtd+BfdPOBh/PosANSIqBs6zwshIQW3ZIc3nLrMmp2BPq
         h2ZkB05dM7CQA==
Received: from fedora.fritz.box (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01071902.me.com (Postfix) with ESMTPSA id 66A4E5EC02C9;
        Thu, 12 Oct 2023 10:26:52 +0000 (UTC)
Date:   Thu, 12 Oct 2023 12:26:49 +0200
From:   Lucy Mielke <lucymielke@icloud.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/p4: Fix "Wunused-but-set-variable" warning
Message-ID: <ZSfJ6c5fo5enjvv+@fedora.fritz.box>
References: <ZSGpl_hT23B6ix0M@mainframe>
 <20231007203411.GA8085@noisy.programming.kicks-ass.net>
 <ZSQqfr96SfZM_OEk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSQqfr96SfZM_OEk@google.com>
X-Proofpoint-ORIG-GUID: 9pFRWMcEYoBw4AFqbI9oJ7ZVnrKWy-je
X-Proofpoint-GUID: 9pFRWMcEYoBw4AFqbI9oJ7ZVnrKWy-je
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=685 adultscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310120085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Oct 09, 2023 at 09:29:50AM -0700 schrieb Sean Christopherson:
> 
> rdmsr() writes to "high", but nothing ever reads from high.  FWIW, I would _love_
> for rdmsrl() to have return semantics, e.g. to be able to do:
> 
> 	low  = (u32)rdmsrl(MSR_IA32_MISC_ENABLE);
> 
> or even
> 
> 	if (!(rdmsrl(MSR_IA32_MISC_ENABLE) & BIT(7)))

I have taken a look and it seems to me like this macro is called quite a lot
for different things thoughout the kernel tree, including drivers. If
one were to change it to have return semantics instead of the way it
currently works, you'd have to change around 300 occurences, right?
(Let me know if I misunderstood something.)

Return semantics or not, since the only way "high" is used in p4_pmu_init()
is by being written to by rdmsr(), the variable can be completely removed by
just using rdmsrl(). Would this be a patch you'd be interested in?

Mit freundlichen Grüßen / Best regards,
	Lucy

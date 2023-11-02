Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5239D7DF66F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346852AbjKBPdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjKBPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:32:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750E913D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=11BCDEm9879RyNLict0JY9FhBpnez8fFKSpmVHu8wGA=; b=Vevh3VFnrQ+KgRhjOD/bHbtXUI
        KydUwg7U2w34B6ejWy2vTYa0Iq1PbHAeNJmUu4vfA2z0oRg+fJqro12+myXiWhOrg1umyKkVnLS+W
        SIs78CThiaQKIi4AJ93EyzKygwLToa3DphJGKXOOM4rvxBPTx+6BKzF4NABYqN/2PqfixNgozhu/0
        Nip4Mm9HYwPovXxLO46WSWWZtmHKsWgy81FffTWgMpnrhjsMrJSyGW+vN9+KCUOtH5emI4nJcHtmo
        e+QglIbH6A11uL2adeJX+tYsFl4VcI8IL+xg5VGGkSxOQS5K4T4o4JGb9SH2PMyTF4SzdJHs7fgc9
        fwq8W2Ag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyZgV-006gQL-2g;
        Thu, 02 Nov 2023 15:32:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 372D4300202; Thu,  2 Nov 2023 16:32:39 +0100 (CET)
Message-Id: <20231102150919.719936610@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 16:09:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH 00/13] perf: Employ SBRM to simplify error handling -- batch 1/3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These few patches start the process of using Scope Based Resource Management
(SBRM) for the perf core.

As per the subject, I have cut all the patches I have for this into 3 separate
parts so as to not overload you all with some 35+ patches.

I plan to post the next batch in about a week or so, we'll see. I'm hoping we
can get them all merged in time for 6.8.

The full pile can be admired here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/guards


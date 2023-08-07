Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394277728BB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjHGPIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHGPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:08:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2422C1FCE;
        Mon,  7 Aug 2023 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Cc7Qso+rtqYL4z41yt/S7GCvRApv9pu8SfGh30r2Ct4=; b=MKv0W1lCMX7Ig/GFUcBTKF23rP
        kfBI64q+FB4WSJjX6NLuD/+/rI1HuEZYBeNX4bB27POHliDxcoNHoNoWlsu9NHNEwKx6wwKUH/LBO
        fqV+CBH06QCDe0I9F8TZ0t4NMynLzlsPSklN7kaf3+B0oxuZhz1PqzcCXYjfy8Z6Z2XAjLtwJXjBB
        jf/rRReJO/M2ohlj0sKH7G/H4XsMbNe/2MTZh0mqu74JeloE+UbHZR7veW953WyUdAVKlhl6YMdyz
        pPiZMhetJCBDFbwW/n6JlAULYU0CFK0YTLWocYBY27vtMfOvclELTaZho3UbToYjWu3l2gMyc0zbA
        ECZ/gBzQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qT1pP-00BlpC-Vn; Mon, 07 Aug 2023 15:07:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8AB0C30014A;
        Mon,  7 Aug 2023 17:07:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6D7CA2028F056; Mon,  7 Aug 2023 17:07:27 +0200 (CEST)
Message-ID: <20230807123806.700370534@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:38:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        Tony Luck <tony.luck@intel.com>, luto@kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        jacob.jun.pan@linux.intel.com, lenb@kernel.org,
        irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        srinivas.pandruvada@linux.intel.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/3] x86/cpu: Cleanup of INTEL_FAM6_foo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I seem to have missed 'spring' but here goes...


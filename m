Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F997A6BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjIST40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjIST4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:56:23 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B61A28F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:56:16 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 444CA40ECE;
        Tue, 19 Sep 2023 14:56:16 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ZgFTH1fIwPWt; Tue, 19 Sep 2023 14:56:16 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id E89B740F41;
        Tue, 19 Sep 2023 14:56:15 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 3jfNTX4TIJpv; Tue, 19 Sep 2023 14:56:15 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 862F840ECE;
        Tue, 19 Sep 2023 14:56:15 -0500 (CDT)
Message-ID: <a5c505d1-730c-912c-3c83-1df83d8e264b@foxvalley.net>
Date:   Tue, 19 Sep 2023 13:56:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] arch/x86: port I/O tracing on x86
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
References: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
 <20230919194337.GC424@noisy.programming.kicks-ass.net>
From:   Dan Raymond <draymond@foxvalley.net>
In-Reply-To: <20230919194337.GC424@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No, very much no.
> 
> This sticks tracing in the very rawest of raw output paths.

That's the point.  Tracing is a low level debug tool that can be
used to debug the kernel itself.  If you don't trace all port I/O
then you are bound to miss something important while debugging.

> This means I can no longer use early_console->write() to print to my
> early_serial_console.

Why not?  Did you try it?

> That is the one and only fully reliably output path we have. You're not
> sticking tracing in it.

Keep in mind that tracing is optional.  It can be turned off using
CONFIG_TRACEPOINTS.

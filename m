Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BE580BB8B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 15:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjLJOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 09:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 09:09:05 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D5DF3;
        Sun, 10 Dec 2023 06:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702217348;
        bh=yQG9FMKSExq+UqrKqtA7z6rfOEhxv5CjsSfxjoOFKGc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZJ2XbjqK9himh+fH+YjfkR7z5g0yuwyX/4+HU+3o3aCqiVUlP7oi3ve1RDbJYTxXA
         ink4c0if+BfjeY42azfKaPP8MogUVuMlzTHskOCeqxSWu5rhiDxz+mPBhogVgvDC5q
         L0AvS7xOEtTD07AwFlH0EOf/OLlfoq1yAwAQJvT5YmX1YFYtMAA5GQgo5zKHWL3hV3
         54r9etPzTC3EdZXGCVoc5aAK51AwEB6vDygvRg/cZHIhxmKpKf85xhz5kHZLM98Y5N
         UqRgug0gGEBNEPBJdXtI8aS3HR18wACxAc2zK43kPnlCtMF0YG5Gbc5DzrROX2cAGY
         uS8GY+aghcHwQ==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Sp6F02BljzG0H;
        Sun, 10 Dec 2023 09:09:08 -0500 (EST)
Message-ID: <2683467e-cadb-4bb8-8c50-87ef052edacb@efficios.com>
Date:   Sun, 10 Dec 2023 09:09:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Allow for max buffer data size trace_marker
 writes
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20231209175003.63db40ab@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231209175003.63db40ab@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-09 17:50, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Allow a trace write to be as big as the ring buffer tracing data will
> allow. Currently, it only allows writes of 1KB in size, but there's no
> reason that it cannot allow what the ring buffer can hold.

I would expect the tests under tools/testing/selftests/ftrace/* to
be affected by those changes. If they are not, then it's a hole in
the test coverage and should be taken care of as this behavior is
modified.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


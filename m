Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC7980BB8C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 15:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjLJOLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 09:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjLJOLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 09:11:38 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F82FA;
        Sun, 10 Dec 2023 06:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702217500;
        bh=Sx8TXHQnq0Bu4P1ud22ViTYxLo53aYEoyv0Qmlg6phk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f4RYCi4gN3RvYVZWFmIodncah0uu2r/Q+Iu4iGV9zbpu/LA9DVgKSUvy1OGTJoZXS
         bJPPzFFTMj9XtzU+Jqke8xCt29nfo4P8CeA07vNgxzQ1qE5jU1CsGDKBNLq+VlB5LK
         s3nuRn4DSvw7hPVx2fh6i9YQ6aPTNXgd3Lf8LoF/uH8hXO8RB21b2jUlIgmWhN0Boo
         3vyqglorUXcqgwFZaXa9uBgVbm8oOq3BBLfAQlAjXuU/AVF+ki6f5064uThfOIxOmJ
         Jy6gi7yBSAOvS4eSYcpyAr6WyjYVg42XEMJhxSHqUF+qZVSgWD35gRXeC1pj7bZZtQ
         ha+sqDTEOO58g==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Sp6Hw2zm6z1hZ5;
        Sun, 10 Dec 2023 09:11:40 -0500 (EST)
Message-ID: <18d6a5e5-f7a5-4a86-aa0b-eec38652c0d5@efficios.com>
Date:   Sun, 10 Dec 2023 09:11:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Have large events show up as '[LINE TOO BIG]'
 instead of nothing
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20231209171058.78c1a026@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231209171058.78c1a026@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-09 17:10, Steven Rostedt wrote:
[...]
>              <...>-852     [001] .....   121.550551: tracing_mark_write[LINE TOO BIG]
>              <...>-852     [001] .....   121.550581: tracing_mark_write: 78901234

Failing to print an entire message because it does not fit in the
buffer size is rather inconvenient.

It would be better to print the partial line, and end the line with
a <TRUNCATED LINE> tag.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


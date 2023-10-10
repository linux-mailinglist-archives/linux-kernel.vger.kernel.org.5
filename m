Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977357BF35D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442355AbjJJGxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442344AbjJJGx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:53:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E89E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:53:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A44C433C7;
        Tue, 10 Oct 2023 06:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696920807;
        bh=3Xd5odMKBFBnhMasD1TN2er1RvKIMlpFiAWIcG05Rik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xyiq6CUp8XABAFw63iIihqEhIcKBDP9iIDfKNRnLw0bmRew0p3XykDoixzrnGvi0G
         SEOF25klPe33w9qu7OsWH2SBhEGKfgulUt7d52P3R5/bRAIChbNkVBhU1iIayNQAjW
         GBQz8hjeansSE6fVnv84zI32eKMt6riqPd+LX2Fscw9z0glptCyEk36I991coZaCSb
         kCvsRIDD3PCakZPebtj05z47ilhqWZjnV+pAbqRJEPOHsadljzKZ0P19YU6B7YiOlw
         0KxMIwqHBKfMvRzd1cd7+BiNSRN2kPfG+J+MT3qesZwUZ9DrtmaMKreGEYR7dMo5vy
         zxoI3kQ2zPJQA==
Message-ID: <604a8dd9-f891-368a-3b6c-3756ee6f4f35@kernel.org>
Date:   Tue, 10 Oct 2023 08:53:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] Ftrace: make sched_wakeup can focus on the target
 process
To:     Jinyu Tang <tangjinyu@tinylab.org>, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     ttjjyystupid@163.com, falcon@tinylab.org, wangjiexun@tinylab.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231009153714.10743-1-tangjinyu@tinylab.org>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231009153714.10743-1-tangjinyu@tinylab.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 17:37, Jinyu Tang wrote:
> $ cyclictest --mlockall --smp --priority=99 &

rtla timerlat -a <the amount of latency you tolerate>

will give you an structured analysis of your latency...

https://bristot.me/linux-scheduling-latency-debug-and-analysis/

-- Daniel

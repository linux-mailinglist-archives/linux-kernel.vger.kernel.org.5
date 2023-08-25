Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B507887D2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbjHYMx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244902AbjHYMxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:53:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F3D3;
        Fri, 25 Aug 2023 05:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92A8D61598;
        Fri, 25 Aug 2023 12:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212FBC433C7;
        Fri, 25 Aug 2023 12:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692967990;
        bh=6BZoIt0th7mIYU6ghVSvm50hQNhmzHkXM6FJps/g814=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cQyX3v6AltADgNtuIvJ5dcn/eVQ9TjASsQU0/Y7E0XPpLCkOebD5HceBa7KHQyBaZ
         qoUeN+vVuh24HugljXlxKPOkits9KME/Kl45w3HE7VKjeX52xwOUYEE6XffzvN8d9U
         ISvp1lm2q4CAepkLMHOo/mfuDmQI1jdOefD0yNyAd++SzzxFJe5/rI7Y0QWVdk0GlM
         fIADc0Rc8rGJ/UQgBPy2vf90Omw2cJENYGwjipk++gbroEV6/tlHgMFftVywNbkp3P
         S3JVsr1u6LlWWeSCbdX7AFKDmTQsXqjcd6V+pAfTwHENQAC8+RJ/gUm1KK2hSDferW
         +FXLrOi/VhJUw==
Message-ID: <4b25927d-3191-9258-3f06-25fd6bd382a4@kernel.org>
Date:   Fri, 25 Aug 2023 14:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] trace/hwlat: remove extra space at the end of
 hwlat_detector/mode
To:     Mikhail Kobuk <m.kobuk@ispras.ru>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <20230825103432.7750-1-m.kobuk@ispras.ru>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230825103432.7750-1-m.kobuk@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/23 12:34, Mikhail Kobuk wrote:
> Space is printed after each mode value including the last one:
> $ echo \"$(sudo cat /sys/kernel/tracing/hwlat_detector/mode)\"
> "none [round-robin] per-cpu "
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 8fa826b7344d ("trace/hwlat: Implement the mode config option")
> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
> Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel

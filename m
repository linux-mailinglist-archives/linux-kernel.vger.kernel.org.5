Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A1975FFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGXTQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGXTQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:16:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC9F3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:16:33 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id O12kqBAgrZ2imO12kqURSu; Mon, 24 Jul 2023 21:16:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690226192;
        bh=ejbuiYtaaiGg6LrrpuEGWLH5D/477hMA6Nm5r3K1n00=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LluKkc9cY7y/uaYKduRy8jcgbh0N73Jh9+4a0CBrcIV9zCKx/hzNP+kCCtIbob8aV
         mxaulaFub9qaMMs5KQE2GM160p8drgxoPJE1Ne7mxINXC+zsKc4GCS4ce3jyc5/EFs
         dARLL8FcU4yOhNTYLQcC4ItqUJv6rZJ4bqNy7BDaLHlVMGRsJAeWXERoGWKI0z+gay
         gMwTJfZgE0SaYjDG+8CvGkuomUdX00WrILytcAspRil5h8KNey2R9kjoirXMmG+bbk
         rJIm3HPs+wilXT1KnbXKKkpqHteDYlFn/fX2o+S+TF67qB3ALiilFOZe8F9jKMvhbE
         lIxwCtCDojBUg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Jul 2023 21:16:32 +0200
X-ME-IP: 86.243.2.178
Message-ID: <916237e0-02da-6b1d-881c-7fa211bab6b0@wanadoo.fr>
Date:   Mon, 24 Jul 2023 21:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] kstrtox: Remove strtobool()
Content-Language: fr
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <23d2ea6b90579207e87cc1bf64fc4eed1ed9f173.1689885328.git.christophe.jaillet@wanadoo.fr>
 <20230724110520.b250bc244908a40a53bf2da7@linux-foundation.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230724110520.b250bc244908a40a53bf2da7@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/07/2023 à 20:05, Andrew Morton a écrit :
> On Thu, 20 Jul 2023 22:40:35 +0200 Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> 
>> The conversion from strtobool() to kstrtobool() is completed.
>> So strtobool() can now be removed.
> 
> I still have some strtobool()s in mm.git, so I can't apply this.
> 
> Probably nobody can apply this to their tree at this stage.  A resend
> after 6.6-rc1 would be the simplest approach.
> 
> 

Let's do it then.

Note that in -next there is still some strtobool but only in tools/.
I thinks it is ok to leave it as-is.


git grep -w strtobool

tools/include/linux/string.h:int strtobool(const char *s, bool *res);
tools/lib/string.c: *  More specifically, the first copied function was 
strtobool, which
tools/lib/string.c: *  d0f1fed29e6e ("Add a strtobool function matching 
semantics of existing in kernel equivalents")
tools/lib/string.c: * strtobool - convert common user inputs into 
boolean values
tools/lib/string.c:int strtobool(const char *s, bool *res)
tools/perf/util/bpf-loader.c:   err = strtobool(value, &bool_value);


CJ

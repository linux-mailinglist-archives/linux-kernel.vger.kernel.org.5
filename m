Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7AE7BA349
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbjJEPxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjJEPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0467287C1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:46:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696513594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42tl0KPN/Bk5Rmo8LcdKc7+SvXEUS7Jqrg3bxIq0n+E=;
        b=GC+8EvOvVL5DURXQm+J2WQyy1zaQ2QLnBqxYpuqOuPhOvIGF3VBuaNfRdxK1WtcJ5mS9/G
        dsMIUKRRkgwMfaho4ZQCIk/EdSDooECU9C8i/5qu4Dyu5scSFmShTYCIHqpJEKCE7abvmB
        IYRTa3OCqK5A83+kT7IvDyMrLbJ5oG4WruS3kZXeAwUjqktrHEPN6DWa+Pzid9z9odB+U6
        t98QiFWAoH27JREG2UNjdrmAIVsEYGpVOJaXTPQJxz+yks4NWSnCWDtRe6co9jFQwXzvky
        kN1dZLC3WdqA68IT84mjpo2dTmU4hChPhWr1+/CRU9aTkt6JAicQGUoWMM+Zwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696513594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42tl0KPN/Bk5Rmo8LcdKc7+SvXEUS7Jqrg3bxIq0n+E=;
        b=5rRhfG6fcWxCHcdyvNfi5eiaHI6YTGLb8bpBac0WkcvFRQVHBP0GAQL6PaQsQTEILen/8o
        yHMu0dA/yP3ttdDQ==
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nipun Gupta <nipun.gupta@amd.com>
Cc:     maz@kernel.org, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
Subject: Re: [PATCH v4] cdx: add MSI support for CDX bus
In-Reply-To: <2023100531-matron-oversold-4a73@gregkh>
References: <20230911135259.14046-1-nipun.gupta@amd.com>
 <2023100531-matron-oversold-4a73@gregkh>
Date:   Thu, 05 Oct 2023 15:46:34 +0200
Message-ID: <87wmw1p4g5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05 2023 at 12:24, Greg KH wrote:
>> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
>> index a08958485e31..86df7ccb76bb 100644
>> --- a/drivers/cdx/Kconfig
>> +++ b/drivers/cdx/Kconfig
>> @@ -8,6 +8,7 @@
>>  config CDX_BUS
>>  	bool "CDX Bus driver"
>>  	depends on OF && ARM64
>> +	select GENERIC_MSI_IRQ_DOMAIN
>
> This config option isn't in my tree anywhere, where did it come from?
> What is it supposed to do?

13e7accb81d6 ("genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN") :)

> And I really need a msi maintainer to review this before I can take it,
> thanks.

I've put it on my ever growing pile of things to look at.

Thanks,

        tglx

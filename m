Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D627FAEAC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjK0Xrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjK0Xrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:47:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138AE10F0;
        Mon, 27 Nov 2023 15:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=coo1mUhNKEbB7zpzsIDS96POvmXQMHwqPRZiekd+CmI=; b=wB9/gKBqr6F+MhLzrYnNfoBZ0d
        WxMFM3ctnyahkLXi0XuAzxWHwSh8eJP6hHwtZtKgPllQyXL6byFPTyVdeKOdhkY53o977GVzHm+et
        jmqS4QhQp3hje+jNN2ncvX770fUMihH1X+bKEgwVeM8R9ljIVHOVjQNPEAjoFQsCRoyEZkThWO/g3
        IPNBKDD2DvXxMGBKA9XrN2seD0PJh4MQyZ27VdmnCWYnBSM15X526WYOl56QQWZY1XD4wAw2aNcLy
        li6ZGUkudDtKo/9D9KlH53KvFuq0CW5WoOCLd3WiYDemXPNSXi0fmEZjYLSitigEsJ9yOa1LH1zaC
        TQu4ZDnA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r7lJg-003hTz-0m;
        Mon, 27 Nov 2023 23:47:04 +0000
Message-ID: <6e664be1-dc6b-461e-b75d-2be49641402c@infradead.org>
Date:   Mon, 27 Nov 2023 15:47:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] PM: sleep: Expose last succeeded resumed timestamp in
 sysfs
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     suleiman@google.com, briannorris@google.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <170108151076.780347.2482745314490930894.stgit@mhiramat.roam.corp.google.com>
 <170108152012.780347.6355289232990337333.stgit@mhiramat.roam.corp.google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <170108152012.780347.6355289232990337333.stgit@mhiramat.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--


On 11/27/23 02:38, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 

> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index f6425ae3e8b0..2ab23fd3daac 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c

> @@ -514,6 +526,9 @@ static int suspend_stats_show(struct seq_file *s, void *unused)
>  			suspend_step_name(
>  				suspend_stats.failed_steps[index]));
>  	}
> +	seq_printf(s,	"last_success_resume_time:\t%-llu.%llu\n",

The <TAB> after "s," is a bit odd IMO, but I don't see a need to resend it
just for that.

> +		   (unsigned long long)suspend_stats.last_success_resume_time.tv_sec,
> +		   (unsigned long long)suspend_stats.last_success_resume_time.tv_nsec);
>  
>  	return 0;
>  }

-- 
~Randy

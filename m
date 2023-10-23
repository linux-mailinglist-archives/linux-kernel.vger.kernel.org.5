Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703F57D276A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJWAL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJWALx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:11:53 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53190D6;
        Sun, 22 Oct 2023 17:11:51 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5ae99bb5ccdso1224130a12.1;
        Sun, 22 Oct 2023 17:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698019911; x=1698624711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qnX/Fx3frmdqtOqFHwCFZaH5doZ5gfCTfKPTC2KzhBA=;
        b=mUwk/Dg/+6YHzRhEIOUn/nEEi/Y0cAcIYCxeIB1+Q5QpzGyk54VFWc2y5F13sqziYi
         Oxer5gpB6m9Kk8W2VfeOxU3csfFIJsZUoafpYddjwUC/2JVVfNS/oC3h0yfzhIMuPIc+
         dGpHP0en7HGse/xgVFj62CaictLbTJMj7CkkPi7WEq6RmeRu7C/BEDTiEk9y2+pucL9a
         KOVXyNuTXefs6HwAGQia91RAa7WJ1xcBDMUVDY6kK4BXPvNcRyCDGB28w41Q31FuoOQw
         6mHYxymYxbzuTtrIRGvCYLR0t/U0fp27O51XWOq1fUUcv0TmVj9khO/CIKLc6BsE1YIj
         1C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698019911; x=1698624711;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnX/Fx3frmdqtOqFHwCFZaH5doZ5gfCTfKPTC2KzhBA=;
        b=lEWO4S+q6t0tgNBWzruGonAb5Ba20e87Dv5FhBxAOuCv5q7kfgQHHLJIu7VNNmC/iB
         hBCvxSnYydBFPw+WIAoC8zA6Rmi8zgXhuZ/4jxQCo0hZFgWgQUHOUq2vzVO5qE+datNt
         cbsAzhs4njjaTbQP7mYxrLEpjD8BsdP6F7AYOLkz2E9AJAFcV67E9SDpLR9RD96WvIfP
         n1wXjBpS+ZQvTOg4NxSvJ3eKYuCP+GfnR/1DyGTthN8wyg5jD8kA2NOV/Y78NJPYLaB/
         Iw7bkswcPsLR6qN+BPQJMj/3nFOWN2ff+ckGmiQM5b+KB4uC3n38RZsO4Z7829x1/pr6
         zE/g==
X-Gm-Message-State: AOJu0YxWwCXzHhUiJvAcsQrkLxWlh/TYDHOROrXnkOnYnmgGqR/WlYSC
        mhpyxzxHAURidIr1CYqPsDA=
X-Google-Smtp-Source: AGHT+IGiPJCjgRQg5yeXZ/CMRQAAVtxtQZOthXT4NAmKWbn8i6rwYTmHjcLkBbnzbkYYr20fdw5AnQ==
X-Received: by 2002:a05:6a20:734b:b0:15e:bf2b:e6c8 with SMTP id v11-20020a056a20734b00b0015ebf2be6c8mr5538117pzc.2.1698019910437;
        Sun, 22 Oct 2023 17:11:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b001c73eace0fesm4862982plz.157.2023.10.22.17.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 17:11:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a523a854-5ba3-670c-f0ee-5ec259043b74@roeck-us.net>
Date:   Sun, 22 Oct 2023 17:11:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     fenghui <fenghui@nfschina.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231021105748.18280-1-fenghui@nfschina.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_watchdog=5fcore=3a_Remove_unnecessary_?=
 =?UTF-8?B?4oCYMOKAmSB2YWx1ZXMgZnJvbSByZXQ=?=
In-Reply-To: <20231021105748.18280-1-fenghui@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/23 03:57, fenghui wrote:
> ret is assigned first, so it does not need to initialize the assignment.
> 
> Signed-off-by: fenghui <fenghui@nfschina.com>
> ---
>   drivers/watchdog/watchdog_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 5b55ccae06d4..dceaf5cc89fd 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -194,7 +194,7 @@ static int watchdog_pm_notifier(struct notifier_block *nb, unsigned long mode,
>   				void *data)
>   {
>   	struct watchdog_device *wdd;
> -	int ret = 0;
> +	int ret;
>   
>   	wdd = container_of(nb, struct watchdog_device, pm_nb);
>   

NACK

Complete code:

static int watchdog_pm_notifier(struct notifier_block *nb, unsigned long mode,
                                 void *data)
{
         struct watchdog_device *wdd;
         int ret = 0;

         wdd = container_of(nb, struct watchdog_device, pm_nb);

         switch (mode) {
         case PM_HIBERNATION_PREPARE:
         case PM_RESTORE_PREPARE:
         case PM_SUSPEND_PREPARE:
                 ret = watchdog_dev_suspend(wdd);
                 break;
         case PM_POST_HIBERNATION:
         case PM_POST_RESTORE:
         case PM_POST_SUSPEND:
                 ret = watchdog_dev_resume(wdd);
                 break;
         }

         if (ret)
                 return NOTIFY_BAD;

         return NOTIFY_DONE;
}

ret is not set in the default: case.

I don't know what this is about; you have submitted two patches
in a row, both of which would introduce a problem if accepted.
Is this a test ? Either case, please refrain from submitting
such patches in the future.

Guenter


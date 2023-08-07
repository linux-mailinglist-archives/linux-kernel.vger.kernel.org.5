Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77174772DE9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjHGSeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjHGSeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:34:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48776171A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:34:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686bea20652so4819613b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691433254; x=1692038054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d88A3sG9TaqZPtcXslScAWFzfv6XeMcngx6sKg8vHNQ=;
        b=Em1xesaDN/TYjnW+HYQm9P6CMNKG45w+0jhyo82tCc/91ZJl870oXMkSyaN8cigQUk
         8AgAcoezl7JzWpwkCQ8bGbGi7UBuKfO0pdYSmBqV1gfw8qkq1glvR4rvW0OGIwrlUjm1
         1S2ekRyUtx4IVJAByWJIq/jxb743gGYd5lWuiMoVpLdNy9m3bzJUnidCrwHlMKB6VxMk
         aPTkbDb6hIdDvUO5aLygEJjiRetGs+OuVJjEtjZvL0FzzSB7otdsthPsKQbU4ZWtVFgR
         44f90M5sZdPqQbpUMO5k+0Ftrv4ZJo7BitGFBXw8xDIOtWgHB99HTLfpTeVooXPS0RIt
         JmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691433254; x=1692038054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d88A3sG9TaqZPtcXslScAWFzfv6XeMcngx6sKg8vHNQ=;
        b=cGemYblFmuV0eUW2x/AcD7l7O5QhUEdBz/ZNAN7T320hOHMIaP21VJF7q3C3u+KKZg
         fUDd8/GFnhbKLHcOIFHMUW1oW8gxIRAx62l2Kba8XtqS2cq9oEW/Izi++BTZKBmD3iVw
         Ode+cxJHlr+ODaZZ2xMV5Grqoxbgjl4ojh3TFysxvpYKR26J3kO1enhaNx+5Y5DegzH7
         +uckqbjz3TLZzFb5wvLfH1OTbn0vhTYhx5jSban4zaLt2u9yd3hViixcPOrSB/0cCWJ1
         YVPCRwsvy0FZB0yI288yZoEIxCYcQphdSZbWP2aMYrc+9kioQFSw+lnaJ97JKjeF3VKw
         BW9g==
X-Gm-Message-State: AOJu0YyLBdKVXkQvHmpkBfYWo9JRqlbQ6vBkwPVKddry8Q7tz8jWBC+E
        JHFU/b/Y4zi/bOGIOA5Q+YI=
X-Google-Smtp-Source: AGHT+IHuvTN39/NVlA7y7tL/NRGCy3zLlAgwmCPlcb7TYmOqcuWURgprnybxcrAvpZXbjl+vWvwMDA==
X-Received: by 2002:a05:6a20:6a0b:b0:12e:7ff9:b612 with SMTP id p11-20020a056a206a0b00b0012e7ff9b612mr13363270pzk.45.1691433253667;
        Mon, 07 Aug 2023 11:34:13 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id c5-20020aa78c05000000b0066f37665a63sm6439108pfd.73.2023.08.07.11.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:34:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 7 Aug 2023 08:34:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH 3/3] iocost_monitor: improve it by adding iocg wait_ms
Message-ID: <ZNE5I77_wzVei0nk@slm.duckdns.org>
References: <20230804065039.8885-1-chengming.zhou@linux.dev>
 <20230804065039.8885-3-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804065039.8885-3-chengming.zhou@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 02:50:39PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The iocg can have three throttled metrics: wait, debt, delay. This patch
> add missing wait_ms to IocgStat to show the latest wait_ms of iocg.
> 
> As we are here, group iocg usage percents "inflt%" and "usage%" together,
> and group iocg throttled metrics "wait", "debt" and "delay" together.
> 
> Effect after changes:
> 
> nvme0n1 RUN  per=50.0ms cur_per=177105.713:v1053528.587 busy= +0 vrate=135.00%:270.00% params=ssd_dfl(CQ)
>                           active    weight      hweight% inflt% usage%    wait    debt   delay
> InterfererGroup0             *   100/  100  54.28/  9.09   0.34  24.07    0.00    0.00    0.00
> interfered                   *    84/ 1000  45.72/ 90.91   0.48  41.09    0.00    0.00    0.00
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

For 1-3:

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

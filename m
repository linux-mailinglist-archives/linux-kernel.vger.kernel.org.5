Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77958752518
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGMO1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGMO1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:27:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801E72680
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:27:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso7523775e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689258425; x=1691850425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PxQyfBDyp9L0H87NjuF/C5shA0jZRwDe5Ep7LksUpGA=;
        b=lyyADvTRTCZYjkS+hGu8ZcpekL7ubco8ddA/U4p8sXAvMjxU/scSqXN8fMoPf/acrs
         ymDzktU59IXkgLBWFyZro3HgIQnOeqyOvZBtqdi0BCVggDQLkcFxQ/PrjLTC+rsb1gn2
         AZUFlZZAnec8s/iFK7WxxAopdSOGf70TeeevRikuhtPLb6/asiVHQFXbF5ycjdNIPzej
         CVkpoxn68D59mep2SZJZFoLUWqVZVWDSYrdrkSQ/zFZ3D5tt7ksNEYgRrPecUzKqFaQA
         23QqTczfiuJLk+NJlwsOGLQ3HaOmy3Hgeyv1rpcKo7P38SPejXaL+zyjm9o7wGcrVdCo
         KWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689258425; x=1691850425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxQyfBDyp9L0H87NjuF/C5shA0jZRwDe5Ep7LksUpGA=;
        b=TYwVW9IWIukC0FUQCgu/xdamqDXVkB3qw19gO5dgAWgMOGPti8dlNIyJnkE+7RAdS8
         56rvrv+XVePSN528jcTqp/mszEjGCt3L5buC/5Cw74AiORJLePsaRAUwr+3UHBG0e5T7
         eg28k0756Ojmb+UyzQx46pV4BPFYWMfTq0tpemKUfyNRexYXRAcjIf0KvvhJphTsoZFh
         xWTb0j+/Tx6+utMEQVWEeJz5ccBZ+UsvUSlXtw5qDUqjtZR+TX8Sqa+lX8awEk2fn/50
         /T3b3zg7pR2X8R5hayCq75o/Axu4RtQO7bTn06yokJil2hQXlPQf1WsBOoNfBu1cI8C6
         TA3A==
X-Gm-Message-State: ABy/qLYyQ2R/QEcK4k9hCo4JerFP31LC+LCqbFjZu1F71QcBRRWN1bVt
        1GoiL4ywdfv1ezsoDCMiU3VqTA==
X-Google-Smtp-Source: APBJJlFEgqEOG5VUSLROkOBtduudA0q3XdNXVLgqDcYk1NQxcfJmrHVM1leqhzyFg1ZhYct7U868Eg==
X-Received: by 2002:a7b:ca5a:0:b0:3f7:3991:e12e with SMTP id m26-20020a7bca5a000000b003f73991e12emr1661543wml.1.1689258425056;
        Thu, 13 Jul 2023 07:27:05 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003fbe36a4ce6sm18432534wmc.10.2023.07.13.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:27:03 -0700 (PDT)
Date:   Thu, 13 Jul 2023 17:26:59 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Linke Li <lilinke99@foxmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Linke Li <lilinke99@gmail.com>
Subject: Re: [PATCH] isofs: fix undefined behavior in iso_date()
Message-ID: <c00d9b0f-69d7-4243-bf3d-cfa5cb18e495@kadam.mountain>
References: <tencent_4D921A8D1F69E70C85C28875DC829E28EC09@qq.com>
 <79582844-3178-451c-822e-a692bfd27e9c@moroto.mountain>
 <aa811b76ac704140bfa98884c8d6f51e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa811b76ac704140bfa98884c8d6f51e@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 02:11:02PM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 10 July 2023 10:57
> > 
> > It looks like maybe there is an issue with "year" as well.
> > 
> > fs/isofs/util.c
> >     19  int iso_date(u8 *p, int flag)
> >     20  {
> >     21          int year, month, day, hour, minute, second, tz;
> >     22          int crtime;
> >     23
> >     24          year = p[0];
> >                        ^^^^^
> > year is 0-255.
> ....
> >     32
> >     33          if (year < 0) {
> >                     ^^^^^^^^
> > But this checks year for < 0 which is impossible.  Should it be:
> > 
> > 	year = (signed char)p[0];?
> 
> Or not?
> 
> What happens in 2027 ?
> I bet the value has to be treated an unsigned.

Yeah.  Good point.  We could delete that if statement and pull the whole
function in a tab.

regards,
dan carpenter


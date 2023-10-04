Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6B47B7FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbjJDMuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242506AbjJDMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:50:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AF5A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:50:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so15511885ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 05:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696423836; x=1697028636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhOZL0I3FBTOfyJ3ennuGJmU/lunAyqILUznWBH305w=;
        b=JUKjC0a9BFyafr1nUkiiQL94O5jOo7Dsz8V3bGTal363iI5b5RX3xnZ2GpTC+sITxa
         QRZkdVaGUTUxCj9B50MSjP8uQd3Q7D/wLw5vhDwk0aEDd6thDQXBjXXoCiZIwuyFuIQS
         f37YqPx1Ie6oIRjlXNVqizDJtAyUwLi/YakWevpLRgD+w5whSDMRFlfrCZxWNST6Lq2i
         cBzqkmV9MlE+TJKOvYb5s5ffO7Ix2BuqcWdbrp6FZ9kD92CmVRmxbhj9lD/2HYhIQxNB
         93/6rSbDdLfIQtCKa4vK9VcDQezJ3AMFFVoppHG/epkjC36Dbr6+tBMeD/0E+2QuOMFM
         /eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696423836; x=1697028636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhOZL0I3FBTOfyJ3ennuGJmU/lunAyqILUznWBH305w=;
        b=mlU7v8V49+RaXlhWupQjZJfPVEWt2AFOcmwiBvGd4UAy/osxabZvLX/+CyI+HO1Nro
         f8B3yZt/N+ejNyjPcIVJTHAX3mCM9c/fo/DLR6XmD3UJ8Srm0eQC6qD3bJ7eEMyLhUxQ
         2zyK5lfQDfLsqhd/7yPkBAQLtnTBrFC2r0H2mQdSdR0+bMJpww8wf61trHxmOktOaRZd
         bzCMaPrHuoKRC1QlX3xjYRiJReP7Bo50ch8s8LUusYhxiPgI2eFgm7xmRIUwP67NutfD
         al82T3yTS0eAqjCAsPafFl0IyXmwrjRXdnwFNzymTHWVanb3h7p9XtKgDlFZvRY7Xj0/
         /d/g==
X-Gm-Message-State: AOJu0YyWesHqhx3/aLYc724BGrnN+WgnMbIFLG6wU/YuN3IXyglrtK75
        OI/0PyKvbITMx4iGserXB55afEAF9Ig=
X-Google-Smtp-Source: AGHT+IFcjMsOQQhmGdfIuMvLf8hz8TNgdUnzohKk0xxDDt4+Vc0L1eBz/HGGC0IQWyDiJNN4xSJjKg==
X-Received: by 2002:a17:902:e810:b0:1c5:59ea:84de with SMTP id u16-20020a170902e81000b001c559ea84demr2643108plg.29.1696423835809;
        Wed, 04 Oct 2023 05:50:35 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b001c61073b079sm3612247plf.71.2023.10.04.05.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 05:50:35 -0700 (PDT)
Message-ID: <bcf1998e-5efa-4505-a8d2-3381c16de885@gmail.com>
Date:   Wed, 4 Oct 2023 19:50:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: what to do on no reproducer case? (was Re: Fwd: Uhhuh. NMI
 received for unknown reason 3d/2d/ on CPU xx)
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <0e6de51b-da1d-43f0-ffae-fb521febbe07@gmail.com>
 <ZQo8hzP-eRjXvtXf@debian.me>
 <2a298145-b6ec-4b4e-bd45-0cddf62b6052@leemhuis.info>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <2a298145-b6ec-4b4e-bd45-0cddf62b6052@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 15:10, Thorsten Leemhuis wrote:
> On 20.09.23 02:27, Bagas Sanjaya wrote:
>> This regression looks stalled: on Bugzilla, the reporter keeps asking to me,
>> for which I'm not the expert of involved subsystem. And apparently, he still
>> had not any reproducer yet (is it triggered by random chance?). Should I
>> mark this as inconclusive?
> 
> Yes, without a reliable bisection result there sometimes is not much we
> can do -- apart from prodding various developers directly and asking for
> help or an idea. But in this case that's not worth it afaics, as
> messages like
> https://lore.kernel.org/all/e08e33d5-4f6d-91aa-f335-9404d16a983c@amd.com/
> indicate that it might be a hardware problem and not really a
> regression. Hence:
> 
> #regzbot resolve: inconclusive: not bisected and might be a hardware
> problem after all
> 

Thanks for the tip! Now to fix up:

#regzbot inconclusive: regression not bisected - possibly hardware issue

-- 
An old man doll... just what I always wanted! - Clara


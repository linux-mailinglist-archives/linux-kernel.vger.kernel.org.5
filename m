Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E808784AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHVTtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHVTty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:49:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4EFCCB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:49:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68a3f1d8be2so2297526b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733792; x=1693338592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poyvuz4d7dAHCrItBaYh47AoS5CadHl5LbM0lDfEjyk=;
        b=fMwb16nauGn/DJmL0n4N3Np/PI2YaMt8COJh2lKCnojD+7Fniop5qct73rRH8NozAQ
         y563nt+jmA6qf9wZbkJSRmNqd/+17t7m1ejHA9Jv+pfP+2kOli0ZttvG6yR9c7VMcvXM
         15mdnHlEKbu2VxRj2lMiXGdzbAoYrpPfkKAZrOoHplqDpMSs5pThEWW5YtSvZXwlxUWv
         7BB0Q/o+HjIQWY0oQ2rjOUMSCEA4pVrDKuWIISyQSx7+WQs9d2cz9RK84IHh6ME5vcSg
         6yMWzBYUI45Q5CphCCbZD3Px8ItU4VaezOsb8r3JXTCHlpo3+TMruf9sLjQ6C+/JrBPl
         TBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733792; x=1693338592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poyvuz4d7dAHCrItBaYh47AoS5CadHl5LbM0lDfEjyk=;
        b=afp80KmNt1Hb1Za1RiRbxH01QOYQ17Ftg6l5PENZdlS0WzwhJPHzSeFsK+xBfK185K
         9hoI3VmFTA14aSnkrbAh4JTSSK38527BmwJYbKx+LAwEFPAjyNcCUFc8PBzMxAGG3aZk
         ATPnLtFj2GqCnnqgs4qSd2FtOtLoGbT3zNiX8H/PC+3qBiKYanPn+GXzIIssrvKCvlr2
         P2OnhuUbb2j5boVHk5661v6OkImb7Y6r1hoVjhtk335tynhY9gUGmQpPPcbetDmHQdHk
         6fRQxNruQc+5GkaOr3m85CCGEVwDJy3PHWcxREX9nWxrLe3KaMLEBv98mzxRVDK/Wl1J
         oM3g==
X-Gm-Message-State: AOJu0YwLIkdNZ02JqgJGUke6mf2mbSZLGfYHG92AtiYsvvXNc+twi+s2
        m+AOlDmaETjrtAiD0K1jICXyrb8Fua0=
X-Google-Smtp-Source: AGHT+IEItHCrIzWdBGFHJB4RoCk2XPY8yU0d8ykVbgPXPcaOyBZISzgSI1SsVorKp3y2XKQSBdOUog==
X-Received: by 2002:a05:6a20:5489:b0:148:479a:eb7 with SMTP id i9-20020a056a20548900b00148479a0eb7mr14603099pzk.61.1692733792172;
        Tue, 22 Aug 2023 12:49:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:8fa0])
        by smtp.gmail.com with ESMTPSA id z7-20020a633307000000b005642314f05fsm8304091pgz.1.2023.08.22.12.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:49:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Aug 2023 09:49:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tio Zhang <tiozhang@didiglobal.com>
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        zyhtheonly@gmail.com, zyhtheonly@yeah.net
Subject: Re: [PATCH v2] workqueue: let WORKER_CPU_INTENSIVE be included in
 watchdog
Message-ID: <ZOURXUD7EfO0JVFE@slm.duckdns.org>
References: <202308142140.cf9be57a-oliver.sang@intel.com>
 <20230822110609.GA3702@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822110609.GA3702@didi-ThinkCentre-M930t-N000>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 07:06:51PM +0800, Tio Zhang wrote:
> When a pool has a worker with WORKER_CPU_INTENSIVE set but other workers
> are not that busy, the pool->worklist will mostly be empty, which leads
> the intensive work always having a chance of escaping from the watchdog's
> check. This may cause watchdog miss finding out a forever running work
> in WQ_CPU_INTENSIVE.
> 
> Also, after commit '616db8779b1e3f93075df691432cccc5ef3c3ba0',
> workers with potentially intensive works will automatically be converted
> into WORKER_CPU_INTENSIVE. This might let watchdog to miss all work
> potentially running forever.

The watchdog is there to ensure forward progress. CPU_INTENSIVE work items
don't block other work items, so I'm not sure why it should trigger the
watchdog.

Thanks.

-- 
tejun

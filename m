Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8315B7EDEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345034AbjKPKfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345029AbjKPKfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:35:39 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7139811D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:35:10 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c595f5dc84so19505251fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700130909; x=1700735709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wnBSrgqOtUFJ68G1VtwZiej43nPaE3HHJPkSErJV3vI=;
        b=SEEEnbTNn5maPkOjZkKvC3dp+TS3pwikWoerZcrJIQxHnBBDRI61myuzSi3I0xMEgq
         QC/7LK7dr9GVd2cfaRJnDdunQybZlmZt5Us+bRvnDgK44DkabmN68NnXrop6qyrqmqyM
         Mcq03bu8PQTpyqId24VFanlUzZ1QLQKk9cB7IWCxTOPHRMeQzTvPu87seBgYVgSFlzoC
         RpIqBRU4z4rhPn3FJKNw1aUo0ETJtlmTTAJAXba2mOq0hK48Qvmb6vbFHvGu/MMm4K0K
         SH/PJUOUMIeU61b1brU86p4nC8jjjJWfvdCt/um6I2O2/hTT96D725ttBcbzD42e0ciw
         o+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700130909; x=1700735709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnBSrgqOtUFJ68G1VtwZiej43nPaE3HHJPkSErJV3vI=;
        b=oEu1uUr1HpMPS8gPXnbFGYGv8pHgezq7GKd2Z5Kii8kn1yaqEgaLZliPwX+uFyZYDH
         XFVMl/LnxlkCszW8MjyC6gsz4tD9HR7sHiPwjZygS2z1WjHZFWR6rX2wQH8RCdMhoV5f
         xfa5B3CGzaUGLcgz9sBSTj+gkGvEgy2Y1RgtMIEq8eXR+lqT9meguQeZniQNxl98pEh2
         wDfGdiBYpf7y2VOTGj5fVot8jIcMR8N3WdUYp2EssN7qD6jWv93VBM8hhPO9HlaWZLvJ
         8I6D7HbW1Oh9suVCCIWqww48sXoMFnT1qeXxFOVTYx5j7D4pIeKjEADtUilcZ2m12mxG
         IQHA==
X-Gm-Message-State: AOJu0YyFaOlo0I1zO1xKIaQArNQTQCbkJKfMyqWN4idDOCtLNLOJLaP+
        9UunGuqT7cGByCILSS8RTvFOi7eG5C+YsC2/ufXvwg==
X-Google-Smtp-Source: AGHT+IGuIx5cTnA2BbuLI2scrcKPDTm5iT0N/S7DLT1h4K3KNloqvqXTr4TKC0FYyTvb6AouuCtJXqbnyTPQgSwWuHc=
X-Received: by 2002:a2e:a417:0:b0:2c6:ec37:fb5 with SMTP id
 p23-20020a2ea417000000b002c6ec370fb5mr595336ljn.10.1700130908682; Thu, 16 Nov
 2023 02:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com> <87bkbudrqq.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bkbudrqq.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Thu, 16 Nov 2023 18:34:57 +0800
Message-ID: <CACSyD1N2QZ7iL9wRFWErmzC2Dw5cH2t2=QtRDyHxKGQv2GRYKA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, nphamcs@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This sounds reasonable for me.  Just don't forget to change other
> swap_range_free() callers too.

Got it, thanks.

>
> --
> Best Regards,
> Huang, Ying

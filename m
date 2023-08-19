Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99A5781FFB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 22:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjHTUnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjHTUnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 16:43:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519DE498658;
        Sat, 19 Aug 2023 12:41:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so18552715e9.2;
        Sat, 19 Aug 2023 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692474098; x=1693078898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cxwXDLwCxXc0IZzNcXrKUDIbLtmIiz7rl3av1/ZQkfI=;
        b=L+7FCmhyjm4vrGBGtPC7uYg2qvmrc3Qra9iNdxwPnjf99G0/38+PX3r/oE2syTX/yU
         uEWg9pu3cj+NYOyI4nzbf2bK+/AH9Fv+PvIqm5t9hYc6O5h49LOZUfq4xvLJFyg1AN0k
         KkR1SnY6yGSbdFJTxbkDOu2+eUWmK/BkWiK2Ix65I6d7xSYGK0cX/IRKueeUDTqDu42p
         anYdtgTPBRbNQuIyCnt8kOcIp+RY7AD3bGPGqeFKJNruMf5QV6ILWa5NAMOkhXjDGpui
         cV93gtgkznHOfAcRCnm0YvkMvTGLklj4lzL5PaUpJV2bNg1SgHthMMNht+v56bPI3JCH
         Hg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692474098; x=1693078898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxwXDLwCxXc0IZzNcXrKUDIbLtmIiz7rl3av1/ZQkfI=;
        b=TscHU5wpR8f6nI6Quk+toxJeB7blmXJjwvkN7ibe889GMNrdErtPIJSpj/i1rB+KC3
         ktneSmOL6D4NHbpSpSzF0+Wy1lDhz6FxrmnoPGsxbOh/uMlJaB6dDgBdDr7/WGxMx8+j
         Z2u9WCfdRKWwol0cdfefZ22Dq8QKrRTD+6Sy0znDT7ieqLc4DzmoDZuAB8oxonEYpEfA
         LkPJertbmydGAGqlv+pHo+pmpRCOtH7fbUWqVrFx4i+3hH4hj02iJW2Wwh5724clNvGd
         HAzPouCSQJr0cElhYicrUz/0cpCaIOvPIaecnTwlskyXEWULAy89QXrfMMPogTg7jYfB
         N2tA==
X-Gm-Message-State: AOJu0YwXPxsqPGcA9o0zIYvvgyffSWeygg+AVU9FKQ3Hs3EMAqwboTYd
        LpWSjW1VFBY+gBcCMftyEUk=
X-Google-Smtp-Source: AGHT+IFI8HXRbhVf2FXZB3T50ohz6ewZ3PYNQWqGFthESfjR1NXsNeZjeKxg6136eI3tCzGMrjHnaw==
X-Received: by 2002:a1c:7303:0:b0:3fb:f0ef:4669 with SMTP id d3-20020a1c7303000000b003fbf0ef4669mr1882065wmb.17.1692474098300;
        Sat, 19 Aug 2023 12:41:38 -0700 (PDT)
Received: from ?IPV6:2a01:cb15:b7:2500:add8:daa6:d03:e00b? ([2a01:cb15:b7:2500:add8:daa6:d03:e00b])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bc5d8000000b003fba92fad35sm10489223wmk.26.2023.08.19.12.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 12:41:37 -0700 (PDT)
Message-ID: <c7d1eced-d77b-aca7-1422-6eefaf704f3e@gmail.com>
Date:   Sat, 19 Aug 2023 21:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] intel_idle: Add RaptorLake support
Content-Language: en-US, fr-FR
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "noltari@gmail.com" <noltari@gmail.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
References: <20230119070205.90047-1-noltari@gmail.com>
 <c79904e98b86b68c87add286aa1487b3f81712b6.camel@intel.com>
From:   Guillaume Martres <smarter3@gmail.com>
In-Reply-To: <c79904e98b86b68c87add286aa1487b3f81712b6.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 17:13, Zhang, Rui wrote:
> On Thu, 2023-01-19 at 08:02 +0100, Álvaro Fernández Rojas wrote:
>> This patch adds RaptorLake support to the intel_idle driver.
>>
>> Since RaptorLake and AlderLake C-state are characteristics the same,
>> we use
>> AlderLake C-states tables for RaptorLake as well.
> 
> RPL and ADL have same cstates and use the same mwait hints, but the
> latency of each c-state are still different on different platforms.
> So we can not just duplicate the ADL table on RPL.
> 
> There is an effort ongoing that measures the latency of each
> cstate on the RPL platforms. And based on the measurement result, we
> can decide if a new custom table is needed or we can just copy the
> previous platform. Hopefully we will have a patch in a couple of weeks.

Hi, I just stumbled upon this patch series as I was wondering about the
lack of support for Raptor Lake in intel_idle. Your last message from
January mentions a future patch, is it available anywhere or is this
still future work?

Thank you,
Guillaume

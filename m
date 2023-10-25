Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269287D64BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjJYISI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJYISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:18:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E042C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:18:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so8006176a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1698221883; x=1698826683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xF6RmXe0iwrBVlFJKvkrtWsUWK5y+quiCOALv0ygLjY=;
        b=cHMoCLoyWqLWgCXUUkkDnO5cbAijynfJ0KVXEABg7InAxq1gAlCLqegw8NqEZZn41h
         G5foSadkFXVwf9Q2pbcuYF3lRalC/3mL2rW65LTbdP0Mv3R14Z5KXsPX48Ts4Cgj4f9Z
         C/KABSVzXS54FGaiYBTszdh5oIQ7ZEzT8qIFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698221883; x=1698826683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xF6RmXe0iwrBVlFJKvkrtWsUWK5y+quiCOALv0ygLjY=;
        b=E3zgnQ8iyRNhZyaylO8XOaTFeXpQBY5xniYJ0PhCGIm1yHMBgJM52+DfK8mSs9MAnb
         oLaYiA8Wx2yb1AEY9wQxjRvsxpl/BxIygHrxOyNi67Knd+M0k1Qx+KdlUlIGP9rrzYz0
         RopZsuhilpwWPsBKp27SLRj/Q4F3f1WPn4FvEJVIb49CxvbC/ZbAJsxHMjHkhHzjGTez
         j68cOl+0ycymlSqqWnU7jcZrap1eNhZYBIxy+jhefmLnX70uUwoQtFe20IsBlowGWJSx
         +q9doHk82d+7H26CZLEFrYl4m6hviGzVk6Df99yZbajU5/0bEdGZwfCfbFvPh/9+mD95
         tsaA==
X-Gm-Message-State: AOJu0YzMQnfhrAHKQUCb09sb02fpWGs54/qw2J7b7VaI3YSWq8h0SxJi
        zK6bT77iAQ1WOw4HY0UllxcY5w==
X-Google-Smtp-Source: AGHT+IFIy8aB1unRqCPL9qYewTHPkrA5JVy0EuoyQaAtd8SKKnjyQjwdjhFVPf1/NxxldDs9u8D+LQ==
X-Received: by 2002:a17:907:1c0b:b0:9be:45b3:1c3c with SMTP id nc11-20020a1709071c0b00b009be45b31c3cmr12738251ejc.64.1698221882709;
        Wed, 25 Oct 2023 01:18:02 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id ov5-20020a170906fc0500b009a1fef32ce6sm9561110ejb.177.2023.10.25.01.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 01:18:02 -0700 (PDT)
Message-ID: <374465d3-dceb-43b1-930e-dd4e9b7322d2@rasmusvillemoes.dk>
Date:   Wed, 25 Oct 2023 10:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Content-Language: en-US, da
To:     kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <202310251458.48b4452d-oliver.sang@intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <202310251458.48b4452d-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 09.18, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 3.7% improvement of will-it-scale.per_thread_ops on:

So with that, can we please just finally say "yeah, let's make the
generic bitmap library functions correct and usable in more cases"
instead of worrying about random micro-benchmarks that just show
you-win-some-you-lose-some.

Yes, users will have to treat results from the find routines carefully
if their bitmap may be concurrently modified. They do. Nobody wins if
those users are forced to implement their own bitmap routines for their
lockless algorithms.

Rasmus


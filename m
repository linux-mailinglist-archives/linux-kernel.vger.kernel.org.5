Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9A9799E9D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 16:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345753AbjIJOHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIJOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 10:07:24 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C65DCC5;
        Sun, 10 Sep 2023 07:07:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fac16ee5fso441729b3a.1;
        Sun, 10 Sep 2023 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694354839; x=1694959639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rUZnx6mLwwhTM82glMGOCmCnlACgLj+v8fzObrhRhQ=;
        b=I+ckYikP5Zvy/CQ8esGm7LKMcDu4CIZu66omSp+ci01cdrZa41l+3j1zdygHvAjgYU
         ZjuhYeHIGpP3R876I1DeiR8Ml25lq1YvOt4K0iNfeUljKjZm9mMPgtpkXjeM5z7bF4FN
         7Yes9yhmE14Q7sVGFi10am2zPBA+wjxXs0aIp8qPJ2y8xVxU2fwB99H0IvF09eRo9yoj
         dNQo4biLxPm9PYsU2SjCjeqAoLaC4wCOf7i5rrixAlJs5IrcEOOj9iLtaJykHikzAwxi
         xQHt9QBWtmHomHlLw1RBagto569zKYgw2ibNcTsw01qopqoqtLsBnFn3AolebnpsAUO6
         PTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694354839; x=1694959639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rUZnx6mLwwhTM82glMGOCmCnlACgLj+v8fzObrhRhQ=;
        b=BYxjnCBI9Tm5vTKqctRpNtlFLGlThMKY/EtSb9MwKisX3/J6sDfAbqhtwibf/xhmuk
         yOq3iiL9BRxt7aHT0RNKvA8m0L27YRdb5vUSJYGN3OcWxOje77by82yYsS9YDqWhCZF1
         epZuQ2nnKO17SEYqUll1FQ3IYebkbdqd3RKUQsoMbRQTeID2ViriCfs+j1K7kjE3ESJR
         UCg/XiRTATpGxIAtSpkwkElOKmXN/Wc7btM5X2xANQjwzgFgq8/9iR9TgqBsejNBRIK2
         bJeomIqR2/Mjoot/J2Q5v3JvZD8n/Mwru7uSbngjCUREy1XFPfw1Uej1x9EqIggWh9et
         hzTg==
X-Gm-Message-State: AOJu0Yw9p/SPZEQ5fXt4KhaxCqJC0V2xxDVhV3WxWx6TAeNC7RqYOuew
        ra/JyPQHa//HlTeegzRZGC0=
X-Google-Smtp-Source: AGHT+IFS7cH20tn/cb9PGVHa8+VoPQGZDG2IFBUES/33lqXwnfY70hcs1yj5q8d+ZJ/Gegdkd1VGMQ==
X-Received: by 2002:a17:902:7d89:b0:1bf:3c10:1d72 with SMTP id a9-20020a1709027d8900b001bf3c101d72mr6083942plm.66.1694354839342;
        Sun, 10 Sep 2023 07:07:19 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902bd0500b001bba7aab822sm3917614pls.5.2023.09.10.07.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 07:07:18 -0700 (PDT)
Date:   Sun, 10 Sep 2023 07:07:16 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/1] bitops: Share BYTES_TO_BITS() for everyone
Message-ID: <ZP3NlPOGtbT7CGQ1@yury-ThinkPad>
References: <20230824123728.2761663-1-andriy.shevchenko@linux.intel.com>
 <a5574786-0a49-454d-67e3-571983e6a6e8@intel.com>
 <ZPCT2vV0r8l/wxim@smile.fi.intel.com>
 <05febba8-49a5-5f9d-34b0-d85d976e1416@intel.com>
 <ZPiSogB2GdyM+oJx@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPiSogB2GdyM+oJx@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:54:26PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 06, 2023 at 04:40:39PM +0200, Alexander Lobakin wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Date: Thu, 31 Aug 2023 16:21:30 +0300
> > > On Fri, Aug 25, 2023 at 04:49:07PM +0200, Alexander Lobakin wrote:
> > >> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >> Date: Thu, 24 Aug 2023 15:37:28 +0300
> > >>
> > >>> It may be new callers for the same macro, share it.
> > >>>
> > >>> Note, it's unknown why it's represented in the current form instead of
> > >>> simple multiplication and commit 1ff511e35ed8 ("tracing/kprobes: Add
> > >>> bitfield type") doesn't explain that neither. Let leave it as is and
> > >>> we may improve it in the future.
> > >>
> > >> Maybe symmetrical change in tools/ like I did[0] an aeon ago?
> > > 
> > > Hmm... Why can't you simply upstream your version? It seems better than mine.
> > 
> > It was a part of the Netlink bigint API which is a bit on hold for now
> > (I needed this macro available treewide).
> > But I can send it as standalone if you're fine with that.
> 
> I'm fine. Yury?

Do we have opencoded BYTES_TO_BITS() somewhere else? If so, it should be
fixed in the same series.

Regarding implementation, the current:

        #define BYTES_TO_BITS(nb)      ((BITS_PER_LONG * (nb)) / sizeof(long))

looks weird. Maybe there are some special considerations in a tracing
subsystem to make it like this, but as per Masami's email - there's
not. 

For a general purpose I'd suggest a simpler:
        #define BYTES_TO_BITS(nb)      ((nb) * BITS_PER_BYTE)

Thanks,
Yury

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C932D7945E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244967AbjIFWDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbjIFWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:03:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933A8172E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 15:02:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401b393df02so3990815e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 15:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694037769; x=1694642569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5d8ZUH185QZnWOmQO9Mwhjew/ssKxRCgRHEnmUvSgBk=;
        b=oJDsbI0a0gHhoWsQ4CeMgM1KHTdf9xEUmVMSzvIOuOHQdAVDRzrHb0GrYRvsnx07jG
         koBWCxzN8ryxxeIV5+3qO6ulcyEF4k+2iHgCuuzsEiOTn4rK/EY1n8Q8yRNZRMjKx4+h
         fHyb77NO+JL/XIdFTJp+HTi7PnJop7iZaSLpZK8bc70VIZr0jFQrse3C4N6MwXR04daz
         b+moDte3OmjdhrXmTldPC1DhA9DH1oUaunDfVtXQ94MA39/rrVWQEu+4sXF9WOhxzBHp
         jdd+2jxNMqM+wIP1Bv5dz3uuYbdzHE3RFUqvoaRRj9azi7vwi4GZQlb2qwLsNYgRcUOf
         UVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694037769; x=1694642569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5d8ZUH185QZnWOmQO9Mwhjew/ssKxRCgRHEnmUvSgBk=;
        b=XG9vA/gGIO7P+9L59l2oSGFILXLe1uo88eHoIW18gS5qhnqUy0GwDtSnR3KJWmZVeZ
         KXGsC3+tEntVbAf4XN0ZZCpWI0BNa+s0nd4p01riL0h7V85QaL+NCPfpkMYV8XulJ4BM
         uYAVa9fh+AcPwhMq1KQjwlI/GwgqLciY4jXPXp0GPeN5AoXrjuVWxJ3PiYq7LZ2ZZHkR
         aCqflhKJfpnhTwisC8QyCSpxyt4Tufl4gSW1naYxX8V+uRNJXKQdB9dgIDD5NxuGDfyn
         Wn/+NDXeopS38PWRSwuU6SWOguzRo8dDdMuokGg0SEib1i4qlQi0J7xO4Uv9ioZsjaYI
         jrfQ==
X-Gm-Message-State: AOJu0YxNXX76TthdUUWXfr14EWBD461hqsYbyK2YtramfSRILGpvCAoQ
        bJxGR90RygjECDjg4A1QHjA=
X-Google-Smtp-Source: AGHT+IGs5R0Ekf039SfHj8ym2nnIMNIrsdvr85LYsD8rMewXO+vyaacGoFlriG3WelNmfSb9/Fx0SQ==
X-Received: by 2002:a5d:668a:0:b0:319:7428:9caa with SMTP id l10-20020a5d668a000000b0031974289caamr3833963wru.38.1694037768934;
        Wed, 06 Sep 2023 15:02:48 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id m14-20020a056000174e00b0031f3b04e7cdsm14049039wrf.109.2023.09.06.15.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 15:02:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 7 Sep 2023 00:02:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yi Sun <yi.sun@intel.com>, Andi Kleen <ak@linux.intel.com>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        sohil.mehta@intel.com, ilpo.jarvinen@linux.intel.com,
        heng.su@intel.com, tony.luck@intel.com,
        dave.hansen@linux.intel.com, yi.sun@intel.intel.com
Subject: Re: [PATCH v6 1/3] x86/fpu: Measure the Latency of XSAVES and XRSTORS
Message-ID: <ZPj3BpLlGkBeYcW7@gmail.com>
References: <20230901143414.1664368-1-yi.sun@intel.com>
 <20230901143414.1664368-2-yi.sun@intel.com>
 <ZPMTVNM2oBCdSYjJ@gmail.com>
 <ZPOIVmC6aY9GBtdJ@tassilo>
 <ZPhD7B+pXyeP2BPS@ysun46-mobl.ccr.corp.intel.com>
 <08dd36d0-08e1-cf55-355e-5c21132c44fb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08dd36d0-08e1-cf55-355e-5c21132c44fb@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 9/6/23 02:18, Yi Sun wrote:
> > Or just use PT
> 
> I'd really like to be able to use this mechanism across a wide range of 
> systems over time and vendors.  For instance, if Intel's AVX512 XSAVE 
> implementation is much faster than AMD's, it would be nice to show some 
> apples-to-apples data to motivate AMD to do better.  We can't do that 
> with PT.

Ack - and with the explicit tooling support, it's also very easy to provide 
such numbers.

As long as the regular FPU code paths do not get new tracing overhead 
added, this looks like a useful tool.

Thanks,

	Ingo

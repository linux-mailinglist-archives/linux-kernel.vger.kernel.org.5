Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96C97CCDB0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbjJQUPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjJQUPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:15:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F81F6FA5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:10:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bd73395bceso2294019b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697573423; x=1698178223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uj2R21g4EPlt4YZKWi7SG89ievVQJ+iyFG5BwjhrmmE=;
        b=MxwpeeqNfHY7X0frHicLPeeZeYmqkyHd8w3y/ANb8sFCWtaAWLrg96H8KbsYKz6TYK
         ZOxQTvSUqO7uZdI/QJ5nXw3cDwnGWiy6OiSVBUasJECgl/rqJzGD4Qj4KSxemJaCHI9v
         NAjWtEucEs/2UFfG0vKJkMtnUFjQVdZBSm1erpxuG7kmyTGXWqlUkUwQMOkRL6pMaFDq
         WIEvqQPW0+DEcmhqU+lP5la0EakTcxmYZmNX4hqU07xbS3oVlGJYVpEFhmaXhOQzPyEA
         De2H7xvy06DHkacLh7VJ3OIDqorbYbOfodLJjpyTGenlPxDVEGexvluIXan5WifPQBHk
         /9Jg==
X-Gm-Message-State: AOJu0YzY0W3G3MQGpgI7SGhJHIiAjvEU4IHkDiWoJ+WW3f/pG+AmKz+b
        c0lLOLTuWs1JHEpKDuwTI4r2fmXP1vlKWdq3
X-Google-Smtp-Source: AGHT+IEPY0k7Zb1PMfxn6P2a1QNtfE7IToifhIIwsP0rg4ArLxFEVp2FOQ6vFHPhJI2ALpNnMSKmzw==
X-Received: by 2002:a05:6a00:3408:b0:691:27b:15b4 with SMTP id cn8-20020a056a00340800b00691027b15b4mr3871596pfb.5.1697573423273;
        Tue, 17 Oct 2023 13:10:23 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id z21-20020aa79f95000000b0069323619f69sm1918389pfr.143.2023.10.17.13.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:10:22 -0700 (PDT)
Date:   Tue, 17 Oct 2023 17:10:14 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1697573418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uj2R21g4EPlt4YZKWi7SG89ievVQJ+iyFG5BwjhrmmE=;
        b=Sd7GNP/bf0yRIpIrDgRsW5XZ4eSKsUoJ5xRV2D58RK5XCT0LV2IxaO3HmNa60rGT2E3d5L
        jtdldngQhriPe+qNxE1kT0DMtqconE5I+up4eMlISXEI8569NwNjfV7GoHvR51wmEXnDgQ
        j0Awwtx/zDEM/wM1rwbOLFHJb8fxtJ+i1G2HDQzv3Iit94/AZTABUdDt0j4B2xHzadTkmd
        q6W+nawquOo//gCaRyawwJu7omaFskXMsQg2GgTH8CY6kPME9wleTHg4ppGpLSOoedSLe2
        8ifxIM9dfCcdghArMGZ+4W1wU4pJWKcgmsdsM7mpNHOvJOvlBVolya0dupzNQQ==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Subject: Re: [RFC] mm/kasan: Add Allocation, Free, Error timestamps to KASAN
 report
Message-ID: <eqinp4exznpgclzgz3ytjfdbpjffyyfn62dqfiaw2htk4ppa5p@ip25t7yczqc3>
References: <VI1P193MB075256E076A09E5B2EF7A16F99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1P193MB075256E076A09E5B2EF7A16F99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/18 03:39AM, Juntong Deng wrote:
> If the free time is slightly before the error time, then there is a
> high probability that this is an error caused by race condition.
> 
> If the free time is long before the error time, then this is obviously
> not caused by race condition, but by something else.

That sounds a bit arbitrary to me. How do you set the threshold for each
case? I mean, the fact remains: an invalid read after the object being
freed. Does it matter what it was caused by? It should be fixed
regardless.

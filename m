Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF45D7585D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjGRTuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjGRTui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:50:38 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B932C1993
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:50:37 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77dcff76e35so55800739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689709837; x=1692301837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sceM71mrx1ldduQdHfFt58Ax0ojkJo0YGdjctC0+c48=;
        b=br7guNmJXC/Ai3p8yzf3uq/bFlwqMWP0FRiog1Q2l2KwuTdvUP58SqA2ES8+3hbDpv
         sxaK7HCILkXFU3/UdudEquUMmZkgJ5SljGLJjTORacBd4milG8hDHE0S6hTDB7kgtJQq
         r7lTUGUW3k76LRn1/Pn5Iu3OpW8uCOPM0lZv1zt4MklceEX7HAG1YHFYbDPIGWGi7Pgc
         WAf0qbSN8RXiYy+yk5uo4I0QmVy67JVjPVsQ+J94i13CvYdQV9Ge08oeytLGAAhXw6Oh
         8hV6Vea+QuLxS+uEAqACv5PiWIid5Sd2B4iF+xiXHrv6UN46ytz4HPKTQFsGK/CKgWoA
         cOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689709837; x=1692301837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sceM71mrx1ldduQdHfFt58Ax0ojkJo0YGdjctC0+c48=;
        b=d+2PWJloPIaG69KkRVN1FCyFl3ed2puiGnMwqfqVV5v8CXM2s2oxSzYXrZZR667Mwi
         Y4I/nXHq7+0URTiskFy9/t+aPJUy+AWLsqbqJ6yt4UzZKs54ESW0ylchWziwh8Y1dMi7
         UzXhFyc/mLy69gTsLyb4ReWeFXmW7r5aqjvX1R+WaYzzsjg+xp30arWCWxF1t/P5qVdy
         BFpc/7k42JYl1zaiEbhgKVvj1iesvirizRIPNVxgoVtI56EANg9HNEwn00rep3xHxMk3
         jtUvCZ8auJF41EiREQOvfFogtsiAfV64jfFDLf+HbNITE0OTl/OX3JZdxKCHp8NnTvJ3
         6dRA==
X-Gm-Message-State: ABy/qLa0qqs5FGtI8n/ZMXZw7OitllYEP3oFtTVa0abMqRTnl/8anz4R
        vP2PnZ5+CpcyZPM13p1ZOYplzw==
X-Google-Smtp-Source: APBJJlExhZyeCQ3djR1Cvzi97TCTNYMMqCCxoh+CrqNwlnrO2E8mU7bxYMTGsr9clM27dle2ZVCHPw==
X-Received: by 2002:a05:6602:3a83:b0:780:cb36:6f24 with SMTP id bz3-20020a0566023a8300b00780cb366f24mr2829957iob.2.1689709837198;
        Tue, 18 Jul 2023 12:50:37 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f28-20020a056638023c00b0042b6f103e62sm731222jaq.133.2023.07.18.12.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 12:50:36 -0700 (PDT)
Message-ID: <36fa996d-1045-2a3a-af57-f1bbc6119d5f@kernel.dk>
Date:   Tue, 18 Jul 2023 13:50:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] io_uring: Use io_schedule* in cqring wait
To:     io-uring@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     hch@lst.de, andres@anarazel.de, david@fromorbit.com,
        stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230718194920.1472184-1-axboe@kernel.dk>
 <20230718194920.1472184-2-axboe@kernel.dk>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230718194920.1472184-2-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 1:49 PM, Jens Axboe wrote:
> From: Andres Freund <andres@anarazel.de>

Ignore this one, leftover patch in the patch directory when sending out
this one...

-- 
Jens Axboe



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4C77161C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 18:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjHFQow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 12:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFQou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 12:44:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C29BBF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 09:44:49 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51f64817809so287629a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691340288; x=1691945088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A522AjDl5DEvsvtIx3nF2oxKNHEm3knvcY8h1W+FtFM=;
        b=00QifAQTEKMyIBRPRQNPMRNsvsQTGzJwMmlmH/6Vfbhn30YEISMj2j5cB1Q67caUMS
         HYvoiSiuUv+RihMGOldaHg9bh2pPEQ/B7DKKnC0w5oWn30ofwe0VNpsxGNHuL6/cGHie
         qZmcoOaDltKhLhRbv/RhA7OlfKXm6QMirf4OeBV31I+puYtJ4D///Yn86mdBkqeg2ls+
         xuFq4dCw48l6objBCJ4UceVCRexZQNkwqFKxdDXeZBILokZ4vPtA8EGBXMD7koIyLP+s
         cdHq+m5s4HPujWHOqD1Pqe9TmHLofdS/il/kGjYsxFZL1ZHjugKWjchLcrjfLZABrFE8
         E+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691340288; x=1691945088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A522AjDl5DEvsvtIx3nF2oxKNHEm3knvcY8h1W+FtFM=;
        b=W4qIjhDxpJ+iB5yDSxdrn/iGNjFsuqbEVi0nLBsStRq+gEVxAcpTtiaLENa6XB5kYy
         I9S5NP7qWWGXR0Qy0F1+l7V7t6HRp3QT1lYk3rdgWHGIogrcguVJpbE9ft45+phMSvY+
         v3PrZbWYAblo/oyg2d36gLy3f9fwi/NUr4PDY+jt/vhxWlHejEKKvVXlJc3kKP4sVE1H
         pL/MWLLru81Be68+NCYZtHBTq0lipZKhyCFvzKgFiPSJnC1VLp9B05vpCXiSpVpVceWb
         BQGg5vUJzBY02ShLT26VzO30Tx0ElAw2ThHl86TpX+Z6spMTB8NJb1yxKplbqTbcgz/6
         TSZw==
X-Gm-Message-State: ABy/qLbe5zp/ue8uy6daXmdVpiX/Gb32g8XEL6G0SPCgmbfmFajAKlOa
        WCbiYwt1R2Gkx/Wc3yJMytLMPQ==
X-Google-Smtp-Source: APBJJlHsqt5xn8/2q3ojtNfG5H7V0CwjM00N0ZhzzTwfE/iwBY/PGjP40gUhFzOsWgQcjk5ibVpbJQ==
X-Received: by 2002:a17:90a:53a3:b0:268:437:7bd9 with SMTP id y32-20020a17090a53a300b0026804377bd9mr21966599pjh.3.1691340288605;
        Sun, 06 Aug 2023 09:44:48 -0700 (PDT)
Received: from [172.20.1.218] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090aac0400b0026833291740sm7057566pjq.46.2023.08.06.09.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 09:44:48 -0700 (PDT)
Message-ID: <e136823c-b5c9-b6b3-a0e2-7e9cfda2b2d8@kernel.dk>
Date:   Sun, 6 Aug 2023 10:44:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCHSET v4] Add io_uring futex/futexv support
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, andres@anarazel.de
References: <20230728164235.1318118-1-axboe@kernel.dk> <87jzugnjzy.ffs@tglx>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87jzugnjzy.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 10:06?AM, Thomas Gleixner wrote:
> On Fri, Jul 28 2023 at 10:42, Jens Axboe wrote:
>> s patchset adds support for first futex wake and wait, and then
>> futexv.
> 
> Can you please just wait until the futex core bits have been agreed on
> and merged? No need to contribute more mess in everyones inbox.

Also no need to keep dragging out the review of the other bits. The
dependency is only there so we can use FUTEX2 flags for this - which
does make sense to me, but we should probably split Peter's series in
two as there's no dependency on the functional bits on that patch
series. As we're getting ever closer to the merge window, and I have
other things sitting on top of the futex series, that's problematic for
me.

-- 
Jens Axboe


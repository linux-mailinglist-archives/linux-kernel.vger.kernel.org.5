Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AA7770723
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjHDRcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjHDRb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:31:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C749E5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:31:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bba9539a23so4472175ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691170316; x=1691775116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qQmF/aDPN/Nd1iFTYAKf0iaoJAfdocEV/pAQRYwbqs=;
        b=Ok9lyphivxgObFBlVcatBdf9FmrWhag5FrhV0znfPx7b0uGvx81YG9TIoMjLRNS7b/
         ts0mtR1Y9E0+QBeAk/a0+IlNVPt+PxsQChz4M88beydb3Mpsg7rhIdCllLO6JQb6IBTV
         Y4Ku4AtHVmGXtReS5HYAymdGGt4hwG6JyKtnjSbpeF7/eoxKNvLxy0f0PbDgukuFafYp
         zgiXrx2mpc+A684TIxjc2aQBX5g7EVb4AiL+aX8VXtRaB71gh5dh0d2MzDsHgoigdu9u
         vQd6ZSCf++eWeBf7rkJ/u0bayfu60/INm38m5w3FLO/qPHjtZRa54bcrOKhB9ga/smdb
         U+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691170316; x=1691775116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qQmF/aDPN/Nd1iFTYAKf0iaoJAfdocEV/pAQRYwbqs=;
        b=Yf7iQwOdmeQ7Cvy0hhKAvsjoPeyYP3kribnS5z6jGibuY8JSKt7zLxZlx6pTWOJViH
         lTw00eXwEshi7y1sXMskbOtC4EeFnjaHSlUFtZJ3t7I988l5/2+kF2IqO2vtzoKO1xMQ
         2bqZCVGQ7c0LJ7o3uJvolCeH1NR7LKU0wkMlhq+ILI49PXyWxhqihjuIXzV5Gp1c9k00
         Vu6KAInS88mEoT7T0OeWzlsvhdMAvaDI3uMIrU2HEKbYPNaqVt2JV9+vPuplbKx4y1m7
         nABiAhsa5LOYraDYSpYRTKhAStdQ3aLV4U0CXbwZOXsu51yErLofbLhxEsdVwXBqY7Eh
         SbyQ==
X-Gm-Message-State: ABy/qLZBKSweqzjhQm93j1zKFIetznaYXuqyKZP8ctIa8IL3/U5KXOCJ
        1geJQqfBBbN0SHIU/d4dqu2trA==
X-Google-Smtp-Source: APBJJlEdzXnBEVkC+oRckNCewl432/bLmEhe9+Wm62NxjTqEJ4fFwsHGLSLh75I/cZUN4QFCJqB/nA==
X-Received: by 2002:a17:903:244f:b0:1b3:ec39:f42c with SMTP id l15-20020a170903244f00b001b3ec39f42cmr24213518pls.5.1691170316247;
        Fri, 04 Aug 2023 10:31:56 -0700 (PDT)
Received: from [172.20.1.218] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b001bbcf43e120sm2024602plb.95.2023.08.04.10.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 10:31:54 -0700 (PDT)
Message-ID: <32b8aef9-061a-bf4b-e3a4-c72a4ecbe27f@kernel.dk>
Date:   Fri, 4 Aug 2023 11:31:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] romfs: only select BUFFER_HEAD for the block based path
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     lizetao1@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20230804102648.78683-1-hch@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230804102648.78683-1-hch@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 4:26?AM, Christoph Hellwig wrote:
> selecting BUFFER_HEAD unconditionally does not work as romfs can also
> be built with only the MTD backend and thus without CONFIG_BLOCK.

I folded this in with the other one and made a note about that.

-- 
Jens Axboe


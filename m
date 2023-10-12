Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673F97C74E9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379652AbjJLRhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347447AbjJLRhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:37:38 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6AEC6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:34:29 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5859b2eaa55so914049a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697132069; x=1697736869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxXWSmNhCNW/OXK7DP6Jnp8axx3k5VLR/sBU6Vx39zs=;
        b=DgtfU2SbYgoU7i+9cXMQFl3xqZskhwp9SyC4j9CL7pRhGxwO/hfM3yKxm7g2aheNBc
         +XnZHP85HatTLGuRm9jWa75G0/NDP17JNRKMtDRz8Wf8l2UBGwuPq9Z3aRwTRW6T7NHh
         FfErH2Fi+f5yfcgj++hMu833Abw1Ba1ooxm+8yNIB/W+EjQ7NZki3os5Y7d5SIRnmS28
         dm08VHh7Fon0ni1A+sRJsFyWEHh4rtDU8CdEWgJLBpLPvAtQDZlyCBI+c1qFY2I+cC8I
         ZxSwW6PTnORtlTe1a3BB4qfO6i2CqPy9ujrRaGvzngI7pwo/YjL5c3zTnQABwhZQNs1j
         iZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697132069; x=1697736869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxXWSmNhCNW/OXK7DP6Jnp8axx3k5VLR/sBU6Vx39zs=;
        b=hb2oy3Lua/RmCvo+YVMSw1LO11ZSDtG19ABvsPYwjAf329ZCR8BIBGjfE/S5iSa0w3
         VV1jFeQUOnV5RA1RvY21M18KlC00e0ORd1BDbHmLHWlR5dToFU67yvMZ6wt2JooTFzgp
         vuGVyo4TeF58ynvcWLPlmtq7v+wLG+Es1Ky6lXj5qiJgm8KPHCnf6T1fz5qPpARDovTy
         6WN7YRs6D+vBf5rdiiOHSay9oRblk4O6aM2IS5BS/3LkOvjSbSEovUVzngP5HkQtJk5z
         yE/ZtVfTAORefJ6zd80RMWpZr4h3UbIvJV89sKGNyTpkgTXcS7kRvjh/Q2ClrtBrIP4L
         FQkA==
X-Gm-Message-State: AOJu0YxBF6wZebqJIHTFJQ7JJBuIn3e5T1jgZgyISjALjcIPAE6/Sd2O
        +kMlfjLMIA9ICjxw3w86+PWa/HoyA/8OVQ==
X-Google-Smtp-Source: AGHT+IHPbuvsKE1+B01ysXg6HZys1Yekto/nLWUsxF+MXPprfQ7BTpGSDysaK4Eyr9+4BlmWqKtH6w==
X-Received: by 2002:a17:902:7248:b0:1bc:10cf:50d8 with SMTP id c8-20020a170902724800b001bc10cf50d8mr21926466pll.23.1697132068645;
        Thu, 12 Oct 2023 10:34:28 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id l10-20020a17090270ca00b001c59f23a3fesm2230912plt.251.2023.10.12.10.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:34:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Oct 2023 07:34:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Use the kmem_cache_free() instead of
 kfree() to release pwq
Message-ID: <ZSguI0D8RUgwlpKc@slm.duckdns.org>
References: <20231011082759.8570-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011082759.8570-1-qiang.zhang1211@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 04:27:59PM +0800, Zqiang wrote:
> Currently, the kfree() be used for pwq objects allocated with
> kmem_cache_alloc() in alloc_and_link_pwqs(), this isn't wrong.
> but usually, use "trace_kmem_cache_alloc/trace_kmem_cache_free"
> to track memory allocation and free. this commit therefore use
> kmem_cache_free() instead of kfree() in alloc_and_link_pwqs()
> and also consistent with release of the pwq in rcu_free_pwq().
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Applied to wq/for-6.6-fixes.

Thanks.

-- 
tejun

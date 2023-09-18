Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8037A5226
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIRSjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjIRSjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:39:06 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0354610D;
        Mon, 18 Sep 2023 11:39:01 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3ab29af398aso3497760b6e.1;
        Mon, 18 Sep 2023 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062340; x=1695667140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbNCRc6jnNBZS939u1reR2uAUdcvd46hdXXQ91lu/cQ=;
        b=VwIRN74q0KhYfZHQJgFmZi6nJrmqSTLarzyPFF0OR1fOJymdpeF7vN50MXVjU17aRd
         fMOjsmCTVmFUQB2OUPrjb7ma3KLSo14F1/C97KtOCqNNln3JnmlsZ8LQoLRrVDovpBo5
         rF3HpvsdY96AbMOmv5aCwLJmVwzeLIEjkfOJycKeqLOnHAWShrEW1gcUVXgujonmD4Cn
         hrTqjkzheSABVGUos8Up+4nYQW8zJdNuzgfH+tV8W5J6Yed1VhAqzcVo01aNVd8gLia4
         UtOs/s4qbss0xmUTTLqML3UgYUCt0TPd7YewyaVDjQuJisWx8erC7EvzQjwP2p+JlRBO
         jSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062340; x=1695667140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbNCRc6jnNBZS939u1reR2uAUdcvd46hdXXQ91lu/cQ=;
        b=J2dPU9BvdFteYR6/b42+DOQDJgApLzmuXkyx2eo7nN1MQxsF6iPKr/QvwYZLfC3DdA
         QesP/UNoUHg12itxMtf8H2IbL56YrGH+u/g12CZ09Bs8ikablns4rmVqFbIzFNuzgGUc
         0JUy6/qMgpukvk6N7Mm8BfhI0l10nAljB49uu4gJbmiBw4ziptigpa7Htx5H+MvhvP9x
         SCOMBZYenHMpMCVPcoGogF/T0zkN/m8O9G9iQLESxjjRFkpckvOcV5JPvi0/6399Fk4g
         C5qlr6kRLCN9YYk3tIEa6f8RsFinUUAveyhcg7PTpC6/KexJgR9zd0bPLaUZ2FSUvWiJ
         SeBQ==
X-Gm-Message-State: AOJu0YyO0IvMOyJkAsOgBq0mf9Rah/Cr5ukHK1oxDhAJswcWaQnKnKd3
        qsh9+qsEzFc7DxY1Cb+nacYz/TK92HcBDA==
X-Google-Smtp-Source: AGHT+IEXhCQqKqEcbJ++hGfTwfzlLufF+PR8XA9CZMXBctFEIM4ClSL4x2OmaIeD2+CHgipENBXB/w==
X-Received: by 2002:a05:6808:8d:b0:3a7:3100:f8b9 with SMTP id s13-20020a056808008d00b003a73100f8b9mr11311772oic.31.1695062340236;
        Mon, 18 Sep 2023 11:39:00 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id t23-20020a656097000000b005740ba1d649sm6186076pgu.88.2023.09.18.11.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:38:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 18 Sep 2023 08:38:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: correct stale comment in rq_qos_wait
Message-ID: <ZQiZQvym5h2FANWC@slm.duckdns.org>
References: <20230914091508.36232-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914091508.36232-1-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 05:15:08PM +0800, Kemeng Shi wrote:
> The rq_qos_wait calls common wake-up function rq_qos_wake_function to get
> token. Just replace stale wbt_wake_function with rq_qos_wake_function in
> comment.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC87277CEAC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbjHOPFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbjHOPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:04:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256B610E9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:04:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26b4cf4f77bso1762499a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692111896; x=1692716696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RT6WNrugPktT0WzLKzKehyy4VYO4wkfZ/M3c3LVEmFI=;
        b=T9hpNUsAw9Wng2+zRSoSkfft3svRVYlQ6eh759ro6nGjTP6EWc1Jxs+eGIsM0w4rMz
         ICmfKqKo/7MIwbP16qYUf7iMccneby+XZxLHSxvLDMkUesJXH0h8umDJTPKw7YjT2ES+
         AaCfAEA8PIXkJT5wSqqkzRqwKS3XOdQ24hFfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692111896; x=1692716696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT6WNrugPktT0WzLKzKehyy4VYO4wkfZ/M3c3LVEmFI=;
        b=RO65yf5Q25cFza1EwZqy9XB1TGAdcLJMFA0w7XTSMaujlt+IFYwqTDTut6YlYUkYUG
         aoMqueELQ5Q+rwGY3qoVNQwm9nCAfvU6uLt10ilFOa5PIdU06a9/uJI8hynxCBm5Yofe
         kbAH8w6AIKkrKI51AkDWNpbAJ+cl35+hq6YBP67WnjyBwYFkBPozyZiURZ1aElwptIEI
         sm7egcB3L90IYUFR+LvQbQ8SpaMl4bINrBj0BvFJrYO4tGGWmY/2X3VkJaMGTgyAIr5j
         KoTa6nC0MnG69f2mVxhZKWPPQg6lF9cJ9eJeRmm/0UJ/hBdhi666aXBWqSffGbjRmfXq
         JQRA==
X-Gm-Message-State: AOJu0YxuASiAov7AG492qrx3qADbrNaYh+52FSJ0yhv6yIM5W7wdfND8
        uf3QS9nzge6QT2D7QsGpQtfatA==
X-Google-Smtp-Source: AGHT+IF+c5I0laTE1tcETPIswMVPJOHUJev/aR8SbWf3quxuPMRsozUFJEdBzKyH5yW29DExs/Kchw==
X-Received: by 2002:a17:90a:fe17:b0:268:2f2:cc89 with SMTP id ck23-20020a17090afe1700b0026802f2cc89mr11952810pjb.4.1692111896552;
        Tue, 15 Aug 2023 08:04:56 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id bx20-20020a17090af49400b002681bda127esm9693931pjb.35.2023.08.15.08.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 08:04:55 -0700 (PDT)
Date:   Wed, 16 Aug 2023 00:04:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Yunlong Xing <yunlong.xing@unisoc.com>, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, enlinmu@gmail.com,
        enlin.mu@unisoc.com, yunlong.xing23@gmail.com
Subject: Re: [PATCH] printk: export symbols for debug modules
Message-ID: <20230815150450.GE907732@google.com>
References: <20230815020711.2604939-1-yunlong.xing@unisoc.com>
 <ZNuDxFGoXPCwECyt@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNuDxFGoXPCwECyt@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/15 15:55), Petr Mladek wrote:
> On Tue 2023-08-15 10:07:11, Yunlong Xing wrote:
> > From: Enlin Mu <enlin.mu@unisoc.com>
> > 
> > the module is out-of-tree, it saves kernel logs when panic
> > 
> > Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> 
> I am fine with it. After all, this API seems to here for
> similar purposes.

Indeed, I didn't know that powerpc uses it.

> Acked-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

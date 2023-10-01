Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D847B494F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 20:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbjJASyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 14:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjJASyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 14:54:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35EA94;
        Sun,  1 Oct 2023 11:53:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31f71b25a99so15717523f8f.2;
        Sun, 01 Oct 2023 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696186435; x=1696791235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3cD6+vLh9d0ZT/ELU9FRBDaG0MrX94eVa84jGJPRbYc=;
        b=j5F4gqElpltv8i3nHLnLvXd5fIh0rJdVa/zUOkc0oqRK9417SLVQed9chMkB6iNgwz
         0wt/pB7Y2DPl4iRdcH50bk3VCsFX50xKMgMoDSxykDLuEVUhzxT7k3Ne2/FviaWS5PpO
         gc/AzPUwxjqq19uR1t0Yvar/ey3xhWT/ZxQcULp7CX7EPIOJuYEYBF+fwMB1AjjzMK3o
         sLVBABzRthsXaIeEfc7nJVOJk6HpTfbmOOpsCBrWZplTUbLviGCq16yy8xpPYjoxZpEJ
         hyjKignNY9PeY25rFuTddrGOKg7RGG98SrYaUo9QxH8KZ4/IeiRR8ZOEh5GotO1aJhSO
         /tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696186435; x=1696791235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cD6+vLh9d0ZT/ELU9FRBDaG0MrX94eVa84jGJPRbYc=;
        b=S0dv4MuKBJqfs0KrT9HBLs1DFMroOHOq+YmPuGDWPp7XNMUBpm52/8afaFir0NI/84
         D6UNFfQsFvg9v5wpYzgVS6oegeI7EcouJkK7jF6aNPc9YWnGTyESIhd0iVg2PfC4C1Wc
         vgHg+O0RN5hgNBZCpbAo28RDEe4K4IjtHBC793XhUXHNaku7sYyTP5CeWFnG4O9kY93j
         mnrf1MuP/cj5rng3jhm1/65vtxkn7R3vQQopYTc2VuZrO9+bsE+VRntmPLMXk61xWTlV
         QwKVP/E096QqlAU9AqMZSSRiC10ndTUFf6dP3e2OEKF2+hfp/uTbEsFEhiz1T6K9Q2Zc
         OWsA==
X-Gm-Message-State: AOJu0YzNHzjxfbn7KXapCQyFAR5nLNl5X2ILsrKFZ7wVvW8oerq9LFbX
        I2gz2JgtrYT07MCV93LF8n/aMTBnsqTVi4byBck=
X-Google-Smtp-Source: AGHT+IFlkqsvcgnhD+3Mg6qa7uqBTqo20BB11WgxJqDc6++w/YY2dF7AwWBvKnyzvQerqV40/qL/GvLz0C61N8ICmq4=
X-Received: by 2002:adf:e583:0:b0:31f:f644:de09 with SMTP id
 l3-20020adfe583000000b0031ff644de09mr8222483wrm.6.1696186434871; Sun, 01 Oct
 2023 11:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230926182625.72475-1-dg573847474@gmail.com> <CAM_iQpUbDR1S6hY6gPhjXrnWCQHGjQZ6JcB27zbauzdBhP76RA@mail.gmail.com>
In-Reply-To: <CAM_iQpUbDR1S6hY6gPhjXrnWCQHGjQZ6JcB27zbauzdBhP76RA@mail.gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Mon, 2 Oct 2023 02:53:43 +0800
Message-ID: <CAAo+4rX0SVNnydubFLx2hfLJtuarnqFtSxGcUiy5O=HH-y_=Sw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Did you find this during code review or did you see a real
> lockdep splat? If the latter, please include the full lockdep log.

No, it is found during static code review.

Thanks,
Chengfeng

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C97BCF54
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 19:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbjJHRHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 13:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJHRHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 13:07:33 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35344A6;
        Sun,  8 Oct 2023 10:07:32 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1dd8304b980so2652338fac.2;
        Sun, 08 Oct 2023 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696784851; x=1697389651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpndYN4f7naEuL14aFLLGfFvBTssPCHabYEQXlCTG3E=;
        b=VqGUuvW3+mz4ry1yKs8kMmWOefDS+PbBxFY9bIV1LGUJ+aDmYhGxFaF4KqZtkmdE/B
         0yCJUx0NaGUs/9vBdG/Xi1j5rGLYEdfF6NBrFfDwlvirNCUO/82GqCIbV7Vvvcv5pTKh
         KAE0keXDkk+vQYE6MmwsPISJDOGvd60VYEM5DQEmtobr6jGLhWzKrZPZ0jt18aISgJb1
         Rs9aP1pf7pZZ1+jhC3uf12w6xUi5Q9h0rohnE9EHZHlkudb8ZwxZt/7J/a1HtPfOPprY
         iuB7VDtuBgy8wtMvdi1FoFTKpWxvqdrqngzhyiLlqOxylxwyNSEW9Mdgd+i4gxXPrnJC
         jXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696784851; x=1697389651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpndYN4f7naEuL14aFLLGfFvBTssPCHabYEQXlCTG3E=;
        b=Ri+vPKR196WqYEScx/xXrLqzu30nADWDhjlxITrrq2159EtNja13/VFSBVyuLCXfdD
         3lV4yhxGRlIcNgTbJg/g6KrqRnxnK4sBC/XM55sWiVHEoNUeLOc6+U+mH8/R1LFPICge
         CrirzQZX2jk8Zbrj5Y2y5vawcY2CjpDeNZa12kcaOTflAQDqGXtusAikVPGzWwT38gJp
         nGvcp0ketOOfYaRZnfHp3qQTD/pMa+CUHyIOFbAkuCtj6ysWyi5M3rIN/8gkxkwtrXwS
         ZKOC2QDjWONN8MQbAiZII3s5YD6yWERdIowGC1FSxUOi4RqkBmXpZg8BLkO0iPoWeSQu
         UDFQ==
X-Gm-Message-State: AOJu0Yy99FdOZtnpH4ouIaV/XKYpFo0UXSSoQ4HO1mD/0O96usIAWGQE
        SgsdfMXIZqpLyTnWZqrtFtg=
X-Google-Smtp-Source: AGHT+IFLn0MNgMl/nwq1QvCpuPP5W6rrVhzun+f+nXejLdFBUwSguuaoZ1pcCJ6yhvOR1sS4ZL/whQ==
X-Received: by 2002:a05:6870:ac1f:b0:1bf:50e0:95d9 with SMTP id kw31-20020a056870ac1f00b001bf50e095d9mr16177181oab.26.1696784851429;
        Sun, 08 Oct 2023 10:07:31 -0700 (PDT)
Received: from localhost ([2601:647:5b81:12a0:a3e9:5a65:be6:12db])
        by smtp.gmail.com with ESMTPSA id f15-20020aa782cf000000b00694ebe2b0d4sm4732282pfn.191.2023.10.08.10.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 10:07:30 -0700 (PDT)
Date:   Sun, 8 Oct 2023 10:07:30 -0700
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     Ma Ke <make_ruc2021@163.com>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv6: fix return value check in esp_remove_trailer
Message-ID: <ZSLh0vtpbP81Vh7G@pop-os.localdomain>
References: <20231007005953.3994960-1-make_ruc2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007005953.3994960-1-make_ruc2021@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 08:59:53AM +0800, Ma Ke wrote:
> In esp_remove_trailer(), to avoid an unexpected result returned by
> pskb_trim, we should check the return value of pskb_trim().
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>  net/ipv6/esp6.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

We need the same change for net/ipv4/esp4.c?

Thanks.

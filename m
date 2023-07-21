Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5670175CE42
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjGUQTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjGUQSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:18:40 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F5444BC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:17:26 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-635dd1b52a2so15028686d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689956245; x=1690561045;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gqfQ3B4+VuBd922SBl1y/3NgJzQmtJe4fT7OCLYNoiQ=;
        b=CqOIyVOX3RihhCbRjjUBKcSr6Y6wwwqdJSqkvDqeoI0LAHT1T5MoMmsbozmtvgrvAv
         Ir2/YV5YOWbV97aPA0erpe3Wfl9Le+S33jqg6/VnUlRyshtX5crcciHOAYgnXKvdr0pU
         wT77av8dFeZlgGqQW5wuXjorFiplm17dPWhU0bs0e8hLCNO0DxVcC4lnddeT/UL9ENXN
         PTrbv7Ni1sNG3iMtwpGlCP4PKwqlZpREsccqfhl/1b9wM9a4BePR+fZgmW/RpESIKt+u
         h2LpS9lX+VQtQxkUODQ2Hesx7sLFcoXjdQiIRnHluB93IBAhJRd47fpg5cGZqqwIBAyg
         vRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956245; x=1690561045;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqfQ3B4+VuBd922SBl1y/3NgJzQmtJe4fT7OCLYNoiQ=;
        b=G6zOF6bTSBBUouHAvQxbI2kXcwK+a5Ve6XNQYZKJyMT2FBrW1GJdzU+OTlchiaQLbV
         uLTNPHzzjBvvYDOLDE21npbHGug2HoKUw+dlphNTi37bM60I+4XAsCgkNm9NHTNU9PnH
         TKu/TSXziKnZJn7GW+oIVbdcuVa9D3NSjZOwAERae6oxax3aPuriYnc9zBpG3KDw5kDq
         UstPvS898m9ByjTer8QUIb+sWF6cEpvp/gmpQvCCfza9oo1KrLXxh/Co90vyD9nRsdma
         3HuPBOWERNm38i+CFnTdUuYrvi9G4eDOMJMqj7KMRPOviiwKcl8uV82D06lH7MvI6P0o
         qu/Q==
X-Gm-Message-State: ABy/qLaTBRZmbisOiKKzuYo9+Ze5tNrDTNm5aXwG25Am7jQCrwwFiz61
        hugGtqC0uf8mZLj1yrvof6bP
X-Google-Smtp-Source: APBJJlE866PIhaxkT6jyhnfTRaN5FvYQVf0UFFdQke701sBz9E36ZY59fHn4miEr6ScoK3KohKURmg==
X-Received: by 2002:a0c:ca12:0:b0:62b:68bf:7c6c with SMTP id c18-20020a0cca12000000b0062b68bf7c6cmr490904qvk.25.1689956245385;
        Fri, 21 Jul 2023 09:17:25 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a109500b00765acdc4f56sm1204696qkk.60.2023.07.21.09.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:17:24 -0700 (PDT)
Date:   Fri, 21 Jul 2023 12:17:24 -0400
Message-ID: <5b6c88a6762d471367b390aa4ac07368.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, <eparis@redhat.com>
Cc:     <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: correct audit_filter_inodes() definition
References: <20230721112101.176222-1-xiujianfeng@huawei.com>
In-Reply-To: <20230721112101.176222-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 21, 2023 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> 
> After changes in commit 0590b9335a1c ("fixing audit rule ordering mess,
> part 1"), audit_filter_inodes() returns void, so if CONFIG_AUDITSYSCALL
> not defined, it should be do {} while(0).
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/audit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/next, thanks.

--
paul-moore.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBE676292C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGZDSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGZDSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:18:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5651C121
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:18:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bba04b9df3so22917475ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690341531; x=1690946331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+54frm2BF9b0x4h3VLTQtdsqR6hdRnwcDLw7C242SeA=;
        b=FGGVTLYwPeR+WMnjwMI4toEthyhRuGbvyo0laNbwGyrJG0Rpc76WpioCPzaTOgNkjp
         oBPVZE33eucPSlzkjVJSs/g06TVbmFgkVHZ+4PeLrOsjBfcdVDgjJsYrHrCIdd0iunPR
         gNSyLeJ2KuvmbCAQDbUxpamCavfrGexiS+w3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690341531; x=1690946331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+54frm2BF9b0x4h3VLTQtdsqR6hdRnwcDLw7C242SeA=;
        b=iNz+ka9X5FDJaq/lwvd9W7gd3GmaQj8nBlCXOXwp+tILiJKIjvVKb5TCigRxkYkfZP
         gzfUPMHwKKMJueUeiA/BJCeRZ4JxDoEKqyA/tnLOJAm2wY2xvtvyUR4DA4aC3S7Rhbw3
         fbxo3TA3LEdS4Jcl9RnIqVQmtL9i6sAgGn+T2DhtnOuoNgZ6a3XByFd869fwnKuq8IEx
         ieKF2ptbhHT8+UE8Hd0VhDLhdo8sqLkWszmKcxzIHUewGL7Q0puZTYA2BYdLwdSqgip7
         hkkqTf4cDLXQFlokfazT/oARz7JVuHT31vH5AdkqGFwXw0FB3AWlvKyhhIceazhcwwsM
         ygSQ==
X-Gm-Message-State: ABy/qLbCI4eyH3RnInAkTXAW7kqwtazsQ5QBmnUVLsx6/mXJkdhewtex
        o0cohYqCsDDPrcxp1pUvRK03oA==
X-Google-Smtp-Source: APBJJlGwD2Cnl6vJMPdr7RWlX1wYQngr8hUuDiRtzOr9laitJN5WR9+Qb8PAnqB/EQPwGUwUOj2fww==
X-Received: by 2002:a17:902:e744:b0:1b8:3e15:40e8 with SMTP id p4-20020a170902e74400b001b83e1540e8mr919513plf.56.1690341530878;
        Tue, 25 Jul 2023 20:18:50 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a2a4:d590:6375:66ba])
        by smtp.gmail.com with ESMTPSA id p21-20020a170902ead500b001b8af7f632asm4039466pld.176.2023.07.25.20.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 20:18:50 -0700 (PDT)
Date:   Wed, 26 Jul 2023 12:18:46 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Yang <andrew.yang@mediatek.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        wsd_upstream@mediatek.com, casper.li@mediatek.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] zsmalloc: Fix races between modifications of fullness
 and isolated
Message-ID: <20230726031846.GJ955071@google.com>
References: <20230721063705.11455-1-andrew.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721063705.11455-1-andrew.yang@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/21 14:37), Andrew Yang wrote:
> 
> Since fullness and isolated share the same unsigned int,
> modifications of them should be protected by the same lock.
> 
> Signed-off-by: Andrew Yang <andrew.yang@mediatek.com>
> Fixes: c4549b871102 ("zsmalloc: remove zspage isolation for migration")

Have you observed issues in real life? That commit is more than a year
and a half old, so I wonder.

> @@ -1858,8 +1860,8 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>  	 * Since we complete the data copy and set up new zspage structure,
>  	 * it's okay to release the pool's lock.
>  	 */

This comment should be moved too, because this is not where we unlock the
pool anymore.

> -	spin_unlock(&pool->lock);
>  	dec_zspage_isolation(zspage);
> +	spin_unlock(&pool->lock);
>  	migrate_write_unlock(zspage);

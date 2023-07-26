Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359297628C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjGZCbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjGZCbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:31:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A84B2696
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:31:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e97fcc60so3720969b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690338689; x=1690943489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPT7rgVOueA/vtWzJH+SEIhz2dNMOJZy5yAUufE6SRM=;
        b=UgZdpL68r9t5pAABfse/TTJsSZCOv4QCHuO+UpNLc2JIjwkZlAaG2LF0WxD2n0oJGw
         s6ZRGmOf0jc46JY6mGqz2vp+udgDBJpl17lS2Is89v9Pfo0DonU3ipUxPBTZOqtDxfno
         K/og2RtGTkQ8iLpLMZDsLHOeGyxVYslQTRUBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690338689; x=1690943489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPT7rgVOueA/vtWzJH+SEIhz2dNMOJZy5yAUufE6SRM=;
        b=Y1tIke9N3GeavNLNurPhqs4qvZO8BmUacuC07iRl4AR/WQNllVI2oLr4h/K7eExv30
         gZadct0R8THIPRz7HLEc5f1ilXt23q32S6gbiOWVwbOQGFiqfqFpi4NZ/V6dJqRzsrh/
         iKqzYKhgS13YT2D+bAcyucl8u33wCiRlYgpbY74U4TbmR0Tw/Kx2Fv+X+Da5sxvYazxX
         iZjQoYunSY0P6WeLnpoH6nAEnaA8loRz5a2e0GmTmH4tAzxUyyX8vJnrBfMHBJHACejE
         DR0oYa17SOJwhj1pINaVZjVP1l78wxlfXV5UTx1xfvh5wMZ2YDQ7h2L+E2zVscqmNCLy
         T6kg==
X-Gm-Message-State: ABy/qLZYK95u3UM6ne4tDAjFDjwm4mehy59rkb6vJwqw0RhoqTO5QhHJ
        MxcjKw9aeRoOfbEhBkiLXogsvVukgwAZ073+D2A=
X-Google-Smtp-Source: APBJJlH2AoOqIXtcjLvfyeaz76cmHZnd/fj7CnIcg6rsc3YAd6G84tjm9xlptvLlZqyVp4X4BgJmGw==
X-Received: by 2002:a05:6a00:17a9:b0:686:6fa8:2b0d with SMTP id s41-20020a056a0017a900b006866fa82b0dmr1180821pfg.4.1690338688739;
        Tue, 25 Jul 2023 19:31:28 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a2a4:d590:6375:66ba])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7848b000000b00686bfbb7353sm325907pfn.184.2023.07.25.19.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 19:31:27 -0700 (PDT)
Date:   Wed, 26 Jul 2023 11:31:22 +0900
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
Message-ID: <20230726023122.GH955071@google.com>
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

Sorry, I don't think I follow. Can you please elaborate?
What is fullness in this context? What is the race condition
exactly? Can I please have something like

	CPU0		CPU1

	foo		bar

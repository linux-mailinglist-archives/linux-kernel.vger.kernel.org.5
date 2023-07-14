Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7212275374B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbjGNKAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbjGNKAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:00:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9214DA7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:00:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fbf1f6c771so2940724e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689328842; x=1691920842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nW17uulaRP+RzVbFI1UVw6jezngQMBzbw6+rTsBgQ78=;
        b=FEaWOpZLavjysJsvR3BbULO6j53U+vn5Phun4cT01xIYLHlJSLFdtHG46xtHuNtDTJ
         1KKts5LWVtDJF2LCN79TLbCStPSYp889j5QIrQqEfcGSYx8ISkfdLNhNQObgIfuIezM6
         Fv1R5G4wNPYfGHCjGsjfkYXp+Ftv3AyE7Z+4gDHbyrTlT7z9I9JzRgSfhQk8TiyDx5Mv
         mnAOX4Ys1SBcp7EJeoaXqYu3xtVrv+OLMfTSRbtN2gM0QVndnaq0ABIQU+CEPXnxWNRs
         kITpjxPO4N625IAjMV7GZP5ngMi+eiUyW0oFqxkecMeeF14M0+Ij396odW0iAddSx8Kc
         JCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328842; x=1691920842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nW17uulaRP+RzVbFI1UVw6jezngQMBzbw6+rTsBgQ78=;
        b=VwBxGjchsBGfXrady7R7OnIGjG9bbXdHJ4pGpnbQ4YEq8205XUTdeSNX8BGIwBw1NM
         BZJJkopmII0xCRCQ4wZD3I9jLvOuZjhG+M3flQS4k7Iog8NTSXSpj+fnOX9xR+TBlfLq
         maY53JrLo6yiudKpGSRARZmZwpKxj35hA8fHBKiVItqgDcu7xQtBusdNZGchYTRwrYWQ
         7o3wo533vObYELawifbG7yXOZBS6bXFdMjVxfhKRj7zlAB7KZV1aTt8YDk6SxNxwnMQm
         AHmV6I9lLjLTc04UxqqvgMrZYQL3z+wK+JdOhfSS6Q8CzRFCwPTtreo7juUdcXgRvY6p
         s0pA==
X-Gm-Message-State: ABy/qLYhYzro0RqxIuWc2c/6rVihtaP+K2NBAbRhH0PiwFo3S0PrBO+r
        D5hMst8pg3LL3V6WWtU14ak=
X-Google-Smtp-Source: APBJJlGGNBWhR2IdwTTuepUBlE9+94vub89vKZOU8jvUrJ/TBvUCAXO+Br8gzdikwbx88q8DtyHtEg==
X-Received: by 2002:a19:2d05:0:b0:4f8:7697:5207 with SMTP id k5-20020a192d05000000b004f876975207mr2979938lfj.23.1689328841558;
        Fri, 14 Jul 2023 03:00:41 -0700 (PDT)
Received: from mobilestation ([85.249.20.77])
        by smtp.gmail.com with ESMTPSA id g15-20020ac2538f000000b004fb881e5c23sm1424489lfh.47.2023.07.14.03.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:00:41 -0700 (PDT)
Date:   Fri, 14 Jul 2023 13:00:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Wang Ming <machel@vivo.com>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        dan.carpenter@linaro.org
Subject: Re: [PATCH v3]  ntb: Remove error checking for debugfs_create_dir()
Message-ID: <ag2uziaj2mbsqryo6ss25w5s3ryenshoylraejtgp46gxce6hh@qcggqjnqheb5>
References: <20230713085621.3380-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713085621.3380-1-machel@vivo.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:56:06PM +0800, Wang Ming wrote:
> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in tool_setup_dbgfs()
> 
> Signed-off-by: Wang Ming <machel@vivo.com>

The patch itself is correct for sure:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

As a side note IMO I would have converted the driver to successfully
probe an NTB device only if DebugFS is enabled and all the DebugFS-nodes
are successfully created. That's because the driver fully relies on
the DebugFS nodes to activate its functionality. Without them being
available it's absolutely useless. The way the test-driver is utilized
is demonstrated for instance in the NTB-test script:
tools/testing/selftests/ntb/ntb_test.sh .

* It concerns all the NTB test drivers...

-Serge(y)

> ---
>  drivers/ntb/test/ntb_tool.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index eeeb4b1c97d2..e0acc11d29ba 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -1495,8 +1495,6 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
>  
>  	tc->dbgfs_dir = debugfs_create_dir(dev_name(&tc->ntb->dev),
>  					   tool_dbgfs_topdir);
> -	if (!tc->dbgfs_dir)
> -		return;
>  
>  	debugfs_create_file("port", 0600, tc->dbgfs_dir,
>  			    tc, &tool_port_fops);
> -- 
> 2.25.1
> 

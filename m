Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABAB7BE6E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377228AbjJIQtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376275AbjJIQtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:49:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C292
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:49:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c0ecb9a075so28384855ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696870157; x=1697474957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FzXP6kwrbxKhnop3+3+cxMONUrHv9NcUFMx6K7cJsPI=;
        b=lM3EYsZB+rn83EPQH+A6cUbmSe1fJV1kIv6ld34mDIZlJovi8ubNJij9kmNeLQDPHs
         t8CPA7RM9fkMt9FgzKqY9XNviuGOFahDoqpPKQ9owEVVtoa9nh5IxkpJlCoMVnWnr5e0
         jyldnXhAOSskXB6rrofSu/0TEh1cyQrPR74CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870157; x=1697474957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzXP6kwrbxKhnop3+3+cxMONUrHv9NcUFMx6K7cJsPI=;
        b=XjLxvxWzcTSNU2yrSB5hMXm1H9wQzFeF/vmiX1NIOmjfWV2YeCdgNWALX/AMm+/uBK
         dwJ6espNlww39JfR7u53WEXQCkBjBPQOiEwcxZWlSu4+INfI6xIbcndl5J8WIFkygqhn
         LzZv/W4dBKSnc73CRIyywQHKz3kdFhuVbpAHMC19eBvcoK7P5Kp6fezgY0uRoeTEfzCT
         sXrwBH8wdrotSffLH6UcSbtEwB3h05iPx8deKzoB9H3qKezizcRzgDGsxrY4tgUC6Lzx
         3mpqob5V+NSXDp42rsWKvJLzciORZwT/mue2q4AFm4V17Lyf8rNAwb+j3cp73rob2Mmu
         pU9Q==
X-Gm-Message-State: AOJu0YzsxiYrLvvIlW/FuPXjJRh7kYNuH1OPU3Mmd7RtiYc6kLRpohL2
        AHjgnbxEGA79C3IFR2l4oxhqNQ==
X-Google-Smtp-Source: AGHT+IGGKRI6y3DdhjXge5W1yLrVgIgQLS2I09uREGzmdSNXWP+DAt+tEmgAftetMyfFTPpw9gI6bg==
X-Received: by 2002:a17:902:ea0c:b0:1c6:3157:29f3 with SMTP id s12-20020a170902ea0c00b001c6315729f3mr15960058plg.36.1696870156869;
        Mon, 09 Oct 2023 09:49:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902ee1200b001a80ad9c599sm9873783plb.294.2023.10.09.09.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:49:16 -0700 (PDT)
Date:   Mon, 9 Oct 2023 09:49:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tests: provide a word-at-a-time test implementation
Message-ID: <202310090949.02D4079AD@keescook>
References: <20231009120455.173862-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009120455.173862-1-svens@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 02:04:55PM +0200, Sven Schnelle wrote:
> Add some basic tests to test the correctness of has_zero() and
> find_zero().
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Yay tests! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

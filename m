Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA25801286
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjLASVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLASVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:21:36 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9FE106
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:21:42 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-286447abfbeso1392185a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701454902; x=1702059702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+Gai+NlAR+6Oq99yI1BFjyn3hyrRU5cVnUGizMPITk=;
        b=mykA4JbkGhdeQg2nCL0stVTM/XQqTqLpSjVIm3UA6lEw0wtbGMVIVzmuvHzi3x1Lag
         VGClgsAa8ipu3+fFFQvcp+vzo/XnGtoDTjVLHmiAxBrarMTQfHm30OpW3ZKhCoDrvvEe
         ItCn5miOX/H2pk795yIcifd95hfyg6UbnQmDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454902; x=1702059702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+Gai+NlAR+6Oq99yI1BFjyn3hyrRU5cVnUGizMPITk=;
        b=QEy60Pt0ud7NuHKxw2lLVZeT2bodlyyfIt8bdefWh9PJyHkNRk/dJdds2Aa8deEwzC
         PyVppP+mA6MFjnCuoUB7lAyChXFxOKsiq3MrlJedrWtd8qGeFBW0O9qjMhcQbTmRjMLE
         RL8FYsCRNcXgOLDX/KQEy9YI6LyX7bUNBra8CmG9a7UdGz3OyuzOD7x3v3FrHj1NZewa
         v9WrjcS0q1CKyaJ/72Yalv43qbIviwOE+SYLoVxmn6SKYxgQrHPGCyH3MmiVbc7YxZxZ
         JkFnt5woYh031LdRSbSDREKhUxQEX40ES46UWx3yFOr5mTQyY2sZjL9wOkoViE3qEUUY
         XUcA==
X-Gm-Message-State: AOJu0Yx5KS1jmoIgmVeLUnK4ew93oOzJlnqA2d6xHwHSiZBraVjYBsgc
        +Hyt0LqGV8a14d8rh6lJB2K4yw==
X-Google-Smtp-Source: AGHT+IE0dZuIaNlCdUpw5zNbkxtxg/0F/q29cFI/xqNR/oMAjQ7qFCHVhVH0wyr8ixJL3sD6bNGh9Q==
X-Received: by 2002:a17:90b:3890:b0:285:b8d2:cad9 with SMTP id mu16-20020a17090b389000b00285b8d2cad9mr25789429pjb.21.1701454902029;
        Fri, 01 Dec 2023 10:21:42 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w19-20020a17090aea1300b002858ac5e401sm135702pjy.45.2023.12.01.10.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:21:41 -0800 (PST)
Date:   Fri, 1 Dec 2023 10:21:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Shahed Shaikh <shshaikh@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qlcnic: replace deprecated strncpy with strscpy
Message-ID: <202312011021.CAA6356844@keescook>
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
 <170138162711.3649080.9337007847087027672.b4-ty@chromium.org>
 <20231130224312.15317a12@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130224312.15317a12@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:43:12PM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 14:00:28 -0800 Kees Cook wrote:
> > [1/1] qlcnic: replace deprecated strncpy with strscpy
> >       https://git.kernel.org/kees/c/f8bef1ef8095
> 
> You asked for changes yourself here, please drop all the networking
> patches you applied today :|

It was a request for future commit logs. But yes, dropped. Justin, can
you refresh this patch as well, and include the comments about the
sizeof() replacement being safe?

-- 
Kees Cook

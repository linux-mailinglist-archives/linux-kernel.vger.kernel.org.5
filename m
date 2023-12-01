Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29CA801278
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379124AbjLASTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLASS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:18:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC19131
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:19:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-285bcb577d6so2302052a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701454745; x=1702059545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/r/b5wB85MlFGGxmClGr6DvtbRffHHrqFc2cNWTq5OA=;
        b=ZTUi7WpSDb9JrgxXhR8Mn9De27rOF3QKwQKZ+qrR1VXDKAoBP83teE3Po6dHcfAHY6
         8ATW/ZwWC57obYIuy+PzzUuc/2Dq6T472DJRAUXHXxC04/IJJzH3DAOVDOfksqnCKTo1
         B6VqqlTW7gov/di+ENcFu/St39frG+D2VwxAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454745; x=1702059545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r/b5wB85MlFGGxmClGr6DvtbRffHHrqFc2cNWTq5OA=;
        b=j3TTxRz5vRLVacjRZT2hXY146lIeGWzioCOam5cncXelvbu8tKeXOjCGxYvg/0fQJN
         lcg0tF+0j44pdDwTth9i5p1p+m9w9DlirrlYYjGyDaxfkDnFBZopNV16YOE843eo7Lx5
         WC+u0DmorBpgGmHgRtHGeG8U3M8ikfkmlYZd3el94b/MWz6M7YN43c0skjuUQNp33hb0
         5QYewZBSK8xR5dEvuZzK28wDCh2Xnh6oI0jNuprDb5gd14Sg0YsWNsuub9xjDE5TAdVA
         BQFqOtFLVBWTAGeD3BZhWbAYBVvzckLv0JAkzlhg97Xhtd3F0oV/6+eaWp7B1pcox1nL
         mALA==
X-Gm-Message-State: AOJu0YxhjWyTjna7bpuJzU5vvh1v4QxteDvnsXTKMNpxgSaQDNDL5NWk
        ZQmuK+f/PU6I3Jaj1tQwD/AJgQ==
X-Google-Smtp-Source: AGHT+IH5qSt9M18U01kU6sw+qA2MJgSEFcLkf+LsZsRTecXMRfrV5OLB5yPRo3yAJ5pGP5A3jCWsgg==
X-Received: by 2002:a17:90b:80b:b0:285:8673:450d with SMTP id bk11-20020a17090b080b00b002858673450dmr26239658pjb.40.1701454745518;
        Fri, 01 Dec 2023 10:19:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q32-20020a17090a17a300b002860a7acca1sm3780052pja.10.2023.12.01.10.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:19:04 -0800 (PST)
Date:   Fri, 1 Dec 2023 10:19:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for
 lan9303_get_strings()
Message-ID: <202312011018.478B0E750@keescook>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
 <170138159609.3648803.17052375712894034660.b4-ty@chromium.org>
 <20231130224021.41d1d453@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130224021.41d1d453@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:40:21PM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 13:59:58 -0800 Kees Cook wrote:
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
> >       https://git.kernel.org/kees/c/f1c7720549bf
> 
> Please drop this, it got changes requested on our end because
> I figured Alexander's comment is worth addressing.

Done. Justin, can you please refresh this patch (or, actually, make sure
the ethtool_puts() series lands?)

-- 
Kees Cook

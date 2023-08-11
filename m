Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2377872A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjHKFz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjHKFzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:55:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7A82D6D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:55:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2680182bc21so975123a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691733352; x=1692338152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OD5ZJXsW01Gkak3C9PDmNcxF6jiUQnE47JaTYXQ2XI=;
        b=KmJ7vo2x2kgxcCOFYtH2hKSHu+0pY2VUNnZpCBbS25LCbKUtxA688X2pLRPq9USzib
         SUIXyKe3IQrJtsvW1BW3eo5YJGPrXCSJVMzZDcXuk5jr83tmrf5PuCtCj2wpE4VcbgcK
         T+S+T323/s0Qx0kVW3cGQ6hnilxAECCDhcmz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691733352; x=1692338152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OD5ZJXsW01Gkak3C9PDmNcxF6jiUQnE47JaTYXQ2XI=;
        b=DKucq2ykopJNL0URs8oMyDC++Ivtd06YnbB/y50Sh7grQFsX9pWxKNfj4KS9AI6VtO
         P8RcHSnBaUUKmLOUaw1ao7ZYF+p8fnpWvYhME05uK2uh5pYis7TsPai1k2I8rWplX9RT
         jZcxUSg7TI+O0kj60EFhbljLpstfIspDfgQgxdrmXXaMq5ccSjTJ59+qwLYOfUBHxTLz
         I+WErC0SFqi/yF7sKQ5xyM+WfT6SYaXrBz3IChW18y7ZSRJGdHot004HmUWTVSiAylT7
         bk3FSXkT2lo0jD2RMm+b5/TwmyK/OyfWRfVTcQIUPCRAZ9t+omvALsMBAPRb51fGOoxc
         mhYg==
X-Gm-Message-State: AOJu0Yw7qbTvoxvYwVEiB9YkT0otReF+wBfxA6YeEDTnKInMf4Abtic/
        cDql9B6/g6Fk84RDZnocBLtWnw==
X-Google-Smtp-Source: AGHT+IG/KPGlnVMvs4ls738U22u+HBpqZA1zXRBdAtInf7cvftgHPpkb2CXU/kZ/s1PD0WUg+5/Ziw==
X-Received: by 2002:a17:90b:1b04:b0:268:13e2:fc91 with SMTP id nu4-20020a17090b1b0400b0026813e2fc91mr449458pjb.31.1691733352385;
        Thu, 10 Aug 2023 22:55:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v10-20020a17090a898a00b00263fc1ef1aasm4350298pjn.10.2023.08.10.22.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 22:55:51 -0700 (PDT)
Date:   Thu, 10 Aug 2023 22:55:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ARM: ptrace: Restore syscall skipping and restart
 while tracing
Message-ID: <202308102254.689CB3F@keescook>
References: <20230810195141.never.338-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810195141.never.338-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:54:17PM -0700, Kees Cook wrote:
> Fix tracing on arm since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall:
> always store thread_info->abi_syscall"). This was seen with the broken
> seccomp tests "syscall_errno", "syscall_faked", and "syscall_restart".

I'd like to get this fixed in v6.5. Russell, do you have a fixes tree
that you'll be sending Linus's way before the next -rc? I can send it
via my seccomp-fixes tree if that'd be easier.

Thanks!

-Kees

-- 
Kees Cook

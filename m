Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10F77681F2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 23:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjG2VII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 17:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjG2VIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 17:08:06 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB3B1BFB
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 14:08:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9a2033978so48631961fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690664879; x=1691269679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=df0j41X3vQ99yevuaGGsVtpCGhFPoGbQqptBVGUtLL0=;
        b=JVqw/E6vJ+zeQv2pJYYhFUIjN6uVQiFzEzWWuPj1ht/efyZTykgi0B5qWANXflXubc
         rYuFLs9cRGQ2UUEvRpVI/UJ4DsVy6weySii/nzsOBxh6QVfSVCUBToxR/B4e5C7RD6+1
         VDMi01EcOD+BijeWsjd6meXj/zrosAnsmPhvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690664879; x=1691269679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=df0j41X3vQ99yevuaGGsVtpCGhFPoGbQqptBVGUtLL0=;
        b=RKZqtbVrOLmMEGb3kN6LHhnHOGmiSRCmXtHHlB00go2TGdUSaQgqYjXW5o1g33vHoB
         7srz4XmW1oFlNHJhVWXkDD5/thQ4PYkGjlyxyep4y922DOJkeapOrtkBsZWeFQTdF2LG
         jnj0NpyipxgMJJvWacfU1vaRQyDul5bnKfvdGIQ0Y6I59jfuzapellFT3P4j92aLAM0j
         nS9FT4AZBsKQn0HhZ8TODzyFjCf7PVJo7LfaCfvxUJ/dOVxzWmOpxBRIxEUj+1glXhZQ
         YtnWHdr8d2jnwcncAfECANRKS8b/GLCLrXD1a201O5taORcYHUyNNcZUZHK8zFeLl7ds
         rKkQ==
X-Gm-Message-State: ABy/qLaT0LlSNExaT6vkMdj/5S4DTxrXPb8MArdvpxUciCl1FZsYiaxM
        IWCIBVcpotsxQMUVG2hdwPwt3aHVSZJV1KFm/+wpjg==
X-Google-Smtp-Source: APBJJlGoUzXmlTtqJwzQdUYHXeE0xIpnf+ts2qBAPMhUvYnLtj79yye88uSVQBbo6CisVJ9Vw2VCkQ==
X-Received: by 2002:a2e:3807:0:b0:2b6:cff1:cd1c with SMTP id f7-20020a2e3807000000b002b6cff1cd1cmr3629633lja.34.1690664879474;
        Sat, 29 Jul 2023 14:07:59 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id z7-20020a170906074700b0099293cdbc98sm3761840ejb.145.2023.07.29.14.07.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 14:07:58 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso4209394a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 14:07:58 -0700 (PDT)
X-Received: by 2002:aa7:c393:0:b0:51e:1a51:d414 with SMTP id
 k19-20020aa7c393000000b0051e1a51d414mr4358469edq.32.1690664878368; Sat, 29
 Jul 2023 14:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230727200041.21404-1-svenjoac@gmx.de>
In-Reply-To: <20230727200041.21404-1-svenjoac@gmx.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Jul 2023 14:07:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
Message-ID: <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
Subject: Re: [PATCH] arch/*/configs/*defconfig: Replace AUTOFS4_FS by AUTOFS_FS
To:     Sven Joachim <svenjoac@gmx.de>
Cc:     Ian Kent <raven@themaw.net>, autofs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 at 13:01, Sven Joachim <svenjoac@gmx.de> wrote:
>
> Commit a2225d931f75 ("autofs: remove left-over autofs4 stubs")
> promised the removal of the fs/autofs/Kconfig fragment for AUTOFS4_FS
> within a couple of releases, but five years later this still has not
> happened yet, and AUTOFS4_FS is still enabled in 63 defconfigs.

Ok, I ran the script, and also decided that we might as well remove
the AUTOFS4 legacy naming stub entry by now.

It has been five years, and people will have either picked up the new
name with 'make oldconfig', or they just don't use 'make oldconfig' at
all.

         Linus

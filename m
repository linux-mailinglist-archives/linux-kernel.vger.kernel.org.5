Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E075A758E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjGSG4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGSGz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:55:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B350F1FC4;
        Tue, 18 Jul 2023 23:55:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so1038271a12.0;
        Tue, 18 Jul 2023 23:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689749756; x=1692341756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=idS0iCzx7eFGMTV38VDkZYqyRsHIoOKLdTk6ADUO6Wk=;
        b=TXj7JYK829kTN42IX87oR+dv1Bhmi/Ytn/BfMsZB/TIzFVzr3ocgR48UlYdmGAfh5V
         gLNDMxuxt+kzJbK+XJ+sF+TGHGlDUjbpANtPNOIA654j8FI0gkOjrG/vVWC5CbiXCfpz
         P7MsvLUxqAA9KZJOwGyT4IcHJ7MUXrhF5uO8sr0B/Vo9rdESAs6tdLVeGVEuHujq+EE6
         WZ3vbGlApM/43BmsAIF56h7zrLF3HvMwEHNoG2/L/8YiTBugtkzsYvFU5H3gG9kXzXxs
         5XEVRyLqXV4JD19Pbrbmdy+AHs+9g4R4ifMRt5Es95eAsQeePO8CM+VtncGVDtK3Z7vu
         M+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689749756; x=1692341756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idS0iCzx7eFGMTV38VDkZYqyRsHIoOKLdTk6ADUO6Wk=;
        b=HlGPryGdbGCcQwbUiUpWerojzhDmemDMFQtTkK2I8+iQ4FeBDCqIVVy+NHtcPMC1tj
         kMe9tESiyZY1fLDg/SQlwe/liRfbiJpmC/+FLRt8UJi+BvNMeCVOq6a8fdoH7YB5XLGP
         D7pnN1nxIdn9szKAyEZxW8l+e8QsfRzAOLA3fTJH1T9LLIf4WqG18jZjqX2DMmr1F1XZ
         LJOofIPUzsHTIntlgQo0cx+OWmDEGO0SGWh8PMNgkB9HC8IN2yDwwJz/k1gEPMg2YccY
         R0NgW2V6Llu+Ozx9MsO+jMpIxgsvtAmo2HIMkPdP4pDGB7IV/9sRwjKby+M/7oK7sPcn
         zvfw==
X-Gm-Message-State: ABy/qLY6tnlV8tn24J19694RYNc7FHZgs3Ol56Js43+QdR/4BXykas35
        OlgBQCNtftMeGIhwZLAJgj64+9mpjmU=
X-Google-Smtp-Source: APBJJlHZi5Ev24UIeyWRbnLbNs4tsiNaZj7bd6/BgxkuOC0d9xKcix3IISSeP9rN4kw5CCIC8fzvUw==
X-Received: by 2002:a05:6402:3c5:b0:51d:e185:a211 with SMTP id t5-20020a05640203c500b0051de185a211mr1304894edw.21.1689749755735;
        Tue, 18 Jul 2023 23:55:55 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id d18-20020a056402079200b0051ddfb4385asm2266405edy.45.2023.07.18.23.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 23:55:55 -0700 (PDT)
Date:   Wed, 19 Jul 2023 08:55:53 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzbot+cf71097ffb6755df8251@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8712: Fix memory leak in
 _r8712_init_xmit_priv()
Message-ID: <ZLeI+b3oXP3hstdg@nam-dell>
References: <20230714175417.18578-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714175417.18578-1-Larry.Finger@lwfinger.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:54:17PM -0500, Larry Finger wrote:
> In the above mentioned routine, memory is allocated in several places.
> If the first succeeds and a later one fails, the routine will leak memory.
> This patch fixes commit 2865d42c78a9 ("staging: r8712u: Add the new driver
> to the mainline kernel"). A potential memory leak in
> r8712_xmit_resource_alloc() is also addressed.
> 
> Fixes: 2865d42c78a9 ("staging: r8712u: Add the new driver to the mainline kernel")
> Reported-by: syzbot+cf71097ffb6755df8251@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/x/log.txt?x=11ac3fa0a80000
> Cc: stable@vger.kernel.org
> Cc: Nam Cao <namcaov@gmail.com>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

I am not qualified to make comments on the code style, but it looks functionally
correct to me. So:

Reviewed-by: Nam Cao <namcaov@gmail.com>

Best regards,
Nam

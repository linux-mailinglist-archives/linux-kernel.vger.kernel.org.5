Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C11752B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjGMULD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjGMULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:11:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5DE2D72;
        Thu, 13 Jul 2023 13:10:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9924ac01f98so155465166b.1;
        Thu, 13 Jul 2023 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689279037; x=1691871037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yreGFvCmpHnziSDHuJXMrwPArv/PIvS/Cz4S/6XBN9o=;
        b=MQ8cTiSmhMxzzKWxx8hq7LNeFS3a7hWxrQdeumfh5bfeBisfhkQj4+bGg6+mtJBtgZ
         UGVHFc/SBdS8WepYaxgHqVYw1XK//Y9oPdUzYLhA6phUhFxgVzvwGdivLXc0AFWA7ZI4
         9rd+WiBHbA9opPbdk/do7WTcn4GwcFmsSm+DEMfTgd9wPKMsf1sg8WLwxyCA+JAf0YUM
         WmI26O1yDduxglzRuhiXAuE9EzJ1GjcCEpuOdWtWlKiB7rnUqmYwZoA41RJoxHBK5JKO
         nKtT/sMVbaYdpD3nXYeN0YfKQ3dG4yH0LnvzU76m5SjolfEQ+wtPHeRaaA6CPGeW0DM+
         BtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279037; x=1691871037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yreGFvCmpHnziSDHuJXMrwPArv/PIvS/Cz4S/6XBN9o=;
        b=lH2KemvBWQTrSPJ3WWKk6pipYCbZ5G6zm/4DeUTpg11lnR4ScgEKx6NbFo8h30Pftn
         HXD3hLHG9dTfDwt327BVfWEOspbGzk64pohAB8/yjaUtC2d2I74PtLXnxFub0uE5Pg9a
         bYbgqIZeQ5/X8mcibXATTC8Uv3NziOn0qTztRh4gR+J5cjJT/8VRgTBvm7yQDrLtHukW
         50WtRnVTkY6RkDwgAL8Lzz0jqr7cA3QzYcYZ93ccXWrZXp+Y2MSIvVHgjFQgsfMaHrB7
         4m0bcDBCbZPeCmTP6q6NU7vHOLK4urdKODkus7Fy2h/jDIsEam0DEZYc8lZvR4Mt/gA2
         SbMg==
X-Gm-Message-State: ABy/qLbAMPJXJSZo20717nqgJ6QM78EjfkDpUOSRcx+jKtot6eDHJOSL
        UsSrdN2bjcYYvSgW5JVKxZA0Ly2IJMw=
X-Google-Smtp-Source: APBJJlFNGTLlZYUpz8EsCiTChVxpbGWOz7UmSy+UjyXaCRtqOEDO7oiQjxyK4Nn+vG63aWiegdD2HQ==
X-Received: by 2002:a17:907:6e24:b0:987:16f5:692f with SMTP id sd36-20020a1709076e2400b0098716f5692fmr2852136ejc.44.1689279036847;
        Thu, 13 Jul 2023 13:10:36 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id x25-20020a170906135900b00992acab8c45sm4450161ejb.12.2023.07.13.13.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:10:36 -0700 (PDT)
Date:   Thu, 13 Jul 2023 22:10:35 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzbot+cf71097ffb6755df8251@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] staging: 7811: Fix memory leak in _r8712_init_xmit_priv
Message-ID: <ZLBaO2/p32h0enDT@nam-dell>
References: <20230712205733.29794-1-Larry.Finger@lwfinger.net>
 <ZLA1942ebuVcUT3h@nam-dell>
 <b684a76e-7d22-fece-5358-f459e4a979ff@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b684a76e-7d22-fece-5358-f459e4a979ff@lwfinger.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:51:00PM -0500, Larry Finger wrote:
> On 7/13/23 12:35, Your Name wrote:
> > The allocation was done in a loop. Shouldn't memory from previous loop iterations
> > also be freed? And allocation by r8712_xmit_resource_alloc() should be freed too.
> 
> Nam,
> 
> You are right on both counts. I will prepare version 2.
> 
> Larry

Perhaps you can make use of my WIP that I didn't have time to finish:
https://github.com/covanam/linux/commit/ee8a0719ec8535f932b30aa67325fc21ba998c50

(Untested and the label names are kind of dumb)

Best regards,
Nam 

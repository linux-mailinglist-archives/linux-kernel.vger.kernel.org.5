Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3947CE343
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjJRRBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjJRRBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:01:19 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFF3B0;
        Wed, 18 Oct 2023 10:01:17 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-581e5a9413bso942539eaf.1;
        Wed, 18 Oct 2023 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697648477; x=1698253277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hr0ycA5aHb6vFQVTChWOwllkgCks7I3a7aaUZga0s58=;
        b=ABCO/awwwHbIMTVqnGp24qorbg0akprQMUcS9TFiRKIsluD4mEElu+OPS/1PyXwscg
         cRTlIW60oXcbs0W8HbhyYHwRYh9OTM5Aj6wQv3nL8jv8HTQYPuSgE+HYxejTkJ3RoqJQ
         wgQvPrzlk6UPl6vYXXXk2qf23BHdVAk2hX6l5wB5Hmnp7+yguZPZ55myutNvzyUhoePd
         eu1ptI029MSa0QVfyTDYVlThSKISFtIb0BVF/e7ExGRinMNIjSGSS1phz20mwFo0bDhy
         Ms+IThkxUzQPsy/pkic5C9NpwtyhRrrBohJdAJzvMW3/RlKA214hFusEVDNzkvQE96cZ
         knJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648477; x=1698253277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr0ycA5aHb6vFQVTChWOwllkgCks7I3a7aaUZga0s58=;
        b=v9rRIOUF2VShTUGKUFogBgKx2NSZ3q+8BdRChaDPCfe7SiHuDOvPS7RSa7LKJk6v+f
         Zx5+ZECM76mGR337TcaZoHNSgaNRuw6ady5pR6mfw+ojs7RVfypjgaJ23njivbFgx8Le
         bAkOeMXpn0syBzOX5/Kpg8BZU5oxENX+Qy0btFgymIuIQfS6zz8aHJdetY7nAoI8yR9P
         YGQvwYIXzwQyLu5IjJGJDRIR1tJg0vhPVXGWC5jh7r+Jfp8uZ2HliFfjzK0afG7kJ7vk
         FNcoUC6RDm5nVmwkAMlRO03Sb+urK9NFkKP3qJSzH+bZRp30UFk/VhAd/+ihR9Vl29xJ
         iqEQ==
X-Gm-Message-State: AOJu0Yyg6XEB1cbgsx67bpcQZt0rnrvUWmYgXgtmRhgRBQOVJOsSIf2i
        rY9TOqzb47pVT/JyRVdl6kg=
X-Google-Smtp-Source: AGHT+IGAR9FT9S+HPbNUPuOZJAwG3+pwoP70aGYbDGxtB3QICfIgpn1ejznN/Qqo1qW4b5zRSrP3bg==
X-Received: by 2002:a05:6358:ed7:b0:166:94b8:da17 with SMTP id 23-20020a0563580ed700b0016694b8da17mr6604656rwh.16.1697648476989;
        Wed, 18 Oct 2023 10:01:16 -0700 (PDT)
Received: from ubuntu ([223.226.54.200])
        by smtp.gmail.com with ESMTPSA id v14-20020aa799ce000000b006bd6a0a4678sm3574595pfi.80.2023.10.18.10.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:01:15 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:01:11 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>, netdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumaran.4353@gmail.com
Subject: Re: [PATCH 0/2] staging: qlge: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <20231018170111.GA3452@ubuntu>
References: <cover.1697568757.git.nandhakumar.singaram@gmail.com>
 <2023101856-visa-unlimited-a365@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101856-visa-unlimited-a365@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:28:30PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 17, 2023 at 12:03:57PM -0700, Nandha Kumar Singaram wrote:
> > This patchset performs code cleanup in qlge driver as per
> > linux coding style and may be applied in any sequence.
> > 
> > Nandha Kumar Singaram (2):
> >   staging: qlge: Replace the occurrences of (1<<x) by BIT(x)
> >   staging: qlge: Replace the occurrences of (1<<x) by BIT(x)
> 
> You have two different patches doing different things yet they have the
> same identical subject lines.  That's not ok, sorry, please make unique
> subject lines as obviously you are doing different things.
> 
> thanks,
> 
> greg k-h

Sorry greg, thanks for your feedback. Will update the patch

Regards,
Nandha Kumar Singaram

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06277C9637
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 22:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjJNUCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 16:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjJNUCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 16:02:45 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531ECB7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 13:02:44 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-351367c8fcdso12486335ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697313763; x=1697918563; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuUrYpvnqDMxLzTPZKkvRFwxUirANKIHNsy0NE09+KA=;
        b=XniL/yl7qxQTTTpLhN39CilgYyXjJ91JlnPjYyQyfRoZdGX/F0Kdg05tS4zLcN5UzE
         yTfh5UhYZDAGZbYq6rbhGzFNIqjoMifaGf3GNXEgsBbvvvh3YS7pvDGOot/EWW/UN0wA
         6G5c1GdxiBrFCAFAQV2xD82n9OuwKucbDE6jYRV8cI379ipeYwOqA/zrhLf6qUF8t5a5
         mMbdPcvgdZB/YKBFaCLrE2jzWAOs89/usHSozzuIaRTv57kJrVAxU5Dh6mcL+9gs2/Sn
         1HX44JJiKIf2mGOQ/H07FWQ6ALvU10gmGidtRG9+CDFjPabZwbn7bF4mpKXtmYxjvRI2
         oRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697313763; x=1697918563;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuUrYpvnqDMxLzTPZKkvRFwxUirANKIHNsy0NE09+KA=;
        b=j5w1hyHsUdhde6FLvt8q4cW7fk+dF2TvO5lplWQizSdou4gzDd/7P4dWELhwgY5FcW
         5Y8BbojkAyWkLNb6UaSMnyGhe5fhiSuLCvfxqmvXdL3PNLiyonwRTgCN/XfpTlMQ8mhu
         kKL/EPLIju54O2QPLHE5S7GYXWgp7NgDQiKwMyePlSaXvTKcTnHTFVC7ZDVrhxFqDRhx
         x/l7o5YjRaUEr19zY6NUL/n39c3rNgq5K70ytNARDBTeE9yb+rNkTHDXQcoAZXJkSCPv
         IUVijmr2ellFCXsJoMvIejgu6vFZ7/ZKzuu1MHj1XTtKy7WJSCsszHY1/XMhWyyPs/MX
         IUjg==
X-Gm-Message-State: AOJu0YzbdmHwPAWg2Rx1LrF66hWQa7ZmW2BMuJA+0Kr14oRgyghJdsP6
        QrnM4WoRdeO6tfb+6l7jZRw=
X-Google-Smtp-Source: AGHT+IHUbuZbMaT4g/6Kg6pA4EQGMHR1Ur43zi07zof3jJPeXKvSW3OtE+/h0wBWLhgGmPzGUlk+Tw==
X-Received: by 2002:a05:6e02:2189:b0:34f:e4e1:b4aa with SMTP id j9-20020a056e02218900b0034fe4e1b4aamr35858798ila.14.1697313763610;
        Sat, 14 Oct 2023 13:02:43 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001c72f4334afsm5903041plc.20.2023.10.14.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 13:02:43 -0700 (PDT)
Date:   Sat, 14 Oct 2023 13:02:42 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 0/4] staging: vme_user: Coding style cleanup patches
Message-ID: <20231014200241.GA20874@Negi>
References: <cover.1697240381.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697240381.git.soumya.negi97@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 04:47:12PM -0700, Soumya Negi wrote:
> This patchset performs trivial code cleanups on the driver 
> staging/vme_user to improve code readability. All patches address 
> issues reported by checkpatch.pl, and may be applied in any sequence.

I have made a mistake here in the cover letter message. These patches need to
be applied in order. I think I will have to send a v2. Will hold off on
sending it just in case any other problems are pointed out by someone after 
review.  

Regards,
Soumya

> Soumya Negi (4):
>   staging: vme_user: Correct spelling mistakes in comments
>   staging: vme_user: Fix unbalanced {} in if-else blocks
>   staging: vme_user: Add spaces around '*'
>   staging: vme_user: Add spaces around '<<' operator
> 
>  drivers/staging/vme_user/vme.c        |   7 +-
>  drivers/staging/vme_user/vme.h        |   2 +-
>  drivers/staging/vme_user/vme_tsi148.c |   7 +-
>  drivers/staging/vme_user/vme_tsi148.h | 548 +++++++++++++-------------
>  4 files changed, 283 insertions(+), 281 deletions(-)
> 
> -- 
> 2.42.0
> 

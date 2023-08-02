Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149AA76D3BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjHBQdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjHBQdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:33:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657C7210D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:33:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c0cb7285fso5918566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690993987; x=1691598787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtBbHYKIwkHKZ0Zqrmo9idEAZ2kRQFP6iegoxSJ/xF8=;
        b=nyKb9bMVISBZ7dNpJYOkoCiXyxEmOCI9gZRLuQogkdq9215mCzlXRBzkCCLsuZOA2e
         EmEUljnteW80VvFZIUl05EDL01fGauesFCtKZXwjG47J7RD9G8NArlHzMciU97wDz4cA
         MZ2t+MLFuWx8EomRcKxmGgOMgqOmbZ1y6c1rKzreyDzbgFxDSJBBN+lpMj61Q7zN/VuY
         Y9O49L0SQ7ttMCde5GtGrK01jMjR4KRe+4HC3AYePi7qS9JVRoySeXebfHTJtasdWHOv
         o4AD9/COfYu9fqtPyjCCwYftPAcsKVzUSmNGQr3BllIQ8Xozos4/jieOBYdngbBeONYa
         wlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690993987; x=1691598787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtBbHYKIwkHKZ0Zqrmo9idEAZ2kRQFP6iegoxSJ/xF8=;
        b=GYF/42R0Ly0WJXfM4iNMZWU6bk5zrRq3gJ0YS73GX3KoH4p49+NnIDfjzr789dzHas
         1lTVpToZWkGwFe6wnCw8KzcZJ6Vuw4ctH3WFYMh9po7zHbt8H2+0fK+yntyB0422rmFR
         kqyvkBokqhBIqca9PBgHeV5sJQ7ynT/wouPPBc/mk0WOShZmo5tpEfh9l5xUgdoe03QJ
         QpokxPCW/2jAgD5HLljJuCuGK61gz+3E0WoGADV6wTRwm3FXwGAta71gJXp1PYzBDfNb
         r8FKGpwKzWEf0zYYvV75kY5XqT585pR6thOQLUHYBp+L+nnd2E1AIyw4u5Ed+4bv38wn
         A0/A==
X-Gm-Message-State: ABy/qLaiWyIYFo/DRmxfTtShceiVZS4e8vdN4H4Ula5Lm4YMaehtSw5Z
        5rOwiwhZydFwhFoOYbwMfUAf0EQYLakcug==
X-Google-Smtp-Source: APBJJlHQReYwlAsIjiFCxJRjnmCI02hfYaU/Kv4cKkDPIqq0vR9s54cFdIccOvObl8ufn9sL9uRiGA==
X-Received: by 2002:a17:906:7787:b0:99b:f8e5:710c with SMTP id s7-20020a170906778700b0099bf8e5710cmr4974203ejm.51.1690993987284;
        Wed, 02 Aug 2023 09:33:07 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id sb9-20020a170906edc900b009920f18a5f0sm9241481ejb.185.2023.08.02.09.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 09:33:06 -0700 (PDT)
Date:   Wed, 2 Aug 2023 18:33:05 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: replace camel case by small case
Message-ID: <ZMqFQbqMCx7Oc7gO@nam-dell>
References: <ZMpZixfZ4WQgpzF1@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMpZixfZ4WQgpzF1@ubuntu.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 06:56:35PM +0530, Pavan Bobba wrote:
> Replace array name of camel case by small case. Issue found
> by checkpatch
> 
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>

Not too important, but this style is usually called "snake case", not
"small case".

Best regards,
Nam

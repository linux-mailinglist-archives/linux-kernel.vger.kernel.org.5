Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD24175EAE9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGXFiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjGXFh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:37:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA568BC;
        Sun, 23 Jul 2023 22:37:57 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so4466526276.2;
        Sun, 23 Jul 2023 22:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690177077; x=1690781877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qr3y5Ojf5ok/sUCcB3SYpJ/LNqYOESYAzKUDTKRvY0Q=;
        b=NnG1oQfDhN1cnVdjF1qetPrwiDxXI6MPGeaAfbaILYY4vyJO6SHru1FSIV+A9jZgjb
         5uFpqauuuQf7aLCxUz6weP4Y7NEmCQKOD82eB20mHoQNhg7pp9IkOYlkC65LlVHNwNAA
         AyG1j7gyxhojHlSlJv1/n8Plv+MShja2lmf2B7tWgUiNGOi3MGcqI7FBTRHktKSMyowF
         xyDvRoTEQ8IND55SajBg+acn8+5mNHvsqC/Iagy5TIdgoZEeENZoUO2xp6utPyUXOnWl
         maRNMUUnsWW9m0z+H114C8QhyRAhUgVRAQn58rtxFRWwsV69xPEroEjw6gSy26e64Dk4
         DZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690177077; x=1690781877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr3y5Ojf5ok/sUCcB3SYpJ/LNqYOESYAzKUDTKRvY0Q=;
        b=LLv8e92Z83nQIZS416hpXi1N/qLxZsGWXuYXNo2a6tDgRwA4Tq9icRMj+KOLEPGlYg
         2yzWvGW3qKKQIYP0n538F4tBZpOaLttvWgJFCOngha/NhFP7cC87aGpEnQWUqwJfMZud
         jTJTqJRvt8lCVBgzsmb2gX3LB7gudkg8xpJxwFVsCcnYV+XDGqb6L9JGu83GHLq8XQV5
         Dwk1wB1dgIPlo9p3h2Fc9ZoYpgvHL/rqd1iM9kUiS+GRWTkLEqejqr0eMmo/Zvt3Adsu
         l+4tkPL2e/dzGEYseoLNv5j0KLQ/aCU05Lb5UtT0mop51kV/TITaKdPSa0rVeGVK1jpz
         k03A==
X-Gm-Message-State: ABy/qLbcFzFkBC9zfNKHl+9Rlgw8x92513VuQSU6nmeiWqMtjuepLQrJ
        ie8F0dauTzRK9QJfEzZmFhERaDlvl1w=
X-Google-Smtp-Source: APBJJlExZU6Hz9BZRDG6IJaYGIHoenJA1wTjop4/oS5bbSID+JtxCkLtI1x0u6IIyMUtvlKkeeYoyQ==
X-Received: by 2002:a25:48c5:0:b0:d0a:8972:abc8 with SMTP id v188-20020a2548c5000000b00d0a8972abc8mr3032365yba.60.1690177077018;
        Sun, 23 Jul 2023 22:37:57 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id b17-20020a17090a8c9100b00264044cca0fsm29287320pjo.1.2023.07.23.22.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:37:56 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:37:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Input: lm8323 - convert to use devm_* api
Message-ID: <ZL4OMt+vF6zqNCSS@google.com>
References: <20230714080611.81302-1-frank.li@vivo.com>
 <20230714080611.81302-8-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714080611.81302-8-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 04:06:11PM +0800, Yangtao Li wrote:
> Use devm_* api to simplify code, this makes it unnecessary to explicitly
> release resources.

LEDs can be managed with devm, as well as we now have better way of
managing custom driver attribute; I posted a series of 2 patches
addressing this.

Thanks.

-- 
Dmitry

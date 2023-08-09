Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A98774FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjHIAlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjHIAlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:41:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E701C10D1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:41:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99cdb0fd093so368572966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 17:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691541674; x=1692146474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53bleXI1rwMamZX0JWcAtU23Wr0BIzKJAx0qsLh8yXA=;
        b=P+2/9o3rsXDweHtlRPZzhxI1iPCzdYp9atAuwlSGbuCtNsTg5F1zH06KhH1cW5Xlyy
         /Km0R6yfUAhnTFrbOCO6sdKHEZ4Y7ljRokGXJXX5dDPTduAIQ8kNl2t+P4Ah84gbtO/1
         cQc0By1FBfOsuEQhzbEWjf6w5eXtd+aEcKNLed5lFmRBL3JXeXJOyvbfNoJx0YPfxghY
         k5AI//fgNi2wlHUiN/f2psVTQBNoVGHFqbdmYKRLu9cf3e6qVMd0KVS5KH74h8v/J9uu
         rv9niSeuRyxYyNwhuLqZZNqWMQ+pPiddBL/eualB55TM9RpcrqiCml9iYLd8BA6LSUmX
         K8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691541674; x=1692146474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53bleXI1rwMamZX0JWcAtU23Wr0BIzKJAx0qsLh8yXA=;
        b=hvkKJhfrrFXMTi/r5W1+uUEdXjUqRhXLiz8YdR1uIsi9NE48mCCEK2sJ5i5WnPSaZG
         l92SQe5vHuhpPC9KSwqZ4IQ6MCfahZ/mZH+Ss4QRlVx/AL+G+DAg9vbOTVj+j4U6dPS0
         eLCA8bazRglqU+YFwk7MGzcoVdTGh3Tr1D6ACEuOZ9FxBxtgezZo5iX9xLa9Kn2WOjU3
         wsb3XYvzF8Qef2/fbRSFGsZ6b/9amZDNqpzRVcZDb2MPqVm6EgMHoNhP431bRIfXk4Su
         eUpWogWbDF4LCjM3eyfeYVlkkynazn2oal5rzM/R1UmD8xG9yhx9T/Pg2pR7Ugu2oaA0
         wlFg==
X-Gm-Message-State: AOJu0Ywq71gEy7OTTt2AYyma0RH/vGAaPVKWbVjxr54fGU31STJpEP7U
        D66Qthb6r3c+h6j4f+4gxwioF/WOWu4HhXQJrMNwuQ==
X-Google-Smtp-Source: AGHT+IH+o2gQmZ+g2rXKzG+WrwjtCAkrRGG17r1COP/wNQau3mqxf/ssgwfBWD/6BXEh19oUwJIUMTL6DpaCyUXau/o=
X-Received: by 2002:a17:906:218a:b0:988:6491:98e1 with SMTP id
 10-20020a170906218a00b00988649198e1mr892372eju.42.1691541674457; Tue, 08 Aug
 2023 17:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
 <20230808-net-netfilter-v1-2-efbbe4ec60af@google.com> <20230808234001.GJ9741@breakpoint.cc>
In-Reply-To: <20230808234001.GJ9741@breakpoint.cc>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 8 Aug 2023 17:41:01 -0700
Message-ID: <CAFhGd8r5LfczABYD3YNmbwH9tJtsr5MQNi6pUMLiZY3Qywo0kw@mail.gmail.com>
Subject: Re: [PATCH 2/7] netfilter: nf_tables: refactor deprecated strncpy
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 4:40=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Justin Stitt <justinstitt@google.com> wrote:
> > Prefer `strscpy` over `strncpy`.
>
> Just like all other nft_*.c changes, this relies on zeroing
> the remaining buffer, so please use strscpy_pad if this is
> really needed for some reason.
I'm soon sending a v2 series that prefers `strscpy_pad` to `strscpy`
as per Florian and Kees' feedback.

It should be noted that there was a similar refactor that took place
in this tree as well [1]. Wolfram Sang opted for `strscpy` as a
replacement to `strlcpy`. I assume the zero-padding is not needed in
such instances, right?

[1]: https://lore.kernel.org/all/20220818210224.8563-1-wsa+renesas@sang-eng=
ineering.com/

Thanks.

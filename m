Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD3877B239
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjHNHTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjHNHT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:19:27 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64147E71;
        Mon, 14 Aug 2023 00:19:26 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34a8bd1a7fbso7130545ab.1;
        Mon, 14 Aug 2023 00:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691997566; x=1692602366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HqNtGwsSULgMECvIXjtwzuQmVgy6JxgBjy21HeKeOCQ=;
        b=oBhPfXlsvIKAXZKcJTu6l5WToHj87XI39B+YS1gfNuzPLsSEEFjGtAbiq5jeuP21FK
         OPDozNKBQlpjqnRoCeO8B3/wpoummcq0edk63L6IUP1wvcIT+lg49oFypJc3DyMdB/Tu
         L5Lbcr25YggfiqabG//dfxCvhwm9MiewlXsNLRnU8JsPOWM06rASp5Tr3K8QMzUpBtxA
         UY3nEqv4slYPg0LwCJ5AVChXRbRgUUeC0S5MupQzXmpl9Dmcq0sBi21zwQqRfMjCaYJp
         tZ/kvJ3tb3IgERJXJqr5UsgPmZ0FQbZ4AAj3GFbA1Zw66DZLS2dShhQOnEwB4BkIX7U8
         x0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691997566; x=1692602366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqNtGwsSULgMECvIXjtwzuQmVgy6JxgBjy21HeKeOCQ=;
        b=gRQ53cVHZp5zVnSr8gidtDTLwL/L1cRA6tnmM6CK0aV/ZFzv9g1+15LikW0nryxvmE
         oT5/CzmqLB521fAeY1rJ9FOg3YDBTCsLZfR0xVi3dlDwWap0+K40lEAukoITPTUw//Vc
         oORItvG8vSwYhtetEriop67uRlBb8sc20MVwDMj9oa0EsiKVHa+JBpVyQx8hcx7TSNGg
         OH+snFubxPGppaWx7iStctLdb58pY/t2WiaSkbUfa0f3p15dTs/rgmMAjEmPnLrJ6UoQ
         L6yzqjhkA4eUcswqKgQNDmllVDq8syah8tOzWnzxbtA1BOyGgzJ2Yz3aEmRVvvjYpHfN
         +/Ww==
X-Gm-Message-State: AOJu0YyYJjrSaigBi2xKr7LZ2yXd2DxjacfE8DhOp+ihel0XT8Knmf4T
        9LFakJ1ONlqJEhe9+shLWEMj1/g5NLTiu+U21JnqLXmv
X-Google-Smtp-Source: AGHT+IFEeQV12Om0jbMo5OdJW3o1Ck3rqSKG/g1Gf/dAUMqAr8SJHR/E/YFXLLMvHHuZvDXbIlimBTQFl7AUsHPoziw=
X-Received: by 2002:a05:6e02:1bac:b0:349:7905:6a61 with SMTP id
 n12-20020a056e021bac00b0034979056a61mr14191927ili.26.1691997565787; Mon, 14
 Aug 2023 00:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230813212343.245521-1-artem.chernyshev@red-soft.ru>
In-Reply-To: <20230813212343.245521-1-artem.chernyshev@red-soft.ru>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 14 Aug 2023 09:19:14 +0200
Message-ID: <CAOiHx==NiPG2GdZNrJn5hPEdi70Spe9Kc9CHO5NjnATAjCgUsg@mail.gmail.com>
Subject: Re: [PATCH] brcm80211: brcmsmac: phy_cmn: Remove unreachable code
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2023 at 23:31, Artem Chernyshev
<artem.chernyshev@red-soft.ru> wrote:
>
> Since wlc_phy_txpwr_srom_read_nphy() in wlc_phy_attach_nphy()
> can not return false it's impossible to get true value in this
> if statement

If they can only return true, then maybe their return types should be
changed to void as well? No point in returning a value when the only
caller is ignoring it.

>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>

Regards,
Jonas

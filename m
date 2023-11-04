Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771A47E114A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 23:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjKDWRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 18:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjKDWRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 18:17:22 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA3DD6D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 15:17:19 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5ae143e08b1so37781037b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 15:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699136239; x=1699741039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFj091NY484IatkiEQTNZzogLvWatap97+ZtL042cRs=;
        b=bQtP0qUgqMze1LOQHt+4smSIw6fTeBhSAPACNoo5vbID0j+aCDrm4bmKvwg9lyqwHu
         KwnbYcLcB9KR3W1xTctTJK2ifdyh6QJiohRzlfC3Go5fDuY3AfvgQ6ztMb6I59zcKTgg
         /lIUAd8LPy12JJOPyaaSBLVulYlqToz6U9KHgEx8YImAHxUYXVMdhoTQmexbiZoZmszq
         Cuh7oNuBtyvlm+vCmqMwZcxWNkddqPF1Z4n7AcGuNwwRBs55Ux3xFKlPD16vkuetoX/W
         XRcs5A15oLFE/dbWIuhh8zqrYXqAoBdLrOUPE4ES9WNDt20rZSvqPkLC+LXr1pNbOnMi
         bUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699136239; x=1699741039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFj091NY484IatkiEQTNZzogLvWatap97+ZtL042cRs=;
        b=N2r/yfy+G7DyZ5WfjIID11fS11+x5R0boAEYUACfqI/BGWrFRIOmB4JEkHn0iII4UX
         tMJQrzMkB75bqnUFKbdGsIjFsA4KWIsuvlGdeBMjID4GSK2bDxqKXaVkqd6UhL0w9brf
         tI+TfhIFQ4lXzdpvR54FTw6cFBFyv9bxOw4KMVawDZFrbxgDXi2/ok5j323ZPnNemQBd
         2DmbTXOn5UYSmgYGkMYgT9ekERFTG3vsWNPK98IUpIVd00aWVDgq39zRGjucg/5dtUn3
         gdyeFC5rj/NoW+gYMWjtU7zJQa+8TijP+ZYtRmGTfqsceFzYD3k/8/HM2m4P86cAsUOu
         DPWQ==
X-Gm-Message-State: AOJu0YxsNhjVZBlE1d/86zzY3NWdbRK6U6Oy2JRfRgdVA3aeLaq17SQC
        4ferIo4+o1hbfBPKbgZ6aQN1DGwlRCSVDDS03CVeKQ==
X-Google-Smtp-Source: AGHT+IHMsx/9Sr5/jGo9tNVECiMnGWjMcLR+eV9W9UNnHt+/Os+5LsdzN9IRgx87prnKDEtH0vwuQurH+Lp6UjR+Cj0=
X-Received: by 2002:a0d:cac8:0:b0:5a7:d412:af32 with SMTP id
 m191-20020a0dcac8000000b005a7d412af32mr6677516ywd.10.1699136238995; Sat, 04
 Nov 2023 15:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
 <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com> <20231104141031.GF891380@kernel.org>
In-Reply-To: <20231104141031.GF891380@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 4 Nov 2023 23:17:05 +0100
Message-ID: <CACRpkdaxC5kAJ3BOG36t=6J273+r7-F7z7He2Y4ihwGT0ptAUA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: dsa: tag_rtl4_a: Bump min packet size
To:     Simon Horman <horms@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 3:10=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:

> In this case it may not have activated the automation, but
> I do see that the patch is now marked as "Changes Requested"
> in patchwork, so all is well.

Yeah, in this case it should even be

pw-bot: reject

because I found the real problem elsewhere.

> FWIIW, pw-bot is (slightly) documented here:
>
>   https://docs.kernel.org/process/maintainer-netdev.html#updating-patch-s=
tatus

Thanks, I'm getting better at it!

Yours,
Linus Walleij

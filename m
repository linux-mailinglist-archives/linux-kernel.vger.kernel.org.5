Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8607C57CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjJKPKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjJKPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:10:39 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C0E92;
        Wed, 11 Oct 2023 08:10:38 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7c08b7744so24486647b3.3;
        Wed, 11 Oct 2023 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697037037; x=1697641837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZ+0EuF5YJZ4tWXxllxg0D8l6wWXIGY7EtMWeHX4c7w=;
        b=KP5qF2OeNpMn93ow74BONaXtJRNUid8+Zudhqm7uiYmRjv9gclPgcRxHdodnzPXKsZ
         hIioP8p4LlEJUJx8cjFG+E6ZYwIlhgUw1rN4UNHp+8Nw5ej7O34YHwmJXjClcG5AN0IC
         EGVap9g6zCYbIHn0Mqf13S5fYml7tfzjbNeu9vaA1kkw/7B/sWVJUjtoYxjCQWzaIKdJ
         W2EzbPgxJL26LGnI4F/5msmGBnXC/k9RDT+npSwd/swpjot6v4GUibpszXvJHijGux6J
         nbpoYK8B78tuG1yM6416JKuDplBrjWWRsn0BOB7zZjyQI9FWM0nhzHzghQcujFNRby85
         VkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697037037; x=1697641837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZ+0EuF5YJZ4tWXxllxg0D8l6wWXIGY7EtMWeHX4c7w=;
        b=ma/mAeQCRfY0ozHuHM+dOKvoEM/EXYVkZJjxAoCl54TQ7GvTN0qhlZkR4/mCiQOIl6
         aINetnQJkRdTwL1WybgrEXM46QwLZeKxm3CdpjqM4pm6/vrtzAYOE7ppER/tGqnpXiUl
         DXdsnj/cuZI971ldDj0NoHaFyI1xSRbm8tQXhkkB6DmYqC3TlFwzKQ9tIT0fqh30qYGb
         XRIMB2W10Hze7My8fS5lh0w5z+EAwU4N2X3SUvfLF9PRhiSAx7bMSrjFfNL27axXxEeh
         /Wcqn9C07jyXaUczK+gJAtmpHRqsW7PhS+AeR9OHbSmzCl21o2jYiHe51KZ8pHhf9xzB
         oAcg==
X-Gm-Message-State: AOJu0YzLsTJepzrw+J1zkvN+pDiNMfeJ0ipQNfDDuCgLjgcZavn75n/A
        P1sF2kCOjAftGVTn4E3TLI3DIjNT5NbEwhk712kQspuj
X-Google-Smtp-Source: AGHT+IGdSl2Whfuh8VaSaCZZjAv8aeW1G1qfz4PqmqtReXfeNe8t6+LxRbeH2GPJZ0VIaIOU4QL1EIZNdb1IVBPiFSg=
X-Received: by 2002:a05:690c:d87:b0:5a5:7ed:cf80 with SMTP id
 da7-20020a05690c0d8700b005a507edcf80mr25137034ywb.23.1697037037500; Wed, 11
 Oct 2023 08:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230906095143.99806-1-aford173@gmail.com> <8cf5b8d1-5f03-438a-94bb-5691dee8cc86@lunn.ch>
 <CAHCN7xJ_2HjQ8iCYimPG+CiMQuDy7YpG2sf6Vq30VsddaSs8CQ@mail.gmail.com> <14224244-836e-4151-86e9-03414aabfe56@lunn.ch>
In-Reply-To: <14224244-836e-4151-86e9-03414aabfe56@lunn.ch>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 11 Oct 2023 10:10:24 -0500
Message-ID: <CAHCN7x+Dzy9+VgJGwHtm3PpW2p3GtQCsm0cdr8imm5KivuB-FQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: ethernet: davinci_emac: Use MAC Address from
 Device Tree
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-omap@vger.kernel.org, aford@beaconembedded.com,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:00=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> > I don't know who the right person is to ask, but is there any chance
> > this can be accepted?
>
> It did not help you did not make it clear who you want to merge the
> patches. It is a good idea to use To: with the Maintainer you would
> like to do the merge and Cc: for the others.

I use ./scripts/get_maintainer to generate a list of maintainers for
the respective patches, and they should have all been CC'd.
>
> What is the state of patches? Has the other patch been merged?  If
> just the driver change is left, please repost is on its own, and
> follow:

The device tree part has been accepted by Tony into the OMAP tree.
I'll split the driver off, do a V2, and just fetch the maintainer of
the driver itself and CC netdev.

>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#net=
dev-faq
>

Thanks!

adam

>         Andrew

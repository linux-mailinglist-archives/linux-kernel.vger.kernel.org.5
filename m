Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D35D765778
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjG0PZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjG0PZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:25:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE832109;
        Thu, 27 Jul 2023 08:25:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fdfd4c749dso6668375e9.3;
        Thu, 27 Jul 2023 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690471535; x=1691076335;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HoTtUL2U0F8o9w8gLl2KsDdaZrr/V4+iLv0Ml6w3sE=;
        b=LlFVC0KQ2PYUt+lVm/JZTmUyvFrp1+yS41YYHy3Q4P8vRdt1lYKNwmI8rmymBGx7AC
         NQgbOsxPtdmHvtmNLMUp3Zs5ymjkO2tJ2YUo8p9XrUWozwehrNk4ytGOms/wDdN0wCJr
         8jXVHMJ7PwAn/MhbNpuOSvHt1OaSYUVr3jEtPVRAt7wzlH5lbh/tiyklpr0JgGYsGYPe
         DZuLm7TIrzthfombrd4O+dV+MSl0yDHsue04iZbJ0Td6pP0M60yTclwT+tDh6QIGXWrG
         xssn5OL3hEQr0SZKnr7OUtXX0kk4TiawL3EfuYwiXv9ayrVYZMCUosYc1T+dS3SZTAzg
         g+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471535; x=1691076335;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HoTtUL2U0F8o9w8gLl2KsDdaZrr/V4+iLv0Ml6w3sE=;
        b=YeQVvNQqlw+Lpia0omFVqKoX6rkjTb6CyUlq2CrPF8FA/lWVV6b/EQfjMMb+a4Y2/1
         z7YtUi1Fo44fAfnPmGec/5OY1ilqz7eOIdXAGx03jwlWqHi9XEx6Sw99R0QPArClAQc3
         EnBGqgs/+rcB1qIv/S1xb0Rf9qmv4pcUES4x92a8e6i03OQDnziVaxrygUAAAsW8ZD7X
         e4u6ZROs8tWemuV6u2UAwQL4P+mS1tJYkDENpbWaagq9O/uLbUpMOHpI6flpb6ooaoz2
         QxSDVOpCh3xSsyQN5SoX949+Rif3OXvSOIvZy9zS5fcJ8W2mFCLV94D+9gZq+qMEHGuP
         zMhg==
X-Gm-Message-State: ABy/qLbBvIPi/XROYfQTBaMUkzGgVnWPoitmXALIZIIi+SCft5mAkBGU
        +SOESuZHkVP5C1p+TxPY++o=
X-Google-Smtp-Source: APBJJlEZjvknLN6rnzSYDeqINRAD16bO1ZVoVhxgYKe4qK/Z15Wln9t3o7ki7Ev/F6QioQMzKRPaMA==
X-Received: by 2002:adf:e8c5:0:b0:313:e971:53af with SMTP id k5-20020adfe8c5000000b00313e97153afmr1952783wrn.32.1690471534575;
        Thu, 27 Jul 2023 08:25:34 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id k8-20020a056000004800b003141a3c4353sm2385404wrx.30.2023.07.27.08.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:25:34 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:25:11 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        dsahern@kernel.org, tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gal@nvidia.com
Subject: [PATCH v3 0/1] net: gro: fix misuse of CB in udp socket lookup
Message-ID: <20230727152503.GA32010@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GRO stack uses `udp_lib_lookup_skb` which relies on IP/IPv6 CB's info, and
at the GRO stage, CB holds `napi_gro_cb` info. Specifically,
`udp_lib_lookup_skb` tries to fetch `iff` and `flags` information from the
CB, to find the relevant udp tunnel socket (GENEVE/VXLAN/..). Up until a
patch I submitted recently [0], it worked merely by luck, due
to the layouts of `napi_gro_cb` and IP6CB.

AFAIU it worked because:
`IP6CB(skb)->flags` is at offset 16 inside IP6CB:
 - Before the patch: `flags` was mapped to `flush`.
 - After the patch: `flags` was mapped to `data_offset`.

`IP6CB(skb)->iff` is at offset 0 inside IP6CB:
 - Before the patch: `iif` was mapped to `frag0`.
 - After the patch: `iif` was mapped to a union of `frag0` and `last`.

After my patch, on the receive phase, while `data_offset` is 40 (since IPv6
header is 40 bytes), `inet_iif` calls `ipv6_l3mdev_skb`, which checks
whether `IP6CB(skb)->flags`'s `IP6SKB_L3SLAVE` bit is on or off (in our
case its off). If it is off, `inet_iif` returns `IP6CB(skb)->iif`, which is
mapped to `napi_gro_cb->frag0`, making `inet_iif` return 0 most of the
times. `inet_sdif` returns zero due to a similar reason caused by
`data_offset` being equal to 40 (and less than 64).

On the other hand, the complete phase behaves differently.
`data_offset` is usually greater than 64 and less than 128 so the
`IP6SKB_L3SLAVE` flag is on.  Thus, `inet_sdif` returns `IP6CB(skb)->iif`,
which is mapped to `last` which contains a pointer. This causes
`udp_sk_bound_dev_eq` to fail, which leads to `udp6_lib_lookup2` failing
and not returning a socket. This leads the receive phase of GRO
to find the right socket, and on the complete phase, it fails to find it 
and makes the throughput go down to nearly zero.

Before [0] `flags` was mapped to `flush`. `flush`'s possible
values were 1 and 0, making `inet6_iff` always returning `skb->skb_iif` and
`inet6_sdif` returning 0, and leading to `udp_sk_bound_dev_eq` returning
true.

A fix is to not rely on CB, and get `iff` and `sdif` using skb->dev. l3mdev
case requires special attention since it has a master and a slave device.

[0] https://lore.kernel.org/netdev/20230601160924.GA9194@debian/

Changelog:

v2 -> v3:
  * change functions to static inline in the header file

v1 -> v2:
  * make functions inline
  * fix logical bug
  * add a comment when we can use the new functions
  * checkpatch fixes

Richard Gobert (1):
  net: gro: fix misuse of CB in udp socket lookup

 include/net/gro.h      | 43 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/udp.c         |  8 ++++++--
 net/ipv4/udp_offload.c |  7 +++++--
 net/ipv6/udp.c         |  8 ++++++--
 net/ipv6/udp_offload.c |  7 +++++--
 5 files changed, 65 insertions(+), 8 deletions(-)

-- 
2.36.1


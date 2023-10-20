Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39577D0816
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346919AbjJTGGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjJTGGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:06:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC7BD41
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:06:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so8526a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697781980; x=1698386780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+KpcMmCI3VUCo8mmukDnMjRaKfX1uWu9XwF6P2O7gk=;
        b=P+Wmh5wBzqhDLj6VjehokqDW9U30UZs+ebQCvVKTTIUH3iHxu6I5EIGJ4yC/pGWYpR
         MahTzH2vvvcGYtfaE4+BmrWloHHkyp2l3ltS9zCV/nj0tyYWLnOzq1t0LRJlATVtzdkh
         CQzp6sqxg4qrUqqIqvmn283mrWtGBs8LSdi/7PH5vimW500v94mDGkG/zMeqEFifDW1B
         7e61yjxfStTch12sUJ96SO9qOX/+VRU3QfZ+GvbzKoC2BX4RmXaolOVtpiJZNoaP8zOd
         1ONNWKJOnjotfIXKx00hF8NKbwLSkriO59aETKNmjw+rgWxqv7pixeHX7F33u6d6tTdp
         E01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697781980; x=1698386780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+KpcMmCI3VUCo8mmukDnMjRaKfX1uWu9XwF6P2O7gk=;
        b=qWmwQsUiPcFm/bnSAndE7lvYHMbEkS+vONvDL6OfCUUQ0GBckKiEDtUv4IdvujJXTe
         FbaI0vbLH4KDoLV/M/zD3rYZGkTCrLdM82NOhChPCdHQh+BtBGHW/ilpde6dstsPzRQC
         HD+PUJGVqGY2myLdcZF8jwmowrAz/FDTyxl+fG0MGcDVrFlBURtjZRBN4/bBmgITTUfz
         r0cnwGWRHjYOiseMkp0VWsMOOnjL9X+7ru3mqmYjrBjmaC0mnC8S0TzqJqAHDBj1j51c
         G90OoO+Mc3EEuEbHi5jLmrYinlNZjLq6dHl4pnWpiXlBzQfsoU86GE4Imk2jNHa+fIA6
         0O2A==
X-Gm-Message-State: AOJu0YznwVt9+SAV7k59WdQs1Hgf9Oxu98Ib+iCmDgZMLU0dgykKrsoe
        9OsqSqDpj2bAZZ86OZRCvaGPzw/gXJU1avX/YixdoA==
X-Google-Smtp-Source: AGHT+IFZb6yUqXDBArx7UAg+OPKTxM16DwwyHfneQxiggc0wpZ7pPj42La/dpln+7xV+yupI3oY6XHXehRMD2odEuSE=
X-Received: by 2002:a50:ccd5:0:b0:53f:3d3d:8b04 with SMTP id
 b21-20020a50ccd5000000b0053f3d3d8b04mr69176edj.2.1697781980284; Thu, 19 Oct
 2023 23:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697779681.git.yan@cloudflare.com> <e721c615e22fc4d3d53bfa230d5d71462ae9c9a8.1697779681.git.yan@cloudflare.com>
In-Reply-To: <e721c615e22fc4d3d53bfa230d5d71462ae9c9a8.1697779681.git.yan@cloudflare.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 20 Oct 2023 08:06:05 +0200
Message-ID: <CANn89iKU6-htPJh3YwvDEDhnVtkXgPOE+2rvzWCbKCpU25kbDw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/3] ipv6: remove dst_allfrag test on ipv6 output
To:     Yan Zhai <yan@cloudflare.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexander H Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 7:32=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> dst_allfrag was added before the first git commit:
>
> https://www.mail-archive.com/bk-commits-head@vger.kernel.org/msg03399.htm=
l
>
> The feature would send packets to the fragmentation path if a box
> receives a PMTU value with less than 1280 byte. However, since commit
> 9d289715eb5c ("ipv6: stop sending PTB packets for MTU < 1280"), such
> message would be simply discarded. The feature flag is neither supported
> in iproute2 utility. In theory one can still manipulate it with direct
> netlink message, but it is not ideal because it was based on obsoleted
> guidance of RFC-2460 (replaced by RFC-8200).
>
> The feature test would always return false at the moment, so remove it
> from the output path.

What about other callers of dst_allfrag() ?

This feature seems broken atm.

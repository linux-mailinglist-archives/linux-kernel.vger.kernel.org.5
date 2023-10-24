Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC097D54B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjJXPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjJXPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:08:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2B5EA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:08:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so12320a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698160113; x=1698764913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN6NTJXQ2pnokdJ55KzUK3vWFKSJONMYwiEEr9XTwTo=;
        b=1WUcBoE5jAg/WuQLxIaaSUMuDWqFijh5KSJJ45vJIyqtDyB07oQ/4NtAU18VhC/p83
         VpOiWXHcOqWWZqo0OuppQNa5PzD+0DxKl5sZHRHHtFTXiNAFfIu9dCMzqNjmoTSS/SWn
         o3IAEuEF6QXneU6odsbyEkZIq9ALN3c8QVdjWhVZzECxYgVfiLvVjQ2JFfDA47kT/mxW
         awtvQNEFcpkNg6OQ1Ughwjvyr5dzB2/IyjQbv7I+ctoSiB9NOIPBGacqMZoupGFsFUWd
         Sklc6tS2O+idM8PPE1gBb7n793FDCfWiaGuSsOvXkMk+n1smRJAUlg5S4aq7hnxt8Y/M
         NpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698160113; x=1698764913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN6NTJXQ2pnokdJ55KzUK3vWFKSJONMYwiEEr9XTwTo=;
        b=fHYqayWu4cqTtNSfQyeubYLd4CPKrwe00ig5t5LtgbxmF5/wCllyDLZxUeBpsJTIkb
         r2VlLmXqADXLqorZv0ZwJkJhiKRgAipHB8PRGRzxkKrvpnr0QXsiBl2F8XBtbAwWDNB2
         tGyR8eJW3ghiRDSs6qGTvt/M0iqwc7jfpMtBXsMDLorjSJVnFkc2u3H+FaYJ0TA3IQ+j
         mqaxlN/lTi8LeAPhc3Sx/HDT4bflKbb3a7PDJaKXejZzGmOu7N/Kjgp9Lj1FjocmmAkN
         Xa2JyA7hJrwhZJqQ86G39oHOWNnhFsj7WK57zoPoAClnNiYHyErKmLuqj5YR95/HJc3R
         KUQA==
X-Gm-Message-State: AOJu0YwvMvvtN53izD2hLUU98cLeMRm8oCijz/XUfCG0AwEIseM+9nuw
        xqGtZp8NWQaCm2iL/yu54+JdP5mrJWcbuKomZTe/CA==
X-Google-Smtp-Source: AGHT+IGDaQwq8PYlqMHnqY7xaD7BvFZBeaYTGKJoUNgOrP7VfmW9tZsV9kzPV1QQiiG7hgxsqnwAs4uvuzS5I3CUNYY=
X-Received: by 2002:a05:6402:241b:b0:540:9fd2:f831 with SMTP id
 t27-20020a056402241b00b005409fd2f831mr126967eda.3.1698160112944; Tue, 24 Oct
 2023 08:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698156966.git.yan@cloudflare.com> <0e1d4599f858e2becff5c4fe0b5f843236bc3fe8.1698156966.git.yan@cloudflare.com>
In-Reply-To: <0e1d4599f858e2becff5c4fe0b5f843236bc3fe8.1698156966.git.yan@cloudflare.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 24 Oct 2023 17:08:18 +0200
Message-ID: <CANn89iK+ektbs1Db=z4+O89HaOLVLK3NbXisWuyLxXQHcpJoNg@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 2/3] ipv6: refactor ip6_finish_output for GSO handling
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

On Tue, Oct 24, 2023 at 4:26=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> Separate GSO and non-GSO packets handling to make the logic cleaner. For
> GSO packets, frag_max_size check can be omitted because it is only
> useful for packets defragmented by netfilter hooks. Both local output
> and GRO logic won't produce GSO packets when defragment is needed. This
> also mirrors what IPv4 side code is doing.
>
> Suggested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE07CAE35
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjJPPvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJPPvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:51:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71365AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:51:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9b70b9671so298645ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697471500; x=1698076300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFeXmQZfEkNQkEz1U5GC4L95YIPIbK2MUFvggu/UIEk=;
        b=p/1x9O/YlsD0FLMxDWPgXcot6xiK2+thKKgxFClxTLnaM7PFDb6N6Oy3FU4Uhw3fZp
         z/HgNPrOyic3n0BvBOrAtHpGSvHEI7SgX6lw2bejeMHisnsP/O1q8T2KuCvgKyMXr6bc
         zLX5R6T75rzriEs9wkFa/a9CTWRI1rPwe+D9JsdtCb1rVbkQGmCjsO9xWFHfSIX82H21
         yo4FmVsoBP7iSJ9cvhUSX9DI0CrpnGG/arUy88jOFznalYKZ9uGiF3EStsWflLgDVnU5
         iVPIP/9ysDdM89rNF//+iQPqborWA4dRpQf7GgpktZZv8DuG5GTpmhpYejS7a8xKL7vf
         aFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471500; x=1698076300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFeXmQZfEkNQkEz1U5GC4L95YIPIbK2MUFvggu/UIEk=;
        b=u1S+h2S8YxlDcHfoAMCrQJFBofWvU3gGL1cbWh1gp31AkwZiLnTRG7mWGAe+SKNNaX
         rDyC0Rxi2zeLhm9KMViZVYvFyoGdgdpzUnY7kFVOQIiBVViXemq5xVsx/ixfG/Y7+ffE
         2KkN7YAtIJ6Y2tFeTfSEc5+wefTsMBC06YRai/cOitTcZJQLAtH0gM0syY27d8uTd8du
         5gKkxMGqHdHBSmTF+D10sszR78/CDOGO9WfOpGMLc2Yduvqv+VxG7b7wx5Bq2BzoTz1u
         /jDWzdpYgQaRAiBh484XDviHg9zVVSk6prnVA2XoKoTtvc1zfodDn6cqn6vLsB81eWXr
         8cyg==
X-Gm-Message-State: AOJu0YxdCVAUqruLb3pNrzjh79F1kwQZMJelffwRm8Ggy2qlWK2dSWZd
        /hftvbBStKMAJ7b63D1SpMz4UWGhMz/gajOTUjhN8cyrNX5BiGYbYmU=
X-Google-Smtp-Source: AGHT+IEmvWfb9yBVNL5GED+BdBq0lbt0TdRkDME7jWGP5D5U9iMQ+561vIu2zwSpQG5s6plvxRrcIBLJ8Ij9QA/YrAU=
X-Received: by 2002:a17:903:40c1:b0:1b8:9551:de55 with SMTP id
 t1-20020a17090340c100b001b89551de55mr321115pld.26.1697471499608; Mon, 16 Oct
 2023 08:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231016132812.63703-1-wuyun.abel@bytedance.com> <20231016132812.63703-2-wuyun.abel@bytedance.com>
In-Reply-To: <20231016132812.63703-2-wuyun.abel@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 16 Oct 2023 08:51:28 -0700
Message-ID: <CALvZod5uy476CBNoxcUUsH4W9Yc7Oqg4yUM9gNK=fKRs_bqidA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] sock: Doc behaviors for pressure heurisitics
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 6:28=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> There are now two accounting infrastructures for skmem, while the
> heuristics in __sk_mem_raise_allocated() were actually introduced
> before memcg was born.
>
> Add some comments to clarify whether they can be applied to both
> infrastructures or not.
>
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

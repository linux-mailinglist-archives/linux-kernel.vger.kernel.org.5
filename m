Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF857BAB6F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjJEU01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjJEU0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:26:25 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAB69F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:26:23 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a50756542cso16831027b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696537582; x=1697142382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+vFXwmp+9tswjf710RHJJtAQWo4CXzsbf/R25OOJto=;
        b=HCKnPK1fVFM2Fy0yEDomfm4PnWgHeKspsIxXI2vr07ZBFJgNesdQr8NErgrCKrfLN+
         RFnA/X3eHHgNaRXpgfNgFsFHjFwPJWyW3jVpeVuod+/PomNT6foiqcwUGqfaUnB9GWax
         CLbUHwWu3jgaL3y+aD7PGOBV3r3ov69rPI96fH1lHoo+605aVgnykNNZvdZ9ovSNSpbh
         DI8o6vYcWXoEj5BPdySBJyo3qnkNggpWdi9DzMjmUxx1YJRd/sPGCunWHKKY0+2YwSmm
         ZWSg5sXCY4KTdYkzU2SE9GdmYzfW8zXWSiZZCCfn7vIG72H9/jL0fHDDfYpIAioTHLeQ
         /4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696537582; x=1697142382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+vFXwmp+9tswjf710RHJJtAQWo4CXzsbf/R25OOJto=;
        b=B0uNEwUJ/7IKyIiYsebIkdaHfpYnWlxENUS9qUl6EKfmQh1GJqjlFn0JgB6q83Akwm
         gdpsBAH1A20HS2EBbf5P/OYMYPCvZYisvSLbQxDPcM/XAENRS2kYI0ZyMOVWmucuMUWI
         WPy2oPoxx4xQX5chE82KE8qiVCiDgBIXDaRCqUQh71Eol3LF1tQ8YKgwXJX10AXd84ku
         2EFComfx7VXzuu/bj0pCQQLLL2ZlCScvR7GCndqtmFwmD1Y82WMNYdnPGchVdG2693bk
         f/F/nL1fI7UsqPD41IVlkwZQJnCWDOs3BEawikOjq0ADbmGhqyHhedfgCFhQ7NzcukD7
         pW9w==
X-Gm-Message-State: AOJu0YyRAiMKzZ5nzP3CUfgthdQvsggf9ZAKpmAAurQJhRqYvs1D7IxE
        7Yv45b42Dw9TZ8TaqwEK/k65j1F8W1eOeJEGPvq8pw==
X-Google-Smtp-Source: AGHT+IEGpzdAhuxSYuqOwe4aCJHv9kTL7tagkbcdujS4GlykXJh/4hKMn94/znw1qMEseb/YeerBjXKnmSgSFHqsr4g=
X-Received: by 2002:a0d:f783:0:b0:58c:b8b4:2785 with SMTP id
 h125-20020a0df783000000b0058cb8b42785mr5719790ywf.45.1696537582399; Thu, 05
 Oct 2023 13:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org>
 <169632602529.26043.5537275057934582250.git-patchwork-notify@kernel.org>
 <CACRpkdacagNg8EA54_9euW8M4WHivLb01C7yEubAreNan06sGA@mail.gmail.com> <0c0b0fade091a701624379d91813cfb9f30a5111.camel@redhat.com>
In-Reply-To: <0c0b0fade091a701624379d91813cfb9f30a5111.camel@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Oct 2023 22:26:11 +0200
Message-ID: <CACRpkdZU6hxqftMmNyu68iVJDmftDYe9tYk7+1bZ4_Ne7CevCw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ixp4xx_eth: Specify min/max MTU
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     patchwork-bot+netdevbpf@kernel.org, khalasa@piap.pl,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 9:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:

> > Sorry Paolo, this is the latest version of this patch, which sadly chan=
ged
> > Subject in the process:
> > https://lore.kernel.org/netdev/20230928-ixp4xx-eth-mtu-v3-1-cb18eaa0edb=
9@linaro.org/
>
> Ouch, my bad :(


It's chill, I already rebased and resent the patch, it's life.

> The change of subject baffled both me and patchwork. As I process the
> backlog fifo, and was unable to reach the most recent versions due to
> the backlog size, I missed the newer revisions.
>
> In the future, please try to avoid subject change. If the subject chane
> is needed, please explicitly mark the old version as superseded, it
> will help us a lot, thanks!

OK in patchwork I guess, I don't understand that tool very well otherwise
I would have done it right, I'll try not to confuse it more.

BR
Linus Walleij

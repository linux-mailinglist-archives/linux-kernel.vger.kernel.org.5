Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1832077D1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbjHOSfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239156AbjHOSfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:35:52 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3433210C8;
        Tue, 15 Aug 2023 11:35:52 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d67869054bfso3874462276.3;
        Tue, 15 Aug 2023 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692124551; x=1692729351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh1O+1gVXI3T9iBOxDxQAR2i9UnYz4TT5ra9BvCc1mg=;
        b=qBmK+aS9ICUojWI119cCyWMNuBSPLRe9lXMq3kfOSGu0GfNjihtVpU82yej5bLvwWl
         glD1OHovQ3tLICx3voxK+rgHFbligdZ0LXnaVs6atEYUer4t3D4t1mqAJDZJT4h0nq+z
         IoDpAMHXuuS5E5qZ/N5aOBKXC99YvQZO2EK4n8GxsXTzQ8dHUQSNuCJv1UDU0paKW4Mv
         375JNjdGdqqlzzj73WMbfN2fmNqaigiiu1QviLrJJwxRgaUWhm13d1uuIeiLKw2xtE8a
         ozTuAFPRNZi1C6w1gXzSh5chVfwR3I9w4M4Th2SZ97Z3Kx5s5nnDhH+LHMySH9utYpUS
         3dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124551; x=1692729351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xh1O+1gVXI3T9iBOxDxQAR2i9UnYz4TT5ra9BvCc1mg=;
        b=Ky76bnG4QQATpaneVq+2Fc79IfmIckosv3QpP5LAMQ25LGJxkK0tdGPkq3u2qCcp0I
         Gwhspwzea5+/Z9PKmbhZIoyV6W+p1JzB4ZBCGzVMAeWfDW7gvcb7vTpSZlhAsNoDbbkz
         rmcoQ6gzLoyMhCNs4bqHoe8qj5hssLzPyP3CbCCJc16x+Caf1ZyZM11DFOlAve7rlKpf
         XT25e0o8DgYQT/0IFddu4II4khDd27UgGuD6jJ89c1SwgBs7otAWe6WCmmbCkQsf1kmR
         tjsqNxnevKEmv73UXNdB09muTYSheMhEqiO+oLlLh9TabWIs7xxOa2uuJvNL5OgNiW2w
         dqkg==
X-Gm-Message-State: AOJu0YyVkoLsvSYpjEA9uX5XodF/KbCkZ+pHmUdY0E8QazdJo2sPcduT
        tO07rM3ak32ZXzXfnGhglTPZsCcGuXcwDwF3mEc=
X-Google-Smtp-Source: AGHT+IGv3yWIjf4c9EUYmkPPQkNN0PjLvswZ93d/AfVlQdfOFwnSFiNKxxAjbWqWSI1xxQ2LIb8fMPtqdQoYMtCCllY=
X-Received: by 2002:a25:d603:0:b0:d42:42f8:93c2 with SMTP id
 n3-20020a25d603000000b00d4242f893c2mr13382566ybg.16.1692124551429; Tue, 15
 Aug 2023 11:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <85964510-4f88-58d2-2687-f7fa76013cf9@amd.com> <87v8dgtb9o.fsf@meer.lwn.net>
In-Reply-To: <87v8dgtb9o.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 15 Aug 2023 20:35:40 +0200
Message-ID: <CANiq72=8DH8SZS2TZF+nHzCq3onXz-OuyE-xmYZncDmiKqVfzQ@mail.gmail.com>
Subject: Re: [RFC] Proposal to relax warnings of htmldocs
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avadhut Naik <Avadhut.Naik@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 8:23=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> As an alternative, of course, we could consider turning off those
> specific warnings entirely for normal builds.

It could be nice to get to enforce warning-free builds as soon as possible.

Perhaps we could move those to a `W=3D1`-like group and clean them over
time instead? Or do we have that already?

Cheers,
Miguel

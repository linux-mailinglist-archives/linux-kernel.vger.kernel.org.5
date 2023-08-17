Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0077FA58
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352833AbjHQPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352811AbjHQPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:08:00 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1237A2713
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:07:46 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso118586891fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692284864; x=1692889664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K3VUBr4xVNyWd1q3Dkt0BFJj2tgIgj7jnvk0NM4tyvY=;
        b=NeWV+rDtQKxXitneCXEm40RYezydwvEO2Y7rZ/De84aIIfeP6G228M9/f+pPnlC/lC
         Q0M1fmJqZXGRpj4VojiTVoc6ZO9ldjHSExEeu+UnJCdH/ylh8g+7U9hDy9dJmVPTMpV9
         fbzrHWoFUJELiZO1beUF37tgm1i8IpVurqpMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692284864; x=1692889664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3VUBr4xVNyWd1q3Dkt0BFJj2tgIgj7jnvk0NM4tyvY=;
        b=WIXF0prIp5GU8kxCY/Ag34xaWzOiQFNYmKf2aUmNkK8+H1daGd1BCMVBoVWr3nRq/0
         pvCV4O0GckRBNOzC5VJbveo8CUYS/sjhiZ4pFMq7EsdZj/z6EKw/lBTpixYi6Kti/qy/
         Xciu583KfHdUe027iffbMgT6OrBaCcGA/GP5Tm3nO0uRVTHv+rQm/EdAYoeLOBFaO/dl
         WMrL4bK4Qgq/vClb5QIyz+1r6Dwe9U5u0ehBD3CcFXsZ9GGiUP34EphEpt3Jiw7jM/mr
         BLxgkgQ/P37hNFVwcnad96qmUbrKz7Eh1nKzNLOez3oDoCG39xQ1Oe4pUjOsRy7u4Hy7
         lA2A==
X-Gm-Message-State: AOJu0YzRrLuGrz0AL6JSBDii6P4QGWwmiJCvxXlya7vwOhsP/XyUeDKm
        4PH39qBUNqLmuzrfH69WRSW6Tkpv/OvdNIIQgzgawo0X
X-Google-Smtp-Source: AGHT+IEIbAlWXTrSPqRyZw9g5DfJNAnuKFwlzk5NR2uGqHC7MgI1Qw5SnoaQce5LBOgiLKWarSfhfA==
X-Received: by 2002:a2e:9e86:0:b0:2b9:dfd0:c3d5 with SMTP id f6-20020a2e9e86000000b002b9dfd0c3d5mr3888718ljk.46.1692284864074;
        Thu, 17 Aug 2023 08:07:44 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 14-20020a05651c008e00b002b1b92910c8sm1254458ljq.86.2023.08.17.08.07.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 08:07:43 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fe8c3b5ca0so12651852e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:07:43 -0700 (PDT)
X-Received: by 2002:a2e:9ad0:0:b0:2b9:e623:c2d8 with SMTP id
 p16-20020a2e9ad0000000b002b9e623c2d8mr4525544ljj.44.1692284365734; Thu, 17
 Aug 2023 07:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <499058D2-E924-464F-BBFE-C15EE6028787@oracle.com>
 <CAHk-=whnm7RyZfy2s4BOdkMz=dMrPJRnH79KVH8rtC1vrV9G1w@mail.gmail.com> <27B358DC-D32E-46F5-B611-A179C6AB2B90@oracle.com>
In-Reply-To: <27B358DC-D32E-46F5-B611-A179C6AB2B90@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Aug 2023 16:59:08 +0200
X-Gmail-Original-Message-ID: <CAHk-=whqj8mRjZWCriZnbUyvtnNwwUJE1Zbg8eandWjk059rkw@mail.gmail.com>
Message-ID: <CAHk-=whqj8mRjZWCriZnbUyvtnNwwUJE1Zbg8eandWjk059rkw@mail.gmail.com>
Subject: Re: [GIT PULL] one more nfsd fix for 6.5-rc
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 at 16:55, Chuck Lever III <chuck.lever@oracle.com> wrote:
> > On Aug 17, 2023, at 10:49 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > I'm sure it's right, but it really smells odd to set that initial
> > offset not when the bvec is created, but long afterwards, just before
> > it is used.
> >
> > Is there some reason why 'bv_offset' isn't initialized when the bvec is created?
>
> Yes:
>
> https://lore.kernel.org/linux-nfs/7c9421cc4b92dee76cc7560c50a4a0ab3fb1ef0d.camel@kernel.org/T/#t

Ugh, how ugly.

> But also note that this fix will get replaced in v6.6
>
> I just wanted to ensure that v6.5 wasn't broken. It's a little late in the
> cycle to apply 383bc8bbc.

Sounds good to me. Thanks for the explanation.

              Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8781275C9DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjGUOYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGUOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:24:42 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45852D71
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:24:38 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-579dfae6855so22615887b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689949478; x=1690554278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8ztgMvA+efivb3zvfwoxg39ThpiIM2mYSu5oGv5kHQ=;
        b=cP8k+YLz02K0HGvAlXEo84L+RFE1hAHgDU85TQL6prNb2Z1x9Kj092DtJQ+5Z2Gnt4
         hX/jQxXF1ZzmY02zOJRUhRX0m8vv8y11XVCAloo/etTo/xIhUNLekzvEpswheDzTvKDq
         fLiAYPbzMigSmG5ENKuoiA3fFM/cctYg3titn8JI/6g9lYQVhSsqkb8ZijuwxRuAL0dy
         r4CqMG1BsTjbP0KyvGOtg12OZIIw8MwesZku+d6/GGIb/qTug06+GGpkGPqCFHvAmiRE
         niRsOFymcfOzvCEF2rT0OcQuzfdz5GiRy6xFtStUT9kUVw9nDcsTZk8fmcnYi/bNS0Jk
         UdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689949478; x=1690554278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8ztgMvA+efivb3zvfwoxg39ThpiIM2mYSu5oGv5kHQ=;
        b=BAX3Cz/cKMs45AlEps35sTkum+CxkAsngl4MuFmHR3FGO0gqQ/JExRUJMJQXwdeFYv
         J/O4/ThDQMT91S23FxRWFKN7ryU9Yblvk9S1+2PqZMRPp5vdUEAWpmLXA4vn5cMdIEMz
         IPJEYumtZKjhufT2KCe15r1paAAQ+jSdc9Q+/VPoV5uTb6nFLs8iu1/+rbvkein6gQ8B
         pC5U4pZWMs9DmD6gtXHAxGESZ+TmQaBI6URnDLkMZb1sD9NfX+sKss+1U1Z5JN7eQD8O
         jwE564lR9QS8qyorNA/OBqlre13XVXesmGxEOI4544R4Zy1R/0CwaU+vLahT9xO8w2eH
         2gFg==
X-Gm-Message-State: ABy/qLaB0GbS8EMDE5K1fvyfX+RcGt7SNwyPgGf0oHkzov4RVlRZ91ix
        BB3EN0+28eWIK4eEBtDtwZotlj3TpgAMvXR1JWC4
X-Google-Smtp-Source: APBJJlGkctnRWeYQSNR/Xwb+OMnSG51UHGgmnhj0crFYLZf3uLEvqoDrwlYGU+rZRaE9jZgtAqzvJN1Wd16AeboXQtE=
X-Received: by 2002:a0d:de84:0:b0:576:777f:28bc with SMTP id
 h126-20020a0dde84000000b00576777f28bcmr209789ywe.21.1689949477988; Fri, 21
 Jul 2023 07:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230721033236.42689-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230721033236.42689-1-jiapeng.chong@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Jul 2023 10:24:27 -0400
Message-ID: <CAHC9VhT3pA12ndrPE_VzgA7_tr2cWVz1jn3QLch+CW9P+B37uw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Use NULL for pointers
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, bpf@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 11:32=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Replace integer constants with NULL.
>
> security/selinux/hooks.c:251:41: warning: Using plain integer as NULL poi=
nter.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5958
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you for your patch, but a patch to address this problem has
already been posted to the list.

https://lore.kernel.org/selinux/20230720203116.316250-2-paul@paul-moore.com=
/

--=20
paul-moore.com

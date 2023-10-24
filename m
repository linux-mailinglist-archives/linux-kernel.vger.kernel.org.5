Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707277D5406
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343734AbjJXO3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjJXO3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:29:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD811C4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:29:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507c8316abcso6125059e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698157746; x=1698762546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF7d4jMMf4MfKI2w84pu3BWkSz+khKl3I43eAdPZFH8=;
        b=UhOO9upf6IAiAOqwTt0PZlCNflI6+1EIhpxFEmTr4ZJCUxAljvIKouDj0GVqyUUELG
         WzLznNZ353OvKc5GSC8ZuP1VQmdZedx+QagiPGqKlNC0ognqirbuoeTgW/X40xZ8eOoG
         1l4Ahv/EAGIbi2RArCMSsHFRkUF/Mw2H5NqJxDkTJDC1K3oDxcmYQtF1OVVqQ5BNCNCN
         P3F7Zyzd4F1UPHpW8+zLHkuucOygd/4oG4XY8epIVMU9gxhq1y8mK8ZLHBFPTFSyZFK9
         ABYu0aUEb1RroAHgw3W5l3oMnFIzpPxQRiZwG5ivuIeLm+lKkqoKZbUshttmTRcR+Ur0
         hnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157746; x=1698762546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VF7d4jMMf4MfKI2w84pu3BWkSz+khKl3I43eAdPZFH8=;
        b=GXadc+mR+iJvV/Rkhhn+NajKz7HfEAgRbC8X3G7qAgaL7CnO8dP9aaSIC5rM//5CRS
         uaCEGCy4CInRZo+xVtH0UFXtY7QQHeioSEoLEHiyIq2BkdyEGnf5KNCC5i/m69XFRm84
         rLhTJRWpgAFV1hZdG2IMBPsPYgom561tksPFAQkgDFeGZHXKfJLOh8T9/GkZ5Px8Snew
         ftvHgC4agbo9orrh7H/XVyc362HV5qUCr0nj/gm/HXGqs4KuvbBCRgxnVUeF1RkpT7jN
         /9IBVFw0/jvFndw2ax0cnZjGH30A1R8IY26hVEeTCJUHmtm0Z6kLI7LG5HaLoNnhoDdH
         C+yw==
X-Gm-Message-State: AOJu0YxYTEDOPxPHXL0hgd6TESAuhOPiZaLWGV6zRpwBhVEvKs5Iycmm
        Xu2swuUO7e8+e5IShV722sXcRv7RjTACZjP9AIHWyQ==
X-Google-Smtp-Source: AGHT+IEaUVpLjkEPg1Gwxq89Vzp9eDheQ49NKLnoKGe7P731lBXW4hmUVsVuOnscqMEw9jdFOmoebDwqlNbVvsERRQY=
X-Received: by 2002:a19:2d5d:0:b0:507:9e6c:e165 with SMTP id
 t29-20020a192d5d000000b005079e6ce165mr7320188lft.50.1698157745751; Tue, 24
 Oct 2023 07:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698114636.git.yan@cloudflare.com> <a79fe77d7308f7e6de7a019f23a509b84cbacd79.1698114636.git.yan@cloudflare.com>
 <20231024102201.GB2255@breakpoint.cc> <CANn89iL8LfGJF2xJP0JhW7sMUXiMdJGAe7jhL0XW3pVMG7cmkw@mail.gmail.com>
In-Reply-To: <CANn89iL8LfGJF2xJP0JhW7sMUXiMdJGAe7jhL0XW3pVMG7cmkw@mail.gmail.com>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Tue, 24 Oct 2023 09:28:54 -0500
Message-ID: <CAO3-Pbohogh1q=20ycPimoPaeAskcAGABvEW=YdZRg3ppRsJ3Q@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/3] ipv6: drop feature RTAX_FEATURE_ALLFRAG
To:     Eric Dumazet <edumazet@google.com>
Cc:     Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexander H Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 5:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Oct 24, 2023 at 12:22=E2=80=AFPM Florian Westphal <fw@strlen.de> =
wrote:
> >
> > Yan Zhai <yan@cloudflare.com> wrote:
> > >  #define IPCORK_OPT   1       /* ip-options has been held in ipcork.o=
pt */
> > > -#define IPCORK_ALLFRAG       2       /* always fragment (for ipv6 fo=
r now) */
> > > +#define IPCORK_ALLFRAG       2       /* (unused) always fragment (fo=
r ipv6 for now) */
> >
> > Nit: Why not remove the ALLFRAG define as well?
>
> I agree, this is not exposed to user space and should be deleted.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> >
> > Otherwise the series looks good to me, thanks!
> >
> > Reviewed-by: Florian Westphal <fw@strlen.de>
> >

I thought there was some convention of not deleting macros. I sent a
V5 to fix this up (not sure if it is the right approach to go) and
carried your review-by tags over since it's just a small change.
Appreciate if there are any more suggestions there.

thanks
Yan

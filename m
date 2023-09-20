Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E57A8D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjITTqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjITTqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:46:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE06CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:46:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c0e7e3d170so37265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695239195; x=1695843995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1gDFWdH+zhoVhcN/66huTv4AT/CGtvploIElj8nrZg=;
        b=tHS8fUa4/jyh/wk980y9NObpf4pHiQK/D0p+YN081RFDJfn9jfWpt4qJrAY4qrjM5m
         lbjokXImvS0JKTwr4AB+xqlrs6ZPrsVrEyFw8lC8g8sox3twN9D2s9hDc1egJyRyS3ZI
         vz65rwJB7Jkuq10+RaiPjdcPPMMGGT1Jp21GYPoatc1shiq2SYFbwJV9LSkZibRasm95
         8Xbkeph6UTZw53rV6I49V8HUj9PSi5uAsUhbvbQIHcMzy5o8O9NSarxG2RJmozqut7TX
         CjEv19jzLUAU7I8VkL4pTgDfurKEQatCwlTfmFdp1rOCwaMRRVHE/mKaw7Z4q7/RyHMr
         enWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239195; x=1695843995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1gDFWdH+zhoVhcN/66huTv4AT/CGtvploIElj8nrZg=;
        b=FuwuzHEXBawqc0iE4cShOf0hff1FtxF1OHUgESgVcQUmyTC+um219bGH2ZGCXIKlel
         jYViYBOS8Sm8v5xV09H2kn4IAXWQ3qfnu9ElGXQX1vM7Ef4CmDOTHoxI7YXg0nl2Cky0
         UfnB88EjXOBDilWCfbvuNomxnvZZQorHgBIhzABwkoe5xDFHNSRZdZz4xtXvo6udCunf
         RWE0LA+GD8zby0v2sxeHN5XGnDFNeSoD6ko/OaVLfkv7KP4tpvt1moGItnMunAAn3oLA
         l//CQnzMkfDY43p5e7wwiOS0LWbaBmXNwnD7TqJUzUvoTubZXq5wFmNjtbV3/CCbLNo7
         ZEsQ==
X-Gm-Message-State: AOJu0Yzbtxx+FqpE7P6HWb2U/p+PqWE+g9Fa9K1QiAT7RAUNdZ1EyEES
        kdayyXmIoA2l9VtJDmK6tHgYYCA+0DCAJevwwVh6/Q==
X-Google-Smtp-Source: AGHT+IH4cJjqSUopETrHJarjPAVi2y0a8t1+QAfpfCzTd4d9SfisXhgNE8Kx5Nor7zgLorMhAVrPgqi+P8d4gPxTggg=
X-Received: by 2002:a17:902:f691:b0:1c1:f658:7d05 with SMTP id
 l17-20020a170902f69100b001c1f6587d05mr39680plg.18.1695239194530; Wed, 20 Sep
 2023 12:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230917191040.964416434@linuxfoundation.org> <20230917191042.204185566@linuxfoundation.org>
 <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz> <101987a1-b1ab-429d-af03-b6bdf6216474@linux.microsoft.com>
 <ZQrSXh+riB7NnZuE@dhcp22.suse.cz> <4eb47d6a-b127-4aad-af30-896c3b9505b4@linux.microsoft.com>
 <ZQr3+YfcBM2Er6F7@dhcp22.suse.cz> <CALvZod7E_Jm9y+40OKtLs5EFA0ptKGjoe2BU58SY29pUiPc93g@mail.gmail.com>
 <ZQskGGAwlsr1YxAp@dhcp22.suse.cz>
In-Reply-To: <ZQskGGAwlsr1YxAp@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 20 Sep 2023 12:46:23 -0700
Message-ID: <CALvZod6b3=+=xXEUeWOQW3t_URJpeeVX46WjBHv5BS+436KoFA@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop kmem.limit_in_bytes
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
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

On Wed, Sep 20, 2023 at 9:55=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 20-09-23 08:32:42, Shakeel Butt wrote:
> > Also I don't think reverting 58056f77502f would give any benefit.
>
> Not reverting 58056f77502f would re-introduce the regression in some
> non-patched versions of Docker runtimes which cannot handle ENOTSUPP.
> So I think we need to revert both or none of them. I would prefer the
> later (option 1) as the fix is trivial but I do understand headache
> of chasing all those outdated deployments or vendor code forks.

I think that would be too much conservative an approach but I don't
have a strong opinion against it. Also just to be clear we are not
talking about full revert of 58056f77502f but just the returning of
EOPNOTSUPP, right?

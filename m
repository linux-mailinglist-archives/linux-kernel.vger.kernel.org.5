Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9144C7A8EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjITVrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjITVrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:47:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5301AF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:47:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c469ab6935so23445ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695246424; x=1695851224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gANn8NVB2NEK8/dkBC5MGqGDIrIr0tBy9ASv9Dt/xcQ=;
        b=jtrGWMQwcRUPRx28PjQyFE1lP8JHYX+I+msSRy140Mtm6CB3rwFPkFGNekz+BPX3y2
         mta3dgdx20Bh+Yw+/GenKkvFYdblncAbOO5yCdJZIVAlMruc4KKZI1YZKiBxqAjWY8JD
         MydmauF2nmaJCNYv9hjJnF3TLb5wLn5rG5ZcZNje2j4ipPfTPi7nKr/k8StSPgMn061L
         uM34lI8YPmp4LNeP40DyFaliAOJjsgRDDDUeDj86MJF7RKclxtmCvpS6gxQ6BGYelTbY
         GvCuExXENGNPQ4XQTWSpdQIjbbO3c5cbSUb8uKqXr+y1SQUXb1MCUSOWwL+5hhVbtYp5
         +j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695246424; x=1695851224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gANn8NVB2NEK8/dkBC5MGqGDIrIr0tBy9ASv9Dt/xcQ=;
        b=TkmnKlZT1xWuh8T5zMjWfL59oONNFfu/eBf0cUJBh3NXRv8V08VIRhKSheuN1HISb7
         k7oaVB9GdTun3gDkAeO/N3KFra2ZqhrHhV+t+ay9Pi+obvsOXCV3nknsWxEbglJdsqJB
         QNTKEA4qr3Lxh+loUGKq5YQb2jd5pVGhctVs9iFRfOD4FE0go8pSfnhDAqyGJJF/tiwW
         g30sFShEgrHinxJIF0z08yKUvtV0LPRIHJg6V+uZQn/scjAXjhsE2vEPQMm7elzMivgm
         agdELq8f/ovMKlkDTL75ESfQNmr0pHLfLnBUqxuayZThd6ft/6nn+SDSeNfamTcIlRV5
         5rGA==
X-Gm-Message-State: AOJu0YwV2Q+t2fm71P2of6n7266AH5dS7Ks58bvghX7TUia7R8nj18a6
        dSzQRqx/KsbUFbLfHykVcmQ04Ru6BsyWlmaZ8+xTiA==
X-Google-Smtp-Source: AGHT+IFXbWfy6csSqRz3YbIOJf32CePT0J0T1e3RUq2k1c/wNw2XTsxo4NBrKI6WzhP+fZJL+GEvVH2o8pllJgrDPj4=
X-Received: by 2002:a17:902:c949:b0:1c4:1392:e4b5 with SMTP id
 i9-20020a170902c94900b001c41392e4b5mr20503pla.21.1695246424078; Wed, 20 Sep
 2023 14:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230917191042.204185566@linuxfoundation.org> <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz> <101987a1-b1ab-429d-af03-b6bdf6216474@linux.microsoft.com>
 <ZQrSXh+riB7NnZuE@dhcp22.suse.cz> <4eb47d6a-b127-4aad-af30-896c3b9505b4@linux.microsoft.com>
 <ZQr3+YfcBM2Er6F7@dhcp22.suse.cz> <CALvZod7E_Jm9y+40OKtLs5EFA0ptKGjoe2BU58SY29pUiPc93g@mail.gmail.com>
 <ZQskGGAwlsr1YxAp@dhcp22.suse.cz> <CALvZod6b3=+=xXEUeWOQW3t_URJpeeVX46WjBHv5BS+436KoFA@mail.gmail.com>
 <ZQtRKzUOfdaVKRCF@dhcp22.suse.cz>
In-Reply-To: <ZQtRKzUOfdaVKRCF@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 20 Sep 2023 14:46:52 -0700
Message-ID: <CALvZod5DSMoEGY0CwGz=P-2=Opbr4SmMfwHhZRROBx7yCaBdDA@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 1:08=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
[...]
> > have a strong opinion against it. Also just to be clear we are not
> > talking about full revert of 58056f77502f but just the returning of
> > EOPNOTSUPP, right?
>
> If we allow the limit to be set without returning a failure then we
> still have options 2 and 3 on how to deal with that. One of them is to
> enforce the limit.
>

Option 3 is a partial revert of 58056f77502f where we keep the no
limit enforcement and remove the EOPNOTSUPP return on write. Let's go
with option 3. In addition, let's add pr_warn_once on the read of
kmem.limit_in_bytes as well.

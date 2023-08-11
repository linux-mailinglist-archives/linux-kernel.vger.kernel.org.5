Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D568C779B3A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbjHKXWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbjHKXVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:21:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9694B30DB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:21:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bf1f632b8so348787466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691796094; x=1692400894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41cGtG6cdoUsfVpP0qVw+Y1Bpx5c38TTy0gk82Cpz6Q=;
        b=i3xYc732/iiDpKNh2N66tltWCbh4Pdkji90m3sEPA3eqCoMvq8rrH9AJKAO0glDt02
         w44/2DktBIECOWW+F4A3uAf6dwRdb6D0PEqfMpyRyoXqPBzuG2mvEJ2l3mK4RKy6MK+K
         tDDPi70JJuqZ/+ewiwLdqaXRRwSCN115ivKPzo/BtizjxXUasab5EaLzt3NL6Jk7oHU/
         rxTQ/uZvmDM4aiHF/qxT+1lYpoPI1pxBto0kRN3eaOBU5cTTYm4b2N2sf0TA6D/mZEYv
         6Hfs6W+y69TyEW53KcWe9KHzOMAL+O29tHUOuJ8wx+hT+ofM/WY/u7t6CmK53NJe5nTq
         M+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796094; x=1692400894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41cGtG6cdoUsfVpP0qVw+Y1Bpx5c38TTy0gk82Cpz6Q=;
        b=WTo4YP3IEiNpiRdbRXuQ2FOCCg6sOYE+/Gy41pleBsqcDcGRpbvMjwDeOpzNL+Ql5F
         eI5ZWhfgeRGa1T7cEPk6hquNVWCRaD4VEea5eEeNF95Ha4qPQUm0nalYkN3g0S+/c6Sz
         F/FnBv8luYiiARZkJ4xixSq7xzO+lcZc0ePS0AzdGnDfuXgwE/2afv+MO+tfeQt2iNMH
         u1J000nBV8Ar0O9EifEqffJWZfhucUkE4DHtyl/zdUdAb+LW3ieUgMydw6xc+evyX52L
         qru0tD/QNTmem+Sgdc8tWC64IYB6zCER/ATNagPfEFxYd1ss7LMGbU8sQb0hQHhERfuH
         5jgw==
X-Gm-Message-State: AOJu0Yx/6Oo9yOyLtvJ3BlMS078ibpql+lXk38+iXLoEFyF5iBRqJCCy
        dppnR41fl1Jssc21E0IVU8NTuz1k9HTH9gOekp89MQ==
X-Google-Smtp-Source: AGHT+IFsPB8co56cHDOqbaePaJ0/dhH50ArKYwr/+PHCZSEHSYO0iewdDv3H/FJuolhANWWjoh89CFtRuPwqSPnPPxw=
X-Received: by 2002:a17:907:784d:b0:99c:e1f4:271f with SMTP id
 lb13-20020a170907784d00b0099ce1f4271fmr2988726ejc.18.1691796094347; Fri, 11
 Aug 2023 16:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230620194644.3142384-1-yosryahmed@google.com>
 <CAKEwX=OLR02MazB31wR-nphjZJvBHrm5Zy7hLPByZ3ubgO8mjw@mail.gmail.com>
 <CAJD7tkZ7dLwny7-CX7qCywZPtki+fDuESGfv+B9QG87cSsrHVQ@mail.gmail.com> <20230811141920.2f9bab6f21ab635ff1bd63ac@linux-foundation.org>
In-Reply-To: <20230811141920.2f9bab6f21ab635ff1bd63ac@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 11 Aug 2023 16:20:57 -0700
Message-ID: <CAJD7tkbfKxCOoxNCgtbaAg4LXFbf=afaxei0SbKU2B=HFpPf6Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm: zswap: multiple zpools support
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nhat Pham <nphamcs@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Fri, Aug 11, 2023 at 2:19=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 13 Jul 2023 03:35:25 -0700 Yosry Ahmed <yosryahmed@google.com> wr=
ote:
>
> > >
> > > I'm experimenting with some other zswap changes - if I have
> > > extra cycles and resources I'll try to apply this patch and see how t=
he
> > > numbers play out.
> >
> > That would be amazing. Looking forward to any numbers you can dig :)
>
> So this patch seems stuck.  I can keep it in mm.git until the fog
> clears, but would prefer not to.  Can we please revisit and decide on a
> way forward?

Johannes did not like a config option so I proposed it here as a
constant (like SWAP_CLUSTER_MAX and others we have). This is a value
that we have been using in our data centers for almost a decade, so it
has seen a ton of testing. I was hoping Johannes would get time to
take a look, or Nhat would get time to test it out, but neither of
these things happen.

I obviously want it to be merged, but hopefully someone will chime in here =
:)

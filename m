Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB4C77D67A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbjHOXAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbjHOXAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:00:02 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54B51FCE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:00:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5650ec45a7cso3485574a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692140400; x=1692745200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cMcDZ8u4QXqlKEKuadKRcWWAH9liLNOPn0kivqsMbQ=;
        b=hT6pWaQXflgGvi4PKJEzKA9fyAUFUWmgipUYHnKxzjcwxNNrCXpfPE3EQRmkHzQ+8Z
         QW4A2dzuG88ENL6MFNGTME4ffjI12q7p/9in21baCwnL3nYMXpgWk9yJsHCYBQNv9hos
         cluwFSxQkjhBgs2EDGxN0a3SP5KfEYuov22Qy6caF1YW7en/PQOJuXO8YuY6eW8DCec+
         IcPbzJ4jQ4U1R8up04AEIUPzPgE2JGOipmiXBtDgvS9AWjrGfzYcxvodnYOvWWZRQ6oz
         SSLdaSESf98Ckyk/3md9aJHOD0lvm2PiUH+ZrS3YGTYe592/g48ddAk1Npu0/xjJOe4y
         9F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692140400; x=1692745200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cMcDZ8u4QXqlKEKuadKRcWWAH9liLNOPn0kivqsMbQ=;
        b=N+8DqtnA1vB7X8axBwJHACCWhbXFIgAl3AMN3WIIjbZCu+LCqLZpg4r1C7WCJQ8T1T
         MugIdKoa9NTGTRbYZcWhrqAcD8kTbYVr0P0EDeuMfewfSi0e6PRavKSef0z+zdF8OZci
         ZkERCGVe1RUXAHEUcpMJYWJqshuhf0/ShX0rIcrzAUbR2o4JNGQtEc+HUdCr7WKp/rne
         wcF5Xn5RelzrB4NeepWOqZFYmjaDr0zjdLhC70cQYgOw2O38bvffNGDUMh84itqhN+Uo
         lJLFD9Ss0kEah549ZqB2cBY3RH5N02JO4PsEoy2v+gDybbVhn1srT8qzdPjfgjTh9jok
         rwzw==
X-Gm-Message-State: AOJu0YzfHwoyM0bEGoj1CGRMik8nJc3tzWhzb5tv3lCsf0j8SY0KsB1a
        MDSyEzBvuK4kbXrXGZIQqwMx4t3OwtXzbM3Ecp0M4Q==
X-Google-Smtp-Source: AGHT+IG1hoYNPfeMlPFtFc094g+68RVzeeOzOIred3Tbx17HYLf2pJJeKElhEI8OAJKD0W7Qhu3s0CJHhla+3WYZoAo=
X-Received: by 2002:a17:90a:f686:b0:268:c5c7:f7ed with SMTP id
 cl6-20020a17090af68600b00268c5c7f7edmr4628pjb.30.1692140400076; Tue, 15 Aug
 2023 16:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230620194644.3142384-1-yosryahmed@google.com>
 <CAKEwX=OLR02MazB31wR-nphjZJvBHrm5Zy7hLPByZ3ubgO8mjw@mail.gmail.com>
 <CAJD7tkZ7dLwny7-CX7qCywZPtki+fDuESGfv+B9QG87cSsrHVQ@mail.gmail.com>
 <20230811141920.2f9bab6f21ab635ff1bd63ac@linux-foundation.org>
 <CAJD7tkbfKxCOoxNCgtbaAg4LXFbf=afaxei0SbKU2B=HFpPf6Q@mail.gmail.com>
 <CAF8kJuPhP4q5ObisoyWZ0QdqUrTeNBec3P36PNz=KHLiXW6SrA@mail.gmail.com> <CAJD7tkZ21fcwS=m4RuctR4H7dG+NvFQgcc_-Bi6Et73ULgc1kw@mail.gmail.com>
In-Reply-To: <CAJD7tkZ21fcwS=m4RuctR4H7dG+NvFQgcc_-Bi6Et73ULgc1kw@mail.gmail.com>
From:   Chris Li <chriscli@google.com>
Date:   Tue, 15 Aug 2023 15:59:48 -0700
Message-ID: <CAF8kJuMj1ioKwt9b+JvLNHEpOLEjo+=RyY9z8yELhhNN1udrtg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: zswap: multiple zpools support
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Yosry,

Sure.

Ack-by: Chris Li (Google) <chrisl@kernel.org>

Chris

On Tue, Aug 15, 2023 at 3:30=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> I was hoping we can add the basic support here for multiple zpools,
> and then later, if needed, extend to support runtime dynamic tuning.
> Adding this will introduce more complexity as we will need to lock all
> trees and make sure there is no activity and alloc/free zpools. If a
> limitation for compile-time constant is observed we can do that,
> otherwise let's keep it simple and incremental for now.
>
> FWIW, we have been running with 32 zpools in Google's fleet for ~a
> decade now and it seems to work well for various workloads and machine
> configurations.
>
> >
> > Chris
> >
> > > has seen a ton of testing. I was hoping Johannes would get time to
> > > take a look, or Nhat would get time to test it out, but neither of
> > > these things happen.
> > >
> > > I obviously want it to be merged, but hopefully someone will chime in=
 here :)
> > >
>

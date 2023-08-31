Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF9878E4A4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbjHaCFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjHaCFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EA8C2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 19:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693447462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qS9DIY2LuvUPjop/XQ0XRMN/MyTWTk1wrQjx1uhvL9U=;
        b=bVzh9s1MWnV525Ba8ERLtimc8aVg4RiD1c70cd4+yqS62EOra4v9yy1GNxAkA94U1+VTO6
        kDQyXh6OY9XhRByW5qQxfGLxoD1gCc033a7uABapaQVzhqZoYXiRuzGS/9n5EYiqODbs/a
        /mXgU0dURSAJZjMuXgsnJM2QUePxjOA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-2VhqkW1BMaqA-FOBPVSjKw-1; Wed, 30 Aug 2023 22:04:21 -0400
X-MC-Unique: 2VhqkW1BMaqA-FOBPVSjKw-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-57128334fb2so504109eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 19:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693447460; x=1694052260;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qS9DIY2LuvUPjop/XQ0XRMN/MyTWTk1wrQjx1uhvL9U=;
        b=Y0Nw5MYY23WOeZUwmOR5iwbBiHXy93IB/VpUA1mM6GJ/P7xbdL/KB72aZhYobH5W/A
         xUkEZjxfBwHRk1MHifOFaLWkaE6a4U0psarLCxbweNr1823rNScYN4JXPUvTtXWBUlUx
         Yu+G7e5Eng8gpd/muTyop56upBissXY9lfGtf25eUb5gMxdc4JLf16KpeOoM3Ldh891G
         0w1se3Ve+shScI0wAF5b2rY0xEft7RDf1e2YXJ4sKQEZKyRS8cMtWCQvrTOeiOy6pU7j
         WPJlGYCE+F1AKcIZykio7eXOVdp+mmt/vzynVLpUO6odcgrfFmmoqjV///kglIIc5xl9
         i1TA==
X-Gm-Message-State: AOJu0YzsJwaR/e28huasCGMLQUHoKI26lPflFDvfpc0jP+LAcuWsFgO3
        V43fwEcqt2zNIwnBZlW+Hk+dKTX9JugoF7yv7sbs9A6m22SzORT6EJ3ORqBcMUlETaDj9HYCEAa
        Tc/gYYipS3od+WBW+UXdBugf3
X-Received: by 2002:a4a:6547:0:b0:573:2863:2926 with SMTP id z7-20020a4a6547000000b0057328632926mr4033928oog.8.1693447460292;
        Wed, 30 Aug 2023 19:04:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwta8V72PVbc0dwYP6tCEM0KG678FkYs6xsfTalPuLbQwpTlAJIfUEUcg62gz3GZB4XaBd2g==
X-Received: by 2002:a4a:6547:0:b0:573:2863:2926 with SMTP id z7-20020a4a6547000000b0057328632926mr4033787oog.8.1693447459561;
        Wed, 30 Aug 2023 19:04:19 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:98e3:3c98:3d83:9703:4411? ([2804:1b3:a802:98e3:3c98:3d83:9703:4411])
        by smtp.gmail.com with ESMTPSA id g63-20020a4a5b42000000b00573a7d8f382sm201455oob.36.2023.08.30.19.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 19:04:19 -0700 (PDT)
Message-ID: <b525dd86727e2b42ef947993c23ca0eefce83e25.camel@redhat.com>
Subject: Re: [RFC PATCH v2 0/3] Move usages of struct __call_single_data to
 call_single_data_t
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Aug 2023 23:04:13 -0300
In-Reply-To: <1a4d9f90-1bb0-4092-9be8-9cf2c70ef79d@kernel.dk>
References: <20230520052957.798486-1-leobras@redhat.com>
         <CAJ6HWG6dK_-5jjoGJadOXqE=9c0Np-85r9-ymtAt241XrdwW=w@mail.gmail.com>
         <b84ad9aa200457b1cbd5c55a7d860e685f068d7a.camel@redhat.com>
         <1cd98cb37dcf621520e52ac7a15513aab5749534.camel@redhat.com>
         <51cf9db1-4487-4229-4d43-e91268e52125@linux.dev>
         <16efceed0b215ee34cc46ca7bba4a86bcf2d8ad7.camel@redhat.com>
         <1a4d9f90-1bb0-4092-9be8-9cf2c70ef79d@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-30 at 16:48 -0600, Jens Axboe wrote:
> On 8/30/23 4:29 PM, Leonardo Br?s wrote:
> > On Tue, 2023-08-29 at 10:29 +0800, Chengming Zhou wrote:
> > > On 2023/8/29 08:55, Leonardo Br?s wrote:
> > > > On Tue, 2023-07-04 at 04:22 -0300, Leonardo Br?s wrote:
> > > > > On Tue, 2023-06-13 at 00:51 -0300, Leonardo Bras Soares Passos wr=
ote:
> > > > > > Friendly ping
> > > > > >=20
> > > > > > On Sat, May 20, 2023 at 2:30?AM Leonardo Bras <leobras@redhat.c=
om> wrote:
> > > > > > >=20
> > > > > > > Changes since RFCv1:
> > > > > > > - request->csd moved to the middle of the struct, without siz=
e impact
> > > > > > > - type change happens in a different patch (thanks Jens Axboe=
!)
> > > > > > > - Improved the third patch to also update the .h file.
> > > > > > >=20
> > > > > > > Leonardo Bras (3):
> > > > > > >   blk-mq: Move csd inside struct request so it's 32-byte alig=
ned
> > > > > > >   blk-mq: Change request->csd type to call_single_data_t
> > > > > > >   smp: Change signatures to use call_single_data_t
> > > > > > >=20
> > > > > > >  include/linux/blk-mq.h | 10 +++++-----
> > > > > > >  include/linux/smp.h    |  2 +-
> > > > > > >  kernel/smp.c           |  4 ++--
> > > > > > >  kernel/up.c            |  2 +-
> > > > > > >  4 files changed, 9 insertions(+), 9 deletions(-)
> > > > > > >=20
> > > > > > > --
> > > > > > > 2.40.1
> > > > > > >=20
> > > > >=20
> > > > > Hello Jens,
> > > > >=20
> > > > > I still want your feedback on this series :)
> > > > >=20
> > > > > I think I addressed every issue of RFCv1, but if you have any oth=
er feedback,
> > > > > please let me know.
> > > > >=20
> > > > > Thanks!
> > > > > Leo
> > > >=20
> > > > Hello Jens Axboe,
> > > >=20
> > > > Please provide feedback on this series!
> > > >=20
> > > > Are you ok with those changes?
> > > > What's your opinion on them?=20
> > > >=20
> > > > Thanks!
> > > > Leo
> > > >=20
> > >=20
> > > Hello,
> > >=20
> > > FYI, there is no csd in struct request anymore in block/for-next bran=
ch,
> > > which is deleted by this commit:
> > >=20
> > > commit 660e802c76c89e871c29cd3174c07c8d23e39c35
> > > Author: Chengming Zhou <zhouchengming@bytedance.com>
> > > Date:   Mon Jul 17 12:00:55 2023 +0800
> > >=20
> > >     blk-mq: use percpu csd to remote complete instead of per-rq csd
> > >=20
> > >     If request need to be completed remotely, we insert it into percp=
u llist,
> > >     and smp_call_function_single_async() if llist is empty previously=
.
> > >=20
> > >     We don't need to use per-rq csd, percpu csd is enough. And the si=
ze of
> > >     struct request is decreased by 24 bytes.
> > >=20
> > >     This way is cleaner, and looks correct, given block softirq is gu=
aranteed
> > >     to be scheduled to consume the list if one new request is added t=
o this
> > >     percpu list, either smp_call_function_single_async() returns -EBU=
SY or 0.
> > >=20
> > >     Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > >     Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > >     Reviewed-by: Christoph Hellwig <hch@lst.de>
> > >     Link: https://lore.kernel.org/r/20230717040058.3993930-2-chengmin=
g.zhou@linux.dev
> > >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > >=20
> >=20
> >=20
> > Oh, thanks for the heads-up!
> > I will send reviewed version of patch 3.
> >=20
> > I suppose it can go on top of block/for-next, since the above patch is =
there.
> > Does that work for you Jens Axboe?
>=20
> Just send it against Linus's tree, it's all upstream now.
>=20

Sure,

Thanks!
Leo


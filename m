Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9939D7AA5BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjIUXl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:41:56 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B0FF7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 16:41:49 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-493a661d7b6so1862279e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695339708; x=1695944508; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w48GztKGUIvMqqvPZVDMleDtLD/hcfB0PxWuC7Y1iOw=;
        b=DFD/rYlLTeDrOiGM45jyBtz17y5yAuVkN9ykqbctoA0NuU2/enysa5nLfnGkwPmpZB
         OdZZ8S6A41NJz/vhG9nXKl90oU/7G5AF1sxBFn4iRfD7itTfq+v9XOEoe22NSrXdEv2G
         TT8SArPrsHZFRdFU1J8tvvLu1BZDra/n7eJ+eaC8vn0iu1IkwOkDVKXxZ16JCuVOaPEM
         hyDSGgiByFKiE5Pmn3+nKw6zYnMy8tt9G/YCi9kCtFAVLGTyPZ9JyfnMtTJRr3hY0uUC
         wG1hBKrzQTVgZxbRH0W10UzykXtjlW3UEX/EotHMizWXknNLG1RFmbK7YGHVMHxPgEEe
         ydnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695339708; x=1695944508;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w48GztKGUIvMqqvPZVDMleDtLD/hcfB0PxWuC7Y1iOw=;
        b=CfovyqICLIOUQdWQMq7jtLexyjGm3MQms0H7HCtlOr6vnQtbcvoqciSN49+Sk6ot4L
         Pv/ILYPBWBhC+C45AmZXNYtmLig2Ifwx8szOOArS+nudSadjo78hIHLqqoUqxxvQjwJG
         JUvTDP8A7QOnceYZY6AIG0naB30K0bYSF0qVgeA3pWbvWa/mg7M6gdaqYfSECpOZl1J6
         U/PXSgF2AOdLsOCNWkNprw+O0APCIQeLOERclwX2mFY99c2YPCD2Kq4e3JiB+fTwUlfR
         fiNVJHbxZv3omJo95BR58H/srJqR9LXxIr8iKdbHP/yyU6WEYQ6/F3K9NxwI7HxoVA8A
         jObA==
X-Gm-Message-State: AOJu0YyPtrNIp54QJ4ufVxytCu2Tmnye/WVeDoVluWIHYotrpHHReBzY
        3d9rwWlyxGVcAQ+MqNGdLXOxu6ieK9isZF7RUPc=
X-Google-Smtp-Source: AGHT+IHowdOAInWy8qSJ+bGjp+ELswpQrYyP6Vw2ghvlTdU0OH1bR6+Ua/20leLuBdh2b2O6fPWb//YZdRjluLHi5Uw=
X-Received: by 2002:ac5:c978:0:b0:493:a661:c5f5 with SMTP id
 t24-20020ac5c978000000b00493a661c5f5mr690990vkm.2.1695339708341; Thu, 21 Sep
 2023 16:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230921181236.509072-1-Liam.Howlett@oracle.com>
 <20230921112521.fc07c658804f4e188179da77@linux-foundation.org>
 <20230921185330.j5jw3oms4tc6crkf@revolver> <ZQyYH+5pnDc1KYj0@casper.infradead.org>
 <20230921162748.a85eb5af766e0662e4f22a5e@linux-foundation.org> <20230921233422.kv46hm4lddhp6rgb@revolver>
In-Reply-To: <20230921233422.kv46hm4lddhp6rgb@revolver>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Fri, 22 Sep 2023 00:41:37 +0100
Message-ID: <CAKbZUD3GS7YJmeO1q=f7LRomkJAigQaFw93Vwn99jZaO9O1Eyg@mail.gmail.com>
Subject: Re: [PATCH 0/2] maple_tree: Fix mas_prev() state regression.
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 12:34=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Andrew Morton <akpm@linux-foundation.org> [230921 19:27]:
> > On Thu, 21 Sep 2023 20:23:11 +0100 Matthew Wilcox <willy@infradead.org>=
 wrote:
> >
> > > > > It isn't clear what are the user-visible effects of this flaw?  P=
lease
> > > > > send this along and I'll paste it in.
> > > >
> > > >
> > > > User may notice that mas_prev() or mas_next() calls that result in =
going
> > > > outside of the limit passed to the call will cause incorrect return=
s on
> > > > subsequent calls using that maple state, such as mas_find() skippin=
g an
> > > > entry.
> > >
> > > When Andrew says "User visible" he means "userspace visible".  Not
> > > "in kernel user visible".  What are the _consequences_.
> >
> > Thanks ;)
> >
> > We have a Link:
> > (https://gist.github.com/heatd/85d2971fae1501b55b6ea401fbbe485b) but it
> > takes us to the reproducer code.  If it took us to Pedro's initial bug
> > report then the sun would shine and birds would sing.
> >
>
> I don't think the irc channel is logged so I'll respin with a cleaner
> changelog for both patches and the subject of patch 1.

FYI:

The original distro bug report: https://bugs.archlinux.org/task/79656
The original userspace program bug report:
https://github.com/cebix/macemu/issues/271

(and yes, this is my fault, I should've raised this on the ML with the
regression tracker and all, but I tried to write my own fix then
realized it was trickier than it looked and pinged Liam)

--=20
Pedro

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382AC782951
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjHUMl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjHUMl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:41:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC491;
        Mon, 21 Aug 2023 05:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 477FD61684;
        Mon, 21 Aug 2023 12:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CA8C433CA;
        Mon, 21 Aug 2023 12:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692621685;
        bh=hgOW31wk8SRjSC67Nv902BMOcaWU8LBK4ZkRQH6Q6IE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qtSbrLpNhb+Pi/ERfZVD5FNkfewQN4Ay053QIvzQskpDARAkFiB/Yv6rKrpvQdqb+
         rfuXLoo2WA1Ol/WFQhQt5VbBS2AZl8jX85bmn6sOnrrd5e1K53XHCg5R29g1ZpTiNK
         UIIg9ni6wP5UQ3ZlSXO2LBOoFGbrX4RuOV/xx3C3boBmwr7BMqvcNtNgIW+olcc80E
         309wQz+3Asq9+e83zOjeJzq/ki9kkJ6AoVAJ2UcFNWP19ggCwaQGPG1XLDWgruJbG4
         NfctozSCWDsQgmPnvTKHrAL6ev1DKYNE1hFH1OghOcImuilQq+uLJsBvgv+wFLWOZz
         BPyILf3FKMiHw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so18173121fa.3;
        Mon, 21 Aug 2023 05:41:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YwimBoV9CibPzM/etZ1Ar6c+j9qVKFq9jsoxnC8BFGopDJ5JrsJ
        k2d1iaXWlT+HxyW7L1IhVt87DprJIrXbbz8VNw==
X-Google-Smtp-Source: AGHT+IGW3Q9pDpGN6dwjIY2sTqNp6l2eJoOkRHOaNZYjUFIDglVh8+eHS7Tiaj07kMgRsBOqoKtccLM65fKu5WC4oW8=
X-Received: by 2002:a2e:90d7:0:b0:2b9:ac48:d7fb with SMTP id
 o23-20020a2e90d7000000b002b9ac48d7fbmr5100270ljg.41.1692621683423; Mon, 21
 Aug 2023 05:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230821125741.3a2474d7@canb.auug.org.au> <20230821070731.GB1380343@google.com>
 <20230821071331.GC1380343@google.com>
In-Reply-To: <20230821071331.GC1380343@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 21 Aug 2023 07:41:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJbi-780UdoOizx3fMOv+W9WcvNqQt+0fUYwMQAet6BUA@mail.gmail.com>
Message-ID: <CAL_JsqJbi-780UdoOizx3fMOv+W9WcvNqQt+0fUYwMQAet6BUA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the battery tree
To:     Lee Jones <lee@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Sebastian Reichel <sre@kernel.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 2:13=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Mon, 21 Aug 2023, Lee Jones wrote:
>
> > On Mon, 21 Aug 2023, Stephen Rothwell wrote:
> >
> > > Hi all,
> > >
> > > After merging the battery tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >
> > > drivers/power/supply/rt5033_charger.c: In function 'rt5033_charger_pr=
obe':
> > > drivers/power/supply/rt5033_charger.c:694:19: error: implicit declara=
tion of function 'of_parse_phandle' [-Werror=3Dimplicit-function-declaratio=
n]
> >
> > Is this because your merge-conflict patch:
> >
> >   linux-next: manual merge of the battery tree with the mfd tree
> >
> >  ... removed of_device.h?
>
> Oh, that was Rob's patch.  I see now, thanks.

Presumably the functions below got added and failed to add of.h and
instead relied on of_device.h's implicit include of of.h which is
going to get removed. So Stephen's fix is the correct one.

Rob

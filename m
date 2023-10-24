Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DFE7D45A6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjJXCmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjJXCmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:42:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5897910D0;
        Mon, 23 Oct 2023 19:42:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC879C433C8;
        Tue, 24 Oct 2023 02:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698115324;
        bh=Axzhu/PU5pIRjTDxygVB5J4OxaQMp9aGqFHCG5Bu1kU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oE/fU/s40CdpBaHVlUL5Y0CN8wNwlg+lpdRdYH9dbEdA95IztWccl8K8dxFGEAarM
         8k0FuOcks6KJTk5vPaKS0saEx4q0G4n/u/5n1iaW2cd3849kie8qNSwDZPPzhwUK+A
         Yqmz9otXyyJQe55wZCkG6Th539MCh5Ow1XFay7BBca8GZ3IKnCc6Kk0pmkJvbzDiI3
         YJC6x1zFu5PUDYxrMY3a0rAGu3eICRGfvE9/FESbBBHjYoWTEBnioW2aZJmfeqpuq1
         BMeQBb0fPaYCVxTs0bxfvTv2xhNXDC1B3PGxuTJJTuNUF6mpxSwd3ImTCuk/PGJjnE
         TnsZdOOaM+49A==
Message-ID: <a21f9855c655e384501ae04636cf5297.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKZGPAMj6umUvoc+supfTU4juGoUXw78UiveUJgZQFE_ErdGbg@mail.gmail.com>
References: <CAKZGPAOurEwCs7B8RAinTEBwWKOEwW=8FLtAKSzLu9LjH9AHvg@mail.gmail.com> <CAKZGPAMj6umUvoc+supfTU4juGoUXw78UiveUJgZQFE_ErdGbg@mail.gmail.com>
Subject: Re: Question on pre running clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, Arun KS <getarunks@gmail.com>
To:     Arun KS <arunks.linux@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 Oct 2023 19:42:01 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arun KS (2023-10-20 00:09:05)
> + linux-clk
>=20
> On Fri, Oct 20, 2023 at 12:37=E2=80=AFPM Arun KS <arunks.linux@gmail.com>=
 wrote:
> >
> > Hello,
> >
> > Lets say there is a clock which is enabled by bootloaders and is pre
> > running as linux boots.
> > Is it mandatory for the client drivers to call clk_prepare_enable() on
> > them to initialise the enable_count to 1?

Yes.

> >
> > Or is there a way we can specify to the kernel that this clock is
> > already enabled by bootloader and initialise the enable_count for this
> > clock to 1.

No there isn't.

> >
> > Because otherwise, clk_disable() prints a WARN() if a client driver
> > uses clock handle where clk_prepare_enable() is not called.
> >
> > I grep through the code, but could find any details. Appreciate any poi=
nters.
> >
> > Regards,
> > Arun

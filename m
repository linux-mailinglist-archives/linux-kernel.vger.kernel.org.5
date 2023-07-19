Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBD0759427
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGSL3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGSL3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:29:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA05E10D4;
        Wed, 19 Jul 2023 04:29:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so5997781a12.2;
        Wed, 19 Jul 2023 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689766147; x=1692358147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/M88rLpp34nq2o9s2pwXP0lZOMqBKJveL8M0DFQmUtE=;
        b=BOyjgkD7ks0MDq7nMMrIo/DiK+rG9bOsCjoqM+AspZCFHxaNyt029ngf3rkrmqEvgg
         P9I+pXVnaYt+xy6cj9ixuZoFniddc01mUtFudfYzc/HxmLU802b1PkJZFJ/uBg4Jh6Ec
         DGkO0ypCVDUn60d84PEaKptnR+tJl1syipNx17ivXNCbzNpzlDn8gvJcLIg6zkW5VTMf
         K08pqhk1WRdUDnYWBy3zyjhjjSXtfQ83TgYFsn9fBKlQYllgi1ISshe+LiHztIOzHCke
         CZJJ20tC2afEcqFVMnzVaiMsbvjzOVtlH+jznEKlujRAULu8KfBHcOR/dtlOcIXgVi7K
         87aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766147; x=1692358147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/M88rLpp34nq2o9s2pwXP0lZOMqBKJveL8M0DFQmUtE=;
        b=eLdXa040M9Bg9aPBjP0Ie/rgTdiztys5JLnq+AkPWHXuj8MeMYBMZGIRuQFg0rxkiO
         SEzcrVybmiyv6JF/RH1bKLFSXL4wTSNxCip5soKao4AejqDlpWSCLfya+5DtluCmO4p7
         OwqfJMZL+SW8rCC/02CpXjJahPzsxY7wI7OvYu1dnRorVcYa2eiPFPFSgo0n9Aq3YYCN
         wia4VBCmtq6W3n3DvlTuAx4M4755ivRinmJN3FS+Yznt4iC4n0rEX70kTaLNJ9K0idsa
         OGdSGmUYXF4ZVm9z2PNGl2s82dFC3vZwlyUQQnmn1ZZcYmssYQVJjRz0hdzqjeOFjZQx
         tp3g==
X-Gm-Message-State: ABy/qLavqhE8XNRDfbdPmmRuGmZw+LqWqdon9GtX7mbex9BaKgWevOdF
        gYWc2yygnDvcXfP3pKJ9DtJae/Rl0eOSKPZoTTM=
X-Google-Smtp-Source: APBJJlE9qEl12RDjSJNzRlxX4qnP5+Q63WIQJiBB4fGQpra0328KB9brVTj5HLVga3ZLUauqll5k+FbHRBrbopSYIy4=
X-Received: by 2002:a17:906:73d0:b0:993:eddd:6df9 with SMTP id
 n16-20020a17090673d000b00993eddd6df9mr2206285ejl.2.1689766146966; Wed, 19 Jul
 2023 04:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <1689660928-12092-1-git-send-email-quic_vpernami@quicinc.com>
 <20230718124334.GG4771@thinkpad> <350d577a-f0b3-1f20-9c35-356355a9aa8e@quicinc.com>
In-Reply-To: <350d577a-f0b3-1f20-9c35-356355a9aa8e@quicinc.com>
From:   Daniele Palmas <dnlplm@gmail.com>
Date:   Wed, 19 Jul 2023 13:17:10 +0200
Message-ID: <CAGRyCJH0PZpR9fD=GmWzzkHuu8f+tBhg6hE+Y9pYyv+sQAd_YQ@mail.gmail.com>
Subject: Re: [PATCH V2] net: mhi : Add support to enable ethernet interface
To:     Vivek Pernamitta <quic_vpernami@quicinc.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev, mrana@quicinc.com, quic_qianyu@quicinc.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vivek,

Il giorno mer 19 lug 2023 alle ore 12:39 Vivek Pernamitta
<quic_vpernami@quicinc.com> ha scritto:
>
>
> Currently MHI NET driver does not support Ethernet interface,
>
> we are adding Ethernet interface support to MHI NET driver, so new
> client can be configured to be Ethernet type over MHI by setting
> "mhi_device_info.ethernet_if = true"
>

how can this be set to "true"?

Is this something that can be changed dynamically at runtime (but I
can't see how currently) or is it "static" ?

In the latter case, not sure if the maintainer agrees, but maybe a new
binding (e.g. something like ETH_SW0) should be used ?

Thanks,
Daniele

> currently we are not changing mhi_swip0/mhi_hwip0 to Ethernet. we are
> adding an provision to configure mhi client as  Ethernet type.
>
>
> On 7/18/2023 6:13 PM, Manivannan Sadhasivam wrote:
> > On Tue, Jul 18, 2023 at 11:45:28AM +0530, Vivek Pernamitta wrote:
> >> Add support to enable ethernet interface for MHI SWIP channels.
> >>
> > Please add more info in the commit message i.e., why this interface is added and
> > how it is going to benefit the users etc..
> >
> > Since you are modifying the existing mhi_swip interface, this isn't an ABI
> > change?
> >
> >> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> >> Reviewed-by: Daniele Palmas <dnlplm@gmail.com>
> >> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> >> ---
> >>
> >> changes since v1:
> >>      - Moved to net-next from linux-next
> >>      - moved to eth_hw_addr_random() to assign Ethernet MAC address
> >>        from eth_random_addr()
> >> ---
> >>   drivers/net/mhi_net.c | 53 ++++++++++++++++++++++++++++++++++++++-------------
> >>   1 file changed, 40 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> >> index 3d322ac..5bb8d99 100644
> >> --- a/drivers/net/mhi_net.c
> >> +++ b/drivers/net/mhi_net.c
> > [...]
> >
> >> @@ -380,10 +405,12 @@ static void mhi_net_remove(struct mhi_device *mhi_dev)
> >>
> >>   static const struct mhi_device_info mhi_hwip0 = {
> >>      .netname = "mhi_hwip%d",
> >> +    .ethernet_if = false,
> >>   };
> >>
> >>   static const struct mhi_device_info mhi_swip0 = {
> >>      .netname = "mhi_swip%d",
> >> +    .ethernet_if = false,
> > false?
> yes ,it is false as by default mhi_swip/mhi_hwip interface will be
> normal net device.
> >
> > - Mani
> >
> >>   };
> >>
> >>   static const struct mhi_device_id mhi_net_id_table[] = {
> >> --
> >> 2.7.4
> >>
>

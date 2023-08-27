Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101EC78A306
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjH0Wrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjH0WrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:47:24 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE1FE5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:47:22 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57355a16941so1350075eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693176441; x=1693781241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epUIiVqABeIowLt4jzYenygYHrRc/gN9x8tk0ImlTJ0=;
        b=PmSImoLKfQrb+YbDPW/g1JLVResIS4mOist3R9UtVGvDptAEbIRXxhgXf7N1jX6tQ1
         HUSGkozPR6SMa4NGt/TTIrywgzSkzg88XdCqaMMR8MMFNm+zE8E2XZ+a0dkGV9vBaBIv
         2T33JsFrtJ0oTw+zHOmxJFeygPCDUCtE34sMB/4Bo0L0P1HTyWvHHbO3U54hEDMmEW6x
         QJIfn0xeNRuWX3ibvK4IjLiN3Er1X5ey4wk0y33m4KrOp8eO5fVkXgKO2QbUL3Q2K4MO
         bvoH8txA9/ygilxSC0QtHxNFmIS29wXfWHueSqwfMUDPoidzwJpr5OG0Ymflvmi6je4j
         xZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693176441; x=1693781241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epUIiVqABeIowLt4jzYenygYHrRc/gN9x8tk0ImlTJ0=;
        b=E5v43IPXDMW2VkOBMeOVMSzstapxva818v+IDQm1VsQSJpKtwroJXemKO29m4AyFRX
         /QF4aRmv3kza+jj/V2mEIGi7nZFIPujusAW70kEuuV7s+NqKwxLTCiltwnKt/XJ+Cbew
         wPIzFB66ekT/7ukgkUv0k3Zww0Hb/El9xpr3Rqn5xj1FUmvHd7/MJWlwD8dupS6n4tbx
         ZvCG95WLOkubHt1O/uuFT4cZyo7imXpR206td2FA9+HHpCMDJOpcrK8yx3oF1pdxFc08
         Q2hz4IyTUf06srbpnFo21DGbtR21tK8wzXIKfRpIG7aXvx5HJLB4+nvNMsYQDsm+GRk0
         Zxkg==
X-Gm-Message-State: AOJu0YzgKbL8LBfZ/RgTLtCE/Dk/w6spFyIz5ypE5fLLl+siVoajhpMp
        9qCYohYaPTTfds7RUDY0IRW2bpSIS0RMkFUHXoIdYi/h
X-Google-Smtp-Source: AGHT+IGytyXnjNFz5kjqSOpNXpmyYRksnRPkEAAwdAEzTMcmMXeJd+xh02gz2541f/Y2MmWW/g5a3mj/MF1Aw2g49uc=
X-Received: by 2002:a05:6871:14a:b0:1ba:d044:8a4 with SMTP id
 z10-20020a056871014a00b001bad04408a4mr11353149oab.18.1693176441471; Sun, 27
 Aug 2023 15:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR11MB76436F3A05897D8F8DC9F967BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
 <ZOvNvkRJstLt4ghx@nam-dell> <PH7PR11MB764320782B13A53D79F3DF69BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB764320782B13A53D79F3DF69BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Mon, 28 Aug 2023 00:47:10 +0200
Message-ID: <CA+sZ8B_inWKE6_zk4ghVtcxXXdP4NBkkQs5qb6Uu7BygY5UMvQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] staging: octeon: clean up the octeon ethernet driver
To:     ozlinux@hotmail.com
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:32=E2=80=AFAM <ozlinux@hotmail.com> wrote:
>
> On Mon, Aug 28, 2023 at 12:27:10AM +0200, Nam Cao wrote:
> > On Sun, Aug 27, 2023 at 05:12:04PM -0400, Oliver Crumrine wrote:
> > > Make the octeon ethernet driver better adhere to the
> > > kernel coding standard
> > >
> > > Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
> >
> > See this conversation about a similar mistake that you also made with y=
our
> > patch series:
> > https://lore.kernel.org/linux-staging/ZOpq4t22iRXewekD@alolivei-thinkpa=
dt480s.gru.csb/T/#t
> >
> > Best regards,
> > Nam
>
> That is totally my bad. Should I leave it as is? Should I resend the
> whole patch set? Should I resend just the last five, but attach them to
> the first one? This is my first kernel patch, so I'll take any advice I
> can get.

You should resend everything. Don't forget to add the "v2" tag ;-)

Best regards,
Nam

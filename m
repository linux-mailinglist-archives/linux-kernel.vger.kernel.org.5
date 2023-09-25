Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC457ACD11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjIYAYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYAYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:24:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAFDC4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:24:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E96C433C9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695601483;
        bh=wXMvj/RnLc+M+hcpz1HKWq8vltJT9IOCskBYJQBUBJ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t91hDePzKfs4W4Ksu6uSXdDLaeVLMYN6CgDerV7k25NWWa1VGH0WQuWHfuuY0aX+f
         e+5i4hguUMyw97Wnn8rs4GdgXnSSfqBrXhFrhSHknadgLm997hiRAECWDnt4ScAiGY
         uWzdSrdPMicIo46pUz0t0nRjXCS7KxFWoRkOD+w/eNowQ36IajhSFDr2SYQzbK6LUt
         0jV1NPCqW+mIfzmXSnsC/el0MVOKpyLXoi4OiHEkmxJW0jvfkrCYkJMFvoGyI5sTRF
         l7PJroQNzukxJv2oOBqWlcVaRb1qs5NzFS+R+P6Ok9a8AFm/Cgh4xjxGIP7efMQSv6
         lbkQYozFP2IKQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso89183161fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:24:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YxAHPU5dATea70phltlHPy2KNA4JOJnlZprtX8tsUzHWl023BYr
        KFYb2loxuuVGydHOq3LKc3Aiqh0iZcz1fLsCxQA=
X-Google-Smtp-Source: AGHT+IEQF1PD/GAayzGimK3s4JPWYRW6dnn03V8Ftv/jkzihd34cqML2y8ZdOK9pO19/IJqkFmwcdZSOYKnDv/XJAWM=
X-Received: by 2002:a19:4354:0:b0:500:7a23:720b with SMTP id
 m20-20020a194354000000b005007a23720bmr3305759lfj.55.1695601481280; Sun, 24
 Sep 2023 17:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <1692949635-27223-1-git-send-email-hongxing.zhu@nxp.com> <20230924140734.GL7231@dragon>
In-Reply-To: <20230924140734.GL7231@dragon>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Mon, 25 Sep 2023 08:24:29 +0800
X-Gmail-Original-Message-ID: <CAJBJ56+mEQQroQkPGptdWokWjK2EBa3M407wXXqGg9Vg6E6cgQ@mail.gmail.com>
Message-ID: <CAJBJ56+mEQQroQkPGptdWokWjK2EBa3M407wXXqGg9Vg6E6cgQ@mail.gmail.com>
Subject: Re: [PATCH v1] firmware: imx: scu-pd: Add missed PCIEA SATA0 and
 SERDES0 power domains
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     s.hauer@pengutronix.de, festevam@gmail.com,
        marcel.ziswiler@toradex.com, Frank.Li@nxp.com,
        xiaoning.wang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 10:07=E2=80=AFPM Shawn Guo <shawnguo@kernel.org> wr=
ote:
>
> On Fri, Aug 25, 2023 at 03:47:15PM +0800, Richard Zhu wrote:
> > Add missed PCIEA, SATA0 and SERDES0 power domains for HSIO SS.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>
> It doesn't apply to v6.6-rc.  Could you rebase?

To be clear, my branch is built on v6.6-rc1, so please rebase against
that, thanks!

Shawn

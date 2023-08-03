Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8AC76E9BD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjHCNN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbjHCNNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:13:14 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE04495;
        Thu,  3 Aug 2023 06:11:42 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-790bed44880so31373439f.0;
        Thu, 03 Aug 2023 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691068291; x=1691673091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lC0SW0eAGcjrPelcOslL8Ss4E31DBBOJeX5ruPDUDU=;
        b=OgeQqTU3eLsToIFQqpnPIA8g1WCwq6zItGL9mntQIrUxGhjbBitttp4rPonWdcsfxP
         iRu6lmPdnlStCJoOCDCEuv4opy0zlLNTWrDmAEXCgmXENtRx5rA/fBxUCmTnEEXn1s3d
         +b7fpiJVshrK7ErQ0MD+MO4FLFbHFFpyzV69Zs7aLy44fmoU9jTLoK5MvRuK820kS5RG
         J+SRnf5gQSlsbchEYrjWURjn7aZhSZjoQmyVb5mdk1f9ajw0rn3vuOWoAlhOae+REEzD
         zfGk59orqaoBC1o2Oruv8/rVXoVQYP4t+5ttTB6qg7JIglPFNGEO+kjJ6kcvnW4QH0jw
         r2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691068291; x=1691673091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lC0SW0eAGcjrPelcOslL8Ss4E31DBBOJeX5ruPDUDU=;
        b=hFbOT7tAeS/COxdSU20i3JjhUwsJzQ9PcnJxapPWhtpp/juWr3OA2Med5XdZRaK1Nl
         VNelsEXIAuxm8jnWVtA6u2t/JQ+JoJ9yxdeLLmf0ioZLgWgnkMEJLeXdWIujM46sdM1E
         W7hoXnvcOXYUMKr2CGDMlSxp1XLONEwhLz3SdRSmgRUBJMIPeQBI05kAFA4XRVqN0zzE
         SJEylf58e/TM9CcYfTvZ9+k+4IC4/WA5oqFM/DufIV8GZWgvQo6sn3F/i2/PwAqJmz7q
         1WrGlHclab2y5htWIQ8ZSy9ZjJQx+tzhQkGd0zJVAXpkehhKgq5a1QcriM8GjFofUIhT
         nzZg==
X-Gm-Message-State: ABy/qLYxWEqNTu1b6vJsWzud3JK+hxiY1lnWWiAulCGlUgg7Dwc3NLju
        26stkc1Xxe2g9WN03F+0KuSD2DrUE+hQGmskrto=
X-Google-Smtp-Source: APBJJlEtqzIxYCVUFEvV5fgDCP81fGeD3GZpt6levaG9H4upWh9g5EvLMYrqL4ob+7IT6h4Vjry/EVcjmBnCK9V7HJM=
X-Received: by 2002:a05:6e02:1569:b0:348:c041:abd7 with SMTP id
 k9-20020a056e02156900b00348c041abd7mr15797226ilu.13.1691068290064; Thu, 03
 Aug 2023 06:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
 <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl> <87il9xu1ro.wl-tiwai@suse.de>
 <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com>
 <87il9xoddo.wl-tiwai@suse.de> <CAA+D8AOVEpGxO0YNeS1p+Ym86k6VP-CNQB3JmbeT7mPKg0R99A@mail.gmail.com>
 <844ef9b6-d5e2-46a9-b7a5-7ee86a2e449c@sirena.org.uk>
In-Reply-To: <844ef9b6-d5e2-46a9-b7a5-7ee86a2e449c@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 3 Aug 2023 21:11:16 +0800
Message-ID: <CAA+D8AOnsx+7t3MrWm42waxtetL07nbKURLsh1hBx39LUDm+Zg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Hans Verkuil <hverkuil@xs4all.nl>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 1:28=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Wed, Aug 02, 2023 at 10:41:43PM +0800, Shengjiu Wang wrote:
>
> > Currently the ASRC in ALSA is to connect to another I2S device as
> > a sound card.  But we'd like to the ASRC can be used by user space dire=
ctly
> > that user space application can get the output after conversion from AS=
RC.
>
> That sort of use case would be handled via DPCM at the minute, though
> persuading it to connect two front ends together might be fun (which is
> the sort of reason why we want to push digital information down into
> DAPM and make everything a component).

Thanks.

ASRC M2M case needs to run as fast as possible, no sync clock control.
If use sound card to handle ASRC M2M case,  the user application
should be aplay/arecord, then we need to consider xrun issue, buffer
may timeout, sync between aplay and arecord,  these should't be
considered by pure memory to memory operation.

DPCM may achitect all the audio things in components and sound
card,  it is good. but for the M2M case, it is complcated. not sure
it is doable.

best regards
wang shengjiu

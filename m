Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB975DF29
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 00:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjGVWaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVWaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 18:30:10 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA810DC;
        Sat, 22 Jul 2023 15:30:09 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b9ec15e014so2606674a34.0;
        Sat, 22 Jul 2023 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690065008; x=1690669808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5mJll+udYAOXh1dqyerngRmFpTg3nf1DZBJwkPP9FE=;
        b=fmBlKEPNTll7Q+ApeducTu+N4D5OEnPiqEyE3puoZ/f1QD58JAZi3eDATZeNITi4jM
         NfCgRpKG9YqZ7gTqit6ClJvIXxAk6p9bQG6pv0wRSvmMg6/61kNc8VHkifEP2v5aqsjg
         cQIdaTdDbMnzV+GtdSdip8WB6G+CpgJTfTVWjkqkUBB14+1nLPcBTPuMMwj1Rqqyunzc
         fJ/hBqVXc716JoOJbFu7BB3PgKyiN31fKUwHTqyLY87rTDz6TBhrrHyjVRBM5mxmqEA/
         UdrAVEnebIlMeTFvBVz9eydtQ+K6ptB6xhScRnBOHxGTVfzldVCuZrLojZqa5elrCdlf
         7+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690065008; x=1690669808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5mJll+udYAOXh1dqyerngRmFpTg3nf1DZBJwkPP9FE=;
        b=Xf47bS03Oqmz2itgy4hcC0EYosjD0PM5VKWlNtJ0kn8yZm2IqKgx0Q7VyKtRD6c4CD
         mfm8Tn6CNglFpRIHSHKkrrwBInUSPkQnR/YXsEtAYo8RawPGWvA87hkHd2ihWVK5sLBW
         iJjS7eCSNUoM9eOTOqhS8BkUu6EZjunCs8gXuIB2iKedPegJoNBR4b2F2FLPF+6T5oeC
         vIME15YNXBe5IOGTidJE9zHPl6yKKDdDQweQXt98VAMBwxVmwZUhsi80sOsgbMlsiXi3
         /w3VL6M4uSviPfrnBbcM3T5yLPdENS6LkSxAlGLSxcisgfvidMMeeJeOhKf0dE93uj+J
         ziyQ==
X-Gm-Message-State: ABy/qLZP1FvFGD3CycklsjkMhLW+ufJKWcxduOGEV4BrGaB5/vJ9Xbdj
        oKCZCaWWwJJzf5Ukx1Iig92R+tXL43Mmd1dhYbs=
X-Google-Smtp-Source: APBJJlFCI6V1NvyiDmCqWK0vJJCL9x89CoMWJp9xHrtgspyjqNJyxayK/dkl5i6UuA6YH6Ew7ialEeiv9fv3vIHFAw0=
X-Received: by 2002:a05:6358:6f0c:b0:134:61a5:7f05 with SMTP id
 r12-20020a0563586f0c00b0013461a57f05mr1831945rwn.10.1690065008440; Sat, 22
 Jul 2023 15:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230701102538.5359-1-franziska.naepelt@googlemail.com>
 <5ad04b3a-7c77-cadb-13b4-509a086cf04d@web.de> <2023070123-unburned-worsening-0713@gregkh>
In-Reply-To: <2023070123-unburned-worsening-0713@gregkh>
From:   =?UTF-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Date:   Sun, 23 Jul 2023 00:29:57 +0200
Message-ID: <CAAUT3iNqwgtFJz2Q1bRN+MsSna26KC1FJc3jchu=8B09A2SkvQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] staging: rtl8723bs: Fix space issues
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Emily Peri <eperi1024@gmail.com>,
        Guo Zihua <guozihua@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Am Sa., 1. Juli 2023 um 17:00 Uhr schrieb Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> On Sat, Jul 01, 2023 at 04:43:09PM +0200, Markus Elfring wrote:
> > You should not put only your own email address into the field =E2=80=9C=
To=E2=80=9D.
> > Please reconsider the distribution of addresses between message header =
fields once more.
>
> Please do not comment on staging driver changes anymore, it is not
> helpful to anyone involved.
>
> greg k-h

Am I supposed to adjust something here?
As far as I understood, I can ignore the comments from Markus, correct?

Franziska

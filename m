Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10FA7A70D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjITDFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjITDFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:05:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA217CA;
        Tue, 19 Sep 2023 20:04:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502153ae36cso10281307e87.3;
        Tue, 19 Sep 2023 20:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695179098; x=1695783898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaDjgFTmIBKoGKyaUqfkfNbHOF4Uuie+vdI+nMpIPEo=;
        b=MdJNGH7ac0ZbQQrBElcPkQ2S/F2A51CzAbKkT21/OzhKnt5kvFNbC7yxJxeUILJeB6
         JeIn5nSlS92zjFygZ7bgHhSydMoejzmMl6rTlOigXe0hZFnCPwAukdKoXuKPrATmBmcN
         A7sXFHPGPfhqp2DadsYSNML/djjMfC0NmPzgZ4vB8TqNBb5tD8ahGir2nxsd+AxZ6Vvv
         al3SJVDvelNmf+QJRezJZe7PWdod4O7kT+tZKr40zFX+kipW8Y0kDC0QYH5OMONVykAu
         0ySB83jmBgdTTzgdWSVIxVm/vlOnkcCUGAwP+Lr/U9jCuEhMz//NRPQZOs2Aw+/rkXmc
         DzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695179098; x=1695783898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaDjgFTmIBKoGKyaUqfkfNbHOF4Uuie+vdI+nMpIPEo=;
        b=d/bNFilIPvFKSXyrIhgKVWrLIqDRwFosRGt0r4JGAOGOy5lg5sDtKUztUQmz3zOy23
         JbETOAmZkLzHhseL5paVBKI00Kbehd+foerN8af+notM9GHiVlTI70ADLJQE+JHpm2nI
         QT1LWP13dyhjac80p7bGkJ3nuBjk91gWUg0k1caDWWiYx0/ZFu2R0E83+Yv7t1oAiMTZ
         mtodg/fw/Nx9cPvYiKJWWDq8Sm4xloMmxpnaY2tsyR2KR/nO51hoJce49hpvV68ijVRy
         5xwkpmjXjuPXCiVwLQZNo5eDJB6LcJAzrL04m5KKRp+dCFZTNKxTh68aKEziE6NqmoAO
         CFeg==
X-Gm-Message-State: AOJu0YwernYOLagH//3Qg3EJKXmtAKccd0z1HqYtsivk7dipLDOtYhGZ
        /p93a9skPRdMPSs3T2yCLtnszBdeYwGA1Mp2HzwYAAlT
X-Google-Smtp-Source: AGHT+IGn8i5bYsDQsO7WXsVvFcf0edDSTZ/yzVtmudtzgbkSRwO71391riQLxCWeXTeI4xywuzTxvThiREYiri8rJLE=
X-Received: by 2002:a19:4f06:0:b0:502:a549:8fa4 with SMTP id
 d6-20020a194f06000000b00502a5498fa4mr1279215lfb.13.1695179097631; Tue, 19 Sep
 2023 20:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230920070618.6c3d16e9@canb.auug.org.au>
In-Reply-To: <20230920070618.6c3d16e9@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 19 Sep 2023 22:04:46 -0500
Message-ID: <CAH2r5mu2onb+9VvnqH=1Qe26a7GxtGjw1_RmpihaNSsnR3n=NQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Tue, Sep 19, 2023 at 4:06=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Commit
>
>   46b169610922 ("cifs: Fix UAF in cifs_demultiplex_thread()")
>
> is missing a Signed-off-by from its committer.


Fixed - thx


--=20
Thanks,

Steve

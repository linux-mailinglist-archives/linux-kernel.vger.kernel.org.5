Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B975079339E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbjIFCOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjIFCOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:14:08 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CE9CDB;
        Tue,  5 Sep 2023 19:14:02 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so49761871fa.3;
        Tue, 05 Sep 2023 19:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693966439; x=1694571239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsoSK8mqixYZcXU+h+UPvRzmoQG63kmRlk1cTNnSgj8=;
        b=n24rgR/khhBl+IAzR6DOzp81oHCpF28l0hR0yHwd6TedbritHC9pmZSyLAwpkgoRWu
         /CfS0AITqcpDKk4dhdjPY6KGZh967HCVbmUP5ical/ApK1lK53Mn6mwUvyZU/85iEigO
         q+hOlkz1KG5y2hC+J5eTbfu0PI/fXzK1D0OxPSadeJTFNNhyQ+RNdRLCsfuWiAgTKXDZ
         Vrqkmi8Zn0ErGqhGn6ZeHDf7TebkBnnMJ9iv/vCJFSSIqYn9+Y4KhzwdIuz8VxBlws4V
         dWAX+1oqqqi3dmK+QGHe184qMo6/2N51p/+BSpFNxw1BIMUoWkhIPKetGcBeHtOoLLZK
         HPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693966439; x=1694571239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsoSK8mqixYZcXU+h+UPvRzmoQG63kmRlk1cTNnSgj8=;
        b=f/DGYAZydUUKP+MNMBdgqj934qbwQquz8IbAFhah29XHp32yqi6mM+DkjJXrla3nB9
         YlE7CSrOH01nOQxm0HZsU/7hzkTPVxN0l99G3vEdMvsAJm2US9iAe9yjROTx2RW2cwHI
         lK2yVLVEwJeDp4wx1GwzPEsNzx51sXbyv7YSJQOaXiP5QfSvg1+JzPYEXvrf7fWpifD4
         Gq7k2QhokeHe6Ph9D5vbPoP1XIr3QeSu5ST07RLhtkTF7c2v/IZmS/MU7LB5wo5Pfnd/
         j+4nOxlk7CCVlUMbr9wPnS7BVuts1qzJkdz60e3l7ZNqH1+NwqIYhTKvPOKlNnHwQFYD
         luFg==
X-Gm-Message-State: AOJu0Ywv+T4nb+/b5a2pznL/6JNHmjWweTxYwPqCyGTVN57WVcqVj8o1
        rXrALBuWLTjTvdlGYs528p9HgTRZjpwT/Hdtk1s=
X-Google-Smtp-Source: AGHT+IH7RM3cY3iOqro2snTJovOGvM5NPQfVguZF/MJFFyi8KcVMBzz/x6XogQ5hLmNj34gjfzOxrgtUb7MRt0B8N+g=
X-Received: by 2002:a19:5002:0:b0:4ff:8f44:834f with SMTP id
 e2-20020a195002000000b004ff8f44834fmr991849lfb.38.1693966439082; Tue, 05 Sep
 2023 19:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230830030503.13349-1-jyanchou@realtek.com> <CACT4zj-nRyAhtasV-gZW9Ja_FWNwvELnkuyPcq4SyDuGuEM8jA@mail.gmail.com>
 <d171e2279da847fa81022f6fd23869fb@realtek.com>
In-Reply-To: <d171e2279da847fa81022f6fd23869fb@realtek.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Wed, 6 Sep 2023 10:13:29 +0800
Message-ID: <CACT4zj8yP0DPRfQ9_=gxaM+paZLW_86b5YVyGse-WiWK_KszPw@mail.gmail.com>
Subject: Re: [PATCH] mmc: Add Synopsys DesignWare mmc cmdq host driver
To:     =?UTF-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
Cc:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hi Jyan,

On Thu, Aug 31, 2023 at 3:47=E2=80=AFPM Jyan Chou [=E5=91=A8=E8=8A=B7=E5=AE=
=89] <jyanchou@realtek.com> wrote:
>
> Hi Ben,
> Thanks for your suggestion.
>
> > The patch includes two parts: a dw_mmc_cqe driver and dw_mmc_cqe-rtk dr=
iver.
> > Adrian and Ulf's comments[1][2] don't seem to be addressed.
>
> [1] The reason why we added many changes was because we found
> out that synopsys IP data book's register and user guide with cmdq
> support were different from non cmdq's , so we referred to dw_mmc.c
> coding style and push dw_mmc_cqe.c to support version after 5.1 JEDEC Sta=
ndard.
>

Apart from the difference in register definitions and the addition of cmdq,
is there any other behavior that is different from dw_mmc.c?
I recommend using a patch series and describing the differences from
dw_mmc in your cover letter, for an example as follows
  [00/04] cover letter - Add DesignWare Mobile mmc driver
  [01/04] Introduce a setup_tran_desc ops ...
  [02/04] Add dw mobile_mmc driver .....
  [03/04] Add command queue to dw mobile_mmc driver .....
  [04/04] Add dw mobile mmc rtk driver .....
And please read patiently
https://www.kernel.org/doc/html/latest/process/submitting-patches.html.

>>---
>> drivers/mmc/host/Kconfig          |   22 +

Do you forget to add dw_mmc_cqe.o and dw_mmc_cqe-rtk.o to Makefile?

>> drivers/mmc/host/cqhci-core.c     |    5 +
>> drivers/mmc/host/cqhci.h          |    2 +
>> drivers/mmc/host/dw_mmc_cqe-rtk.c |  999 ++++++++++++++++++
>> drivers/mmc/host/dw_mmc_cqe-rtk.h |  160 +++
>> drivers/mmc/host/dw_mmc_cqe.c     | 1633 +++++++++++++++++++++++++++++
>> drivers/mmc/host/dw_mmc_cqe.h     |  442 ++++++++
>> 7 files changed, 3263 insertions(+)


And some compile complains for your reference,
---
drivers/mmc/host/dw_mmc_cqe.c: In function 'dw_mci_cqe_err_handle':
drivers/mmc/host/dw_mmc_cqe.c:723:41: warning: this 'if' clause does
not guard... [-Wmisleading-indentation]
  723 |                                         if (err =3D=3D -DW_MCI_NOT_=
READY)
      |                                         ^~
drivers/mmc/host/dw_mmc_cqe.c:726:49: note: ...this statement, but the
latter is misleadingly indented as if it were guarded by the 'if'
  726 |                                                 break;
      |                                                 ^~~~~
----
In file included from drivers/mmc/host/dw_mmc_cqe-rtk.c:23:
drivers/mmc/host/dw_mmc_cqe-rtk.h:155:5: error: conflicting types for
'mmc_hw_reset'; have 'int(struct mmc_host *)'
  155 | int mmc_hw_reset(struct mmc_host *host);
      |     ^~~~~~~~~~~~
In file included from drivers/mmc/host/dw_mmc_cqe-rtk.c:11:
./include/linux/mmc/core.h:178:5: note: previous declaration of
'mmc_hw_reset' with type 'int(struct mmc_card *)'
  178 | int mmc_hw_reset(struct mmc_card *card);
----

Best regards,
Ben Chuang

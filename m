Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5847A1AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjIOJlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjIOJl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:41:28 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FD22D45;
        Fri, 15 Sep 2023 02:40:50 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-49369d29be3so839279e0c.3;
        Fri, 15 Sep 2023 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694770849; x=1695375649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq6+nm7heyR6ehH8tsRoYWyAc9lF7ShRjVQVsfX2g70=;
        b=ejbnQD+rExFIY18qgWopAE0QD/oXme7Qza3KphW6vCRb1/0FrRIBVC4vdvvt19Sj4O
         K90rb99i8kmT5Z4nKhvhOLLSiTc07x0DmXtoDlzRsgZkYiUpJXeDReVGi+5Mh4aJgXP/
         CayhVsMIYkH2yLNLHJf7GDDJwpjua16RqS51r80BsmVlUh/i8rlsyMOpSLvfrhjXDckd
         uauyy5evaXU6+0k0KotS5QWM7EQBgP7pO7xERqkevyxdm4V8whL95n52xIE22zNOCOZF
         cTpKKEtQsSkg9UmtecSPw/ds3DbkhNzbIJFoBeYcHlOa3nphkqSY2fwEIQAD/htduLcj
         qCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694770849; x=1695375649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq6+nm7heyR6ehH8tsRoYWyAc9lF7ShRjVQVsfX2g70=;
        b=J0ebdxJdwHE7qzeAgCABXfW2peR9mi49snbeeI9tTIXdpvrMwt53pn/oy8TbKwptUu
         W3HqixBN7wnQNuLqlIXZcmCkKDkwupmxxXrp9pM9hY25c1FVtTFSb9mbn1aWvyZU6DXc
         4CLICIHlv5F299hUFwklbKMbwd1dCrLGTQlxE14DW9P56S/0BcaFNyDysLwSTABY9MVN
         uVy4DS8ZnD62SlMkzzaSU1bvaZr4rH/EBRcciMCQ++iNLOxNqj0wlW5II0D4wIopR2zr
         1RyEFSl7+o07tLNXb47NzR9/zlM5tzFRBDGJa5PNXf8bX2rmtrQjL54sVh17MBbF8OFj
         uKjw==
X-Gm-Message-State: AOJu0Yw84Ii9orgPyLw/sDugrtOlPKbWJ21ScQz9i05zcZ7AE5tnMIJE
        qaCgrsfhoE+phzHm8gcaNpbhxhlyGYb5sKQQUR4=
X-Google-Smtp-Source: AGHT+IEWE8lOgKhKTzdZIYW3N6MjZEclxoC9oFwuQGGI7fiXHePKjNHiyv4SQpjVMRr/zSJNabHDodI6g528qZMWkrA=
X-Received: by 2002:a1f:4d81:0:b0:496:3a98:6c57 with SMTP id
 a123-20020a1f4d81000000b004963a986c57mr1053707vkb.4.1694770849006; Fri, 15
 Sep 2023 02:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230818100217.12725-1-victorshihgli@gmail.com>
 <20230818100217.12725-19-victorshihgli@gmail.com> <2b3f8b30-1ee1-31dd-53d7-cb2a0deea511@intel.com>
 <CAK00qKAR_4EaRtLRi_CKPDOy+CTFDw_CzkbmL=GOY2QWTU2yOQ@mail.gmail.com>
 <18716e05-6138-d326-ab29-f90e03650490@intel.com> <CAK00qKAEW8qkvXUsnb4UVHBSGAtjT-F1bJiKRMOTWR+Pirg3oA@mail.gmail.com>
 <ef6648b4-94da-20a8-c1e2-b7d6d0090918@intel.com>
In-Reply-To: <ef6648b4-94da-20a8-c1e2-b7d6d0090918@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 15 Sep 2023 17:40:36 +0800
Message-ID: <CAK00qKDjRkqRuTqe0nFaEhx3Jx+1gkOnhpm4B7rEh5YsK=8OYg@mail.gmail.com>
Subject: Re: [PATCH V10 18/23] mmc: sdhci-uhs2: add request() and others
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
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

On Tue, Sep 12, 2023 at 8:40=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 6/09/23 19:14, Victor Shih wrote:
> > On Thu, Aug 31, 2023 at 7:20=E2=80=AFPM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 31/08/23 13:33, Victor Shih wrote:
> >>> On Thu, Aug 31, 2023 at 4:33=E2=80=AFPM Adrian Hunter <adrian.hunter@=
intel.com> wrote:
> >>>>
> >>>> On 18/08/23 13:02, Victor Shih wrote:
> >>>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>>>
> >>>>> This is a sdhci version of mmc's request operation.
> >>>>> It covers both UHS-I and UHS-II.
> >>>>>
> >>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> >>>>> ---
> >>>>>
> >>>>> Updates in V10:
> >>>>>  - Use tmode_half_duplex to instead of uhs2_tmode0_flag
> >>>>>    in sdhci_uhs2_set_transfer_mode().
> >>>>>
> >>>>> Updates in V9:
> >>>>>  - Modify the annotations in __sdhci_uhs2_send_command().
> >>>>>
> >>>>> Updates in V8:
> >>>>>  - Adjust the position of matching brackets in
> >>>>>    sdhci_uhs2_send_command_retry().
> >>>>>  - Modify CameCase definition in __sdhci_uhs2_finish_command().
> >>>>>  - Modify error message in __sdhci_uhs2_finish_command().
> >>>>>  - sdhci_uhs2_send_command_retry() to instead of sdhci_uhs2_send_co=
mmand()
> >>>>>    in sdhci_uhs2_request().
> >>>>>  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_request_ato=
mic().
> >>>>>  - Add forward declaration for sdhci_send_command().
> >>>>>
> >>>>> Updates in V7:
> >>>>>  - Cancel export state of some functions.
> >>>>>  - Remove unnecessary whitespace changes.
> >>>>>
> >>>>> Updates in V6:
> >>>>>  - Add uhs2_dev_cmd() to simplify code.
> >>>>>  - Remove unnecessary functions.
> >>>>>  - Cancel export state of some functions.
> >>>>>  - Drop use CONFIG_MMC_DEBUG().
> >>>>>  - Wrap at 100 columns in some functions.
> >>>>>
> >>>>> ---
> >>>>>
> >>>>>  drivers/mmc/host/sdhci-uhs2.c | 412 ++++++++++++++++++++++++++++++=
++++
> >>>>>  drivers/mmc/host/sdhci.c      |  49 ++--
> >>>>>  drivers/mmc/host/sdhci.h      |   8 +
> >>>>>  3 files changed, 454 insertions(+), 15 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci=
-uhs2.c
> >>>>> index 09b86fec9f7b..08fef7174239 100644
> >>>>> --- a/drivers/mmc/host/sdhci-uhs2.c
> >>>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
> >>>>> @@ -14,6 +14,8 @@
> >>>>>  #include <linux/module.h>
> >>>>>  #include <linux/iopoll.h>
> >>>>>  #include <linux/bitfield.h>
> >>>>> +#include <linux/mmc/mmc.h>
> >>>>> +#include <linux/mmc/host.h>
> >>>>>
> >>>>>  #include "sdhci.h"
> >>>>>  #include "sdhci-uhs2.h"
> >>>>> @@ -24,6 +26,8 @@
> >>>>>  #define SDHCI_UHS2_DUMP(f, x...) \
> >>>>>       pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ##=
 x)
> >>>>>
> >>>>> +#define UHS2_ARG_IOADR_MASK 0xfff
> >>>>> +
> >>>>>  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >>>>>  {
> >>>>>       if (!(sdhci_uhs2_mode(host)))
> >>>>> @@ -58,6 +62,11 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >>>>>   *                                                                =
           *
> >>>>>  \*****************************************************************=
************/
> >>>>>
> >>>>> +static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
> >>>>> +{
> >>>>> +     return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOA=
DR_MASK;
> >>>>> +}
> >>>>> +
> >>>>>  static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> >>>>>                                           struct regulator *supply,
> >>>>>                                           unsigned short vdd_bit)
> >>>>> @@ -446,6 +455,408 @@ static int sdhci_uhs2_control(struct mmc_host=
 *mmc, enum sd_uhs2_operation op)
> >>>>>       return err;
> >>>>>  }
> >>>>>
> >>>>> +/*****************************************************************=
************\
> >>>>> + *                                                                =
           *
> >>>>> + * Core functions                                                 =
           *
> >>>>> + *                                                                =
           *
> >>>>> +\*****************************************************************=
************/
> >>>>> +
> >>>>> +static void sdhci_uhs2_prepare_data(struct sdhci_host *host, struc=
t mmc_command *cmd)
> >>>>> +{
> >>>>> +     struct mmc_data *data =3D cmd->data;
> >>>>> +
> >>>>> +     sdhci_initialize_data(host, data);
> >>>>> +
> >>>>> +     sdhci_prepare_dma(host, data);
> >>>>> +
> >>>>> +     sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
> >>>>> +     sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
> >>>>> +}
> >>>>> +
> >>>>> +static void sdhci_uhs2_finish_data(struct sdhci_host *host)
> >>>>> +{
> >>>>> +     struct mmc_data *data =3D host->data;
> >>>>> +
> >>>>> +     __sdhci_finish_data_common(host);
> >>>>> +
> >>>>> +     __sdhci_finish_mrq(host, data->mrq);
> >>>>> +}
> >>>>> +
> >>>>> +static void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host, =
struct mmc_command *cmd)
> >>>>> +{
> >>>>> +     u16 mode;
> >>>>> +     struct mmc_data *data =3D cmd->data;
> >>>>> +
> >>>>> +     if (!data) {
> >>>>> +             /* clear Auto CMD settings for no data CMDs */
> >>>>> +             if (uhs2_dev_cmd(cmd) =3D=3D UHS2_DEV_CMD_TRANS_ABORT=
) {
> >>>>> +                     mode =3D  0;
> >>>>> +             } else {
> >>>>> +                     mode =3D sdhci_readw(host, SDHCI_UHS2_TRANS_M=
ODE);
> >>>>> +                     if (cmd->opcode =3D=3D MMC_STOP_TRANSMISSION =
|| cmd->opcode =3D=3D MMC_ERASE)
> >>>>> +                             mode |=3D SDHCI_UHS2_TRNS_WAIT_EBSY;
> >>>>> +                     else
> >>>>> +                             /* send status mode */
> >>>>> +                             if (cmd->opcode =3D=3D MMC_SEND_STATU=
S)
> >>>>> +                                     mode =3D 0;
> >>>>> +             }
> >>>>> +
> >>>>> +             DBG("UHS2 no data trans mode is 0x%x.\n", mode);
> >>>>> +
> >>>>> +             sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
> >>>>> +             return;
> >>>>> +     }
> >>>>> +
> >>>>> +     WARN_ON(!host->data);
> >>>>> +
> >>>>> +     mode =3D SDHCI_UHS2_TRNS_BLK_CNT_EN | SDHCI_UHS2_TRNS_WAIT_EB=
SY;
> >>>>> +     if (data->flags & MMC_DATA_WRITE)
> >>>>> +             mode |=3D SDHCI_UHS2_TRNS_DATA_TRNS_WRT;
> >>>>> +
> >>>>> +     if (data->blocks =3D=3D 1 &&
> >>>>> +         data->blksz !=3D 512 &&
> >>>>> +         cmd->opcode !=3D MMC_READ_SINGLE_BLOCK &&
> >>>>> +         cmd->opcode !=3D MMC_WRITE_BLOCK) {
> >>>>> +             mode &=3D ~SDHCI_UHS2_TRNS_BLK_CNT_EN;
> >>>>> +             mode |=3D SDHCI_UHS2_TRNS_BLK_BYTE_MODE;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (host->flags & SDHCI_REQ_USE_DMA)
> >>>>> +             mode |=3D SDHCI_UHS2_TRNS_DMA;
> >>>>> +
> >>>>> +     if ((mmc_card_uhs2_hd_mode(host->mmc)) && cmd->uhs2_cmd->tmod=
e_half_duplex)
> >>>>
> >>>> Should not check mmc_card_uhs2_hd_mode(host->mmc).  The mmc core
> >>>> must get it right.
> >>>>
> >>>> Also why is the setting different for different commands?
> >>>>
> >>>
> >>> Hi, Adrian
> >>>
> >>> I will drop the check  mmc_card_uhs2_hd_mode(host->mmc) in the next v=
ersion.
> >>> But I'm not quite sure what the "why is the setting different for
> >>> different commands" means.
> >>> Could you help explain it a little bit more clearly?
> >>
> >> In mmc_uhs2_prepare_cmd() there is this code:
> >>
> >>         if (cmd->opcode =3D=3D SD_APP_SEND_SCR || cmd->opcode =3D=3D S=
D_APP_SD_STATUS ||
> >>             cmd->opcode =3D=3D MMC_SEND_EXT_CSD || cmd->opcode =3D=3D =
SD_SWITCH ||
> >>             cmd->opcode =3D=3D SD_READ_EXTR_SINGLE || cmd->opcode =3D=
=3D MMC_SEND_CSD ||
> >>             cmd->opcode =3D=3D MMC_SEND_CID)
> >>                 cmd->uhs2_cmd->tmode_half_duplex =3D 0;
> >>         else
> >>                 cmd->uhs2_cmd->tmode_half_duplex =3D mmc_card_uhs2_hd_=
mode(host);
> >>
> >> So different commands can have different duplex?  Why is that?
> >>
> >
> > Hi, Adrian
> >
> > Please correct me if I understand wrong.
> > We use tmode_half_duplex instead of uhs2_tmode0_flag.
> > As I know, the above commands need to be sent in tmode0.
> > That's why I set different duplex for different commands.
>
> UHS-II Addendum 7.2.1.2 DCMD says:
>
>  "Host may set DM to 1 for DCMD which supports multi-block read / write r=
egardless of
>  data transfer length (e.g., CMD18, CMD25). Otherwise, it shall not set D=
M to 1.
>  (e.g. CMD6, CMD17, CMD24). These rules are also applied to other multi-b=
lock read / write
>  commands defined in other Part of SD specifications (for example, Host m=
ay set DM to 1
>  for ACMD18 or ACMD25)."
>
> Which sounds like we should check for CMD18 and CMD25 rather than the oth=
er way around?
> Perhaps use mmc_op_multi() and add a comment.
>

Hi, Adrian

     I will update this  in the V12 version.

Thanks, Victor Shih

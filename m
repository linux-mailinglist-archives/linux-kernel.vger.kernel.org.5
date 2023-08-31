Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2316C78EA40
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241511AbjHaKdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjHaKdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:33:49 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4223ACF3;
        Thu, 31 Aug 2023 03:33:45 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-44e86f3e4b6so288721137.0;
        Thu, 31 Aug 2023 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693478024; x=1694082824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7in1l7CcjxG8sB4UR6LT5vie+Xd9wVhzad5nH73JVcA=;
        b=Ve4IprrWB5P6bkYMK/ZuUAbtQ8cJykG4LRuF/BZ/QGbHP0tHbCExSsvWfPBrtFQvLQ
         sctgNNCu2WjeZLWE0gslteSFtERlgnFvjfsyVhGunGRVSA5g4bwJFQaYaPqE2nKv3ivl
         /zMs+qOWOlDg+/6L7NQ16v/2+qRKgGtU3lRSmykuGSQHOOskmxkTLZ1cMVzSrF8SAuMa
         hYQvk6MvqkmwUUxBi6+TjdN+VLYgLVKk30RzudXxr24E44jXlgHSaGeeHuiv/0mAQdu4
         2xjBWlb7lvlfn1Iklrr5FaNkFhxiSz+0xULjasmkJPf1fWR/UI3FAMciiwW03O45sBU4
         1SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693478024; x=1694082824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7in1l7CcjxG8sB4UR6LT5vie+Xd9wVhzad5nH73JVcA=;
        b=NUaJ7Anf9P3znYsA+PTXKIYLLYhhJw/IbOs5mmbEC4V2wOwHsROeb9jd07pFvU6Voh
         pwawufxS4U64cBxn/0WGYAkBO3OHLoM1XVtZn9gK21kmeDww4eXOOrmvHuVuAmkrd2LY
         qaU6PE6YmnBBQjCHLtnWjuhbWX3yO2PAlRW+ThB3iBYX+684aOo56jB/+9dagP8Ipnms
         AwYc5ijauy361IqxxrXQPOwfKut2lnJnCcHZbdB0DMB2Oyd5aPrKg17I4rCat6zumANI
         p0OrvyYQvDGMool1VLXjVs3JnOoUKvFZJTFe2Pt0Roc8r4B+OIrLDblKRLsbGis0ts+U
         TCsQ==
X-Gm-Message-State: AOJu0YxyBa4d8oatOSE6Ory0P1tQk9lgnvRvs4X3MAWdud19YemrZ1cw
        POy6RjcuckEGQj0V2NOeAC3g+aWQhjBK8MaNSbg=
X-Google-Smtp-Source: AGHT+IHT9WxDcm5ni/+mXsAI/9e4DfU2UCgcchzCdUh1T4J03F6U9v9MZ4AYOgYDYZ33plrU22aHWk2U8NjgntVhGb0=
X-Received: by 2002:a05:6102:34fa:b0:44e:9709:c11a with SMTP id
 bi26-20020a05610234fa00b0044e9709c11amr3547974vsb.14.1693478024017; Thu, 31
 Aug 2023 03:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230818100217.12725-1-victorshihgli@gmail.com>
 <20230818100217.12725-19-victorshihgli@gmail.com> <2b3f8b30-1ee1-31dd-53d7-cb2a0deea511@intel.com>
In-Reply-To: <2b3f8b30-1ee1-31dd-53d7-cb2a0deea511@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Thu, 31 Aug 2023 18:33:31 +0800
Message-ID: <CAK00qKAR_4EaRtLRi_CKPDOy+CTFDw_CzkbmL=GOY2QWTU2yOQ@mail.gmail.com>
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

On Thu, Aug 31, 2023 at 4:33=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 18/08/23 13:02, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a sdhci version of mmc's request operation.
> > It covers both UHS-I and UHS-II.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V10:
> >  - Use tmode_half_duplex to instead of uhs2_tmode0_flag
> >    in sdhci_uhs2_set_transfer_mode().
> >
> > Updates in V9:
> >  - Modify the annotations in __sdhci_uhs2_send_command().
> >
> > Updates in V8:
> >  - Adjust the position of matching brackets in
> >    sdhci_uhs2_send_command_retry().
> >  - Modify CameCase definition in __sdhci_uhs2_finish_command().
> >  - Modify error message in __sdhci_uhs2_finish_command().
> >  - sdhci_uhs2_send_command_retry() to instead of sdhci_uhs2_send_comman=
d()
> >    in sdhci_uhs2_request().
> >  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_request_atomic(=
).
> >  - Add forward declaration for sdhci_send_command().
> >
> > Updates in V7:
> >  - Cancel export state of some functions.
> >  - Remove unnecessary whitespace changes.
> >
> > Updates in V6:
> >  - Add uhs2_dev_cmd() to simplify code.
> >  - Remove unnecessary functions.
> >  - Cancel export state of some functions.
> >  - Drop use CONFIG_MMC_DEBUG().
> >  - Wrap at 100 columns in some functions.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 412 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c      |  49 ++--
> >  drivers/mmc/host/sdhci.h      |   8 +
> >  3 files changed, 454 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 09b86fec9f7b..08fef7174239 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -14,6 +14,8 @@
> >  #include <linux/module.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/mmc/host.h>
> >
> >  #include "sdhci.h"
> >  #include "sdhci-uhs2.h"
> > @@ -24,6 +26,8 @@
> >  #define SDHCI_UHS2_DUMP(f, x...) \
> >       pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
> >
> > +#define UHS2_ARG_IOADR_MASK 0xfff
> > +
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >  {
> >       if (!(sdhci_uhs2_mode(host)))
> > @@ -58,6 +62,11 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >   *                                                                    =
       *
> >  \*********************************************************************=
********/
> >
> > +static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
> > +{
> > +     return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_M=
ASK;
> > +}
> > +
> >  static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> >                                           struct regulator *supply,
> >                                           unsigned short vdd_bit)
> > @@ -446,6 +455,408 @@ static int sdhci_uhs2_control(struct mmc_host *mm=
c, enum sd_uhs2_operation op)
> >       return err;
> >  }
> >
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * Core functions                                                     =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static void sdhci_uhs2_prepare_data(struct sdhci_host *host, struct mm=
c_command *cmd)
> > +{
> > +     struct mmc_data *data =3D cmd->data;
> > +
> > +     sdhci_initialize_data(host, data);
> > +
> > +     sdhci_prepare_dma(host, data);
> > +
> > +     sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
> > +     sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
> > +}
> > +
> > +static void sdhci_uhs2_finish_data(struct sdhci_host *host)
> > +{
> > +     struct mmc_data *data =3D host->data;
> > +
> > +     __sdhci_finish_data_common(host);
> > +
> > +     __sdhci_finish_mrq(host, data->mrq);
> > +}
> > +
> > +static void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host, stru=
ct mmc_command *cmd)
> > +{
> > +     u16 mode;
> > +     struct mmc_data *data =3D cmd->data;
> > +
> > +     if (!data) {
> > +             /* clear Auto CMD settings for no data CMDs */
> > +             if (uhs2_dev_cmd(cmd) =3D=3D UHS2_DEV_CMD_TRANS_ABORT) {
> > +                     mode =3D  0;
> > +             } else {
> > +                     mode =3D sdhci_readw(host, SDHCI_UHS2_TRANS_MODE)=
;
> > +                     if (cmd->opcode =3D=3D MMC_STOP_TRANSMISSION || c=
md->opcode =3D=3D MMC_ERASE)
> > +                             mode |=3D SDHCI_UHS2_TRNS_WAIT_EBSY;
> > +                     else
> > +                             /* send status mode */
> > +                             if (cmd->opcode =3D=3D MMC_SEND_STATUS)
> > +                                     mode =3D 0;
> > +             }
> > +
> > +             DBG("UHS2 no data trans mode is 0x%x.\n", mode);
> > +
> > +             sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
> > +             return;
> > +     }
> > +
> > +     WARN_ON(!host->data);
> > +
> > +     mode =3D SDHCI_UHS2_TRNS_BLK_CNT_EN | SDHCI_UHS2_TRNS_WAIT_EBSY;
> > +     if (data->flags & MMC_DATA_WRITE)
> > +             mode |=3D SDHCI_UHS2_TRNS_DATA_TRNS_WRT;
> > +
> > +     if (data->blocks =3D=3D 1 &&
> > +         data->blksz !=3D 512 &&
> > +         cmd->opcode !=3D MMC_READ_SINGLE_BLOCK &&
> > +         cmd->opcode !=3D MMC_WRITE_BLOCK) {
> > +             mode &=3D ~SDHCI_UHS2_TRNS_BLK_CNT_EN;
> > +             mode |=3D SDHCI_UHS2_TRNS_BLK_BYTE_MODE;
> > +     }
> > +
> > +     if (host->flags & SDHCI_REQ_USE_DMA)
> > +             mode |=3D SDHCI_UHS2_TRNS_DMA;
> > +
> > +     if ((mmc_card_uhs2_hd_mode(host->mmc)) && cmd->uhs2_cmd->tmode_ha=
lf_duplex)
>
> Should not check mmc_card_uhs2_hd_mode(host->mmc).  The mmc core
> must get it right.
>
> Also why is the setting different for different commands?
>

Hi, Adrian

I will drop the check  mmc_card_uhs2_hd_mode(host->mmc) in the next version=
.
But I'm not quite sure what the "why is the setting different for
different commands" means.
Could you help explain it a little bit more clearly?

Thanks, Victor Shih

> > +             mode |=3D SDHCI_UHS2_TRNS_2L_HD;
> > +
> > +     sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
> > +
> > +     DBG("UHS2 trans mode is 0x%x.\n", mode);
> > +}
> > +
> > +static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct =
mmc_command *cmd)
> > +{
> > +     int i, j;
> > +     int cmd_reg;
> > +
> > +     i =3D 0;
> > +     sdhci_writel(host,
> > +                  ((u32)cmd->uhs2_cmd->arg << 16) |
> > +                             (u32)cmd->uhs2_cmd->header,
> > +                  SDHCI_UHS2_CMD_PACKET + i);
> > +     i +=3D 4;
> > +
> > +     /*
> > +      * Per spec, payload (config) should be MSB before sending out.
> > +      * But we don't need convert here because had set payload as
> > +      * MSB when preparing config read/write commands.
> > +      */
> > +     for (j =3D 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++) =
{
> > +             sdhci_writel(host, *(cmd->uhs2_cmd->payload + j), SDHCI_U=
HS2_CMD_PACKET + i);
> > +             i +=3D 4;
> > +     }
> > +
> > +     for ( ; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i +=3D 4)
> > +             sdhci_writel(host, 0, SDHCI_UHS2_CMD_PACKET + i);
> > +
> > +     DBG("UHS2 CMD packet_len =3D %d.\n", cmd->uhs2_cmd->packet_len);
> > +     for (i =3D 0; i < cmd->uhs2_cmd->packet_len; i++)
> > +             DBG("UHS2 CMD_PACKET[%d] =3D 0x%x.\n", i,
> > +                 sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));
> > +
> > +     cmd_reg =3D FIELD_PREP(SDHCI_UHS2_CMD_PACK_LEN_MASK, cmd->uhs2_cm=
d->packet_len);
> > +     if ((cmd->flags & MMC_CMD_MASK) =3D=3D MMC_CMD_ADTC)
> > +             cmd_reg |=3D SDHCI_UHS2_CMD_DATA;
> > +     if (cmd->opcode =3D=3D MMC_STOP_TRANSMISSION)
> > +             cmd_reg |=3D SDHCI_UHS2_CMD_CMD12;
> > +
> > +     /* UHS2 Native ABORT */
> > +     if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> > +         (uhs2_dev_cmd(cmd) =3D=3D UHS2_DEV_CMD_TRANS_ABORT))
> > +             cmd_reg |=3D SDHCI_UHS2_CMD_TRNS_ABORT;
> > +
> > +     /* UHS2 Native DORMANT */
> > +     if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> > +         (uhs2_dev_cmd(cmd) =3D=3D UHS2_DEV_CMD_GO_DORMANT_STATE))
> > +             cmd_reg |=3D SDHCI_UHS2_CMD_DORMANT;
> > +
> > +     DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
> > +
> > +     sdhci_writew(host, cmd_reg, SDHCI_UHS2_CMD);
> > +}
> > +
> > +static bool sdhci_uhs2_send_command(struct sdhci_host *host, struct mm=
c_command *cmd)
> > +{
> > +     int flags;
> > +     u32 mask;
> > +     unsigned long timeout;
> > +
> > +     WARN_ON(host->cmd);
> > +
> > +     /* Initially, a command has no error */
> > +     cmd->error =3D 0;
> > +
> > +     if (cmd->opcode =3D=3D MMC_STOP_TRANSMISSION)
> > +             cmd->flags |=3D MMC_RSP_BUSY;
> > +
> > +     mask =3D SDHCI_CMD_INHIBIT;
> > +
> > +     if (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask)
> > +             return false;
> > +
> > +     host->cmd =3D cmd;
> > +     host->data_timeout =3D 0;
> > +     if (sdhci_data_line_cmd(cmd)) {
> > +             WARN_ON(host->data_cmd);
> > +             host->data_cmd =3D cmd;
> > +             __sdhci_uhs2_set_timeout(host);
> > +     }
> > +
> > +     if (cmd->data)
> > +             sdhci_uhs2_prepare_data(host, cmd);
> > +
> > +     sdhci_uhs2_set_transfer_mode(host, cmd);
> > +
> > +     if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
> > +             WARN_ONCE(1, "Unsupported response type!\n");
> > +             /*
> > +              * This does not happen in practice because 136-bit respo=
nse
> > +              * commands never have busy waiting, so rather than compl=
icate
> > +              * the error path, just remove busy waiting and continue.
> > +              */
> > +             cmd->flags &=3D ~MMC_RSP_BUSY;
> > +     }
> > +
> > +     if (!(cmd->flags & MMC_RSP_PRESENT))
> > +             flags =3D SDHCI_CMD_RESP_NONE;
> > +     else if (cmd->flags & MMC_RSP_136)
> > +             flags =3D SDHCI_CMD_RESP_LONG;
> > +     else if (cmd->flags & MMC_RSP_BUSY)
> > +             flags =3D SDHCI_CMD_RESP_SHORT_BUSY;
> > +     else
> > +             flags =3D SDHCI_CMD_RESP_SHORT;
> > +
> > +     if (cmd->flags & MMC_RSP_CRC)
> > +             flags |=3D SDHCI_CMD_CRC;
> > +     if (cmd->flags & MMC_RSP_OPCODE)
> > +             flags |=3D SDHCI_CMD_INDEX;
> > +
> > +     timeout =3D jiffies;
> > +     if (host->data_timeout)
> > +             timeout +=3D nsecs_to_jiffies(host->data_timeout);
> > +     else if (!cmd->data && cmd->busy_timeout > 9000)
> > +             timeout +=3D DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ +=
 HZ;
> > +     else
> > +             timeout +=3D 10 * HZ;
> > +     sdhci_mod_timer(host, cmd->mrq, timeout);
> > +
> > +     __sdhci_uhs2_send_command(host, cmd);
> > +
> > +     return true;
> > +}
> > +
> > +static bool sdhci_uhs2_send_command_retry(struct sdhci_host *host,
> > +                                       struct mmc_command *cmd,
> > +                                       unsigned long flags)
> > +     __releases(host->lock)
> > +     __acquires(host->lock)
> > +{
> > +     struct mmc_command *deferred_cmd =3D host->deferred_cmd;
> > +     int timeout =3D 10; /* Approx. 10 ms */
> > +     bool present;
> > +
> > +     while (!sdhci_uhs2_send_command(host, cmd)) {
> > +             if (!timeout--) {
> > +                     pr_err("%s: Controller never released inhibit bit=
(s).\n",
> > +                            mmc_hostname(host->mmc));
> > +                     sdhci_dumpregs(host);
> > +                     cmd->error =3D -EIO;
> > +                     return false;
> > +             }
> > +
> > +             spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +             usleep_range(1000, 1250);
> > +
> > +             present =3D host->mmc->ops->get_cd(host->mmc);
> > +
> > +             spin_lock_irqsave(&host->lock, flags);
> > +
> > +             /* A deferred command might disappear, handle that */
> > +             if (cmd =3D=3D deferred_cmd && cmd !=3D host->deferred_cm=
d)
> > +                     return true;
> > +
> > +             if (sdhci_present_error(host, cmd, present))
> > +                     return false;
> > +     }
> > +
> > +     if (cmd =3D=3D host->deferred_cmd)
> > +             host->deferred_cmd =3D NULL;
> > +
> > +     return true;
> > +}
> > +
> > +static void __sdhci_uhs2_finish_command(struct sdhci_host *host)
> > +{
> > +     struct mmc_command *cmd =3D host->cmd;
> > +     u8 resp;
> > +     u8 ecode;
> > +     bool breada0 =3D 0;
> > +     int i;
> > +
> > +     if (host->mmc->flags & MMC_UHS2_SD_TRAN) {
> > +             resp =3D sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
> > +             if (resp & UHS2_RES_NACK_MASK) {
> > +                     ecode =3D (resp >> UHS2_RES_ECODE_POS) & UHS2_RES=
_ECODE_MASK;
> > +                     pr_err("%s: NACK response, ECODE=3D0x%x.\n", mmc_=
hostname(host->mmc), ecode);
> > +             }
> > +             breada0 =3D 1;
> > +     }
> > +
> > +     if (cmd->uhs2_resp &&
> > +         cmd->uhs2_resp_len && cmd->uhs2_resp_len <=3D 20) {
> > +             /* Get whole response of some native CCMD, like
> > +              * DEVICE_INIT, ENUMERATE.
> > +              */
> > +             for (i =3D 0; i < cmd->uhs2_resp_len; i++)
> > +                     cmd->uhs2_resp[i] =3D sdhci_readb(host, SDHCI_UHS=
2_RESPONSE + i);
> > +     } else {
> > +             /* Get SD CMD response and Payload for some read
> > +              * CCMD, like INQUIRY_CFG.
> > +              */
> > +             /* Per spec (p136), payload field is divided into
> > +              * a unit of DWORD and transmission order within
> > +              * a DWORD is big endian.
> > +              */
> > +             if (!breada0)
> > +                     sdhci_readl(host, SDHCI_UHS2_RESPONSE);
> > +             for (i =3D 4; i < 20; i +=3D 4) {
> > +                     cmd->resp[i / 4 - 1] =3D
> > +                             (sdhci_readb(host,
> > +                                          SDHCI_UHS2_RESPONSE + i) << =
24) |
> > +                             (sdhci_readb(host,
> > +                                          SDHCI_UHS2_RESPONSE + i + 1)
> > +                                     << 16) |
> > +                             (sdhci_readb(host,
> > +                                          SDHCI_UHS2_RESPONSE + i + 2)
> > +                                     << 8) |
> > +                             sdhci_readb(host, SDHCI_UHS2_RESPONSE + i=
 + 3);
> > +             }
> > +     }
> > +}
> > +
> > +static void sdhci_uhs2_finish_command(struct sdhci_host *host)
> > +{
> > +     struct mmc_command *cmd =3D host->cmd;
> > +
> > +     __sdhci_uhs2_finish_command(host);
> > +
> > +     host->cmd =3D NULL;
> > +
> > +     if (cmd->mrq->cap_cmd_during_tfr && cmd =3D=3D cmd->mrq->cmd)
> > +             mmc_command_done(host->mmc, cmd->mrq);
> > +
> > +     /*
> > +      * The host can send and interrupt when the busy state has
> > +      * ended, allowing us to wait without wasting CPU cycles.
> > +      * The busy signal uses DAT0 so this is similar to waiting
> > +      * for data to complete.
> > +      *
> > +      * Note: The 1.0 specification is a bit ambiguous about this
> > +      *       feature so there might be some problems with older
> > +      *       controllers.
> > +      */
> > +     if (cmd->flags & MMC_RSP_BUSY) {
> > +             if (cmd->data) {
> > +                     DBG("Cannot wait for busy signal when also doing =
a data transfer");
> > +             } else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
> > +                        cmd =3D=3D host->data_cmd) {
> > +                     /* Command complete before busy is ended */
> > +                     return;
> > +             }
> > +     }
> > +
> > +     /* Processed actual command. */
> > +     if (host->data && host->data_early)
> > +             sdhci_uhs2_finish_data(host);
> > +
> > +     if (!cmd->data)
> > +             __sdhci_finish_mrq(host, cmd->mrq);
> > +}
> > +
> > +void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     struct mmc_command *cmd;
> > +     unsigned long flags;
> > +     bool present;
> > +
> > +     if (!(sdhci_uhs2_mode(host))) {
> > +             sdhci_request(mmc, mrq);
> > +             return;
> > +     }
> > +
> > +     mrq->stop =3D NULL;
> > +     mrq->sbc =3D NULL;
> > +     if (mrq->data)
> > +             mrq->data->stop =3D NULL;
> > +
> > +     /* Firstly check card presence */
> > +     present =3D mmc->ops->get_cd(mmc);
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +
> > +     if (sdhci_present_error(host, mrq->cmd, present))
> > +             goto out_finish;
> > +
> > +     cmd =3D mrq->cmd;
> > +
> > +     if (!sdhci_uhs2_send_command_retry(host, cmd, flags))
> > +             goto out_finish;
> > +
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +     return;
> > +
> > +out_finish:
> > +     sdhci_finish_mrq(host, mrq);
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_request);
> > +
> > +int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request=
 *mrq)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     struct mmc_command *cmd;
> > +     unsigned long flags;
> > +     int ret =3D 0;
> > +
> > +     if (!sdhci_uhs2_mode(host))
> > +             return sdhci_request_atomic(mmc, mrq);
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +
> > +     if (sdhci_present_error(host, mrq->cmd, true)) {
> > +             sdhci_finish_mrq(host, mrq);
> > +             goto out_finish;
> > +     }
> > +
> > +     cmd =3D mrq->cmd;
> > +
> > +     /*
> > +      * The HSQ may send a command in interrupt context without pollin=
g
> > +      * the busy signaling, which means we should return BUSY if contr=
oller
> > +      * has not released inhibit bits to allow HSQ trying to send requ=
est
> > +      * again in non-atomic context. So we should not finish this requ=
est
> > +      * here.
> > +      */
> > +     if (!sdhci_uhs2_send_command(host, cmd))
> > +             ret =3D -EBUSY;
> > +
> > +out_finish:
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_request_atomic);
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > @@ -569,6 +980,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_ho=
st *host)
> >       host->mmc_host_ops.start_signal_voltage_switch =3D
> >               sdhci_uhs2_start_signal_voltage_switch;
> >       host->mmc_host_ops.uhs2_control =3D sdhci_uhs2_control;
> > +     host->mmc_host_ops.request =3D sdhci_uhs2_request;
> >
> >       return 0;
> >  }
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 57209accbb03..9d031e83b6ba 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -147,10 +147,11 @@ void sdhci_enable_v4_mode(struct sdhci_host *host=
)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
> >
> > -static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
> > +bool sdhci_data_line_cmd(struct mmc_command *cmd)
> >  {
> >       return cmd->data || cmd->flags & MMC_RSP_BUSY;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_data_line_cmd);
> >
> >  static void sdhci_set_card_detection(struct sdhci_host *host, bool ena=
ble)
> >  {
> > @@ -502,14 +503,15 @@ static inline void sdhci_led_deactivate(struct sd=
hci_host *host)
> >
> >  #endif
> >
> > -static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_reques=
t *mrq,
> > -                         unsigned long timeout)
> > +void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
> > +                  unsigned long timeout)
> >  {
> >       if (sdhci_data_line_cmd(mrq->cmd))
> >               mod_timer(&host->data_timer, timeout);
> >       else
> >               mod_timer(&host->timer, timeout);
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_mod_timer);
> >
> >  static void sdhci_del_timer(struct sdhci_host *host, struct mmc_reques=
t *mrq)
> >  {
> > @@ -1076,8 +1078,7 @@ static void sdhci_set_timeout(struct sdhci_host *=
host, struct mmc_command *cmd)
> >               __sdhci_set_timeout(host, cmd);
> >  }
> >
> > -static void sdhci_initialize_data(struct sdhci_host *host,
> > -                               struct mmc_data *data)
> > +void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *d=
ata)
> >  {
> >       WARN_ON(host->data);
> >
> > @@ -1090,6 +1091,7 @@ static void sdhci_initialize_data(struct sdhci_ho=
st *host,
> >       host->data_early =3D 0;
> >       host->data->bytes_xfered =3D 0;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_initialize_data);
> >
> >  static inline void sdhci_set_block_info(struct sdhci_host *host,
> >                                       struct mmc_data *data)
> > @@ -1112,12 +1114,8 @@ static inline void sdhci_set_block_info(struct s=
dhci_host *host,
> >       }
> >  }
> >
> > -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_com=
mand *cmd)
> > +void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data)
> >  {
> > -     struct mmc_data *data =3D cmd->data;
> > -
> > -     sdhci_initialize_data(host, data);
> > -
> >       if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
> >               struct scatterlist *sg;
> >               unsigned int length_mask, offset_mask;
> > @@ -1202,6 +1200,16 @@ static void sdhci_prepare_data(struct sdhci_host=
 *host, struct mmc_command *cmd)
> >       }
> >
> >       sdhci_set_transfer_irqs(host);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_prepare_dma);
> > +
> > +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_com=
mand *cmd)
> > +{
> > +     struct mmc_data *data =3D cmd->data;
> > +
> > +     sdhci_initialize_data(host, data);
> > +
> > +     sdhci_prepare_dma(host, data);
> >
> >       sdhci_set_block_info(host, data);
> >  }
> > @@ -1519,7 +1527,7 @@ static void sdhci_set_mrq_done(struct sdhci_host =
*host, struct mmc_request *mrq)
> >       WARN_ON(i >=3D SDHCI_MAX_MRQS);
> >  }
> >
> > -static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_req=
uest *mrq)
> > +void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *m=
rq)
> >  {
> >       if (host->cmd && host->cmd->mrq =3D=3D mrq)
> >               host->cmd =3D NULL;
> > @@ -1543,15 +1551,17 @@ static void __sdhci_finish_mrq(struct sdhci_hos=
t *host, struct mmc_request *mrq)
> >       if (!sdhci_has_requests(host))
> >               sdhci_led_deactivate(host);
> >  }
> > +EXPORT_SYMBOL_GPL(__sdhci_finish_mrq);
> >
> > -static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_reque=
st *mrq)
> > +void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq=
)
> >  {
> >       __sdhci_finish_mrq(host, mrq);
> >
> >       queue_work(host->complete_wq, &host->complete_work);
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_finish_mrq);
> >
> > -static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_=
timeout)
> > +void __sdhci_finish_data_common(struct sdhci_host *host)
> >  {
> >       struct mmc_command *data_cmd =3D host->data_cmd;
> >       struct mmc_data *data =3D host->data;
> > @@ -1585,6 +1595,14 @@ static void __sdhci_finish_data(struct sdhci_hos=
t *host, bool sw_data_timeout)
> >               data->bytes_xfered =3D 0;
> >       else
> >               data->bytes_xfered =3D data->blksz * data->blocks;
> > +}
> > +EXPORT_SYMBOL_GPL(__sdhci_finish_data_common);
> > +
> > +static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_=
timeout)
> > +{
> > +     struct mmc_data *data =3D host->data;
> > +
> > +     __sdhci_finish_data_common(host);
> >
> >       /*
> >        * Need to send CMD12 if -
> > @@ -1719,8 +1737,8 @@ static bool sdhci_send_command(struct sdhci_host =
*host, struct mmc_command *cmd)
> >       return true;
> >  }
> >
> > -static bool sdhci_present_error(struct sdhci_host *host,
> > -                             struct mmc_command *cmd, bool present)
> > +bool sdhci_present_error(struct sdhci_host *host,
> > +                      struct mmc_command *cmd, bool present)
> >  {
> >       if (!present || host->flags & SDHCI_DEVICE_DEAD) {
> >               cmd->error =3D -ENOMEDIUM;
> > @@ -1729,6 +1747,7 @@ static bool sdhci_present_error(struct sdhci_host=
 *host,
> >
> >       return false;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_present_error);
> >
> >  static bool sdhci_send_command_retry(struct sdhci_host *host,
> >                                    struct mmc_command *cmd,
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 03d29423a678..9a2bd319d94c 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -828,6 +828,14 @@ static inline void sdhci_read_caps(struct sdhci_ho=
st *host)
> >       __sdhci_read_caps(host, NULL, NULL, NULL);
> >  }
> >
> > +bool sdhci_data_line_cmd(struct mmc_command *cmd);
> > +void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,=
 unsigned long timeout);
> > +void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *d=
ata);
> > +void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data)=
;
> > +void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *m=
rq);
> > +void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq=
);
> > +void __sdhci_finish_data_common(struct sdhci_host *host);
> > +bool sdhci_present_error(struct sdhci_host *host, struct mmc_command *=
cmd, bool present);
> >  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
> >                  unsigned int *actual_clock);
> >  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
>

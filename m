Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9175C42B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjGUKMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjGUKM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:12:29 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7194359D;
        Fri, 21 Jul 2023 03:12:09 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-794b8fe8cc4so1916822241.0;
        Fri, 21 Jul 2023 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934329; x=1690539129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rnTTSsuNtqms+lEz2mRkVpuu6mi1oaQ2iMvboCkXMw=;
        b=LgNHH36fD4TnDq4XT6TeWTSinIwJ+nk6ByU++7hWZotB+RDqaBBB8oXc15NI1XEtLI
         TcOKs/Cuo9EqPHwqBkh2aIA2Ym1DwJwX2yG+ALmquz606sYDYgYXlrGftkRrnLzWKvHc
         NTbzpvgGJzWJUNqv9Ou5+qPOctFJDe1dkNp/8Ti2VnJ5q/8B5jNm43spDjSGPZSeQqSQ
         rVk0Sp5pCM1aNw870drOY8Y8cJdXsnW3TvKjFB0gHpOv6AzLKUj0pUGw4AnmB8cF6TB6
         zjiH8zu1ziGac2nCmhP2aLVWpyNbc8x0itelU1xiJDLGPYb1kP3Z8Hb7cR73ABEJANLS
         5dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934329; x=1690539129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rnTTSsuNtqms+lEz2mRkVpuu6mi1oaQ2iMvboCkXMw=;
        b=aDehZ+g15LNmnPlg+FoxWBA2Lkvo3N6nD86i/zrl2pEFU7Od097frRwQy+ZOraQVLO
         PNBVKAyBSK/pNNZ/p3hkyrl4xQw5eV0zcAsOg1Z+0R7Yei0Q4qz9kSiiCPOlvsEY55Bj
         Fas4ImXcOfP3SLsOIBsSgTWDoHf+ryTVUMVl84dyzJ0SwSxwvzmTnsEceKC5/E7gfwTj
         lU+SbOODhuewZbsAyMDu8MlW/x+h5Mis3xRudY1Rfh5cO93jH5X53AQNofT2drhjax7F
         YfjlGb205hD0S2KfWit8XL0GCj3aC+ItOID3Fv0UGBhVBCyQZ81LdfOgG0XtpzWoDSCy
         mX5g==
X-Gm-Message-State: ABy/qLYNK1QagLr/XEGiDQT0XEiqxLoInM0VGqX5E0+whLc/SEGylVth
        hUOhBTcwMoFRtKznIAYSI83vscdi1tHJ1JyCLIw=
X-Google-Smtp-Source: APBJJlGjNWiNKRPYacTXhLDq6icaEy51aicHQxUwLnYygmBSvz6yy/mp/OTzsQ3aYGrQmqNI5Gpy1iQpGCSLWFO5KtQ=
X-Received: by 2002:a67:e349:0:b0:443:649c:3a44 with SMTP id
 s9-20020a67e349000000b00443649c3a44mr361420vsm.16.1689934328571; Fri, 21 Jul
 2023 03:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-19-victorshihgli@gmail.com> <79b8a72f-35a6-d4b1-831f-665ec17d3d1a@intel.com>
In-Reply-To: <79b8a72f-35a6-d4b1-831f-665ec17d3d1a@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 21 Jul 2023 18:11:56 +0800
Message-ID: <CAK00qKD1g29zpLwfUMuPHKORd1GDxrXtjUDYUD588W+Y_uXmBA@mail.gmail.com>
Subject: Re: [PATCH V8 18/23] mmc: sdhci-uhs2: add request() and others
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 12:03=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 21/06/23 13:01, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a sdhci version of mmc's request operation.
> > It covers both UHS-I and UHS-II.
> >
> > Updates in V8:
> >  - Adjust the position of matching brackets in
> >    sdhci_uhs2_send_command_retry().
> >  - Modify CameCase definition in __sdhci_uhs2_finish_command().
> >  - Modify error message in __sdhci_uhs2_finish_command().
> >  - sdhci_uhs2_send_command_retry() to instead of
> >    sdhci_uhs2_send_command() in sdhci_uhs2_request().
> >  - Use sdhci_uhs2_mode() to simplify code in
> >    sdhci_uhs2_request_atomic().
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
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 412 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c      |  49 ++--
> >  drivers/mmc/host/sdhci.h      |   8 +
> >  3 files changed, 454 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 09b86fec9f7b..ed0a41c97944 100644
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
> > +     if ((mmc_card_uhs2_hd_mode(host->mmc)) && !cmd->uhs2_tmode0_flag)
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
> > +      * Per spec, playload (config) should be MSB before sending out.
>
> playload -> payload
>

Hi, Adrian

      I will fix it in the V9 version.

Thanks, Victor Shih

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
> > index 6e5a9d93a769..2f47c4f29bab 100644
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482DC75C42E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGUKMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjGUKMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:12:33 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740B730D0;
        Fri, 21 Jul 2023 03:12:13 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4468a772490so705884137.3;
        Fri, 21 Jul 2023 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689934332; x=1690539132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQPD9b4nZBGXAfFAtD7zIsRm/8WJczVkv0B38hqMstM=;
        b=cWyKAfnFV8zwYPDtY9NDoRaUAq+MoE/Qxxghk8p8NrgZBPPV9RR7zYuKGcsvKEcZSN
         MHk5d6Av4Lerx3m/Zwd/Sc0vX6XaZJzjTc+x8CoTyZMYfb4c9ECv5fvAUpghgIBXSh5z
         kpr8917r0yFllb+Q7gX3L8OpH4d5W/Lmnfs6S23e+tOw+asRZVudmTvwTiC8FXCeh0fd
         GcfkfuHYm19UUZZO2MFh/flriqzD0WwRk2GRXyUjZmBpGGYfdaUCbo/jBvLLWcs9qms1
         Dho6cwbz63TQMO+Zf82QxY75QBZtRNcdttPdZ0FXnYl2rJ92s1qbgM9/PyCk4HCvz9K4
         V51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689934332; x=1690539132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQPD9b4nZBGXAfFAtD7zIsRm/8WJczVkv0B38hqMstM=;
        b=Hbe8JTu1p5g8lhClD92KDyscoOFk8ZjN7cBWX4Q2nJNRhXiTdkospWwv+eG+3IFXim
         pTS/Da3W6t2uRBupOgVJyiWhS+ex1hrObZLQhB4f/ogD25BkfLfsls2tY9QiXNrLHAaw
         eEdGxGRZ0CThlKpadQ2909ZaoDqxBIe58JwxrTBQNC4d9KV6onRpwMrIQSQ4+iUYGkpl
         lGNZPVn2TwQttDCmi6I6NPJ54gQuk3W0K/mkDSWwOh0qJUp+hXmURp+Vt+KL3EsJCrsk
         R6PxfSrpaS2sklReeubTlcFHri75/wqJo41sAbRN5MNhWFBXHr8I8SCLgA+BwQk2p1GX
         m9MA==
X-Gm-Message-State: ABy/qLZRieCRmjtsS5OBA3vQMlmBJ13YQ1aH9R988zPluFy8VzTWIQRW
        MMICwJV4wzlinMPerYwL6+wRyGFKQW06YgVsYag=
X-Google-Smtp-Source: APBJJlGWidxVL4wxbDq6CSwNmXSJo8AYiSAWgN9XP4JR0Is7vb+GDYVgu4SE6nqTZtdUGVzkG3EBjIkhR/rEIOxuwfM=
X-Received: by 2002:a67:ed06:0:b0:443:6212:60a9 with SMTP id
 l6-20020a67ed06000000b00443621260a9mr415931vsp.6.1689934332283; Fri, 21 Jul
 2023 03:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-20-victorshihgli@gmail.com> <5450f45b-a9ec-013b-201f-4393e5614d9d@intel.com>
In-Reply-To: <5450f45b-a9ec-013b-201f-4393e5614d9d@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 21 Jul 2023 18:12:00 +0800
Message-ID: <CAK00qKDPbaVLWiAJ=xpBOceNi7j7_3j1414CC+-MrhdC6sx7zg@mail.gmail.com>
Subject: Re: [PATCH V8 19/23] mmc: sdhci-uhs2: add irq() and others
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
> > This is a UHS-II version of sdhci's request() operation.
> > It handles UHS-II related command interrupts and errors.
> >
> > Updates in V8:
> >  - Forward declare struct mmc_request in sdhci_uhs2.h.
> >  - Remove forward declaration of sdhci_send_command().
> >  - Use mmc_dev() to simplify code in sdhci_request_done_dma().
> >
> > Updates in V7:
> >  - Remove unnecessary functions.
> >  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_irq().
> >  - Modify descriptions in sdhci_uhs2_irq().
> >  - Cancel export state of some functions.
> >
> > Updates in V6:
> >  - Remove unnecessary functions.
> >  - Add sdhci_uhs2_mode() in sdhci_uhs2_complete_work().
> >  - Add sdhci_uhs2_mode() in sdhci_uhs2_thread_irq().
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 215 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |   4 +
> >  drivers/mmc/host/sdhci.c      | 102 ++++++++--------
> >  drivers/mmc/host/sdhci.h      |   5 +
> >  4 files changed, 280 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index ed0a41c97944..f92a5cd5800d 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -782,6 +782,221 @@ static void sdhci_uhs2_finish_command(struct sdhc=
i_host *host)
> >               __sdhci_finish_mrq(host, cmd->mrq);
> >  }
> >
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * Request done                                                       =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static bool sdhci_uhs2_request_done(struct sdhci_host *host)
> > +{
> > +     unsigned long flags;
> > +     struct mmc_request *mrq;
> > +     int i;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +
> > +     for (i =3D 0; i < SDHCI_MAX_MRQS; i++) {
> > +             mrq =3D host->mrqs_done[i];
> > +             if (mrq)
> > +                     break;
> > +     }
> > +
> > +     if (!mrq) {
> > +             spin_unlock_irqrestore(&host->lock, flags);
> > +             return true;
> > +     }
> > +
> > +     /*
> > +      * Always unmap the data buffers if they were mapped by
> > +      * sdhci_prepare_data() whenever we finish with a request.
> > +      * This avoids leaking DMA mappings on error.
> > +      */
> > +     if (host->flags & SDHCI_REQ_USE_DMA)
> > +             sdhci_request_done_dma(host, mrq);
> > +
> > +     /*
> > +      * The controller needs a reset of internal state machines
> > +      * upon error conditions.
> > +      */
> > +     if (sdhci_needs_reset(host, mrq)) {
> > +             /*
> > +              * Do not finish until command and data lines are availab=
le for
> > +              * reset. Note there can only be one other mrq, so it can=
not
> > +              * also be in mrqs_done, otherwise host->cmd and host->da=
ta_cmd
> > +              * would both be null.
> > +              */
> > +             if (host->cmd || host->data_cmd) {
> > +                     spin_unlock_irqrestore(&host->lock, flags);
> > +                     return true;
> > +             }
> > +
> > +             sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> > +             host->pending_reset =3D false;
> > +     }
> > +
> > +     host->mrqs_done[i] =3D NULL;
> > +
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +     if (host->ops->request_done)
> > +             host->ops->request_done(host, mrq);
> > +     else
> > +             mmc_request_done(host->mmc, mrq);
> > +
> > +     return false;
> > +}
> > +
> > +static void sdhci_uhs2_complete_work(struct work_struct *work)
> > +{
> > +     struct sdhci_host *host =3D container_of(work, struct sdhci_host,
> > +                                            complete_work);
> > +
> > +     if (!sdhci_uhs2_mode(host)) {
> > +             sdhci_complete_work(work);
> > +             return;
> > +     }
> > +
> > +     while (!sdhci_uhs2_request_done(host))
> > +             ;
> > +}
> > +
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * Interrupt handling                                                 =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
> > +{
> > +     struct mmc_command *cmd =3D host->cmd;
> > +
> > +     DBG("*** %s got UHS2 error interrupt: 0x%08x\n",
> > +         mmc_hostname(host->mmc), uhs2mask);
> > +
> > +     if (uhs2mask & SDHCI_UHS2_INT_CMD_ERR_MASK) {
> > +             if (!host->cmd) {
> > +                     pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\=
n",
> > +                            mmc_hostname(host->mmc),
> > +                            (unsigned int)uhs2mask);
> > +                     sdhci_dumpregs(host);
> > +                     return;
> > +             }
> > +             host->cmd->error =3D -EILSEQ;
> > +             if (uhs2mask & SDHCI_UHS2_INT_CMD_TIMEOUT)
> > +                     host->cmd->error =3D -ETIMEDOUT;
> > +     }
> > +
> > +     if (uhs2mask & SDHCI_UHS2_INT_DATA_ERR_MASK) {
> > +             if (!host->data) {
> > +                     pr_err("%s: Got data interrupt 0x%08x but no data=
.\n",
> > +                            mmc_hostname(host->mmc),
> > +                            (unsigned int)uhs2mask);
> > +                     sdhci_dumpregs(host);
> > +                     return;
> > +             }
> > +
> > +             if (uhs2mask & SDHCI_UHS2_INT_DEADLOCK_TIMEOUT) {
> > +                     pr_err("%s: Got deadlock timeout interrupt 0x%08x=
\n",
> > +                            mmc_hostname(host->mmc),
> > +                            (unsigned int)uhs2mask);
> > +                     host->data->error =3D -ETIMEDOUT;
> > +             } else if (uhs2mask & SDHCI_UHS2_INT_ADMA_ERROR) {
> > +                     pr_err("%s: ADMA error =3D 0x %x\n",
> > +                            mmc_hostname(host->mmc),
> > +                            sdhci_readb(host, SDHCI_ADMA_ERROR));
> > +                     host->data->error =3D -EIO;
> > +             } else {
> > +                     host->data->error =3D -EILSEQ;
> > +             }
> > +     }
> > +
> > +     if (host->data && host->data->error)
> > +             sdhci_uhs2_finish_data(host);
> > +     else
> > +             sdhci_finish_mrq(host, cmd->mrq);
> > +}
> > +
> > +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask)
> > +{
> > +     u32 mask =3D intmask, uhs2mask;
> > +
> > +     if (!sdhci_uhs2_mode(host))
> > +             goto out;
> > +
> > +     if (intmask & SDHCI_INT_ERROR) {
> > +             uhs2mask =3D sdhci_readl(host, SDHCI_UHS2_INT_STATUS);
> > +             if (!(uhs2mask & SDHCI_UHS2_INT_ERROR_MASK))
> > +                     goto cmd_irq;
> > +
> > +             /* Clear error interrupts */
> > +             sdhci_writel(host, uhs2mask & SDHCI_UHS2_INT_ERROR_MASK,
> > +                          SDHCI_UHS2_INT_STATUS);
> > +
> > +             /* Handle error interrupts */
> > +             __sdhci_uhs2_irq(host, uhs2mask);
> > +
> > +             /* Caller, sdhci_irq(), doesn't have to care about UHS-2 =
errors */
> > +             intmask &=3D ~SDHCI_INT_ERROR;
> > +             mask &=3D SDHCI_INT_ERROR;
> > +     }
> > +
> > +cmd_irq:
> > +     if (intmask & SDHCI_INT_CMD_MASK) {
> > +             /* Clear command interrupt */
> > +             sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_IN=
T_STATUS);
> > +
> > +             /* Handle command interrupt */
> > +             if (intmask & SDHCI_INT_RESPONSE)
> > +                     sdhci_uhs2_finish_command(host);
> > +
> > +             /* Caller, sdhci_irq(), doesn't have to care about UHS-2 =
commands */
> > +             intmask &=3D ~SDHCI_INT_CMD_MASK;
> > +             mask &=3D SDHCI_INT_CMD_MASK;
> > +     }
> > +
> > +     /* Clear already-handled interrupts. */
> > +     sdhci_writel(host, mask, SDHCI_INT_STATUS);
> > +
> > +out:
> > +     return intmask;
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_irq);
> > +
> > +static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
> > +{
> > +     struct sdhci_host *host =3D dev_id;
> > +     struct mmc_command *cmd;
> > +     unsigned long flags;
> > +     u32 isr;
> > +
> > +     if (!sdhci_uhs2_mode(host))
> > +             return sdhci_thread_irq(irq, dev_id);
> > +
> > +     while (!sdhci_uhs2_request_done(host))
> > +             ;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +
> > +     isr =3D host->thread_isr;
> > +     host->thread_isr =3D 0;
> > +
> > +     cmd =3D host->deferred_cmd;
> > +     if (cmd && !sdhci_uhs2_send_command_retry(host, cmd, flags))
> > +             sdhci_finish_mrq(host, cmd->mrq);
> > +
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +     if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> > +             struct mmc_host *mmc =3D host->mmc;
> > +
> > +             mmc->ops->card_event(mmc);
> > +             mmc_detect_change(mmc, msecs_to_jiffies(200));
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> >  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  {
> >       struct sdhci_host *host =3D mmc_priv(mmc);
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index a3641c5f8c77..3aa2cb4b39d6 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -176,11 +176,15 @@
> >
> >  struct sdhci_host;
> >  struct mmc_command;
> > +struct mmc_request;
> >
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> >  bool sdhci_uhs2_mode(struct sdhci_host *host);
> >  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_comman=
d *cmd);
> >  void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32=
 set);
> > +void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)=
;
> > +int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request=
 *mrq);
> > +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 2f47c4f29bab..144445e9f875 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1497,7 +1497,7 @@ static void sdhci_set_transfer_mode(struct sdhci_=
host *host,
> >       sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
> >  }
> >
> > -static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_requ=
est *mrq)
> > +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mr=
q)
> >  {
> >       return (!(host->flags & SDHCI_DEVICE_DEAD) &&
> >               ((mrq->cmd && mrq->cmd->error) ||
> > @@ -1505,8 +1505,9 @@ static bool sdhci_needs_reset(struct sdhci_host *=
host, struct mmc_request *mrq)
> >                (mrq->data && mrq->data->stop && mrq->data->stop->error)=
 ||
> >                (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_needs_reset);
> >
> > -static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_req=
uest *mrq)
> > +void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *m=
rq)
> >  {
> >       int i;
> >
> > @@ -1526,6 +1527,7 @@ static void sdhci_set_mrq_done(struct sdhci_host =
*host, struct mmc_request *mrq)
> >
> >       WARN_ON(i >=3D SDHCI_MAX_MRQS);
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_set_mrq_done);
>
> sdhci_set_mrq_done() does not seem to be used outside sdhci.c
> so does not need exporting
>

Hi, Adrian

      I will update it to the V9 version.

Thanks, Victor Shih

> >
> >  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *m=
rq)
> >  {
> > @@ -3111,6 +3113,53 @@ static const struct mmc_host_ops sdhci_ops =3D {
> >   *                                                                    =
       *
> >  \*********************************************************************=
********/
> >
> > +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_reques=
t *mrq)
> > +{
> > +     struct mmc_data *data =3D mrq->data;
> > +
> > +     if (data && data->host_cookie =3D=3D COOKIE_MAPPED) {
> > +             if (host->bounce_buffer) {
> > +                     /*
> > +                      * On reads, copy the bounced data into the
> > +                      * sglist
> > +                      */
> > +                     if (mmc_get_dma_dir(data) =3D=3D DMA_FROM_DEVICE)=
 {
> > +                             unsigned int length =3D data->bytes_xfere=
d;
> > +
> > +                             if (length > host->bounce_buffer_size) {
> > +                                     pr_err("%s: bounce buffer is %u b=
ytes but DMA claims to have transferred %u bytes\n",
> > +                                            mmc_hostname(host->mmc),
> > +                                            host->bounce_buffer_size,
> > +                                            data->bytes_xfered);
> > +                                     /* Cap it down and continue */
> > +                                     length =3D host->bounce_buffer_si=
ze;
> > +                             }
> > +                             dma_sync_single_for_cpu(mmc_dev(host->mmc=
),
> > +                                                     host->bounce_addr=
,
> > +                                                     host->bounce_buff=
er_size,
> > +                                                     DMA_FROM_DEVICE);
> > +                             sg_copy_from_buffer(data->sg,
> > +                                                 data->sg_len,
> > +                                                 host->bounce_buffer,
> > +                                                 length);
> > +                     } else {
> > +                             /* No copying, just switch ownership */
> > +                             dma_sync_single_for_cpu(mmc_dev(host->mmc=
),
> > +                                                     host->bounce_addr=
,
> > +                                                     host->bounce_buff=
er_size,
> > +                                                     mmc_get_dma_dir(d=
ata));
> > +                     }
> > +             } else {
> > +                     /* Unmap the raw data */
> > +                     dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> > +                                  data->sg_len,
> > +                                  mmc_get_dma_dir(data));
> > +             }
> > +             data->host_cookie =3D COOKIE_UNMAPPED;
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_request_done_dma);
> > +
> >  static bool sdhci_request_done(struct sdhci_host *host)
> >  {
> >       unsigned long flags;
> > @@ -3175,48 +3224,7 @@ static bool sdhci_request_done(struct sdhci_host=
 *host)
> >                       sdhci_set_mrq_done(host, mrq);
> >               }
> >
> > -             if (data && data->host_cookie =3D=3D COOKIE_MAPPED) {
> > -                     if (host->bounce_buffer) {
> > -                             /*
> > -                              * On reads, copy the bounced data into t=
he
> > -                              * sglist
> > -                              */
> > -                             if (mmc_get_dma_dir(data) =3D=3D DMA_FROM=
_DEVICE) {
> > -                                     unsigned int length =3D data->byt=
es_xfered;
> > -
> > -                                     if (length > host->bounce_buffer_=
size) {
> > -                                             pr_err("%s: bounce buffer=
 is %u bytes but DMA claims to have transferred %u bytes\n",
> > -                                                    mmc_hostname(host-=
>mmc),
> > -                                                    host->bounce_buffe=
r_size,
> > -                                                    data->bytes_xfered=
);
> > -                                             /* Cap it down and contin=
ue */
> > -                                             length =3D host->bounce_b=
uffer_size;
> > -                                     }
> > -                                     dma_sync_single_for_cpu(
> > -                                             mmc_dev(host->mmc),
> > -                                             host->bounce_addr,
> > -                                             host->bounce_buffer_size,
> > -                                             DMA_FROM_DEVICE);
> > -                                     sg_copy_from_buffer(data->sg,
> > -                                             data->sg_len,
> > -                                             host->bounce_buffer,
> > -                                             length);
> > -                             } else {
> > -                                     /* No copying, just switch owners=
hip */
> > -                                     dma_sync_single_for_cpu(
> > -                                             mmc_dev(host->mmc),
> > -                                             host->bounce_addr,
> > -                                             host->bounce_buffer_size,
> > -                                             mmc_get_dma_dir(data));
> > -                             }
> > -                     } else {
> > -                             /* Unmap the raw data */
> > -                             dma_unmap_sg(mmc_dev(host->mmc), data->sg=
,
> > -                                          data->sg_len,
> > -                                          mmc_get_dma_dir(data));
> > -                     }
> > -                     data->host_cookie =3D COOKIE_UNMAPPED;
> > -             }
> > +             sdhci_request_done_dma(host, mrq);
> >       }
> >
> >       host->mrqs_done[i] =3D NULL;
> > @@ -3231,7 +3239,7 @@ static bool sdhci_request_done(struct sdhci_host =
*host)
> >       return false;
> >  }
> >
> > -static void sdhci_complete_work(struct work_struct *work)
> > +void sdhci_complete_work(struct work_struct *work)
> >  {
> >       struct sdhci_host *host =3D container_of(work, struct sdhci_host,
> >                                              complete_work);
> > @@ -3239,6 +3247,7 @@ static void sdhci_complete_work(struct work_struc=
t *work)
> >       while (!sdhci_request_done(host))
> >               ;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_complete_work);
> >
> >  static void sdhci_timeout_timer(struct timer_list *t)
> >  {
> > @@ -3694,7 +3703,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_i=
d)
> >       return result;
> >  }
> >
> > -static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> > +irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> >  {
> >       struct sdhci_host *host =3D dev_id;
> >       struct mmc_command *cmd;
> > @@ -3724,6 +3733,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void=
 *dev_id)
> >
> >       return IRQ_HANDLED;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_thread_irq);
> >
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 9a2bd319d94c..20eb0943b402 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -832,6 +832,8 @@ bool sdhci_data_line_cmd(struct mmc_command *cmd);
> >  void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,=
 unsigned long timeout);
> >  void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *d=
ata);
> >  void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data)=
;
> > +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mr=
q);
> > +void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *m=
rq);
>
> sdhci_set_mrq_done() does not seem to be used outside sdhci.c
> so does not need exporting
>

Hi, Adrian

      I will update it to the V9 version.

Thanks, Victor Shih

> >  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *m=
rq);
> >  void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq=
);
> >  void __sdhci_finish_data_common(struct sdhci_host *host);
> > @@ -861,6 +863,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc=
_ios *ios);
> >  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >                                     struct mmc_ios *ios);
> >  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> > +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_reques=
t *mrq);
> > +void sdhci_complete_work(struct work_struct *work);
> > +irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
> >  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
> >                          dma_addr_t addr, int len, unsigned int cmd);
> >
>

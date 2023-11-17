Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3B87EF116
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346115AbjKQKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346061AbjKQKul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:50:41 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0641738;
        Fri, 17 Nov 2023 02:50:29 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4acb1260852so643757e0c.2;
        Fri, 17 Nov 2023 02:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700218229; x=1700823029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg6ZRI4dNrEPiTO9SEzNCL6/GObRrK4fghBQ1m3rpkM=;
        b=HsPwIIe4XxjY9cLGpLycT99bZVLzbtfHilzhPD6o5xcjOhAENhY5tLpY1GR/DydQKj
         sNJiDujDUxHU6LlY9koGq8lHrBQevs8B+ryTWwWQXbfCd0G7Ut/KOI7mC1f12FaCqnZ+
         T/swqeus23SWE2GC09I+Xrn/FNRvd1N8IHymvKQzLwdU/9S5VNTQypW9PdSI4JbTpt57
         AkQFt59X9nk2rXpmkN18i4TK+cnEMCFzTn7YftglReip8nVD9Ls1lMsQA80Je/UU/jNy
         ADb077nnePSan70/0F9imR+iwCeynq/wPhRxskYN7weC1XnjBZd2IF0DtU3GIjMGlMHX
         Xh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218229; x=1700823029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg6ZRI4dNrEPiTO9SEzNCL6/GObRrK4fghBQ1m3rpkM=;
        b=belVqAfJ9aUvU/Tcyny6/qf90RW4VomT66GSwdyENsyU7kgaQ5g6B3p51lF+3/EhdJ
         XVV5V7O5ohuwCAvn3YItA9Za5FP/mXgnbEELwfGS/M53wEQLrXmjyxpEL6F8jRaoQHwS
         nBpJeJszxXpOlc882eE0GBZawfhCJj0rLI3p0Oqghu61VE8E2sjy0suufS7HeNFjduQq
         H0Kt1w4oZVnTFYVaGhiVpMo24FSXf8jzA2uynrM7AbtrGDgyZVZVUqdkXE+dmx6J/eCT
         rH4TvC5xDRUHFh2/x5/iknNQxOOaJ19wGQMPV6BPdjuYUhaEjibtD4PDzjPyxn0xe5dl
         L7Fw==
X-Gm-Message-State: AOJu0Yzi5tJCJhIvH68JDUQnq2relHmAP42IQfJAublPmEveAGHqe1Ob
        RVDdCNBGKVAI4PNkABu4cULfW68nA6gKNpAvAJE=
X-Google-Smtp-Source: AGHT+IErRGRiuPy8I42Ox2dbYbXgT2oNTOAX14iaTGu41dZmdUHq1uP2PSWvFxnUqtFW1kjz1truJxc3FI3YLEeKip0=
X-Received: by 2002:a05:6122:468a:b0:4ab:fc1a:ae93 with SMTP id
 di10-20020a056122468a00b004abfc1aae93mr19402394vkb.16.1700218228753; Fri, 17
 Nov 2023 02:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-19-victorshihgli@gmail.com> <CAPDyKFoiroN0XX0CLHGxZYHCZmWe11z5avH=KnS7qpkuNdwxiw@mail.gmail.com>
In-Reply-To: <CAPDyKFoiroN0XX0CLHGxZYHCZmWe11z5avH=KnS7qpkuNdwxiw@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 17 Nov 2023 18:50:16 +0800
Message-ID: <CAK00qKAQRfge+YSBLOck0865qWjVJnX_hiDaxZFJeoCughBnGA@mail.gmail.com>
Subject: Re: [PATCH V12 18/23] mmc: sdhci-uhs2: add request() and others
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
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

On Tue, Oct 3, 2023 at 8:15=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrot=
e:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a sdhci version of mmc's request operation.
> > It covers both UHS-I and UHS-II.
>
> Okay, but again, please elaborate on why we need/want this.
>

Hi, Ulf

I will try to update this in version 13.

Thanks, Victor Shih

> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V11:
> >  - Drop the check mmc_card_uhs2_hd_mode(host->mmc)
> >    in sdhci_uhs2_set_transfer_mode().
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
> > index 09b86fec9f7b..1f8d527424fd 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
>
> [...]
>
> > +
> > +static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct =
mmc_command *cmd)
> > +{
> > +       int i, j;
> > +       int cmd_reg;
> > +
> > +       i =3D 0;
> > +       sdhci_writel(host,
> > +                    ((u32)cmd->uhs2_cmd->arg << 16) |
> > +                               (u32)cmd->uhs2_cmd->header,
> > +                    SDHCI_UHS2_CMD_PACKET + i);
> > +       i +=3D 4;
> > +
> > +       /*
> > +        * Per spec, payload (config) should be MSB before sending out.
> > +        * But we don't need convert here because had set payload as
> > +        * MSB when preparing config read/write commands.
> > +        */
> > +       for (j =3D 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++=
) {
> > +               sdhci_writel(host, *(cmd->uhs2_cmd->payload + j), SDHCI=
_UHS2_CMD_PACKET + i);
> > +               i +=3D 4;
> > +       }
> > +
> > +       for ( ; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i +=3D 4)
> > +               sdhci_writel(host, 0, SDHCI_UHS2_CMD_PACKET + i);
> > +
> > +       DBG("UHS2 CMD packet_len =3D %d.\n", cmd->uhs2_cmd->packet_len)=
;
> > +       for (i =3D 0; i < cmd->uhs2_cmd->packet_len; i++)
> > +               DBG("UHS2 CMD_PACKET[%d] =3D 0x%x.\n", i,
> > +                   sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));
>
> We are ignoring what we just read. Isn't there something we need to verif=
y?
>
> Moreover, the whole thing with i,j and the +4 thing above looks a bit
> odd to me. I am not sure whether the above can be simplified, but I
> leave that for you to have a second look at.
>

Hi, Ulf

Sorry, I don't have any ideas on this, could you please give me some ideas?

Thanks, Victor Shih

> > +
> > +       cmd_reg =3D FIELD_PREP(SDHCI_UHS2_CMD_PACK_LEN_MASK, cmd->uhs2_=
cmd->packet_len);
> > +       if ((cmd->flags & MMC_CMD_MASK) =3D=3D MMC_CMD_ADTC)
> > +               cmd_reg |=3D SDHCI_UHS2_CMD_DATA;
> > +       if (cmd->opcode =3D=3D MMC_STOP_TRANSMISSION)
> > +               cmd_reg |=3D SDHCI_UHS2_CMD_CMD12;
> > +
> > +       /* UHS2 Native ABORT */
> > +       if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> > +           (uhs2_dev_cmd(cmd) =3D=3D UHS2_DEV_CMD_TRANS_ABORT))
> > +               cmd_reg |=3D SDHCI_UHS2_CMD_TRNS_ABORT;
> > +
> > +       /* UHS2 Native DORMANT */
> > +       if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> > +           (uhs2_dev_cmd(cmd) =3D=3D UHS2_DEV_CMD_GO_DORMANT_STATE))
> > +               cmd_reg |=3D SDHCI_UHS2_CMD_DORMANT;
> > +
> > +       DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
> > +
> > +       sdhci_writew(host, cmd_reg, SDHCI_UHS2_CMD);
> > +}
>
> [...]
>
> > +static bool sdhci_uhs2_send_command_retry(struct sdhci_host *host,
> > +                                         struct mmc_command *cmd,
> > +                                         unsigned long flags)
> > +       __releases(host->lock)
> > +       __acquires(host->lock)
> > +{
> > +       struct mmc_command *deferred_cmd =3D host->deferred_cmd;
> > +       int timeout =3D 10; /* Approx. 10 ms */
> > +       bool present;
>
> Why do we need a retry mechanism at this level? The mmc core sometimes
> retries commands when it seems reasonable, why isn't that sufficient?
>

Hi, Ulf

According to my testing experience, this function is sometimes called
to resend the command.

Thanks, Victor Shih

> > +
> > +       while (!sdhci_uhs2_send_command(host, cmd)) {
> > +               if (!timeout--) {
> > +                       pr_err("%s: Controller never released inhibit b=
it(s).\n",
> > +                              mmc_hostname(host->mmc));
> > +                       sdhci_dumpregs(host);
> > +                       cmd->error =3D -EIO;
> > +                       return false;
> > +               }
> > +
> > +               spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +               usleep_range(1000, 1250);
> > +
> > +               present =3D host->mmc->ops->get_cd(host->mmc);
> > +
> > +               spin_lock_irqsave(&host->lock, flags);
> > +
> > +               /* A deferred command might disappear, handle that */
> > +               if (cmd =3D=3D deferred_cmd && cmd !=3D host->deferred_=
cmd)
> > +                       return true;
> > +
> > +               if (sdhci_present_error(host, cmd, present))
> > +                       return false;
> > +       }
>
> If the retry is needed, would it be possible to convert into using
> read_poll_timeout() for the above while loop instead? If so, please
> make that conversion.
>

Hi, Ulf

I have no idea how to use  read_poll_timeout() instead of while loop,
because there are still other functions running inside the while loop.
Can you give me some ideas?

Thanks, Victor Shih

> > +
> > +       if (cmd =3D=3D host->deferred_cmd)
> > +               host->deferred_cmd =3D NULL;
> > +
> > +       return true;
> > +}
> > +
> > +static void __sdhci_uhs2_finish_command(struct sdhci_host *host)
> > +{
> > +       struct mmc_command *cmd =3D host->cmd;
> > +       u8 resp;
> > +       u8 ecode;
> > +       bool breada0 =3D 0;
>
> Nitpick: Maybe find some better variable names. Like error_code...
>

Hi, Ulf

I will update this in version 13.

Thanks, Victor Shih

> > +       int i;
> > +
> > +       if (host->mmc->flags & MMC_UHS2_SD_TRAN) {
> > +               resp =3D sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
> > +               if (resp & UHS2_RES_NACK_MASK) {
> > +                       ecode =3D (resp >> UHS2_RES_ECODE_POS) & UHS2_R=
ES_ECODE_MASK;
> > +                       pr_err("%s: NACK response, ECODE=3D0x%x.\n", mm=
c_hostname(host->mmc), ecode);
> > +               }
> > +               breada0 =3D 1;
> > +       }
> > +
> > +       if (cmd->uhs2_resp &&
> > +           cmd->uhs2_resp_len && cmd->uhs2_resp_len <=3D 20) {
> > +               /* Get whole response of some native CCMD, like
> > +                * DEVICE_INIT, ENUMERATE.
> > +                */
> > +               for (i =3D 0; i < cmd->uhs2_resp_len; i++)
> > +                       cmd->uhs2_resp[i] =3D sdhci_readb(host, SDHCI_U=
HS2_RESPONSE + i);
> > +       } else {
> > +               /* Get SD CMD response and Payload for some read
> > +                * CCMD, like INQUIRY_CFG.
> > +                */
> > +               /* Per spec (p136), payload field is divided into
> > +                * a unit of DWORD and transmission order within
> > +                * a DWORD is big endian.
> > +                */
> > +               if (!breada0)
> > +                       sdhci_readl(host, SDHCI_UHS2_RESPONSE);
> > +               for (i =3D 4; i < 20; i +=3D 4) {
>
> Again we do sdhci_readl above but just ignore the data. I assume
> that's deliberate, as we are probably just interested in the remaining
> pieces.
>
> Moreover, the whole thing with +4 things continues to look a bit odd
> to me. I am not sure whether it can be simplified, but I leave that
> for you to have a second look at.
>

Hi, Ulf

Sorry, I don't have any ideas on this, could you please give me some ideas?

Thanks, Victor Shih

> > +                       cmd->resp[i / 4 - 1] =3D
> > +                               (sdhci_readb(host,
> > +                                            SDHCI_UHS2_RESPONSE + i) <=
< 24) |
> > +                               (sdhci_readb(host,
> > +                                            SDHCI_UHS2_RESPONSE + i + =
1)
> > +                                       << 16) |
> > +                               (sdhci_readb(host,
> > +                                            SDHCI_UHS2_RESPONSE + i + =
2)
> > +                                       << 8) |
> > +                               sdhci_readb(host, SDHCI_UHS2_RESPONSE +=
 i + 3);
> > +               }
> > +       }
> > +}
>
> [...]
>
> > +
> > +void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
>
> static void
>

Hi, Ulf

I will try to update this in version 13.

Thanks, Victor Shih

> > +{
> > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > +       struct mmc_command *cmd;
> > +       unsigned long flags;
> > +       bool present;
> > +
> > +       if (!(sdhci_uhs2_mode(host))) {
> > +               sdhci_request(mmc, mrq);
> > +               return;
> > +       }
> > +
> > +       mrq->stop =3D NULL;
> > +       mrq->sbc =3D NULL;
> > +       if (mrq->data)
> > +               mrq->data->stop =3D NULL;
> > +
> > +       /* Firstly check card presence */
> > +       present =3D mmc->ops->get_cd(mmc);
> > +
> > +       spin_lock_irqsave(&host->lock, flags);
> > +
> > +       if (sdhci_present_error(host, mrq->cmd, present))
> > +               goto out_finish;
> > +
> > +       cmd =3D mrq->cmd;
> > +
> > +       if (!sdhci_uhs2_send_command_retry(host, cmd, flags))
> > +               goto out_finish;
> > +
> > +       spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +       return;
> > +
> > +out_finish:
> > +       sdhci_finish_mrq(host, mrq);
> > +       spin_unlock_irqrestore(&host->lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_request);
>
> Drop this, it's not used outside this module.
>

Hi, Ulf

I will try to update this in version 13.

Thanks, Victor Shih

> > +
> > +int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request=
 *mrq)
>
> This function is entirely unused. Did you actually test this with an
> hsq enabled host? Or perhaps you have just added this for
> completeness?
>

Hi, Ulf

I will drop this in version 13.

Thanks, Victor Shih

> > +{
> > +       struct sdhci_host *host =3D mmc_priv(mmc);
> > +       struct mmc_command *cmd;
> > +       unsigned long flags;
> > +       int ret =3D 0;
> > +
> > +       if (!sdhci_uhs2_mode(host))
> > +               return sdhci_request_atomic(mmc, mrq);
> > +
> > +       spin_lock_irqsave(&host->lock, flags);
> > +
> > +       if (sdhci_present_error(host, mrq->cmd, true)) {
> > +               sdhci_finish_mrq(host, mrq);
> > +               goto out_finish;
> > +       }
> > +
> > +       cmd =3D mrq->cmd;
> > +
> > +       /*
> > +        * The HSQ may send a command in interrupt context without poll=
ing
> > +        * the busy signaling, which means we should return BUSY if con=
troller
> > +        * has not released inhibit bits to allow HSQ trying to send re=
quest
> > +        * again in non-atomic context. So we should not finish this re=
quest
> > +        * here.
> > +        */
> > +       if (!sdhci_uhs2_send_command(host, cmd))
> > +               ret =3D -EBUSY;
> > +
> > +out_finish:
> > +       spin_unlock_irqrestore(&host->lock, flags);
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_request_atomic);
> > +
>
> [...]
>
> Kind regards
> Uffe

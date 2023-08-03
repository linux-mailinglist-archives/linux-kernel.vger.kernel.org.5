Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEA376DCB8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjHCAdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjHCAdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:33:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1C1982;
        Wed,  2 Aug 2023 17:33:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bf3f59905so48875366b.3;
        Wed, 02 Aug 2023 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691022794; x=1691627594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmDQBngkUfZT7Xd42gcofemITc/48pOXICJi21nKB7Y=;
        b=OJGaD8RZzpICKo/egDvoKyYF3ObJBah3LwvF3MMdEUkKFTsRp79+vLiECUE8EC5ElA
         h0wX6cqi32v02EAf16jbWp54W9C/pCGVEwmKhcbiAE9iiy9VAjX2LxDket4+qA3arrvx
         hkgbFDZnO3/GejE+3BhPVZrnVs6+a1q/ynRFZkDm8L2uHRVvMrd15j9+Y2k+Tf6d975i
         fKaKrr0pvpDEMtSrMDpK8aEzMEb8IAwzVZoKpOrNuYwquwaZ43UfbBw0DJsprAKb0rbF
         sSSsY2Q9u25xsvFt/Su9yjAaHzYI+TnIXYxJj6TF8GYkfklHjke6rC0NHp0FetzC5O2Z
         ecTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691022794; x=1691627594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmDQBngkUfZT7Xd42gcofemITc/48pOXICJi21nKB7Y=;
        b=jZ7u9m48ep7jdiGeaioY9vYOFZyovpMGLgTTKqZt8Sq7dOZYloSoyI8T/KIy4BwSai
         Z9yxpHgJ6JfQ15Hf+vDR2wlkT69DCUb3XT7TPESxeGqr2Sj/TaYdfoKvUWW89HbYrWRL
         v8e9LoMNfDJvaxVDXkxp2nver+BCyUznMgmZLKYm0Oz9UjDQNP4WQlgCLl0J1463K8qx
         7FqQrZvW0zJHuP/A3cY3uvEfeOy1zc+jpy0lamAJBBQK5BEjhZHCd1Y8Y8Vy+5Ns0q3y
         VAX4jK33vfg1bphDSDDMEfznSD7RYGKH/4Pp31EDlr97ZUlpACx4ceDtkfiW+ne0IIRF
         IEFQ==
X-Gm-Message-State: ABy/qLY+Ok3tBNAyABuuw2ZqyiPJyV0tQksNPWxM2Emdpz5LEw6hWQR8
        4vRN1ProITmEgfPZtdeQdam5Q6ByiZMsat0kNFM=
X-Google-Smtp-Source: APBJJlFSACtUiKMpTwyQv1yuTsQzmtg6/opAjGJ1VXAdQaGY8pPkN2x/Aqhch7z7a/U8i3sLR38Ik+nmvim2W8U7ObQ=
X-Received: by 2002:a17:906:18:b0:997:e79c:99dc with SMTP id
 24-20020a170906001800b00997e79c99dcmr6226030eja.74.1691022793795; Wed, 02 Aug
 2023 17:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230613172054.3959700-1-quic_eberman@quicinc.com> <20230613172054.3959700-7-quic_eberman@quicinc.com>
In-Reply-To: <20230613172054.3959700-7-quic_eberman@quicinc.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 2 Aug 2023 19:33:02 -0500
Message-ID: <CABb+yY3LGxDTQDiz8Q5yMwzFDm-ejF+WnQsb0zJKizfxPkx3nQ@mail.gmail.com>
Subject: Re: [PATCH v14 06/25] mailbox: Add Gunyah message queue mailbox
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Tue, Jun 13, 2023 at 12:21=E2=80=AFPM Elliot Berman <quic_eberman@quicin=
c.com> wrote:
......

> diff --git a/drivers/mailbox/gunyah-msgq.c b/drivers/mailbox/gunyah-msgq.=
c
> new file mode 100644
> index 0000000000000..7f777339278eb
> --- /dev/null
> +++ b/drivers/mailbox/gunyah-msgq.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights r=
eserved.
> + */
> +
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/gunyah.h>
> +#include <linux/printk.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +
I believe some includes could be removed without issue.

>
> +#define mbox_chan_to_msgq(chan) (container_of(chan->mbox, struct gh_msgq=
, mbox))
> +
container_of need not be in brackets.

> +static irqreturn_t gh_msgq_rx_irq_handler(int irq, void *data)
> +{
> +       struct gh_msgq *msgq =3D data;
> +       struct gh_msgq_rx_data rx_data;
> +       enum gh_error gh_error;
> +       bool ready =3D true;
> +
Please limit the scope of rx_data and gh_error by moving them inside
the while() body.

> +       while (ready) {
> +               gh_error =3D gh_hypercall_msgq_recv(msgq->rx_ghrsc->capid=
,
> +                               &rx_data.data, sizeof(rx_data.data),
> +                               &rx_data.length, &ready);
> +               if (gh_error !=3D GH_ERROR_OK) {
> +                       if (gh_error !=3D GH_ERROR_MSGQUEUE_EMPTY)
> +                               dev_warn(msgq->mbox.dev, "Failed to recei=
ve data: %d\n", gh_error);
> +                       break;
> +               }
> +               if (likely(gh_msgq_chan(msgq)->cl))
> +                       mbox_chan_received_data(gh_msgq_chan(msgq), &rx_d=
ata);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +


> +static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct gh_msgq *msgq =3D mbox_chan_to_msgq(chan);
> +       struct gh_msgq_tx_data *msgq_data =3D data;
> +       u64 tx_flags =3D 0;
> +       enum gh_error gh_error;
> +       bool ready;
> +
> +       if (!msgq->tx_ghrsc)
> +               return -EOPNOTSUPP;
> +
If we hit this error, the fix will still be in the upper layer.
So please drop the check and, if needed, add one in the client driver.


> +       if (msgq_data->push)
> +               tx_flags |=3D GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH;
> +
> +       gh_error =3D gh_hypercall_msgq_send(msgq->tx_ghrsc->capid, msgq_d=
ata->length, msgq_data->data,
> +                                               tx_flags, &ready);
> +
> +       /**
> +        * unlikely because Linux tracks state of msgq and should not try=
 to
> +        * send message when msgq is full.
> +        */
> +       if (unlikely(gh_error =3D=3D GH_ERROR_MSGQUEUE_FULL))
> +               return -EAGAIN;
> +
If it is not expected to hit, please remove the check.
If there can be a 'race' like situation, still remove this and try to
find an appropriate place to avoid the race.

> +       /**
> +        * Propagate all other errors to client. If we return error to ma=
ilbox
> +        * framework, then no other messages can be sent and nobody will =
know
> +        * to retry this message.
> +        */
> +       msgq->last_ret =3D gh_error_remap(gh_error);
> +
> +       /**
> +        * This message was successfully sent, but message queue isn't re=
ady to
> +        * accept more messages because it's now full. Mailbox framework
> +        * requires that we only report that message was transmitted when
> +        * we're ready to transmit another message. We'll get that in the=
 form
> +        * of tx IRQ once the other side starts to drain the msgq.
> +        */
> +       if (gh_error =3D=3D GH_ERROR_OK) {
> +               if (!ready)
> +                       return 0;
> +       } else {
> +               dev_err(msgq->mbox.dev, "Failed to send data: %d (%d)\n",=
 gh_error, msgq->last_ret);
> +       }
> +
> +       /**
> +        * We can send more messages.
>
            ... until we can not (when the platform specific queue is full)=
.

>             Mailbox framework requires that tx done
> +        * happens asynchronously to sending the message.
>
hence the mailbox api needs to track each transfer's stage.

>             Gunyah message queues
> +        * tell us right away on the hypercall return whether we can send=
 more
> +        * messages. To work around this, defer the txdone to a tasklet.
> +        */
>
If not here, you would still have to put the 'defer' somewhere in the
upper layer.
So it is not exactly a "workaround".

> +       tasklet_schedule(&msgq->txdone_tasklet);
> +
> +       return 0;
> +}
> +


> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 01a6f202d037e..982e27d10d57f 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -8,11 +8,68 @@
>
>  #include <linux/bitfield.h>
>  #include <linux/errno.h>
> +#include <linux/interrupt.h>
>  #include <linux/limits.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox_client.h>
>  #include <linux/types.h>
>
controller.h and client.h aren't supposed to be in the same header.
The Client and the Controller driver could include them respectively
before this header.

Cheers.

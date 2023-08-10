Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F66E777AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjHJO1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjHJO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:27:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB2E2698
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:27:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-523b066d7ceso656197a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1691677654; x=1692282454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBseE1wu1Bsd448nakRhJvat8Ap+p5gQbDjVQAFktlY=;
        b=RJJouPar3swIZgrXGnld5iJGpyqY28eSNB0tXevtHsCBTgKWyZSF6YSCyU8wpTsTq8
         VyKaFxJvryL0qcwIbQW3rTBS6sdo29IxesNLOpZwGqsT4fMMCgi0Uh0RDWkGVgL3euSt
         lSs7D6mwa2nyuXncq2Lc5T1IvOPasQdqm40OrqeEI/3wyHCLOSyTZ//0Hfr1YhpAgC3U
         TGrXDH+OWh9p6xATmCWsZ76pvxO0zSLGmQlJQD+8vtIwJqquO7AUxq4Ynz7d+jX6bM2X
         0J79viTQgWvmrFv1wA0SSV0o7avqZhI1fOZ77DurkFK2ybC8zzbm9ZP4G08oVnbsD+6I
         iJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691677654; x=1692282454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBseE1wu1Bsd448nakRhJvat8Ap+p5gQbDjVQAFktlY=;
        b=e6YF0H3t+O3Azx0s8ejRFic1gXKeyz/8f7zqhzZa1OD2Ie9PiAouOOrB+m5u0gHIi4
         zFDD9B4jxasesa+DY9ixeOReUnhxKzY2a9p8x28hwdtPgO1Z1g4TeDE52ku8Q2d1sV1o
         7Y4pRDsjlhZ/JaH69UynUOZR4dw+i1AZaJYIWOeupa1fzulLCOxSSH7kWEgqRC7oxR/6
         +qmZ8/2XN4kRTagnAIeGdLHrhvRxqmkNPqX0RveJjez8lc/pUH9TM1ZlN1s7K9gJ+x5z
         0evMNv1XM1GZgAGvxReZCz18KvKV2AVYuH+6hcjpSaCGtBZfffuvqRU/f4Ttj1PpFm7N
         lNGg==
X-Gm-Message-State: AOJu0Yx5JTRDHvbs6N59XFFz05xRzDevENW+ZngwbWO9tw+UW4peIjiU
        rCxvTR2Qq+rHwj8MeaSloNz96z1wIqqDKJRllvO/6w==
X-Google-Smtp-Source: AGHT+IFWgXBeCEmWnrY4QmZeloDE7h4/FQZj3Gcue2VuhcLFulwXf+nZpJNmcR9GtKxBmLv+3k52zZV7lle6df+14Tk=
X-Received: by 2002:aa7:d44f:0:b0:522:30cc:a1f0 with SMTP id
 q15-20020aa7d44f000000b0052230cca1f0mr2198658edr.14.1691677654808; Thu, 10
 Aug 2023 07:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230810141947.1236730-1-arnd@kernel.org> <20230810141947.1236730-8-arnd@kernel.org>
In-Reply-To: <20230810141947.1236730-8-arnd@kernel.org>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 10 Aug 2023 16:27:24 +0200
Message-ID: <CAMGffE=3rboXRW+UF+p_SEdUmBUCZ86oBFD8iKJcX0FR5GNoHQ@mail.gmail.com>
Subject: Re: [PATCH 07/17] scsi: qlogicpti: mark qlogicpti_info() static
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 4:22=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The qlogicpti_info() function is only used in this file and should
> be static to avoid a warning:
>
> drivers/scsi/qlogicpti.c:846:13: error: no previous prototype for 'qlogic=
pti_info' [-Werror=3Dmissing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
lgtm
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/qlogicpti.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
> index f88a5421c483f..3b95f7a6216fe 100644
> --- a/drivers/scsi/qlogicpti.c
> +++ b/drivers/scsi/qlogicpti.c
> @@ -843,7 +843,7 @@ static int qpti_map_queues(struct qlogicpti *qpti)
>         return 0;
>  }
>
> -const char *qlogicpti_info(struct Scsi_Host *host)
> +static const char *qlogicpti_info(struct Scsi_Host *host)
>  {
>         static char buf[80];
>         struct qlogicpti *qpti =3D (struct qlogicpti *) host->hostdata;
> --
> 2.39.2
>

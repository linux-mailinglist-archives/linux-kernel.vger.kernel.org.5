Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37B6751E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjGMKFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjGMKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:05:22 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFA026B7;
        Thu, 13 Jul 2023 03:05:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51ff068c09cso623322a12.2;
        Thu, 13 Jul 2023 03:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689242718; x=1691834718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eU1v8SBPLo/f8d631zxPH7q1FrYfpA8BtvD+U5WDps=;
        b=IWo8CdTQ52nAlRuplSmJYxlM4xkupx0emk+pAK1lZ8Rpzqq1LvtWfPCZrq2XFMCZW+
         WoRaLwvf4NwuAB27T1uDNMm/NAq3x0J3SdVuEUhsowfaGnt5GzCig97hB3QArr5itt0K
         4jDmJNl6w9qQ7VhnJ/lnAyEdXS3AUc576jo9dhBwBARlbb9xZTVt4T/W+tb/BU9/Ax/7
         QrC+lfA4E95GRgenodQc0jEHMuP6pERg1kJtnHS7AYoA+EOja6eh5GLPOBIvR/amlftz
         L11VWTVbJMa9iLmW21FeAFaPHkagtOvaDE9eN9yDpMhNKpEzqghwq0MKppkSkgJoeaJh
         LVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242718; x=1691834718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eU1v8SBPLo/f8d631zxPH7q1FrYfpA8BtvD+U5WDps=;
        b=KLly6M4lSNsDdTRhlYVaV3LRsUkVC4Hm2aFuykcOHSV+aWgEttMIaCGS8XibPMqhc1
         n7DRHKndl5cLfkeV3hIza6gv2zJ+eyc7JMdEZHcwEzT0cvflbY9/OHKpJA936uGt5g9x
         aj9FGZV0EnOBJ26hrqcLMcvi7yiXgglOJvRwaPXJGzabJWbUh6UecVwuRGleVtdfkEk0
         WdlfqzpcGNDPA5OBnoqACIGbeMh4/x8wpkzWjK3h30FG+/vTDIWCanYStgvQUq9HksaE
         scHI/QVqhsfqhmetzVD0M9KjIHMa7S1Fqmx9UbO0546EJitFfId5DYBeMo34JenygV60
         Ilpg==
X-Gm-Message-State: ABy/qLbWrPFZKIaRYIsrnw8h/+D22THNrkfTugbXoV5d4nGmpVgyhm+A
        yETzAVnumm+l9iQtfd0Tqaa5Qep4wWeHjnWSnww=
X-Google-Smtp-Source: APBJJlFtOTqr20EEKymM6u44/YxzkjgdahoshDCP2JdeZwBwVK0vai/JD8A+i69fF56gan+5u0QDcbgSuf/PrETob5A=
X-Received: by 2002:a05:6402:b2e:b0:51b:dcb4:a9b3 with SMTP id
 bo14-20020a0564020b2e00b0051bdcb4a9b3mr1514757edb.24.1689242718185; Thu, 13
 Jul 2023 03:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230712224251.26482-1-iuliana.prodan@oss.nxp.com>
In-Reply-To: <20230712224251.26482-1-iuliana.prodan@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 13 Jul 2023 13:05:06 +0300
Message-ID: <CAEnQRZBc+EWZDX05KpFNSz1A_NQjX4K2x+LPftpezkeUXRd6fA@mail.gmail.com>
Subject: Re: [PATCH 2/2] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 2:15=E2=80=AFAM Iuliana Prodan (OSS)
<iuliana.prodan@oss.nxp.com> wrote:
>
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>
> There are cases when we want to test samples that do not
> reply with FW READY message, after fw is loaded and the
> remote processor started.
> In these cases, do not wait for a confirmation from the remote processor
> at start.
>
> Added "ignore_dsp_ready" flag while inserting the module to ignore
> remote processor reply after start.
> By default, this is off - do not ignore reply from rproc.
>
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

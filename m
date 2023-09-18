Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5478E7A4094
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjIRFrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbjIRFrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:47:12 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B068100
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:47:07 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59bc97d7b3dso66247137b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google; t=1695016026; x=1695620826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51WkUAC1sLCh7qadDPCoYg3QctdCSxGTDI4u7EfznR0=;
        b=Sl2s1YPzO7UM36+ZjIWr5+DlzfkRP3zQxMET72GSnBmbNubLULUPt2lrp3rkzXvrw1
         VUOEx5Bkr4JE61cq6e79zZ0/CgEScl1TBzoIzENVUeU0O7zdDKO8U0COlekydM1IR849
         zOuX6rwryI/DjmTILuNn7oIwTSlZdnozw/a2FZYXuspXS9CcZM2yPFnmdBkqnruzei64
         m5+muQmt75wk7hWRlh0alioPWMIWMU7Gffer/PZf9EDyHnY5jIMefS5VEG7aneHACTIq
         YSynhjM3F/YOXZWtcuMl6RWfyhwCRcMM5hG2smFOr4HOOVAEyYgofnVzP5U/A09SqF9C
         tmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695016026; x=1695620826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51WkUAC1sLCh7qadDPCoYg3QctdCSxGTDI4u7EfznR0=;
        b=hu2HmPjsT/osjDMKOCY4Uzfktr+wB3BaQZwF8aF9YtsI2Djuk4lPgzNLBWXni9QqpO
         hxZBhnopQigEl+elpKpUI/dR9LOToPMBb/pvRZBvIxWqB5rKc8H3f7CWb7ZJXOocx4OA
         IhBaaqVAkVIIQTxpaXDk17yC4aJgVybBmxeb43Ip62dWPuyGp7xrB7nau6M7oao5nJpD
         iuDWcgJ+nP6lRqFqsBzRX12q+KY/HH9b8d9mLfvszKAA99HPpEc9kegNy6KDeav25cZX
         bG0MZG5bRsmAxo5POXGYhIgXGxuAwpPC0iEkxGk9hu//pZq/LN2DhETazPX+fPkvboQc
         wj9w==
X-Gm-Message-State: AOJu0YxD1iopG4ZDOVFMTpH/ADG2lz+QLyr3EcmLm7+VcgoCEh+b/pun
        mCUndoWx0WtSaNJM+ktzBJao/NC2tli9FxOr5wh5VA==
X-Google-Smtp-Source: AGHT+IE+fpGdilk8uQgpXvD+1ZGsDES8ok1UZmX7jzsrPkcqkrPqz9BHrS/b6//wktgAtgP/g9X5mbPTpEmKpt1f8C8=
X-Received: by 2002:a81:a1d6:0:b0:56c:e480:2b2b with SMTP id
 y205-20020a81a1d6000000b0056ce4802b2bmr12754977ywg.12.1695016026381; Sun, 17
 Sep 2023 22:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230814015700.70156-1-nathan@nathanrossi.com> <CAOMZO5A=q8Kb1pmM0nALerka11F_U3024YrPbRSboX0ay_PyOw@mail.gmail.com>
In-Reply-To: <CAOMZO5A=q8Kb1pmM0nALerka11F_U3024YrPbRSboX0ay_PyOw@mail.gmail.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Mon, 18 Sep 2023 15:46:55 +1000
Message-ID: <CA+aJhH2YD2tfEe6FsD4E8Dd1FfAjOLoBcghFA+HUYpCRC3Rw2Q@mail.gmail.com>
Subject: Re: [PATCH] soc: imx8m: Enable OCOTP clock for imx8mm before reading registers
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 13:26, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Nathan,
>
> On Sun, Aug 13, 2023 at 10:57=E2=80=AFPM Nathan Rossi <nathan@nathanrossi=
.com> wrote:
> >
> > From: Nathan Rossi <nathan.rossi@digi.com>
> >
> > Commit 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the
> > register") added configuration to enable the OCOTP clock before
> > attempting to read from the associated registers.
> >
> > This same kexec issue is present with the imx8m SoCs that use the
> > imx8mm_soc_uid function (e.g. imx8mp). This requires the imx8mm_soc_uid
> > function to configure the OCOTP clock before accessing the associated
> > registers. This change implements the same clock enable functionality
> > that is present in the imx8mq_soc_revision function for the
> > imx8mm_soc_uid function.
> >
> > Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
>
> Thanks for the fix:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>
> Should it also have a Fixes tag?

Potentially, though none of the previous commits (or their referenced
commits) attempted to resolve the issue for the imx8mm_soc_uid
function so I was not sure if a fixes would apply in this case or to
which commit? Though with that said this change would only need to be
applied to kernels that have applied the referenced commit, so that is
probably the ideal target for the fixes. I can send a v2 with the
Fixes included? Otherwise I have included the specific fixes commit
information below.

Fixes: 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading
the register")

Thanks,
Nathan

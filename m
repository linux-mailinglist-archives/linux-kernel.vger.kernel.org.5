Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF6A7EE734
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbjKPTNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPTNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:13:14 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794BF1A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:13:11 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4219f89ee21so6519591cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1700161990; x=1700766790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPxNHo3ULcsNHonG1S3dXxZBWwtHJpSMfZE5XqJO15g=;
        b=Pkt/b6k7WA1LfcJr2gjPZUwr7GYpDOoguHruPyHA93EM8WoC3eJZKYGUO9vfbbjHYQ
         qgLsZjvSQT2O+ngLSdlqUPcw9avI5T5dlRPfJbwpyxGUXZ3J0jpmbCmGQsNo2yzWscQG
         q3ZaAlIuRvopVQSdwjN73aTA3GTgG0+sSLAhbFiLDN7JkClVA+cfgq+fM1VkV9TvLLz1
         LmDVtTSlSguSEPi313DkbV2fVCVJVqJczLD+hdc4ldm12LD7gZGiIQYC3eZnlbwinRP1
         59gB8cD68JnxgTejPsC97DaYKK8I8A7qOa9Qnh+HqLZLKWuNo5mlS/LnRlmj3/J8hyHt
         LJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700161990; x=1700766790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPxNHo3ULcsNHonG1S3dXxZBWwtHJpSMfZE5XqJO15g=;
        b=p0t2a+TiQcUPQdLR5gHMUjPcYCjXhiabwEWhGJ/9jm4W1/yF/bxd2e2uJ2S+pYdpSu
         eI+BeVtGEOV5osf4ZCuDYwyib9/BwP8LTDudiJ5isR1lFEpI/ISEIZ8zmLFvyMm2o0Cj
         vscDfv1jpNcW82gsCLgOAy3WHGYg6pvelNnLIfZCgII3smNmEuXawde3btPOVqfll3ts
         DuA1oB6VGI+lRG0uhEV8SwkR17ZEBTNLleGDY/egutaGFNzp9Jxs4E/Op0/4uXGM1PP8
         06vZX2Gj9BuigWtNu84zRqbzgiDNWapNaWhJYdsg15T+nSLEaLX+B+Poi64mB/+dK7DL
         mSmw==
X-Gm-Message-State: AOJu0YzGbidsPFXeEVvb8PnBki6APPkTToKY73+BEPXDt9psCGLEtXTQ
        tMyJ8CsChshKJDN0YI/tYy0vZ8Yabfm9o2Sckbz8oA==
X-Google-Smtp-Source: AGHT+IHTcTjmLc+6xfRRk7irgDlKVNzX6sIipRK12iEvdBnagtqRWf+9rxO6g4dKAB73yESltnrs0a7UlctfM0jH7yU=
X-Received: by 2002:a05:622a:56:b0:418:1f52:1421 with SMTP id
 y22-20020a05622a005600b004181f521421mr11326596qtw.9.1700161990608; Thu, 16
 Nov 2023 11:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk> <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
 <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com> <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
 <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
From:   Yuanyuan Zhong <yzhong@purestorage.com>
Date:   Thu, 16 Nov 2023 11:12:58 -0800
Message-ID: <CA+AMecGH_yugc7YQX2tqMSKzsA-aJYJSVBOVjiyYcw994-_Zng@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        randyj@purestorage.com, hcoutinho@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 7:52=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, Nov 15, 2023 at 02:44:04PM -0800, Yuanyuan Zhong wrote:
> > On Wed, Nov 15, 2023 at 11:55=E2=80=AFAM Keith Busch <kbusch@kernel.org=
> wrote:
> > >
> > > On Wed, Nov 15, 2023 at 11:21:53AM -0800, Yuanyuan Zhong wrote:
> > > > On Wed, Nov 15, 2023 at 11:02=E2=80=AFAM Jens Axboe <axboe@kernel.d=
k> wrote:
> > > >
> > > > Do you mean something like this? If not, can you please elaborate
> > > > "when we need"?
> > > > -               struct nvme_effects_log *cel =3D xa_load(&ctrl->cel=
s, ns->head->ids.csi);
> > > > +               struct nvme_effects_log *cel =3D (ns->head->ids.csi=
 =3D=3D NVME_CSI_NVM) ?
> > > > +                       ctrl->effects : xa_load(&ctrl->cels, ns->he=
ad->ids.csi);
> > > > Will it be good to change ctrl->effects to ctrl->effects[3] for
> > > > already defined CSI?
> > >
> > > I suggest either re-assign the cached head->effects to one from a sti=
ll
> > > live controller when current path is removed, or move the saved effec=
ts
> > > to the subsystem instead of the controller. All controllers in the
> > > subsystem should be reporting the same effects log anyway, so
> > Is it specified in spec that all controllers in the subsystem
> > should be reporting the same effects log?
>
> Yes, in section 5.16.1.6, "Commands Supported and Effects":
>
>   This log page is used to describe the commands that the controller
>   supports and the effects of those commands on the state of the NVM
>   subsystem.
>
> Oddly enough, Figure 202 says the scope of the log page is "Controller"
> rather than "Subsystem". Sounds like ECN potential. You can memcmp the
> effects log from each controller for a sanity check if you think some
> subsystem controllers messed that up.

Yeah, it says scope is controller.
I think it=E2=80=99s valid to start upgrading one controller in the subsyst=
em
to report different
effects log, e.g. adding or revoking CSUPP for some opcode.
If the saved effects log is kept in the subsystem, how to refresh it
for the subsystem?

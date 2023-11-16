Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FFB7EE4AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345314AbjKPPum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbjKPPuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:50:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D611A7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:50:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40071C433C9;
        Thu, 16 Nov 2023 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700149837;
        bh=cxGMjfUMzjut3poH5+l7X0G21U7y7WehFTBdbs/Vgp0=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=cLpofF3mET3VoLMtKS3oDf4DKTbx+61luyKr9pdFoz6gDPobrcyMqZCtK9HV/78zi
         FE8xkQgsMtAdScnw0fr03rb1OuC+I/SPmgzYgrcWl3vxynoj9hUsrQLrtEQ5fkToHo
         lzEvLUN4Wvev86RyBnzz7cDJ0eYcSOPQlXUwFWvJayfa1fMN72hM3CRIWkI10cvDs2
         bZX/25CvyfQlnGfOY9flhKG8RHJKWr+YLP1hun8cw3rE7CO8LE49YooIl0TV9/IJ/+
         XFZ/KPGrYwEN2RC44wqlPUoybIFrfMTjq3aODw3RE70tM9XoQXqnabOC9lsG1HMdvD
         B+mkjS3MxJ3cA==
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5c184b3bbc4so724453a12.1;
        Thu, 16 Nov 2023 07:50:37 -0800 (PST)
X-Gm-Message-State: AOJu0YxCcHtJxc4oGD590WCBH35WqhfgaUL6ozkjkWa7tQsHwmTX0/VI
        ze8RpsWt/I9yvJT/fgC8Yv2bQ1V5SjjfUfJfVn0=
X-Google-Smtp-Source: AGHT+IHWOfeY/Ow8LM2aFdGyBtyRnKWUJ9qen9rlFQ50S/56218qxwI8feHkZCmpQd1uPgRUF1PAKXFv3BeCFKJDH7o=
X-Received: by 2002:a17:90b:4c0f:b0:280:235:19d with SMTP id
 na15-20020a17090b4c0f00b002800235019dmr15928923pjb.36.1700149836898; Thu, 16
 Nov 2023 07:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20231116154816.70959-1-andrzej.p@collabora.com> <20231116154816.70959-3-andrzej.p@collabora.com>
In-Reply-To: <20231116154816.70959-3-andrzej.p@collabora.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Thu, 16 Nov 2023 23:50:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v65BrPzctN_nxW-updoOvedLT4poQt_FL_S6Yyh61WQcZw@mail.gmail.com>
Message-ID: <CAGb2v65BrPzctN_nxW-updoOvedLT4poQt_FL_S6Yyh61WQcZw@mail.gmail.com>
Subject: Re: [RFC 2/6] media: verisilicon: Correct a typo in H1_REG_MAD_CTRL_MAD_THRESHOLD
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:48=E2=80=AFPM Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
>
> It's a THRESHOLD and not a THREDHOLD.
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877AD7EE4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345297AbjKPPu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbjKPPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:50:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8409B10C6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:50:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2422BC43391;
        Thu, 16 Nov 2023 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700149824;
        bh=BolSwldx43V1s8lR3ByoyIMODjpgx8SOOvx2mkBrbUI=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=UF9HIah3VHoLbYth2CTAiD1ubicY+3D8g70w32pOj8EiJBfWgopgAv+aS118WcvSd
         D7MOh9+8VypvhXwQX8ohvQYLcPhvCTYogzjM/RJUefhmFk2hzi+hgq3MiD081Fom4i
         XH1a33/MHR4QzKmupt6urAfAFvX4pn8AbQskBC1CE1gqPAPNSSadHvbyew2Anb6KXO
         Tm9KCx/wJ+y9Hgl8A7/U8BQlpfD8g53pcMErzwqdFJGhO+5lt2FdSF0EjWGPN7A8bW
         IpKruvN8lZK3aXyVB9xtnd33CfwZtqonmfZuuG2RDyIyK8DIexINh0OH1Jr4j6wOSb
         ULZu8Hu6cjEDw==
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5be30d543c4so714194a12.2;
        Thu, 16 Nov 2023 07:50:24 -0800 (PST)
X-Gm-Message-State: AOJu0YyVQyOHnrpQ4vus+FXAq1fVkJBuwPJGZcvceYVo8O0OhNHAAomU
        oBKBPoGqDCJI1TDB57eXfThB8AACuExW40KCXhA=
X-Google-Smtp-Source: AGHT+IEMGFlu4SzYQe96Vr6F03Rp/SrNkJGccyxr7tmeveiTXRgztgXi+I4dU+cty9a2FC6wuDTy4PmEvaAETZ2DgJ8=
X-Received: by 2002:a17:90b:1802:b0:280:1c25:b633 with SMTP id
 lw2-20020a17090b180200b002801c25b633mr14521522pjb.2.1700149823613; Thu, 16
 Nov 2023 07:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20231116154816.70959-1-andrzej.p@collabora.com> <20231116154816.70959-2-andrzej.p@collabora.com>
In-Reply-To: <20231116154816.70959-2-andrzej.p@collabora.com>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Thu, 16 Nov 2023 23:50:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v64dFzqvvY4BanJ6WO667jFvxaoAX68EACYz7-Byu9i7qg@mail.gmail.com>
Message-ID: <CAGb2v64dFzqvvY4BanJ6WO667jFvxaoAX68EACYz7-Byu9i7qg@mail.gmail.com>
Subject: Re: [RFC 1/6] media: verisilicon Correct a typo in H1_REG_ENC_CTRL2_DEBLOCKING_FILTER_MODE
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
> It's a FILTER and not FILETER.
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

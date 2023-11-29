Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A12D7FD898
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjK2Nti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjK2Ntg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:49:36 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5980ECE;
        Wed, 29 Nov 2023 05:49:43 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cd97c135e8so2670615b3a.0;
        Wed, 29 Nov 2023 05:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701265783; x=1701870583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Irh5FOLnUoxjszhCv8qONiTjS2UNum2n4pRc3UwW/QQ=;
        b=NprO9jmsL69zqT70ikC29oYlr5zat4VkLWD/ODW25U5mTcq9+thJGBSjR2cBoy5A6+
         CZdITro181FB/Pm80HqzZlWuAOGR7NvdSmjt802pOO2zHLhz6EdKBsM+QwxEHvnYHBun
         InZptYsPOLhiIjKi+a6uX4JXO8RCiZ/lPSE2k7CUiDX+M4qiCg3qn+YsE6t34YRRlVoy
         HspfovTJArWTCKRyn4s2aI82ATsZlGMcu23Ne11PGidaIjqjUmckGa4C2Rh1503osV4I
         loJeeTd6+GuJKV+NJwq3XuZgI6/1cTDNnMiZvFeIE5aGzeKLeRVVVA+Gcr1VIUp/eTj1
         PkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701265783; x=1701870583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Irh5FOLnUoxjszhCv8qONiTjS2UNum2n4pRc3UwW/QQ=;
        b=mI/M+dypDYhfy/AZRtLGTRBuaUAiF2l8nCyLJOJOIi8doPBKT3COx1Q+Hy9laF4bZY
         FRM1kg8iJnV3pC4qR8FZGRXQ/a1UwBMiGP6GtuEnOZyjJwJSUpKzMDjjXgh3AaUdRktD
         XZMsmSLkmwYlxWeU8q5Khvqwya0H7OmHn/HtM4tGp0b/8muDcPsVQfXenuqfuslTgxlB
         pdSBZMz9zn/AODglacjNwm/xol0ZdWCAZhF+VdNdHlREqF2lhiqR+IvGXBU1SPC8+Qy/
         db7LfNgL/pm3EHbETEz2w35T9w1Kr/4vsU7YKxHJo1TeVawEbDV2/fJU/ESJJ+yn/v2s
         nlXQ==
X-Gm-Message-State: AOJu0YzNGECB+pY6mM7GUudXiz7GIrTBhVC8ZWJCgHMNTECDkzw2vvkl
        eNEdZLTr0Y7Rk4HJpWW6iXXjAin8LVGTLpshW4c=
X-Google-Smtp-Source: AGHT+IHwQ/nopwgshRkVmMmvgI9zzwEk3H+Qv8ke6oMvs0cb3CNtQT6uGhfEEDX0QL5kFKRzgZjUwvvEU0MxscBFGR4=
X-Received: by 2002:a05:6a20:a114:b0:18b:4c44:d09 with SMTP id
 q20-20020a056a20a11400b0018b4c440d09mr20615138pzk.0.1701265782677; Wed, 29
 Nov 2023 05:49:42 -0800 (PST)
MIME-Version: 1.0
References: <20231129093113.255161-1-paul.elder@ideasonboard.com>
 <20231129093113.255161-2-paul.elder@ideasonboard.com> <CAOMZO5BPQCyCQKPvc9HHqANk5rKic25EkUGCjBdf-d78zGDR0Q@mail.gmail.com>
In-Reply-To: <CAOMZO5BPQCyCQKPvc9HHqANk5rKic25EkUGCjBdf-d78zGDR0Q@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 29 Nov 2023 07:49:31 -0600
Message-ID: <CAHCN7xJyqEN_3GFCRogii_ST3oC354CBG6d029HGRnBKh=H_rQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Add DT nodes for the two ISPs
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        umang.jain@ideasonboard.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Li <Frank.Li@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:59=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Paul,
>
> On Wed, Nov 29, 2023 at 6:31=E2=80=AFAM Paul Elder <paul.elder@ideasonboa=
rd.com> wrote:
>
> > +                       isp_0: isp@32e10000 {
> > +                               compatible =3D "fsl,imx8mp-isp";
>
> This compatible string is still not present in today's linux-next.
>
> Will it be merged soon?

Fabio,

Paul posted a series to the media mailing list adding support for the
i.MX8MP ISP:

https://patchwork.linuxtv.org/project/linux-media/list/?series=3D11776

I am guessing it'll have to go through the review process.  I was CC'd
because I did some previous testing before.  I have a Sony imx219 that
works in 4-lane mode.  I'm likely to review and test tonight or
tomorrow.  I am guessing he posted the DTS changes via a different
series since they usually go through Shawn's branch instead of the
media one.

Hopefully that helps.

adam

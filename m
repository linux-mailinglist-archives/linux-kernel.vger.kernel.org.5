Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7BE75D8D2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 03:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGVBt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 21:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGVBt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 21:49:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457C83ABF;
        Fri, 21 Jul 2023 18:49:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-25e847bb482so388863a91.1;
        Fri, 21 Jul 2023 18:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689990563; x=1690595363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiKQhvyaKXeXw5cLdQSYxAeG/ZQFkb7u94ZK3lWcolk=;
        b=JzSrEwoH4QV9ztzVqrWR0ATBVTx54QxyeI3MDorR9b5N1peU5jWwDY1sezscAy56bB
         HJOvDT4s/qqh4/9PzBrNhxp39PgzEjyv7izlSlnQJoPo/llgWdo2BFuZkVbYLllZMHwi
         GIpGqGNtJEMedOxHyPNKb6BL9UxWU7B9Jk5EKSgfkAWuqHRX5DlRmfWYhsOqW8w2b+Ri
         ohR5nxpuOu6ifCdoay2QX55DAGOtzNdETjYoYbBw4SikariUbYg+pyH6SybySPt6MOhB
         6GGhZDGYx/ToNJHCZut9CSfWryVGK4SgQgd/U22M5yetaaXfMeXCazQJuxIubDZRCLXX
         ylYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689990563; x=1690595363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiKQhvyaKXeXw5cLdQSYxAeG/ZQFkb7u94ZK3lWcolk=;
        b=OCdSvE6mjQ1nFjbCHF3fTCkeN4GzjSzq7zxFurNR3xgurbXwct46A6Tb0us4CsubgC
         1scNjYk4XeH6YJkaznQ+xte1ZbMfxrfEBGRNB1lUCersHs1Vjbbk3EbJLwSLTZCIndyI
         k0Dm64y3CiFJy0CB7Sf2oxRMqwAuy4raR8F2nXZtZxGLjj7UZVH46qvXZcjGWO+oC1hU
         S3ci9ed3QPN5wttbFBuVhOm6Y9IiiGN4iveYV+HQ+//uQsjGH8fFIkibrROoejxWARqs
         8wojKzuHkFCOeOhujzOzttWWLWAWjQozYbT6l0Z0m07HoX/+83iLzINcD+D1TNoV9oCm
         aOvg==
X-Gm-Message-State: ABy/qLYNU/MytYlQaH9szGznAvbBVcySt8O2lHdI/SrXPzL5uzx3zlbs
        1wazTGk9EeUaN4GjGqSWBSdmUuqmCSH0f4XlVYc=
X-Google-Smtp-Source: APBJJlHhgUe1okuvjSgJCWJsSuRwzga2y3tuMdESXK3GavelKhMM7kx4h8mFoyNef72LeAg4Kn4TSlv+/8cCJ466aa8=
X-Received: by 2002:a17:90a:55c7:b0:25b:88bc:bb6b with SMTP id
 o7-20020a17090a55c700b0025b88bcbb6bmr3011203pjm.2.1689990563412; Fri, 21 Jul
 2023 18:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230719-imx8mp_enet_qos_use_125mhz_clock-v2-1-eed15d74bfd1@pengutronix.de>
In-Reply-To: <20230719-imx8mp_enet_qos_use_125mhz_clock-v2-1-eed15d74bfd1@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 21 Jul 2023 22:49:12 -0300
Message-ID: <CAOMZO5AxuMOmy_RwQ-HpTMJn7Lg9j6ytb6t0pMerQd+t0AG12Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mp: use correct clock for eqos
 timestamping counter
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        patchwork-jzi@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Jul 21, 2023 at 12:51=E2=80=AFAM Johannes Zink <j.zink@pengutronix.=
de> wrote:
>
> The i.MX8MP Reference Manual rev 1 06/2021, section 11.7.2.5 "Timestamp
> Support" indicates the PTP timestamp clock expects a typical frequency
> of 125MHz.
>
> As this also improves the precision of the measured timestamps: assign
> appropriate 125MHz Clock parent. As no one except the timestamping
> counter uses this clock, there are no side-effects of this change in
> other peripherals.
>
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

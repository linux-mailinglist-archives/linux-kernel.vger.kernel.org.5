Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259777D7126
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjJYPpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjJYPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:45:15 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E292181;
        Wed, 25 Oct 2023 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1698248711; x=1698507911;
        bh=DI90V1bXwX/Uwv3dOT9N//AgAR2Tj2M9NCy1KVRlAJ0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=f5ZliKWD4GWYi5CTZC9fw481wKGRwUoXBR7j8DqVOl0Vb3hdYy3HwZAB9EtCRdHJT
         h0paaejp+AsubIIG5Y59KzNtTpylq1huiC/d/9+SeUj5iIlAa9e1j/AiZc0LFN/n72
         jsQbgP5j/B1GWxOgk+FeC4nKgudfFHdFFv0Vz5gEXr7fxrvy13bMBo67MvgKI8YsbZ
         2mScJyrytlw7J3o2H7kbdSl12Vl62qMQC/9dDmwYHH9QKDhjb6+tA9gxCIjS6pt7e3
         RWg5x0nDKr5E9+VkBuzMx20Mqxhf8P3BS3sTt+YD32UsMKdmDYKyo5saSkZO/pXtMy
         1ibsvoyTUMvAg==
Date:   Wed, 25 Oct 2023 15:44:58 +0000
To:     Keith Zhao <keith.zhao@starfivetech.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Shawn Guo <shawnguo@kernel.org>, christian.koenig@amd.com
Subject: Re: [PATCH v2 3/6] drm/fourcc: Add drm/vs tiled modifiers
Message-ID: <2wq8ssA4KblYH5JfC8KxeWWoYPleN_BcH6wSZ92tkOixbiU5k2ZU_lS4lO0awCCeomkdjsEoVlUmAH7aaaR2n-bdLKu1AaSar_JW78Kw4Ik=@emersion.fr>
In-Reply-To: <nPUOGd5_-QuZTUXhGdmJ03Bri58JI0SeYVcBLnJG4aFuqobd5i1RUBVoi4CNP3VGg5oBdz5LAGdwHERxtMwXJyHPyVxJz4UpiBuFiA5NlkA=@emersion.fr>
References: <20231025103957.3776-1-keith.zhao@starfivetech.com> <20231025103957.3776-4-keith.zhao@starfivetech.com> <nPUOGd5_-QuZTUXhGdmJ03Bri58JI0SeYVcBLnJG4aFuqobd5i1RUBVoi4CNP3VGg5oBdz5LAGdwHERxtMwXJyHPyVxJz4UpiBuFiA5NlkA=@emersion.fr>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thinking about this again, it seems like you could start with just simple
enumerated modifiers like Intel does, and then only switch to more
complicated logic with macros and fields if there is an actual need in
the future.

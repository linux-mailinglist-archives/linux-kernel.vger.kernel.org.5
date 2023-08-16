Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0214D77D807
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbjHPB6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjHPB6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:58:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0645B1FE7;
        Tue, 15 Aug 2023 18:58:43 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26b4a95f433so814537a91.1;
        Tue, 15 Aug 2023 18:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692151122; x=1692755922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5ze5mf6fpMnNc6CILFKDUXWbVtfcVehD7TL98SIarY=;
        b=o9a5QZyijzh7A3IYfVyp65sP6LzjmtTKhD9uZbuxzENehhFGUDt+h7LZMPtRlZh7G2
         9qO6YdGMVK7/S3KSs58/vlYrRY1ECvNKXfPZCUss+p0h49KkRfURKnu4KNIOOJwI36mJ
         1lCv7OsFxbWRLhxgzH94SLPztENml76msznZWnqPnHQNIm/IBpDgOPX7W2JM48CzknYs
         7CcX1g4g3IoB5FS4iDtw9smAf2gjz452ufbmEWcuBT7Yaq7C3QE/tXE42EGNCO1/FVw5
         PZYtLKzMoS9mRtG5dVnDDO3DNjqCckl3wz0+nMwr2lD+7S/yMyr8OPRlmcN5TJNLKvKU
         vAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692151122; x=1692755922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5ze5mf6fpMnNc6CILFKDUXWbVtfcVehD7TL98SIarY=;
        b=NLm/eXLFRPE5v8QJVJ0M0A4OoJTYZKX7tjrp4cMf1mqx+x8PhcCZP4+jFEiXaXpwgW
         RwWR+jyrXbVe4RRERWvNKo5VUDcTWIvYGWa5TIF1KnmT0zVsLY2wldTZo2mOcOasnFEc
         u1Ihc3/6wd3MtTz+qYW6Vc1m3WkTg+f/YW41U8Asr00DWOsobRvXjFCsUm6N2LzRhwLo
         SJLfY5UGXWWFnTtXNxf/t+EEGGmjLyWoLBwYPBbOEEZYbhsZjUdL1nC1FiC9umX3bK3t
         NEyFGH7Q2FJvPSw7CNXnzm93XTdOUHjzUihD/ARSqlcIp44bsx6iZQIVIaAk4vfi2YP8
         9Cow==
X-Gm-Message-State: AOJu0YxVK4eFNYa0ulxbSaSIrKKW42hRp++33XVVGw13WXHZbWfaGYsk
        FvjDuaQlUguhJ1BuHG3R8PyHhsRcuxL002JQXrQ=
X-Google-Smtp-Source: AGHT+IENW1xj4CkcHrxDjVdEXVfR3z1XiPqSY4R2z8GRQlQUOKzhDEUQGMA0mA5X76drmJxjUYnlopjjfWqLqmbdmVc=
X-Received: by 2002:a17:90a:4fc2:b0:268:196f:9656 with SMTP id
 q60-20020a17090a4fc200b00268196f9656mr362711pjh.1.1692151122372; Tue, 15 Aug
 2023 18:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230815231117.15169-1-aford173@gmail.com> <20230815231117.15169-2-aford173@gmail.com>
In-Reply-To: <20230815231117.15169-2-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 15 Aug 2023 22:58:31 -0300
Message-ID: <CAOMZO5DoM82S_=2itikjwgPUjhTQ_CA+cQoUAgVm+-8VoM=Ubw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 8:11=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> A previous patch removed the audio PLL configuration from the clk

Same comment as in previous patch.

> node, which resulted in an incorrect clock rate when attempting
> to playback audio.  Fix this by setting the AUDIO_PLL2 rate inside
> the SAI3 node since it's the SAI3 that needs it.
>
> Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks f=
rom CCM node")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

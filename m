Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5BC808A61
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443375AbjLGOSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443277AbjLGORe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:17:34 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA06A1990
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:17:22 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d3c7ef7b31so7758007b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701958642; x=1702563442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bsCcuGLo2J2I6ix+dXxn7SDWpUwAIlNPbaC4IivWIA8=;
        b=Hk6K+MZlCrBOJJDwgyumD2wg5DmNF82fqjyHW0SDGmzbrpjcmTPpeNyXN8UEL9dk6E
         naiq1grlAHhLSJvQlapEAxJojBDwtMLTjWcxCARqsVIlaTOPgNrlkReyzGG/37icBL8a
         EfJ+APQPxxTaNOBp6HgOWpe8ZSSVc6LOwla/8oHCb7Ayv6FBkNrgh7hrLBS1cA5Ircqv
         /bM5r1kztB9QQkaCG/yPkc8QjhAUSGd2PSE+scPTQlsarPjFlsK7wtwTCyAVAITRwBgS
         kRjsqgr8GMz6vpcjf5ynIV1lirq5/LwiggWcYgqwpRS/i6AcaEXOJz+jfBaP1YplDL3I
         XZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958642; x=1702563442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsCcuGLo2J2I6ix+dXxn7SDWpUwAIlNPbaC4IivWIA8=;
        b=wo4wK4AaaurME7fAeDIMjHhAn0iy9AO09zsTUMrpO+AZ7qCLNUmGM356aSUOODDMW6
         Qyqbruu1G7yEcDnZUG5niaQekQUFXKo4mG7w387xfO4Gbb4XNs28bbV11JLyTn2pQluc
         8eKbTc7Z3GmxwvikE10siZb9HAKh0/gWHAvgd64IZVwVVz/XebINXHhrfkPRyY/BIy1g
         vOkQ31akUKpSMnz4b0OvveMzNe7aLGSKz+ycTrmjyNgs+l1HjQ6S6RvM/bNHqjkZOBne
         Yc+ln2luuIE2QqdsrkDOMMtGxax0i8EMjhpE997Ja192EEAkm2+LpyEyWpausfbZ7Kmi
         t5ug==
X-Gm-Message-State: AOJu0YzFNC58EbZp+YygPGSJZSocNLusBW2cU+zM0gqTfUpmyjAFRzfC
        mr3SWlvW91+VTJGQitMWmruu384BtbDpHApwBWU2XwfGj3w1n3XI
X-Google-Smtp-Source: AGHT+IEBRQ4AL/XFd1LTfykGK68U5ukkx7PsrewbOYUyuvwi8DZONr9x4L/XICW9RDrsS4gnNobATSOqQIlk4jIDe8A=
X-Received: by 2002:a05:690c:c0d:b0:59d:d85e:795d with SMTP id
 cl13-20020a05690c0c0d00b0059dd85e795dmr2665100ywb.51.1701958641855; Thu, 07
 Dec 2023 06:17:21 -0800 (PST)
MIME-Version: 1.0
References: <20231207063535.29546-1-axe.yang@mediatek.com>
In-Reply-To: <20231207063535.29546-1-axe.yang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 7 Dec 2023 15:16:46 +0100
Message-ID: <CAPDyKFoFexzhQ59O-v1X_QjgztYZbHfQtKqGKsHsnmU6Bf75YQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] mmc: mediatek: add support for 64-steps tuning
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 at 07:35, Axe Yang <axe.yang@mediatek.com> wrote:
>
> Change in v4:
> - for SD/SDIO, tune 64 steps by default
> - reduce some breaks to improve code readability
>
> Change in v3:
> - use BIT_ULL() instead of BIT() to avoid potential left shift operations
>   that could cause exceed boundary problem on 32-bit platforms
>
> Change in v2:
> - move the change made to document to the front
> - change mediatek,tune-step dts property type to enum for better scalability
>
> Axe Yang (2):
>   dt-bindings: mmc: mtk-sd: add tuning steps related property
>   mmc: mediatek: extend number of tuning steps
>
>  .../devicetree/bindings/mmc/mtk-sd.yaml       |   9 +
>  drivers/mmc/host/mtk-sd.c                     | 158 ++++++++++++------
>  2 files changed, 119 insertions(+), 48 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe

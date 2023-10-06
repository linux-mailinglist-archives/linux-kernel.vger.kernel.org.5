Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519AF7BBFA0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjJFTO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjJFTO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:14:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E9D95
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:14:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso4477079a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696619662; x=1697224462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmhUWZX30hXfIU80TyRy7axZSi3Eoh4Vptrv5M6pTXM=;
        b=WAt53QfLhYdq5q3IXyvQFKpgMsTDLGTwRlR0hwPEN5/zAQdr6PeGW78lH1017x3hoG
         8rF6do7ptSLKNdZi6ul3t2s4eGbPXpqmILZz4AqROBsUb7ahXiy3ipdtNRnJZS5gYu6f
         drFYOIN4cKTZN91IhObQxqJBwLJ44aJyoGjAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619662; x=1697224462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmhUWZX30hXfIU80TyRy7axZSi3Eoh4Vptrv5M6pTXM=;
        b=udatL1C1mjEezFNG+W2nt0zFoop6qciosyLjW1WzkeK2LgDM2n1LfndtMbk5J3wCMR
         Q7PzIoxkX/t9z/0JhRROLkgr48KcWJLAp+zTUhcb+++g1Tz3GLauOizbzPCLghE4rH0H
         mYnOSLGE5B0VxQgArgNWQAy28sL0AAUQMoeAntAKfpSz5+11FTEy0+aNrk9L1tf9uJ92
         xBoK/I9vE+6Be23sfMcMLszcEdWmrmIxwry45AT0oMyYVwVdA/UKN1Oh6vLyjMbCSfBX
         u3RwLWk1Uf9raBtKXoj72WP+YRI/ff1O4Bw0zMuqcDy8aYnjXZlY8AENEwbTdXJSc5dc
         K57g==
X-Gm-Message-State: AOJu0YwA10gwmO2y9GpTVJdeGTMyJUSq5p5cQPO1H5ULt3VHcidLI/wd
        EvtwjCQEFNTUbiTShWr81I+YkBJhijKbYyYW0KYauWll
X-Google-Smtp-Source: AGHT+IF+zQv18E/o9kIUsCqRST8GSdTs2q4ZhuI+SAAyXMiqOQcKR7GxGBFcir9i9ZBVMONgNnu05w==
X-Received: by 2002:a17:906:3ca1:b0:9ae:55f5:180a with SMTP id b1-20020a1709063ca100b009ae55f5180amr8248279ejh.9.1696619662178;
        Fri, 06 Oct 2023 12:14:22 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906354a00b0099bd1ce18fesm3389840eja.10.2023.10.06.12.14.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 12:14:21 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso2318a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:14:21 -0700 (PDT)
X-Received: by 2002:a50:9b1d:0:b0:525:573c:643b with SMTP id
 o29-20020a509b1d000000b00525573c643bmr232878edi.7.1696619660110; Fri, 06 Oct
 2023 12:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <1696614170-18969-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1696614170-18969-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 6 Oct 2023 12:14:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ua-bDMvSj-FRWKxCm3oS4U-rqzd--g4UX_TBDF65rb5A@mail.gmail.com>
Message-ID: <CAD=FV=Ua-bDMvSj-FRWKxCm3oS4U-rqzd--g4UX_TBDF65rb5A@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Rename the label unmap_if_dma
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 6, 2023 at 10:43=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> The code at unmap_if_dma label doesn't contain unmapping dma anymore but
> has only fsm reset.
>
> Rename it to reset_if_dma accordingly.
>
> No functional change.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I guess perhaps technically this could have:

Fixes: 3a76c7ca9e77 ("spi: spi-geni-qcom: Do not do DMA map/unmap
inside driver, use framework instead")

...since before that commit it _did_ do the unmap, right? ;-)

In any case, this seems good to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

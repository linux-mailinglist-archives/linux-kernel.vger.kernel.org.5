Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EB878BF41
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjH2HbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjH2HbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:31:02 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AF7106
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:30:59 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d77f869dccfso3609791276.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693294258; x=1693899058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LDEMsoxt2eQtT/CMg03ADwG0EGLZZRxXdmL9JMrBck=;
        b=WrDfLtONfJBPCqlmcV2CqzRmKMJ8WB68nly0MOLt1dFgABf6iU8GW0velZXCxhy+vD
         g1Mi4d9S9Tk4X7Ebcnr6Z9cLQgi0stC4N8I4TFcKSLIZ/suru64/A4a56fKZ0reD/pi+
         rBp00DS2us3WDAMZYRepukqgf8gKfu+GtlrLjSlGr8nL8AnjR/NbTv++cOfjY4GU2YU7
         9sYJ7wVk29b4jtBAGE/5xM6PX5CS1hR2JNd2ej2SbOPZQxSODOU4qJSOqZfFCz1T+G5F
         tdqNYCmil9t/rAHczJkcJIwrsDNiZASAmJlFJgxxsr1MWlPq+u6YAtPeW4DRhaxYFtil
         Wybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693294258; x=1693899058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LDEMsoxt2eQtT/CMg03ADwG0EGLZZRxXdmL9JMrBck=;
        b=Kdlx0ILoA9aaO+NLkn96FhdfC1r7llnRJqP9OSTvdxVD3UEoe2BCF6q4X6HsxLwD2a
         P73c77rtkQ9nRvxNjBNEElmsv1lYV1BtpcG9U2RCItHfAlrm24Po47WmjdgvG0+GH45r
         quZoDEk1Q6wdPTvuYp9W3RZAwRCza+/fe4Ri5ENv2B8bVrGYQiUIKGuKxMmBcCAdJLuG
         SH09fTds/1elRTiXvoocwLrQ1VwS+79Dnvesai1WjiJWy8jbuE0wLPECAjbW7P5dPEAZ
         WDiDquQXzNCpWn1FkRi3LbE0c2B3EN4pM7Oys9cOLcolCMcISHmBm2Rf2AmWiaRpV8r8
         vgQA==
X-Gm-Message-State: AOJu0YwUT/zpvVctmyBxbXrK/AHhf49yVOcHclsclC1DXSk1s9nj64iE
        nUPYohDTsgs3hTimBtLOkYTg0a8t4NLbm6RC85Jjng==
X-Google-Smtp-Source: AGHT+IGmly7wtB94mKNs/2Mha5HqU8Mc36TOfWs0PmjuoYFyy8bJrYuD1ueKH2gt2+gGDbaJA5tL9ngeaVYztbYyH84=
X-Received: by 2002:a25:b291:0:b0:cfd:1bb9:e356 with SMTP id
 k17-20020a25b291000000b00cfd1bb9e356mr27295723ybj.32.1693294258432; Tue, 29
 Aug 2023 00:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org>
 <20230811-iio-spacex-lsm6ds0-v1-1-e953a440170d@linaro.org>
 <ZNYIaagdt7HuRet5@lore-rh-laptop> <CACRpkdYHMyfvAGxgvtB8jgTsOp36Lm4gXzVYcBfXdY7RQK36cQ@mail.gmail.com>
 <ZNdOOuXy7vON/Shb@lore-rh-laptop> <CACRpkdYUnpb4oo+4pBxhQqbnquDP_+w3ecGoFX18TTC9BSZFwg@mail.gmail.com>
 <20230828174332.101ecbcf@jic23-huawei>
In-Reply-To: <20230828174332.101ecbcf@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Aug 2023 09:30:46 +0200
Message-ID: <CACRpkdb8MbRMZcfY_WgkWzmQ3E-v2nSw8gifZXPZvsUgzC5P+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: lsm6dsx: Support temperature channel
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Aug 28, 2023 at 6:43=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> FWIW this seems crazy.  Ah well, Lorenzo is the expert on these beasts.

There is some crazy duct-tape code in st_lsm6dsx_set_odr() already...
If you request the external channels, the accelerometer is turned on
to provide a "tick".

I made a patch but was icky about it since I cannot test it, I'll try to
find some people from the sources to put on CC and send it out
as an RFC.

Yours,
Linus Walleij

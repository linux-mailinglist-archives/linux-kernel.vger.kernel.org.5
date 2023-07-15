Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175B8754BE9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 22:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGOUCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 16:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGOUCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 16:02:43 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9204310E6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 13:02:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-577497ec6c6so30238547b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689451362; x=1692043362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdWH8G7/JxibX+jq7eakhmn5wKNtr6QZ3AvIbtaoqT8=;
        b=Mz58cy0Kt3Z1+wShUaBgVHgGDxpamWmFASj+5ZS65vNBlFE6pTFSlbgIQtK3WVjA6A
         +KUDUfWpkPpfVAogO5+KsQ0NFfm4BuJ6J48O5EVdzzPyWBIRAJdmVrTJ41d8Z/0Qx432
         XmO4UHDIzyGxM4scnj2V1IhMoTLcV1dAca3Xq/Hj8Kk+mykf3bR9xZevexWBjlTWoopM
         ISqAgzN1N5wQT+03yQx6CLfib+MnnbI8bYyVHqasuJTUSIQ9cP2NTnaBKLsxUa3+9Gta
         uUHpWsRlPrzDyO6xEGmSb2Dqs6UvJlS9Ruyt6R0x+nLIo8WGFR8RtDlrRMmcGRY4ATWZ
         VnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689451362; x=1692043362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdWH8G7/JxibX+jq7eakhmn5wKNtr6QZ3AvIbtaoqT8=;
        b=F8TX6vmmel2zNbgJMwllJaYeS2tGdajdeHRPx6oVTToIASuW23nQGnoV0AEimLWIIj
         iogVa18OdWyfawg81us42EgC6Y+rcwXx53noTIxkGRa1HhVQhBRIEQ7vJQ4YvCUgTVW6
         uFnsQRlmnnOy8lgtpklZ/YitZ3bz+3FkiYaxMZXG108Y8+sWa6LeAGZv4sWm1AEHGowt
         k82mXINEj/Ye2OiWOvr7l4teTFvhhkstLMJ2dYg2k1sHWT7JDRFW1P/qmudbSKQebHFg
         /QhUG+I7YatImkv9JBSvpYPY0WDpmIs2mBF+oxC17JfLAnCPBzjsGp9LFToC3CRWqV9x
         3Phw==
X-Gm-Message-State: ABy/qLY1tC3axrWu7UKRi8ICKEYj9IanQ/lVT6da5vgEFD7oIqets/y1
        b2VIek0qs7u4J8Pp9UlkZJezO9rmi0kgQBgnJ6KZBJcB+n6S3fI8
X-Google-Smtp-Source: APBJJlF3v6Vw+WtzHjshzitoTc1qC7LX07Q2C3RsD1IvX+Ry88/4NSzUT7fZSVHUgs1bCHW1MQp7pfPnuQEYdOkovmc=
X-Received: by 2002:a0d:d4c6:0:b0:570:1a2c:5844 with SMTP id
 w189-20020a0dd4c6000000b005701a2c5844mr8288945ywd.35.1689451361822; Sat, 15
 Jul 2023 13:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230713151518.1513949-1-thomas.bourgoin@foss.st.com>
In-Reply-To: <20230713151518.1513949-1-thomas.bourgoin@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 15 Jul 2023 22:02:29 +0200
Message-ID: <CACRpkdYURZbTwyPz_1w94RfiK17KqYvjwXkTf5gbZxz5huKKpQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Support of HASH on STM32MP13
To:     Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 5:16=E2=80=AFPM Thomas BOURGOIN
<thomas.bourgoin@foss.st.com> wrote:

> From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>
> The STM32MP13 platform introduces a new version of the IP HASH.
> This version of the IP support SHA1, SHA2, SHA3 algorithms and HMAC.
> This serie also add some fixes when using the DMA to feed data to the IP.

The series:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for the follow-up!

Yours,
Linus Walleij

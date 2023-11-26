Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C77F952B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 21:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjKZUIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 15:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZUIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 15:08:11 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C1DB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 12:08:16 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da30fd994fdso3412425276.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 12:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701029296; x=1701634096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY/+6Vdf/DK4Vduwgn3n01nTcjhDvzNRLJfMJ/HHsLw=;
        b=ZeWVBZ2bsTOBYFlv/CEqfALy72G1JJXdcBFze91qgJoacKJ+7Ob2czV9Cz52qGL2Bt
         n71OwK364yWaBqvI6TUZZfW4ooHS2igd+LeUBZ5MWvE/xstwbo0u1Yocq/lXW4p6Jb9N
         qKLUpAo/Jv4gOijX1nsCOLLA04s9eXgATcw0H0R/msRKIgDNOEQhw45a3Et3wwtx2FVR
         pE6n+SsH3Ki+ICROzykztMeUFOp+q41eO3uVFaqX9cWKRbUgLCjV6W37qt0ZXCMsVn01
         KbEM7hEjmBGhRmzdMOjL3mwk2wXFslcjYx1A2LX5Hmur8HElGHi6ztj/GDdrQlkjojk4
         Vr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701029296; x=1701634096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oY/+6Vdf/DK4Vduwgn3n01nTcjhDvzNRLJfMJ/HHsLw=;
        b=HkQa3JGsN5ZCFApOHiGEDTtkYs0EEeVQRD5RZSmJCFYvxOMJXeujdq5rudI1a0bGLK
         YsyeqWixhDZ4iXRWuol9GfTUME7gJsll4iS9VRy63EiOQA3s0PLGYJiVmnB5gz9lRYv9
         lyi0LmbrEf21BhsCCHv7oe0ZRsmhqnOrpYeN+nLifU5T/AlRaIJm2qK5tIAyrGzqu47W
         W7JitIhcYw/IKDijJxRRn8Dbpnj5+bO4vzhQWSJEazSOzmri5dXjg5Z401zSSwRZSd7e
         +tzQlql2nXgCBMiEZTFAx8gawJMCNDR8+QP7s73gGE3Ra3aiRZ3MUCvlI+NmuSCpjTeq
         T77g==
X-Gm-Message-State: AOJu0Yz3ZSgG/3kCoK19XrnBA2ZCejfn9Cf/3W38FPfiB1Nticzf9o9/
        hgbZp0ndfJSaaMaF3lzh7Rgcyr4kg7gODCTL1eF6Yg==
X-Google-Smtp-Source: AGHT+IFFBCc7DEmI9LRDuJXBegkzaw0XRK2lD9elEp31ICkd9wVkz9h0c066lGIr5re94D7Av79NdJLG0iWp7EOCIMM=
X-Received: by 2002:a05:690c:2b0b:b0:5ce:2148:d4bd with SMTP id
 em11-20020a05690c2b0b00b005ce2148d4bdmr5935726ywb.4.1701029296078; Sun, 26
 Nov 2023 12:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20231126103029.851742-1-anshulusr@gmail.com>
In-Reply-To: <20231126103029.851742-1-anshulusr@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Nov 2023 21:08:03 +0100
Message-ID: <CACRpkdayV=KUv4j+af_HSEtz05kmg+g-UTOjENsGuS4xtsdTNQ@mail.gmail.com>
Subject: Re: [PATCH v1] dt-bindings: input: convert gpio-mouse to json-schema
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 11:32=E2=80=AFAM Anshul Dalal <anshulusr@gmail.com>=
 wrote:

> Convert device tree binding documentation for GPIO attached mouse to
> json-schema.
>
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

Nice work! It looks flawless, making good use of default typing suffixes
-ms -gpios.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

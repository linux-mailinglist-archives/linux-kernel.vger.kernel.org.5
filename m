Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012577A40DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbjIRGGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbjIRGGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:06:19 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E3F10A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 23:06:13 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59b5484fbe6so44361447b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 23:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695017172; x=1695621972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8q7Bt+xiXJJWh6C0Z2ZmHz6Wu+8lDfWhrLPtQJ73+U=;
        b=E45y1PN2Yo9Pj0qbO7N2B93ijEKRDDOAFcIdgTVa8I3V1rvJ1yVvSWKl1VHv0gavGm
         6sMJ57Xyk84w43Z02FCAh7Bb49knwkKbe/i8/2kbTx2lDLlCU9ABW1RfCsBWG5zCw4Lo
         iGcM2Kwpi2cxXXdG+jR6l5YPvMhqI2HTGpHmigOkXuWHNQE7dSv6bOR2FJTk8jjonL23
         aCycU4ioi8wyFqfekeQMTQY8zLs21/P9EdqRd1927pihqXMOj8DkhHRXYaimsGRqNFpu
         lXLOtRrOYwOvo3hPevy1oXG9aZdWoWUEPToCfxBZ73H7Tvn3enzzql/g381aQbMHOrbT
         QCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695017173; x=1695621973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8q7Bt+xiXJJWh6C0Z2ZmHz6Wu+8lDfWhrLPtQJ73+U=;
        b=evB+u52vpK178zJwV6qjuYiNqpb+RMgvm12uBQvyxWLA8msRWbZFryh9LqHpI+e8HT
         7iA8q9dPHGkuwoto6m8NQTDEtu7mtMNLyUtWY1puS1k0pGsjcI+1S8zgzFy22hctMtRz
         CgiaqyGeIgU4WUAdrfs/jPH32q/Ox8VwfiFKfVy+uXddef0hxSQgnPJCD8UTimw9+FbA
         cF5OhDLrmYakn3uKsGjUBVRyzEp2NMYk9cq45wLiN2yUxiIrd9LiFtWsv98kf3PaqHB8
         PPY9FTtrP1v3BETpMxkXVMW2v15DBEQin9BbqAw1QcLs5Ycx+zts2u1+3Mtm2iKqecib
         o3hg==
X-Gm-Message-State: AOJu0YwaDB08EF2PrSl4qAE5WJGvAkUzz6XLzymxYkkYzeYHXAbGbsH0
        Bu5J3gpQQDzS6cDh35W9pr3ipJR5kTYtO1UEgsEQjA==
X-Google-Smtp-Source: AGHT+IFcWO4BakHTO+j8ugMmEesfwNr0A/vj6TKAEbB/4hZA4CWIs7TCyDnUkRFVGoi+0YCBNkXaCGGO/QSLJdfquNE=
X-Received: by 2002:a81:9114:0:b0:59b:bd55:8452 with SMTP id
 i20-20020a819114000000b0059bbd558452mr9479330ywg.36.1695017172771; Sun, 17
 Sep 2023 23:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230915201520.4179115-1-robh@kernel.org>
In-Reply-To: <20230915201520.4179115-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Sep 2023 08:06:01 +0200
Message-ID: <CACRpkda9gq7ZqNOMWBysJXunB2Li1xOu=kxtmenYnZuKSPKb1g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: armltd: Move Arm board syscon's to
 separate schema
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:15=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:

> The Arm Ltd board bindings are a bit unusual in that they define child
> nodes for various syscon's. The schemas are also incomplete as they lack
> constraints on having additional properties and some properties are
> missing. As the bindings for the different platforms only vary by
> compatibles, combine them into a single schema doc.
>
> Add the "arm,im-pd1-syscon" compatible which was not documented. Add
> "ranges", "#address-cells", and "#size-cells properties which were
> missing.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for cleaning this up. My excuse is that it happened in the
early days of schemas.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

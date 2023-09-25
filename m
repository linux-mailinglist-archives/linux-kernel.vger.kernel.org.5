Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E889C7AD472
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjIYJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjIYJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:23:07 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F00EE8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:23:00 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59f630612a4so31318977b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695633779; x=1696238579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ox7ph+it7sfvxCbDQN0D4pkcdG6TPz8qXQplM76i6ss=;
        b=NAm4GlbPxgovNwg9/SiI6u4XutR1CKY6L7/Q+CSfEhbZUu8DIXf/9yK3y+H6WiQwtd
         db2g0NipSlhG89s8pROVyb8V4e6TbMRJM+whZMX8Jggy4S+sjB13A8MAjTseiRwteaUM
         Za8dNp/PuU67ASd5+w1MuPq6pm9ka5ECPCR06ZXiLjJr3mf3an8A0LjDKtCS6jVF+STE
         WYIBwi/t6SzcEpQe07xPFuHP/SaRBxBr3S1MEyZ5/k9uLLyuH5prwkP6/6eaWcQgi8M6
         pf8XTq50psZR61VVNI2Pd9abbS6CVataN7thBVw4ZJa0LitMEnrb4a7bSUV0hLORaUSG
         vGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695633779; x=1696238579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ox7ph+it7sfvxCbDQN0D4pkcdG6TPz8qXQplM76i6ss=;
        b=KrDJIkxy2DeLn9LP1uNyvJbYwM0zeEi7Trql/8tGIoc2uhk1FXCrFTIY1OV7a3u9a7
         GB7mZ47JBSJ4Bqia5AaAVcgMjDEbOAceQWE3MYLsZXTHZeCCq7A743dn/BC+JraxuzIK
         pnFmfqOGPEq0G6+rhsgzu6b5ueAgDFn54F/ytBmZIw56tYtshZBwbt/8dcJre2fPTWGU
         aO8+zuxYqvW+HsfnNTLxJePrvjpJm4Uc/0bxUb7D/eLVbIcgvMIQRIgSSfzjoohKHnlr
         VQH/lLCFCJUV5hUU8mlCdrLZV9VeIBRIbyEBTaxskLftjEdM1NGXyTyrOXbTWut89/P3
         ySHA==
X-Gm-Message-State: AOJu0YzxdFrSkx/+eotgwJ1pgZVo+KXgET+NKbDaCpxkdqSozY6XMIqX
        esSK/QBcdPf6luOhI7OkB471YXzn8U9JSx9iQe3CpQ==
X-Google-Smtp-Source: AGHT+IFV5y9PGQ2YbkKawNC1OFKUbpRmrOrKqoUCzRadJUQ0zFHb+lmWRYZN0Okx2R8u/rtdSUYncjv3GF95Lx8HVjU=
X-Received: by 2002:a0d:e208:0:b0:583:aca3:469c with SMTP id
 l8-20020a0de208000000b00583aca3469cmr4782369ywe.2.1695633779694; Mon, 25 Sep
 2023 02:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230720115524.137944-1-krzysztof.kozlowski@linaro.org>
 <CACRpkdbhej07QXTdPE4sx9tvHT_wjzDoCiTVJn727HHbgVtZCw@mail.gmail.com> <9b00b686-f59d-490d-bb22-ae864ac1e150@linaro.org>
In-Reply-To: <9b00b686-f59d-490d-bb22-ae864ac1e150@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Sep 2023 11:22:48 +0200
Message-ID: <CACRpkdYswy5zoLjDiySWPmNShufJFtbGqNSJH-cY0R70nnkfbw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: st: href-tvk1281618: fix touchscreen VIO supply
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 8:55=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> > Patch applied!
> > Excellently shows how the schema files find real bugs in the DTS files!
>
> It seems it is not in the linux-next (one month later). Shall I take it?

Ooops. Just me not keeping track of my TODO list as usual.
Sent a pull request now.

Yours,
Linus Walleij

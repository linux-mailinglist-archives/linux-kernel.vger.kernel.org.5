Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9382B77C950
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjHOIXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjHOIXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:23:45 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAF3B3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:23:44 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-56d6dfa8b52so3589874eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692087823; x=1692692623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+/qnY4s3O9rrWU/lJLgkQWAGmTXFaSBrM1nwh5H2Ug=;
        b=U62tym13etyd8Lv2775EVMPp1NUMkeDUd0VgFmZ//jYSNkmrldUQf16rwMjKEyS+Uh
         PuZVNU7eC71Xzt1HXBX8cKq4FELs1x5crxczWj7sw3HFjC2L6fjjVp6AUoLJEJor3Rr0
         ykgoBrShYla3Zk9ru2uq+TnA/8MhzfYN24gWxMqK4XJ/P04I40g4wWCh+/PpHVmGuCiR
         I8pV6qCfuDwnM3/gUDWmlm2tIsXdGcd+zDxKcbJ64faZhjl80zjJPQJOde4BTMtvNmdY
         qkDuCBSiZy1qoRSs/pVAglQnnQznJG4q11bMNgGgzWAsRScz5AlAE5KuLTXW2X9RFvQQ
         waaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692087823; x=1692692623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+/qnY4s3O9rrWU/lJLgkQWAGmTXFaSBrM1nwh5H2Ug=;
        b=NerL445zhxkibuB4i+icDtUzzcdnOl6ngL7QBe1QeGpTGXbIIV5CPb7qIuLApdEEW3
         oyRfoX6f4N7aaVqoJdXCPO/Gwxgrws9dd2PKFRIxG0v0xy6vOHFynmOQYiPXvBaWdCYY
         JQcH+4BN6jQ1/SJFgYgPNBejyHFhru6QRxpoGflOo+wjV5vJnkvD8JcskAJJgXQEIYEZ
         d1O6cm5/I3W+EuYJRw3yF80I7R/+AeSBVqmIXm6kxh2KqhlngnC256m1HTiZzs5bs4nm
         l4is3Yuyzr4vV0qIVl+ZMk6MoBA26NtHngq9Rx+LhtjloTqubDEI9Z3c/V/u2gqN1d4O
         gOzA==
X-Gm-Message-State: AOJu0YweoNmPbhfBd+6axrFSx56IUtUGUi69bqqlZkEPHyIcqxD9QRcU
        jlpFBj5PWLzXstqTCGCOGjsVNZhLpTDiAlhccaQ0Qw==
X-Google-Smtp-Source: AGHT+IHZe2JYf6h5xBkiktmDAAJ7mhgcLZVHcUkqOn4jYmb7vvvl8cefNEhX0u+yeQzyD87YDK5qRQYxMv0CgZbbySc=
X-Received: by 2002:a05:6358:e49a:b0:13a:9d5:356a with SMTP id
 by26-20020a056358e49a00b0013a09d5356amr12170871rwb.21.1692087823463; Tue, 15
 Aug 2023 01:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <ZMZ3aEnrrZRDNdO+@standask-GA-A55M-S2HP>
In-Reply-To: <ZMZ3aEnrrZRDNdO+@standask-GA-A55M-S2HP>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Aug 2023 10:23:31 +0200
Message-ID: <CACRpkdaS_Lq6VGqv2mfSDw03H71XGc9HKAYsgEqkxaakKKxxjg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: brcm,bcm11351-pinctrl: Convert to YAML
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 4:44=E2=80=AFPM Stanislav Jakubek
<stano.jakubek@gmail.com> wrote:

> Convert Broadcom BCM281xx pin controller bindings to DT schema.
>
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Patch applied!
Thanks for doing this Stanislav!

Yours,
Linus Walleij

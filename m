Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7DD77730E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjHJIfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjHJIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:35:07 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5653E1FF7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:35:06 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d645b95c7b8so184647276.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691656505; x=1692261305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBXqYzOT2OtPb+NJDZ3f7HkpKe+WWTIF/B2MNY7bsD8=;
        b=w4hvKtqd3Qwf61/p2oVORO3crFZ6QUpJB9KB3vTijhpiaInY3G+ts0d4W6G4Zv5eQN
         9ysVcS9TtN4UsKUhnBV7IkyiN0VCzl92SgwDMwL9qY5zKZrleGDuy2Vyly6vRj3YSM8M
         oAm0GQrvoRhBgtFyreTILO1Z9TscwikMDY+QM/D4zuc8kfarwjVyMD53sey6Sok/3G5r
         QzJvJ3He+W3kFu2E35NFfk/+yG7f0k8fpcb4DnchMbrheeB9QU4j6GeOeAXtFx0hLFzz
         gYUC7pjjxBrZBbpdVWgCKn8iygLyyQq3HXtXjh1XOxTrIXz5jHRR/cPGmzSks2fq5YOw
         UeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656505; x=1692261305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBXqYzOT2OtPb+NJDZ3f7HkpKe+WWTIF/B2MNY7bsD8=;
        b=C0NaoEWmnoTOFNGL1tG8o3CqV4kjcYh2Trk1uv3a3Kf0sII7n6kxSpYzjyN99KgkuR
         Wj6J0EGZs7SwMWJY4pM34dX78jDaN+YcjC1R4EkBniSQN2oSZZstR5lGggRtZeEau+nq
         8bPe6FLEIYHb0nNXwCzc+NvKzFx8AQJ8XICzJDp5YSObqBtv2FwIycVZVKOP/vM9XbbL
         Ty7iEHt21lAxbWiNCH1wTjqc9LCQeUKHTuvGbezU0Is5nqLCd7lOCfaRgrE46v5DP2m7
         GrqAw9L+sfWOp4qljzHN+K3akYOfntaFcj3T1/Oep8ijwWZdEqDMM+nXat2cx5QMRCYp
         5bSg==
X-Gm-Message-State: AOJu0YwyPzZ2Y4fikBNBP330q/SE/TBSLTcivq33pFTIOKI7PNA8MQXI
        +M7nsB4LtLHhBzyFJkycGnnIDOloh69FRAVsFQSumg==
X-Google-Smtp-Source: AGHT+IH/F9H/BlNGdJX2HjqnmSIeBaU0d288rlMHVZoZGxtbwTJzsuzbfcSMjJlNwl8h4xPDy9C2ezZp6rc7/C0l3aM=
X-Received: by 2002:a25:684a:0:b0:d48:a723:6d2d with SMTP id
 d71-20020a25684a000000b00d48a7236d2dmr1836621ybc.51.1691656505582; Thu, 10
 Aug 2023 01:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230808102207.130177-1-d-gole@ti.com> <20230808102207.130177-2-d-gole@ti.com>
In-Reply-To: <20230808102207.130177-2-d-gole@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 10:34:54 +0200
Message-ID: <CACRpkdYWCO191t9FgZtyO-r==OPXkCtYMo3BGncP7OZKJTKqJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: pinctrl-single: add
 ti,am654-padconf compatible
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
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

On Tue, Aug 8, 2023 at 12:24=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wrote:

> Add the "ti,am654-padconf" compatible to support the new wakeup enable an=
d
> status bits positions on K3 family SOCs that support the IO daisychain
> feature.
>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Patch applied.

Yours,
Linus Walleij

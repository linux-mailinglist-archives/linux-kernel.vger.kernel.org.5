Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1B67F652E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345474AbjKWRTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345529AbjKWRTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:19:11 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247101719
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:19:14 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da819902678so1042817276.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700759953; x=1701364753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WDJYrmtNCIUgBOwBSSL6LRWpJjXJzrwGqwfLZWO8IyQ=;
        b=DFzdOu5XT5IUX9fSr0l9fvliDSyr5vRUcDw9YPXrsFR5hKYUwUP36f7CN6xSpKf+HR
         iRTCNFoko4S/DegreD70QPQAWieByI6K/1AFQcvsq9XxE1Mn+b1WmCOk7Lw2FZ70+U/o
         +DF4LrDFMHRdoR3c4rezUEWXjhORu76OEKd9dj+VsdJl7wg+ZHOC4kIZ9v+9zJwN0gRL
         hNsA49wW/ywcCPKSkFNBrkWD8M6wgwcGCm4tzmrhxgxxYO+J1C7ZRoTTdpdyK3aIKG85
         nThlxp2/4GuWuwHuHY8yvlEF72EIRx7wjlYhhlxOZP3fJX9z2XOnWXRt8osE/t+pWILR
         knVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759953; x=1701364753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDJYrmtNCIUgBOwBSSL6LRWpJjXJzrwGqwfLZWO8IyQ=;
        b=L0X6G/E1JpPPaf1crxqh8ko0wC1b/v/qM6bXjGcj2+yiIWp+eTCS/Nr4rLZcqDI3An
         84LDH/nssrvLb3HniXbbAfU5jriV5Dq/Pzl/ivSV9re+uELWYGZUyt2bRfbpfmEmTfgl
         dFBdqjDzghaQph+IPM/+lEQE0VT+hfClodcK96xbKEDqsGB50eVe5uApkeubhwyQWimS
         3UezLx1ASv19Q47QncRsAx/iDLggpwuOrnWmHTGeCiTEMzh/PxbyK+hBcYdNUqcsw3rV
         v+rWu1Qp8yx5Y3eV+7hgTqj7Dfgn93VMEK6EV7LVWrE3fuoASRH1WD+42oJOKK5w8t8n
         25mg==
X-Gm-Message-State: AOJu0YyJOHdGVm4vqatV2ZzG1G/b1gQi4gbmeLQC5yM4mZZ0GBjJZXTc
        KQ6ku+vJxYymEIzCZZ+pZjNFR/UPYpXp54oQL/iWMA==
X-Google-Smtp-Source: AGHT+IGT2udCJz5BPSeOk3YH2WTr86oiAessLfh8FLsQCx64BtWfnypvCEPOKUg6aGqq2V/JfmXDaQglA91rbdQEg2c=
X-Received: by 2002:a25:808d:0:b0:db4:7ac:feb5 with SMTP id
 n13-20020a25808d000000b00db407acfeb5mr4596961ybk.15.1700759953249; Thu, 23
 Nov 2023 09:19:13 -0800 (PST)
MIME-Version: 1.0
References: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Nov 2023 18:18:37 +0100
Message-ID: <CAPDyKFp=zNBH2Qo_hhF-mrptYAwWjjunTJX=3Q5e_5uZamGVdQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 21:33, Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The SDHI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,sdhi-r9a07g043" compatible string will be used on the
> RZ/Five SoC so to make this clear and to keep this file consistent, update
> the comment to include RZ/Five SoC.
>
> No driver changes are required as generic compatible string
> "renesas,rcar-gen3-sdhi" will be used as a fallback on RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 7756a8687eaf..27cd985b1006 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -56,7 +56,7 @@ properties:
>                - renesas,sdhi-r8a77980  # R-Car V3H
>                - renesas,sdhi-r8a77990  # R-Car E3
>                - renesas,sdhi-r8a77995  # R-Car D3
> -              - renesas,sdhi-r9a07g043 # RZ/G2UL
> +              - renesas,sdhi-r9a07g043 # RZ/G2UL and RZ/Five
>                - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
>                - renesas,sdhi-r9a07g054 # RZ/V2L
>                - renesas,sdhi-r9a09g011 # RZ/V2M
> --
> 2.34.1
>

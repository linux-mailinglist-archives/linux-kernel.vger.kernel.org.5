Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F181B7D73A2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjJYS4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJYS4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:56:43 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F171116
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:56:41 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2FAEE420AF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698260200;
        bh=dpC5A+l/P4E3TUZnqSQSiD+h/0pN6MHwAsvozKjAyuE=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        b=n0h5vAubFSF8HklEHnm0IiBJXrCYXVWEBTFwKU+Ftu71v4YK+0MLH5qHc+pjM64aw
         +m3xIt4wgNS+nOsIYMDlb7pOCEwMCGvFSWpal5w1xAh8/kEneR7fmp9MNUsqzTyLoW
         nu5vCvJsP+f5Rkd7626X090kW0DFEflFkDUXnGqmY+yNzr1sGJ3Pvb+ZviSLY0YcJr
         PtJzvrTZr9Gojhyz032kgcsXU27TyPI9VVT7wjLRGwC4SZStrKVz3qnZAjZ3uPlKJG
         AWh/AtkOUZ6l+L2KQy6Hf3nZM7tjvZjvJ+eqzFCQTr9YCDD6/qd041bu2IIFbLCZnh
         qF2dfPo9NzYsg==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41cd5166101so1536971cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260198; x=1698864998;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpC5A+l/P4E3TUZnqSQSiD+h/0pN6MHwAsvozKjAyuE=;
        b=vXpyl+p7bsQ+sXBFCtLys+83NuuxiGGiQr58kEH0XVIbXJKG/hnv2DZc9yQj4nPRbz
         xezMHWNsv/94kDk0yW20CeqI63RodFIeXXKCTqSmuTzZGEZSTM/ZlgS6N6lpT91XP8od
         PBqFHI8Rbl2E4ATlhTi9qd76wHWJjvicFHH28KsBpaU25yUziNJxVIGY2jraqN540dch
         HjBJr2da2+10fjbu9DmyaS8Kb3+i3XnpaaMjhPAQIlAmOcJkOsJEEmG+4rn13vV7nPEW
         8BTSgm6/M+HuVFrOCKtBdAJh7AYxQRU2+Zh7efhXeWQSGA/57YD3VaPyXU5jrHgMlB3L
         Ei9w==
X-Gm-Message-State: AOJu0YyQvcxlmKis8zYuRRKWLn+7qvVSatG1Ga2l1ARuUJXc+SnfR+7u
        fDM/+gsrYt1zVSK+iS6f0DKY65ndmG+bjIBzZNkQTsnaz9Pd6sOpjgA8hZYp7ZEexymQsV0vj4g
        Mo5flkijDqPwf/Y7m2u1MLfeO/zB8km5ySgLVW78eItMxoUUxuijcnr75aQ==
X-Received: by 2002:a05:622a:1492:b0:41e:3de2:c8ff with SMTP id t18-20020a05622a149200b0041e3de2c8ffmr481492qtx.51.1698260198096;
        Wed, 25 Oct 2023 11:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEODfT6JXWwGmjJQBhTKiW+hVEHvY4WjoEtxUQiB6AZJTG4R8jFdnVJvecEIj+8lVHfkYW9vqesF3eZs9EmsZA=
MIME-Version: 1.0
X-Received: by 2002:a05:622a:1492:b0:41e:3de2:c8ff with SMTP id
 t18-20020a05622a149200b0041e3de2c8ffmr481483qtx.51.1698260197850; Wed, 25 Oct
 2023 11:56:37 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Oct 2023 11:56:37 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 25 Oct 2023 11:56:37 -0700
Message-ID: <CAJM55Z-vw1sbks0KcHOXMzP-6c9NMg+GOndi2pQ7iyWh0=oQiQ@mail.gmail.com>
Subject: [PATCH 1/4] dt-bindings: cache: sifive,ccache0: Add StarFive JH7100 compatible
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cache controller is also used on the StarFive JH7100 SoC.
Unfortunately it needs a quirk to work properly, so add dedicated
compatible string to be able to match it.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
index 8a6a78e1a7ab..7e8cebe21584 100644
--- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
+++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
@@ -38,7 +38,9 @@ properties:
               - sifive,fu740-c000-ccache
           - const: cache
       - items:
-          - const: starfive,jh7110-ccache
+          - enum:
+              - starfive,jh7100-ccache
+              - starfive,jh7110-ccache
           - const: sifive,ccache0
           - const: cache
       - items:
@@ -88,6 +90,7 @@ allOf:
           contains:
             enum:
               - sifive,fu740-c000-ccache
+              - starfive,jh7100-ccache
               - starfive,jh7110-ccache
               - microchip,mpfs-ccache

@@ -111,6 +114,7 @@ allOf:
           contains:
             enum:
               - sifive,fu740-c000-ccache
+              - starfive,jh7100-ccache
               - starfive,jh7110-ccache

     then:
-- 
2.40.1

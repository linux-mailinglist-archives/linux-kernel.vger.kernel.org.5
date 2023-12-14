Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6A812EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443986AbjLNLfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443973AbjLNLfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:35:13 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C207FB7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:35:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so925518766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702553718; x=1703158518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V0lN7lqB7W5a9CFQ9TubSyTsdw9omFHDKq2iCjTufGc=;
        b=pWsLpYCyyLUogAYE9UFSjvwV+Uync7yVasgqNYTg+epzmVJAj5rJr/GJIsZrUGSEsc
         Yi2Ry1ukyA4T4F5PmNxvWs55uxB0pA8ODGuLVIYxqEeyOjYK9fGDo8Ei6iaA2pot8jL+
         V/eXe6DyAX7X5OoBue56/yJKyGjpI+6jCzfiOi4AOtASe8D97dgmcPsvD9cRaXMqjwVp
         q5JyMLBclLkdx0Jj7w7QChNe2JJjQCzNHFVM+qFXpHIPQVxdKLA3usx17/H9itrEOjwS
         elyu6aSbBh0hf51SIda08FjnOxuIlmTWWxaGR5O8a0XaSVs5yOIfO5ml7RvqKI3Eix+m
         IZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702553718; x=1703158518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0lN7lqB7W5a9CFQ9TubSyTsdw9omFHDKq2iCjTufGc=;
        b=eJ23OuobOcOnBGJZZaCUoyjhinIGuhL59TSqr+2BKXgujyzEXt0Ix+sYxAFMh0kF4N
         +7efpldWxy0R8HjAG/Eu26NdElDWiKK8+rEMaYaq/rtu4hLY7Ueen6O28TGUAeLqjKoa
         dulcTp9z9t1TrazixEF8wXsuy9jkZoDqlIGJWwcgcu4NN0eUnH9t9Z5/JIVahCpdzmlc
         bw9q8fab7DEd9QuUjqjH1++3rG/quWe1FBQn2GYNpNnMhAR5bk/LODiDusKz+zdt4P9E
         8+dbA+PHR0bhLzv1ec3fnIP4d6tgr3U9J0PWNmO8yw1vW0gTzSHEV6wGAjrgmm2JJuFn
         n3cw==
X-Gm-Message-State: AOJu0Yzp0FUCtC+2BAuxCh4bvQGHsrWInbaxUyD4WR5F08YkOvCGficY
        iOb44llhIuZarhoHybZlrvPRtA==
X-Google-Smtp-Source: AGHT+IF+xr8PlZ+FtDZFBnHVTRiKyiPP0SraqXz1/bLYb1tElTf1pbuIGEvxDv0nCqa6p5sONRjwtw==
X-Received: by 2002:a17:907:3da9:b0:a18:4e1d:a360 with SMTP id he41-20020a1709073da900b00a184e1da360mr5224871ejc.42.1702553718174;
        Thu, 14 Dec 2023 03:35:18 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id vx12-20020a170907a78c00b00a1ddb5a2f7esm9290656ejc.60.2023.12.14.03.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:35:17 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        claudiu.beznea.uj@bp.renesas.com, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com,
        niklas.soderlund+renesas@ragnatech.se, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: ravb: fixes for the ravb driver
Date:   Thu, 14 Dec 2023 13:31:35 +0200
Message-Id: <20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds two fixes for the ravb driver. Fixes adapt the code to comply
with the hardware manual requirements.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  net: ravb: Wait for operation mode to be applied
  net: ravb: Check that GTI loading request is done

 drivers/net/ethernet/renesas/ravb_main.c | 55 ++++++++++++++++++++----
 1 file changed, 47 insertions(+), 8 deletions(-)

-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E587C8BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjJMQkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjJMQkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:40:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766223ABB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:28:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b2cee40de8so461527566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1697214523; x=1697819323; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SVjdnO017TGpoqeYiTjgwR24iVqshPB2PJMKMRPRcz0=;
        b=3RZTLuWzsG9KHAZ+JkEZ0S9OoYl1HwHWRS5w+y2soNYgN/AZU7B7dxBVS0fodiIjrw
         nVsLj/ktx09P2DnBh21emoIawQj/5He11UvrHepng+kDpYDEtr0rcOB3N3Rh9JqPQcVu
         /G3Fr/EMv/7kBlrp1RgJBXsjyDaJLJYXuDc6abbRvRNBTyqTdJmmzvPr42nTrG8A4uPK
         vGk4UMqty9mQnKxEZuP5OsqiRZelhp6Gc22/+LxWt/7gACCZRmxHzkezf1FXbRITDnkU
         1Ee8df+Jsx09enccphI3SJXJVPsSnMcy1VLLEYVRP3/H8f2Fa7HBogYPNdSiR3daMksy
         8P4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697214523; x=1697819323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVjdnO017TGpoqeYiTjgwR24iVqshPB2PJMKMRPRcz0=;
        b=p6IU8onjF7o33LXdG7h0KzmYNEAOBivcayHT/1I8aeWDFAYdc6pXPYg2NJ7dJVwjWz
         O8RKUjy/O85yruiTPuJjeNboVcryL+qgXB+brJXAQkg/x4UY1fCNWdj3ptzvOU8sUACF
         vXm1+GMB388UfaWd+q9u3B7UOMAhNrVOb6wMJy5ak9wlKq5q/b9NN8rzeA28a8Z6bGAF
         PGArEE2rNgWGGO/sN3IZ2beZ/fAMYFddj8aLMzIXhVBM/7vC5QfH6ExBdwpJpWfX4DeX
         +Odnj1WjYgo2S33AQ/IVfVZA6lcqv5Pd40HEtmMOoyNFfJ20WhxT/izZoqNCNr1otYrI
         Q9FA==
X-Gm-Message-State: AOJu0YwcX+0AdfD6+Wr407OJBy+jW6Wsx/vTRUUZyFDYKMtGV8XJdBf/
        l502PTKrGgj1OX3HLp6msPIGT7kuUI9qaAIaJZ8WuoJMEKRKHVSiGGg=
X-Google-Smtp-Source: AGHT+IF9dkaPMN55YI5eeSdgA29qSKtrLhdcDFV5hkaJapbSuaSIotOLn33LxoI85KsCbbaVtQxamMT2qvzUIDbhLvI=
X-Received: by 2002:a17:907:1c91:b0:9a9:fa4a:5a4e with SMTP id
 nb17-20020a1709071c9100b009a9fa4a5a4emr637165ejc.13.1697214523459; Fri, 13
 Oct 2023 09:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231006173205.371205-1-robdclark@gmail.com>
In-Reply-To: <20231006173205.371205-1-robdclark@gmail.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Fri, 13 Oct 2023 17:28:31 +0100
Message-ID: <CAPj87rNT7rhL_GiSA6GtgcnByKwTmWUsFVMWTRSECz2QydjtMg@mail.gmail.com>
Subject: Re: [PATCH] drm/ci: Default to UART for logging
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Emma Anholt <emma@anholt.net>,
        open list <linux-kernel@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 at 18:32, Rob Clark <robdclark@gmail.com> wrote:
> ssh logging is the default for mesa, as it is generally more reliable.
> But if there are kernel issues, especially at boot, UART logging is
> infinitely more useful.

Hmm, we should still be capturing the UART boot logs regardless. Those
go into a collapsed 'LAVA boot' section but they don't just disappear
... ?

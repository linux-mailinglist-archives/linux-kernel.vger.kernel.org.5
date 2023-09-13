Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B679E7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbjIMMPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjIMMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:15:40 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8549319A8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:15:36 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58fa51a0d97so65549247b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694607335; x=1695212135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Byg1jD7s0jMZ5vr77BfX4OpWHuu8fBcjr6eu9Xx3cc=;
        b=s256qWrYfykDwvr6P8tgnT35YhOfTacdzAqJmINOKNsCo09Sd7BdGYRQs6QTh05Tqq
         R8cEYvDI8kC84VMwf569L2YUvTu0bCw1AHdz8qqyGjw0o6XY04YsISbHthuZRHdY9g78
         e+S3LZZBYzlP5uZ74PkfIwSw/4ix3k4mZ0JDjgR1BWkBteIzsZW3YV/mH45JmNUB8L0Z
         o3iPOjQTlSAzUQE0fI2vBRN1/Kf0bGS9kc09i2/RYbSmDwy3xD/EpV05Uw7ynr6WZzED
         up7rlKRv9oK8JHtU0v+QpJRHsE95TXXtgd3RWALRrRsDe2+EaXvrpg5kAbIwNZYYsPRp
         O5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694607335; x=1695212135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Byg1jD7s0jMZ5vr77BfX4OpWHuu8fBcjr6eu9Xx3cc=;
        b=aM7Wj5C7JJFcvMi38E97JDO56FQjMKkUX+bwOvSg45QImwqZ2TKJRKpllrZ/Uj3Xzh
         IR2VfmMwzoRwOEqVIMVvBom+uT0X7iu3HyGPdOrKIZZV0wLP5QWKMiHS8D9Ir8X5/G/W
         Oa+DNXLiAUBx5bJoPpcze2JkCSGUoNgw0aZq6iiRNSn1dNjoYVFPwdYCXH+zhPbpMWpA
         dWR+/kZbgZgO1nfJyDGnE6dBDTgqYcgwYAYoq5osmIZR/LgqeG+BLgeLL3NX1M6caVsx
         DCRPcBh24ltVlusvkuw24Oyuj8xAWTQbo6753Upp/iweTu6MQcMO2fp/dLol+Rnoca3F
         PnRw==
X-Gm-Message-State: AOJu0Yz4vo8z0eiGO9doiu43RR8pyZT/tCmMZbrXOjPYT8UICweqf7EN
        xyTnvV9uFvSuyrGbVFkQqvSOpjD0xMd2OX0e5m2Muw==
X-Google-Smtp-Source: AGHT+IH7f6HeuGIRcpatvPv+O9n5l2IygEHpFtYWzxzCzwgpF9nRFYscab58C9ggMAtuUBHmFfJbfy41o089CR3uFtw=
X-Received: by 2002:a25:d292:0:b0:d80:8aa6:5abc with SMTP id
 j140-20020a25d292000000b00d808aa65abcmr2003327ybg.61.1694607335192; Wed, 13
 Sep 2023 05:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220616035356.3976296-1-windhl@126.com>
In-Reply-To: <20220616035356.3976296-1-windhl@126.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Sep 2023 14:15:24 +0200
Message-ID: <CACRpkdZ-eyGj-BDUf8kMsB=Yf3ZpYWCKsFP-rB3BjOc_-W7esw@mail.gmail.com>
Subject: Re: [PATCH v2] mach-versatile: (platsmp-realview) Add missing of_node_put()
To:     Liang He <windhl@126.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 5:54=E2=80=AFAM Liang He <windhl@126.com> wrote:

> In realview_smp_prepare_cpus(), the second of_find_matching_node()
> has no corresponding of_node_put() when the node pointer is not
> used anymore.
>
> Signed-off-by: Liang He <windhl@126.com>

Patch applied.

Yours,
Linus Walleij

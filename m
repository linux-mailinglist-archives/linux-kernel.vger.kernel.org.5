Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3B3772610
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjHGNjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjHGNjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:39:12 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FC71992
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:39:10 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d4364cf8be3so3508863276.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691415550; x=1692020350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRDT9DXBzQlTjPrZAhEg59Olbt5sHylTIeFizzconrE=;
        b=WWj1VMRsFjhJYS9j5EcWQz80Rwb9c4CFPW+X/veRPzcjP6bQYlI8+IBKtLrZRyXcKn
         2VOWgfeqxdR2sYk2hA5qDR0AiQezwK0Vg7Ati5GcgJsNYyqlBfBcXQbJ8cHAXfvt0Mti
         +YwEdYUjsc7cIaIZIiYqsS/Jge/eQi/RRiolkpH2NQHjg7dON76ErQNRE0CR3wqgRqYT
         Eui8biZAxl4u7cVjdgZX/qsRojDmDkLUqW1cr7oZWi3Fy8eyaSrgrW5IXIGTZsv8ZywA
         L1HsLMNAXaiKhb5puVZgh3fAWXKY0swJuJeerQB8ZF+S9UsYVA0hqeu27OLKsOLBS//3
         N+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691415550; x=1692020350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRDT9DXBzQlTjPrZAhEg59Olbt5sHylTIeFizzconrE=;
        b=aQ2eQ4TY5yg+MbP+pGNybY8xi/lRTYQ6QrCjKg6BDZ9vqtK8SDWKSTnSXfh75NBIZg
         VwfXEc3hE3dnRcdKmP5B4kzTPnY3WGtEar0DQKQEATSpWz1G8x4/cnWHch0U6hOoiGNM
         bwiOSoa/vKYIAcJejXcvfLb2+VTd4JOtOLVhe52HKH4YvYpngQ5J+x47g5HKRd5iUUm3
         +1fvioEi+n9rXpf7wKuVO/rdwf32SZsmTFcV2HQu/M5/3xi8/je8pbSSYE4gc7S3ec6G
         WL0eJQmHFMtSbDsH3jEj1n70T5L/9KkHRu6vi85hYQ/2W+nZsOllgAg8XLd6c0pSMkx8
         kp4A==
X-Gm-Message-State: AOJu0YxdZAxG4kIr6DseknbW3CwEPWuM4fsxRvC5ekJVO66j2FaaQTDF
        tzVP21NXv7bIMi2yTmJErkNoFLDih4jL/3aOUVKagQ==
X-Google-Smtp-Source: AGHT+IEgUqiyfEGaIlKKBGfAfYasMwxTYrCOJerBNORMgootu9kvLZhnNC9y1WNIMYu+b/QBI2QTxv5w159iXcMsfwM=
X-Received: by 2002:a05:6902:1024:b0:d4d:3551:15d0 with SMTP id
 x4-20020a056902102400b00d4d355115d0mr5414866ybt.61.1691415549840; Mon, 07 Aug
 2023 06:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230721073214.1876417-1-huqiang.qin@amlogic.com>
 <20230721073214.1876417-4-huqiang.qin@amlogic.com> <7hcz0ei9r4.fsf@baylibre.com>
 <9da24c47-341b-1581-0043-a6c1cdce462d@amlogic.com> <7hh6pnhn45.fsf@baylibre.com>
 <35713689-2b28-192c-5004-8a0ba6b9308b@amlogic.com>
In-Reply-To: <35713689-2b28-192c-5004-8a0ba6b9308b@amlogic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Aug 2023 15:38:58 +0200
Message-ID: <CACRpkdaY-RNjiibVX0sZpxG39mqZGP-+nUg1sCBhF_N=4D8aNQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: Replace the IRQ number with the IRQID
 macro definition
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
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

On Tue, Aug 1, 2023 at 3:25=E2=80=AFPM Huqiang Qin <huqiang.qin@amlogic.com=
> wrote:

> Thanks for the suggestion, I'll add it to the cover letter for the patch =
v3.
> (patch v2 was sent before your reply)

No need to send a v3, I just applied v2 to the pinctrl tree.

Yours,
Linus Walleij

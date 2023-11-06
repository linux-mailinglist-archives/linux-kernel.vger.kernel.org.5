Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BC37E3182
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjKFXej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjKFXeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:34:37 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C4A10FB;
        Mon,  6 Nov 2023 15:34:30 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41e1921da84so31854531cf.1;
        Mon, 06 Nov 2023 15:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699313669; x=1699918469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b+/MoxP2Xl3kPb8t5U8uMRuNrhyDRJQ0FvpXcM+0XLY=;
        b=cacUSlw/uUsbdiJIGNpSTTa3Pclv3Pkdr3zATixVBcCL6Qyo1fJokJ4vXYuZ2M/QTc
         hhpldK3s1OpaR/BZzKoIAYFxn3zOV3u4yhp3LGS7IxlrJxrZwSD5PIfYo5HAiJr+LIxe
         GUnHTi7rv+98fA0gb3NRurBECg31IpapVb8aiywBNdF9Pp6ca51wwMxOrL1zgbcQiEOR
         PP5b8rpBf4QZfipMA9EuqEurXUNO3tAnz90/uB9ZEf3sOhhFKcd8sYfUMvH285b8luPZ
         0/UJRnggCM4dlxd/sh/0Z4R3ixl8i5uxUe47MZVuoMIxNLd6DlxmLi7nq1vuPtFMuq+E
         aTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699313669; x=1699918469;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b+/MoxP2Xl3kPb8t5U8uMRuNrhyDRJQ0FvpXcM+0XLY=;
        b=nOYhSjbce3611FIqOz+0ilvV71Mq8tfk3hl4Hy1tfw2XzzCzQTT2j8lyuBkXvgYXUi
         F+i9cBxfg3OIYFgAkSEnOyYumwGemxAogTT/pbBfRZJ9vKJyZtejbgX9qb7ZjVIYSKmB
         i2Sxsb7h/qze6rWfEj7SLQDggDkyS6vnu34eDKCvDiKDKfuHgjMqJLPGxTlA8wXCqPgD
         Tl6h+1l0IxAqLpVgfPcrnVeXW+hhS/k4+9KSEeiJnHzzH2zbdXypEtPrtbbBAPE+ahBj
         oE7pu8SzAhiTpG2eiDnRShGTtaOO1vXNdEUJAKLjBU7knrltYL1ZxeQRWPROdu1ca2/d
         EE1Q==
X-Gm-Message-State: AOJu0YyQuiVoyqtHFDRw04HRtA00dk3Y7hdOzAT8PygogZaV9DhTW2vT
        G8GAkMvxrElxOHJ63y29aVVkGFv5HX4shKjxu17GwQE2yAQ=
X-Google-Smtp-Source: AGHT+IEuJx38f9AfK2nfNYw6omo2opuv+TtWLwt4yCZcsClAXV9J9sN0YqQlMeJS+t5pr7xXqNglIk7XVKRgP/sK11A=
X-Received: by 2002:ac8:5987:0:b0:41c:bac1:6d0 with SMTP id
 e7-20020ac85987000000b0041cbac106d0mr36688325qte.36.1699313668926; Mon, 06
 Nov 2023 15:34:28 -0800 (PST)
MIME-Version: 1.0
From:   Rani Hod <rani.hod@gmail.com>
Date:   Tue, 7 Nov 2023 01:34:00 +0200
Message-ID: <CAJD4rqFKYrvg4oFOffCAUss1bmEXDFsTedwLZK3jX3QWTF8VXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: leds: add "internet" and "rssi"
 function definitions
To:     robh@kernel.org
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        oliver@schinagl.nl, pavel@ucw.cz, yangshiji66@outlook.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 09:29:01PM +0800, Shiji Yang wrote:
> These two types of LEDs are widely used in routers and NICs. The
> RSSI (Received Signal Strength Indicator) LED is used to display
> the Wi-Fi signal strength, and the Internet LED can indicate
> whether the device can access a specific server.

Two more LED functions somewhat common to wireless APs that should be
considered here IMHO are

(i) a function for cellular (3g/4g/5g/...) connectivity or activity.
LED_FUNCTION_LTE might age poorly, but LED_FUNCTION_WWAN [1] could fit
in with existing network functions.
Alternatively, LED_FUNCTION_MODEM seems both more inclusive and more specific.

(ii) a function for signaling mesh (= wireless inter-AP) connectivity
or activity.
LED_FUNCTION_MESH jumps to mind first, but perhaps there's a better
name that could fit wireless repeaters as well.
This function is close to, but does not fall IMHO under the suggested
LED_FUNCTION_SIGNAL, as this one serves to indicate activity on a
wireless connection between wireless APs (e.g. 802.11s) regardless of
signal quality.

Thanks and best,
R.

P.S.
Sorry if it looks like trying to steal the focus from OP, but I
believe it makes sense to discuss these additions here rather than
restart the discussion wrt a separate patch.

[1] name suggested here:
https://www.mail-archive.com/openwrt-devel@lists.openwrt.org/msg61810.html

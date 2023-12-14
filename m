Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49215812D32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443692AbjLNKjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443672AbjLNKje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:39:34 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23D2120
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:39:39 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5907ded6287so4936851eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702550379; x=1703155179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQpEKW0vlfzqI5cDIUoQ0zKRhm/QITCtnmzIzOsRhcU=;
        b=C86E/pKcbzucau9dIR65aigCl679MftuECWgaUycOAQYecKtprATGuDH93O59gA1Ye
         N5dfT6FzojMwlCWjqDdHt1ttY2DNCCPD6aqfVph4sosn/8c9mOtCYjsHCWWSYg8vRPUr
         hoHMSEE+cymNyRRJnQUgzPcf7HQO/9NtfU+xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702550379; x=1703155179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQpEKW0vlfzqI5cDIUoQ0zKRhm/QITCtnmzIzOsRhcU=;
        b=oWq8m2si2hqsgNuFPltmgltbhCSgzXlf9TBZ482Yfo7ClDzpBq5nIbFqLWCA3HnVbq
         8CqRYpuIacFmfKATmpqUnKEc+1yCdrxo24UXgdoLViOQftVhMrvzn8lit1oYdRa9wPCl
         LVr6zVbZC9BZhM93SqRvfgot8obIxjAswGXpJpR9xmX0zdtOM6aApWxkfh8PuQIf+ZoL
         vVnsRfb6gcytytx4Mb0+pi/H/64f8NKDQoyk86eJqpenwpAN5J+5DVrUZ9N8dH6rGlh6
         J6F46ASkyqZzXuh8OplNvRojEYut3cy6rNSLUy75qj/zD1dlvdhnH5cuZB9jKB6PvDRJ
         kmOg==
X-Gm-Message-State: AOJu0YxwIUZ7IP4yEV8LNSZvWj0ee0XC2o0LcYzO52y6NoUgALIIDIVv
        xWrZhRnw/1zWutGLyuN4LX8V4Q7KBEX4ZU7twU8=
X-Google-Smtp-Source: AGHT+IGSB4e9OSDniwuahu8qhyhywLtJbvP2R73PepwC1ben7H2M5MJC7B+bnyWxls5edvJbPpCuAA==
X-Received: by 2002:a05:6808:11c3:b0:3b8:b063:6671 with SMTP id p3-20020a05680811c300b003b8b0636671mr9721045oiv.104.1702550379138;
        Thu, 14 Dec 2023 02:39:39 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id d24-20020a67fb18000000b004665bd1453asm115010vsr.30.2023.12.14.02.39.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 02:39:38 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7c500dcdd7dso1271161241.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:39:38 -0800 (PST)
X-Received: by 2002:a67:c010:0:b0:465:fc90:2cce with SMTP id
 v16-20020a67c010000000b00465fc902ccemr2107147vsi.29.1702550378388; Thu, 14
 Dec 2023 02:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20231213150435.4134390-1-wenst@chromium.org> <20231213150435.4134390-7-wenst@chromium.org>
In-Reply-To: <20231213150435.4134390-7-wenst@chromium.org>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 14 Dec 2023 18:39:01 +0800
X-Gmail-Original-Message-ID: <CAC=S1niMvoD-EzGWqo-5fEBJLWAVk3FnxW3jq5rSj9fQ_H37gA@mail.gmail.com>
Message-ID: <CAC=S1niMvoD-EzGWqo-5fEBJLWAVk3FnxW3jq5rSj9fQ_H37gA@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:05=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> Tentacruel and Tentacool are MT8186 based Chromebooks based on the
> Krabby design.
>
> Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
> convertible device with touchscreen and stylus.
>
> Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
> device. It does not have a touchscreen or stylus.
>
> The two devices both have two variants. The difference is a second
> source touchpad controller that shares the same address as the original,
One nit since you need to resend this anyway...
s/touchpad/trackpad/g

Regards,
Fei

> but is incompatible.
>
> The extra SKU IDs for the Tentacruel devices map to different sensor
> components attached to the Embedded Controller. These are not visible
> to the main processor.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4CD78B761
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjH1SmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjH1Sln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:41:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB82D95
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:41:40 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c0a4333e03so7487995ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248100; x=1693852900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAdzuHMvkCFqVauBXwdDJ3GLtZSu6knldeG83doO9Ec=;
        b=fv7d0plYbBx0FcIuj3iy6HGwIN7yPedlaPgHU/NEm35V6Cm0LDmY5kMwkEfW8chYUQ
         GLSJMlQ++vkYXE+/yH+hGAzg0byYg3zxfFOs48c3CBQZtFPehqM6i5VQHIQAPF+9j3cX
         aFccBBYuFTlkv6fQ01P6L5pNLnKBG5+y7ZLc2gRAzyumuWQLLWg89mU61+SdM5ENcyO3
         TazCePXarmjq/oxsvI9WoiyFn9AZtQnx4wd4S2VfdQuhQUITGb94ALqPAzE7H+mGblzL
         NvTTupKJ4yhfN9xVmWTlXDQg4g5JnYHxsmYTZ/ZLeCPP4CxemnSfcuNVrOcIyEoYmN9p
         eRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248100; x=1693852900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAdzuHMvkCFqVauBXwdDJ3GLtZSu6knldeG83doO9Ec=;
        b=Jqzqz0MSBN01jTyeXfc6qAXrluIIi5BHpeQ1aGG8YksFQRCdYjoXFCAl1KIOlUeQ4f
         oMDHhKMWnOiT2Z5HoyLCSebdu7E/XVYTgX6iimOrbL36QVMegAjKrlrxCTg/LdeYcy0h
         42m4GV71OuiezdKsbCVjrj3cNYvQu89W5rr97z8F/ECvQvg8C5DxulDRZQV6nSFv/n0J
         q4t6bKiLlZd7pnA8qx+81sbxnp66hwTWd6lO7x+0KoH42WhtDRuz7hYhxI4y9b+pkcHA
         lF/0hx7Q1cK0mf9kkPmRojC+T3L3nwxSbl/T7ZIjthtTf2FsGsHKL53Hztd5MyREusxH
         /sKg==
X-Gm-Message-State: AOJu0Yx5jJu+KkneaEss1XBUk313BpUkKutm5+3sfxN93y/IluGQM6Sn
        NRFsdh2Jmn4N9SCUmAaHypQ5Dl3YeWXI2U9dRjQ=
X-Google-Smtp-Source: AGHT+IF6mYJKXlFhbh7I4I5gSzMi8JDvKEAUMyhJKBWuHbj81XXIRg1wZwxpNQBkKLN77Cp+NXDr292Jt4w6/5AREMA=
X-Received: by 2002:a17:90a:9a8:b0:26d:40ec:3cf3 with SMTP id
 37-20020a17090a09a800b0026d40ec3cf3mr24128145pjo.0.1693248100203; Mon, 28 Aug
 2023 11:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_0ED0DF5CD5426F55806D79D028F8A10E490A@qq.com>
 <CAOMZO5BByJsCOCpQ9WZqMWP7qmh7x3N06wD9VhpWMjoi4hg2ag@mail.gmail.com> <tencent_D90A6A9DC4DD4D576DDA5600188F47A2C206@qq.com>
In-Reply-To: <tencent_D90A6A9DC4DD4D576DDA5600188F47A2C206@qq.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 28 Aug 2023 15:41:28 -0300
Message-ID: <CAOMZO5Cxg_x7iO01kDFNH=ENMU3ey4dLsYnLo-1Vf_oP+QNFSg@mail.gmail.com>
Subject: Re: [PATCH] bus: imx-weim: fix to avoid potential NULL pointer dereference
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shurong,

On Mon, Aug 28, 2023 at 12:03=E2=80=AFPM Zhang Shurong
<zhang_shurong@foxmail.com> wrote:

> Hello Fabio,
>
> I think we can make it happen by designing the platform device in a way t=
hat
> its name aligns with that of the driver. In such a scenario, when the dri=
ver
> is probed, the of_match_device function will return null. You can verify =
this
> functionality by reviewing the following function:
>
> static int platform_match(struct device *dev, struct device_driver *drv)

This cannot happen in practice as explained by Laurent in your other patch:
https://lore.kernel.org/dri-devel/20230828183748.GK14596@pendragon.ideasonb=
oard.com/T/#t

Please do not introduce these checks.

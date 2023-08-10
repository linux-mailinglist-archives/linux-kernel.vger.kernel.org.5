Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2851E7774F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjHJJyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjHJJyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:54:44 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911FAE7F;
        Thu, 10 Aug 2023 02:54:43 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bc886d1504so717833a34.0;
        Thu, 10 Aug 2023 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691661283; x=1692266083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s08cxhY4o0sFxBf1wApMpSdM13IK7EgbJLSajHZa8sU=;
        b=pMxkK5LhQ+eDirbFO29SE5NE8y6Ih5PfEZQac3XOWvGgguRy84cXDgW69Tq4hN8Wkr
         qH8ZW0c8Rha0l3fZ326HVZNOfLngbhbHEysMk7RRDJhhnitHb1G23h1+wKaQrLazVBLa
         J7Z4KXq8CP18S/5+XS2syMdTaYpcb5JOldI/jJVyJC9xSJJKRc973s6oxes1E8YkR3Mj
         M7LP6QkWPD8KGUoS30IsdkHL7f9luPL3kTeAulczfWVkcQZYJrYwRsqmMCVqPVW/HVw0
         9ukVxxGepAGA23opUWMUi1/gGT7eObUvDkh7kNF7oYu30mNiQrwhNl3OfOcpG2WkW8K0
         AayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661283; x=1692266083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s08cxhY4o0sFxBf1wApMpSdM13IK7EgbJLSajHZa8sU=;
        b=IoUUNxyQFjE7WGoTp3ZHZLU9LlzYuBZXQ7H5xFzdXt9VmbJq3OQdVUZge4ffRZIfoi
         MNPeRNeC0M0W6ECYCn7FCp1MSTWnPKmjsnD9JsjzjhbSkIKRA6gytJO5MiLCtr1vKVBD
         kjhyCrknu/ko/lhCg0iRKbon3TxEiKFL7c7WcktYqDXHqhGMWsSvQbZGWkE/i/X276zU
         Q48MuIBq3lfxfbH69uHJDt2IpcJr33gl9kyW/Dolg8wgmVBu1fDlJAdmWPEpNJSfncTt
         QL6E5VU89mEqUMsYjtR8kAWKhC/JXflirIV4Xxv8FK/0GmSyT5dyAJ2V4RycJmKyCuRP
         WbXQ==
X-Gm-Message-State: AOJu0YxnX+tgaEK+tlHutDNjJFVxRJB+niGWh/rkDJ07q3Zxk00YG7Tb
        ed1kWzWqxTwFVb0EQSiYG9GJZsumyXzGEreAD8dzkPQC8Mo=
X-Google-Smtp-Source: AGHT+IHIbbjsxhjFHIcfmxnAfTqkWerVa3+/mQbo7P203pwFWrgEfiYAB8PFCOMbGUpXBtlCoHH/ouL5Y/9RRTbZ82g=
X-Received: by 2002:a05:6870:524c:b0:1a6:cba1:7cce with SMTP id
 o12-20020a056870524c00b001a6cba17ccemr2749488oai.32.1691661282828; Thu, 10
 Aug 2023 02:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230809171245.92081-1-coolrrsh@gmail.com>
In-Reply-To: <20230809171245.92081-1-coolrrsh@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Aug 2023 12:54:06 +0300
Message-ID: <CAHp75VekbfUrRrqnb+2UnG-r2SVFRGV94RGofmrfxAg-ii09FA@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-imx-scu: Use ARRAY_SIZE for array length
To:     coolrrsh@gmail.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
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

On Wed, Aug 9, 2023 at 8:12=E2=80=AFPM <coolrrsh@gmail.com> wrote:
>
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
>
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
> This fixes warnings reported by Coccinelle:
> drivers/gpio/gpio-imx-scu.c:106:32-33: WARNING: Use ARRAY_SIZE

Can you test your changes, please?
We don't want just mechanical (scripted) conversion with obviously
wrong results.

NAK.

--=20
With Best Regards,
Andy Shevchenko

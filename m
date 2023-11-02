Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A7B7DF77D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347090AbjKBQR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjKBQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:17:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C736212D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:17:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so1832512a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698941842; x=1699546642; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcTsZNfH8uzMszz0/Isw0cv0s2mphvKpQCC7w0T8ytw=;
        b=otdArOjvbDaZKoyqwx/hcM6m8Hh3K6iOLKCtN+GQhLhB0/nxAXccCNBJvy6BXvmJDM
         0DkbNCSYO1RaKOShRhycnrgMv2PJ8AUUrD0OgQ79+c1rzXkIwsbzpNOdVXPAXTOeVddG
         UN6KT7YIWvd2wRFlGQS1Uk1r7w5FA93Tw1Ardc7+8k23RHoweiUMMW7GFNNc05bd/X5j
         U/dXEjyqb5YK+ivGm69knkxPeBpr1Ze3w6rS/5o1+dJ1FGG8oUUm/KUC3N+y+IdY2yMT
         9X8pYDZhU2EPooYjZUgemmUjteMgjIu8we2/b1nwF+LdBJY1yWQnjKKvNKXmVU3gM3FN
         LnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698941842; x=1699546642;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PcTsZNfH8uzMszz0/Isw0cv0s2mphvKpQCC7w0T8ytw=;
        b=LNiUVktCTCytEeA2O8sMCaxbkClrQFPSGPmDbOOOmA6MZuHmBr/1bghIFPEAJNvsOO
         xXiTaRkYd3zUr6ypYrSeVhV+k+WF5V1GAz8BaAUkvDlo9Z/aYku5+fsZjyo4OTIoZYLc
         fi2zufu5m1CPOs9kewJFRucWowEvrpQ+5a/+0A7zehmQJ3GU5K/HzpI045g734e5gpG4
         aiWNJ0r1hNr/P1d9tKlk/KXStf4zhvX9yry3Ur7u/RZVDBfjhLIotKbGajSY7HuOz5ht
         JzD985mWJstPJu9ut6S17frNLGyskCF9OAwpuIJws0FVxA1x5/3ruLazXbF6RA9/RjFd
         lwgQ==
X-Gm-Message-State: AOJu0YzpxunF2jg89txmNSql7dn8pQQIup6lM+UU3AIyUKJINFMVrpjP
        AXMx1b0sr9d3cFW97JoZOEDt1g==
X-Google-Smtp-Source: AGHT+IHdrz4vMAH2qUJu1kwrlt/8tMoVWJZq1nPfpGgOHFt7yVrmQQe4qPXrPH6Wb7NkVdYDUCFrzA==
X-Received: by 2002:a50:9fe2:0:b0:542:da34:cb7c with SMTP id c89-20020a509fe2000000b00542da34cb7cmr12171037edf.19.1698941842188;
        Thu, 02 Nov 2023 09:17:22 -0700 (PDT)
Received: from localhost ([2a01:e0a:448:76e0:588c:af9c:bddc:7245])
        by smtp.gmail.com with ESMTPSA id a5-20020a509e85000000b0053e3d8f1d9fsm45300edf.67.2023.11.02.09.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 09:17:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 02 Nov 2023 17:17:20 +0100
Message-Id: <CWOGMAUT9MKY.2IBKELIOR1CF7@burritosblues>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <jpanis@baylibre.com>, <jneanne@baylibre.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v8] rtc: tps6594: Add driver for TPS6594 RTC
From:   "Esteban Blanc" <eblanc@baylibre.com>
X-Mailer: aerc 0.14.0
References: <20231102132616.1130960-1-eblanc@baylibre.com>
 <CAHp75VdvR0H7XVLWGqdZqSgoHprUUPQHGiyWEEaHjTgEbeinqQ@mail.gmail.com>
In-Reply-To: <CAHp75VdvR0H7XVLWGqdZqSgoHprUUPQHGiyWEEaHjTgEbeinqQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Nov 2, 2023 at 5:00 PM CET, Andy Shevchenko wrote:
> On Thu, Nov 2, 2023 at 3:26=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com=
> wrote:
>
> > Notes:
> >     This patch was picked from a series since there is no dependency be=
tween
> >     the two patches.
>
> Not sure if RTC maintainer uses the b4 tool, but as I said in previous
> email for pinctrl change, there is no need to resend. b4 has an
> ability to select patches from the series to be applied.

Oh that's good to know, I was not aware of that.
I resent it because there was some minor nits that I fixed on both
patches.

Thanks for your time Andy,

--
Esteban Blanc
BayLibre

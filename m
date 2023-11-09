Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE967E6680
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjKIJUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjKIJUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:20:01 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4A825BC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:19:59 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5be6d6c04bfso7427457b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699521599; x=1700126399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMqzOhl9WJdB/fNzCLgAfODP7qyR0cWrCHRSWDr+Pj0=;
        b=eozzNk7MQrpb00EzZSTP+MyjbgBR58IXVyyVIjuSJ311RdgF0dg/XLO7icXV2sImmZ
         ReEc6cZ5LEW31QXd8fvnkaq1pbc7Ac0i5ccaBCvLKwQZouOflbxwgmcYKb8/wonB8qzv
         5k11Y4hpJdInQp7gORgysFVHxope/jCywS+Xf/IwjUpwNtfU6NlGX5ObSs/Uvk541n9o
         D67NTcZGRtc+ormqXQaJJlZ1w70Oh4V2bNizbEy7C1wZko2iwhkuB3FDgl2yrra0oK7q
         GOnrXy4XirTj72WZIq2I2eUnwdrarhSUJIoKLcg0LOEOpJvnEIkrDMu9nh+5yJv9dYqR
         oq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699521599; x=1700126399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMqzOhl9WJdB/fNzCLgAfODP7qyR0cWrCHRSWDr+Pj0=;
        b=Gj0y0OpDYciFQpooXHLDVFH6tWImrtZcGF9nJ9KHakUWjBYsfAbqdhsgIQXKcbUc2F
         QgZSmW5g28qEPCMx956wvqZVTS/XI0fTEq1pMe5YerCthK9s6Al7U2ZltIPRjr1calLB
         BlJt9lXnYRKiMEd9sy+wC9xAnO2Y7TpxKFKCyVGTm9TNBGlx/u6QB7NEF84SHVlevgqc
         +2oqV97Z9aQ2PyR0DGqP3Ybcqvgkz5hrDgAMfXRvWkdo2HfzSOEusO8fIExqquDYMEOY
         803SDvOH7lS9scW9vtneWbp5drTWO/kEGML4GmAvd3L33OUAKjEHpoOXZ04XAJ7dqriV
         lz2w==
X-Gm-Message-State: AOJu0YzpwKt0qkzOsiLoAORckK6s+TJq4Zg/t30KdapEf+Ft4JxLtVzu
        ZnTxm6/zOD+zI4ut9LlBJRjwFQZeFKd68KDfZt4mBWkwFRdKT4Ld
X-Google-Smtp-Source: AGHT+IHGslikWjLVflnuZnU/FjwclWe1/pFMwApskuuBpFlo3DBr3i51zm8GUoCtqVS2TkIt+0zIc+bYLe0M7YFt/uM=
X-Received: by 2002:a0d:e894:0:b0:59b:c805:de60 with SMTP id
 r142-20020a0de894000000b0059bc805de60mr4100178ywe.45.1699521598749; Thu, 09
 Nov 2023 01:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20231109090456.814230-1-anshulusr@gmail.com> <20231109090456.814230-2-anshulusr@gmail.com>
In-Reply-To: <20231109090456.814230-2-anshulusr@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Nov 2023 10:19:47 +0100
Message-ID: <CACRpkdYtawfonnkGXzTD65fx4CMbbTaXe359tm7=57saHSNfqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: driver for Lite-On ltr390
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshul,

thanks for your patch!

Overall this looks good to me.

On Thu, Nov 9, 2023 at 10:07=E2=80=AFAM Anshul Dalal <anshulusr@gmail.com> =
wrote:

> Implements driver for the Ambient/UV Light sensor LTR390.
> The driver exposes two ways of getting sensor readings:
>   1. Raw UV Counts directly from the sensor
>   2. The computed UV Index value with a percision of 2 decimal places
>
> NOTE: Ambient light sensing has not been implemented yet.
>
> Datasheet:
>   https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-3=
90UV_Final_%20DS_V1%201.pdf
>
> Driver tested on RPi Zero 2W
>
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
(...)

> +#define LTR390_FRCTIONAL_PERCISION 100

This define is just too hard for me to read, can you rename it?

Does it mean LTR390_FRACTIONAL_PRECISION? It's fine to spell it out like
that instead.

Yours,
Linus Walleij

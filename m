Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0AD769A35
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjGaO6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjGaO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:58:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23681E7C;
        Mon, 31 Jul 2023 07:58:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe0c566788so7488072e87.0;
        Mon, 31 Jul 2023 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690815518; x=1691420318;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ORB1Q+Iw/OFBqXFQvBc5swFMkKQ4r1p77ZHKyIsEFdc=;
        b=szOQXcgZiZeR4Nmw9aSousAbXxal+kmPPVxKh+F14Md+xVK38h2x3p09hEaT+UxABm
         c1oC92ctS3vDVt4IEjIG9z4mP0RjVabJWlOrly7YCr4V3ZsPXi2UazcwDr/GN902iTnZ
         ArLnAogFOA3vqZAuUD2KpHYm2cX3HPtyRv0MbXkvCReMvVrym3L6h1geBf21Qwpwd0Hf
         mOFBDd/iamkMAq7nO79njkVI8eIw52NJAmouSM+odeWVXVPIhJRruVxRcMoHBO3UQwwE
         0xTECIbDS9QvP3fYz0n+r+Wdz17p07GbhfCX50wuLysjR9cWYTEIZf9od6EOaNk9zTRy
         8qRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690815518; x=1691420318;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORB1Q+Iw/OFBqXFQvBc5swFMkKQ4r1p77ZHKyIsEFdc=;
        b=kpxcW1ddw8IW6s2WucpQsXWrkphEwBq5VVXqiEInDjUHwCAAPu3jVHRCGwwXFcoT5r
         aWNQA1rpJ3v01wUgwj/61G8kPNbwbrCKPbNEy8tpslGQD4H0G36j+wlEXHoD6Yk+3/X9
         CZmi9UwDylQ5D3tGkFJN6Q7+ye5q+k9/AuXb18nrVPAd8RcDHsIjow4cCMsrt742j9mj
         x5/Nh+UvaeXoGRgVXnUcUU/msEfKFhdlRJOZvQ7Q0KSYFn8peCQL9yuS3AlAfvhchI2r
         qvZZ1NTGJQg0UBAvmQ1viuy5P4N3i3YGdQfLI9Nz8xSg1F3GFyOg2eCtyOZn307WQ+YE
         0h3w==
X-Gm-Message-State: ABy/qLaIG6N6fNstxYvGB7E4xZA1lP+BCaRRjeKoiQ7BsVrOTSTBbdln
        IJifFgnA0tA0d9y8pACdfL3a6QCDzQo=
X-Google-Smtp-Source: APBJJlHxuIAEisOHSGuHnxUa55Fmdq5/4wuIatTtWjc8BIjedxOSUMoxPfgn47jjB4MnYkT6xHotAQ==
X-Received: by 2002:a05:6512:281c:b0:4fb:7559:aea3 with SMTP id cf28-20020a056512281c00b004fb7559aea3mr38563lfb.39.1690815518014;
        Mon, 31 Jul 2023 07:58:38 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.17.21])
        by smtp.gmail.com with ESMTPSA id i18-20020ac25d32000000b004fe15185b67sm2154485lfb.229.2023.07.31.07.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 07:58:37 -0700 (PDT)
Date:   Mon, 31 Jul 2023 17:58:37 +0300
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samu Onkalo <samu.p.onkalo@nokia.com>
CC:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] misc: adps990x: convert to OF
User-Agent: K-9 Mail for Android
In-Reply-To: <a16db5ac-2b9a-45ab-b693-2f459d689c7d@app.fastmail.com>
References: <20230731110239.107086-1-clamor95@gmail.com> <20230731110239.107086-3-clamor95@gmail.com> <a16db5ac-2b9a-45ab-b693-2f459d689c7d@app.fastmail.com>
Message-ID: <7C51AA15-DEBE-486B-9788-F84B260F8880@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



31 =D0=BB=D0=B8=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 16:18:16 GMT+03:00, Arnd =
Bergmann <arnd@arndb=2Ede> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=D0=
=BB=D0=B0):
>On Mon, Jul 31, 2023, at 13:02, Svyatoslav Ryhel wrote:
>> Add ability to use device tree bindings keeping existing setup=2E
>
>I see that there are no more in-tree users of the old
>apds990x_platform_data, so I think it would be best to completely
>remove that codepath and merge that structure into struct
>apds990x_chip, to simplify the probing and avoid the extra
>allocation=2E

Thank you very much for your review, but is it mandatory to drop pdata in =
this particular patch set? To be honest this driver needs serious upgrades =
and refactoring, and I have no dedication to invest my time into refactorin=
g it, moreover, I am not a maintainer of this driver, nor a full time kerne=
l maintainer of any kind=2E I am doing what I am doing only because one of =
my devices uses this als but it is not something crucial=2E

Best regards,
Svyatoslav R=2E

>   Arnd

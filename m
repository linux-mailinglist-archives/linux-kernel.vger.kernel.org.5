Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB41B7DA4DD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 04:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjJ1Chn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 22:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Chl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 22:37:41 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A5490
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 19:37:39 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-779f2718accso210965185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 19:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698460659; x=1699065459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZmopjVX/XnMveCj1kUkjKgN/o2U+0IT7sxlJXjVjVAw=;
        b=dk2oJXzIUjR/UFLRLjjKElpTwM2ZwNOL/2xkcCuE3ZvBq7lESnh7LdRMvgzOaHpGGj
         jXfZvKXa65Lhb7Wb656LPEE5HGveSQoIlyMf49uEZGphU/y863DvgzXJuHMEBkvgdff1
         jLDerNVQlibdLPtmmtoGVBOGapLo8sdN2swamI2ik2kKB5kWxO4LHqPvoqWqQU7aflqW
         5Cy+Z7dDvjx98RMTaIEyulGigITgaJsYODp2kmMBRDDVC7Cek0H9BeNE2YpwqtOO38eq
         Ykgiq/X0P7nmbkaIFk6HzloYbF/WSsDkfjkZNnQynMsaRo6XsiqJklHVxpFUmOhgey/a
         CXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698460659; x=1699065459;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmopjVX/XnMveCj1kUkjKgN/o2U+0IT7sxlJXjVjVAw=;
        b=CZQwHDyxNv6tR7yqYaqio8urh+0SL0nSmubdEltUz1v6XhU2iYIe+GP1YSqs8pBnrY
         yh0tq5QijBh5FHuP8V9I02AdNNzVbkYWBDDssHqyxZX3exTGlffl3zbv9WVkRLHydB6w
         Mup8Jd1VOou/wp3HPgp7ObVZptawrtMrs2oMImQYeeHolnHLhr1oqQh7hqud8FjlOg80
         +EekoGaOR+/Dl3i0TJgeyuKtTtMqXi+9sjFwFdX66LKVU0Gl3VKWv/WKTPbclbv51fM2
         qx+/IgrCv5piuK0SPkiDdSbwo34dT8Vxv4+xRbTKYcyMroHpgx6qqcT8LC5eQi96kmC9
         U5Lg==
X-Gm-Message-State: AOJu0Yyj2g5UO2wY2e4V37NGXqRiwKK+0if5wytOYqaH1Ex4Mff2oGp7
        7cOFlWS7lIQWBGdncLl7Suc=
X-Google-Smtp-Source: AGHT+IGuBfFDwAPMsAVNNZLgHnrWCCC8tdDHFKtVJ4SLTJ7Jf3niEnItXEIjYBeSM4CIZdmNToPzxg==
X-Received: by 2002:a05:620a:270c:b0:778:abb7:5cc with SMTP id b12-20020a05620a270c00b00778abb705ccmr4111001qkp.25.1698460658984;
        Fri, 27 Oct 2023 19:37:38 -0700 (PDT)
Received: from [10.0.0.218] (162-238-114-46.lightspeed.stlsmo.sbcglobal.net. [162.238.114.46])
        by smtp.gmail.com with ESMTPSA id bp43-20020a05620a45ab00b0076db1caab16sm1136392qkb.22.2023.10.27.19.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 19:37:38 -0700 (PDT)
Message-ID: <c36c2c196670a36f32cc776869e91f710c237400.camel@gmail.com>
Subject: Re: [PATCH] patch_realtek: Splitting the UX3402 into two separate
 models.
From:   pizFunk <mmpisoni@gmail.com>
To:     poseaydone@ya.ru, Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.com>, "Luke D. Jones" <luke@ljones.dev>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Andy Chi <andy.chi@canonical.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        Luka Guzenko <l.guzenko@web.de>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Oct 2023 21:37:36 -0500
In-Reply-To: <20230913053343.119798-1-poseaydone@ya.ru>
References: <20230913053343.119798-1-poseaydone@ya.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


How can I get my model number added to the patch_realtek file? It
suffers the same issue as the UX3402 and the line that needs to be
added for my model laptop is:

SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602",
ALC245_FIXUP_CS35L41_SPI_2)

Since I see you're being more specific here in splitting the model
numbers, technically my full model number is: "UX7602ZM".

Again, when I patch this locally it works for my model number, but as
of yet only the other affected ASUS laptop modedls with my issue have
found their way into the kernel.

Thanks!

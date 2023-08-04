Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F37770665
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjHDQyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHDQym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:54:42 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B3146A6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:54:41 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-4475ae93951so1028493137.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691168081; x=1691772881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54IgYWW4ZMPvtaxEboRz9NGB20nt0nl5l0+8sVW/viE=;
        b=RkYhRqCBnlpbJc3F1PcsJLhqGkhfrA75zJTFAgKcANVQv1aOAvoBh3BgwCIGCDbgxi
         jXt5qs6zRhUu+PP8A7R0OvESoKJROFJb9vH5aHiNTmMJqUYbSMT/MAgrqDrkvghaT2Vs
         WoaQA8OY/8l/hqeNs7B4G+huqW8n26EI/b3TjRqUWPHjvjPyyBxQei+f6voYCQHk9wpP
         zRuoM+JszZ4m5WXvs38VretjXIV9lBiSJ7Ai54XvxMbO0u44hlF/Gk+U86FZ4gZZmpRe
         3LAc6221tSH07bq+P2GleS79z1WQ4ASFQAJ6LzU+UA8e6Q22Gs73JsenMl5/qLSzJbIz
         qtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691168081; x=1691772881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54IgYWW4ZMPvtaxEboRz9NGB20nt0nl5l0+8sVW/viE=;
        b=gevaxEOMeRnDUctjn4/0ZdM8ZxSXNxhk1/UlfZCqHS7SMBn7RGMzdVpbny3ijkCNMt
         jnjOHVYMFweKDA/OFcfkyg1719iHZxttz5b8SFXRyR29i05g27bGUVXZVYt1jYEq1gxr
         EUm1Qu+y/0VTtPrGuxDCumq9yPRupSeK1QPVLdTlxQrDfT4NH8zqPQ7LAqBpszz8JpgU
         usaVYyIyUd3Q8Xfis6p/UU0olcs2CgVc9P4N2U7ux+vgFaJnZlJVPUCnMFc77zlT9Wwy
         VlSrgbseIh6lQhjfM07+55eK1xi7pbjtUiI+Nb1brOK+QlaBoB9Ir3CVqwrjbjavCqJR
         wTjg==
X-Gm-Message-State: AOJu0YyMmqCll2drcU0a+Iv6ShQR+rcqxj/28pGjgQ1D23NRouahss4l
        9HPGDdS3qn2/N6MZaMRLcUJwtoF9P5QrWc2edfZU4w==
X-Google-Smtp-Source: AGHT+IHKs1OgapRWNM/ErWvi+4Hrbz+MQG8ZgaBq+vxKTIFeKiht3rQXF6DXqsfPORXrYYOopdR8+sG6KMVuWIJ9N6A=
X-Received: by 2002:a67:fb99:0:b0:447:8d49:bfe9 with SMTP id
 n25-20020a67fb99000000b004478d49bfe9mr1753068vsr.24.1691168080821; Fri, 04
 Aug 2023 09:54:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Fri, 4 Aug 2023
 09:54:40 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com> <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Fri, 4 Aug 2023 12:54:40 -0400
Message-ID: <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-04, Nick Bowler <nbowler@draconx.ca> wrote:
> On 04/08/2023, Rob Herring <robh@kernel.org> wrote:
>> On Fri, Aug 4, 2023 at 9:27=E2=80=AFAM Nick Bowler <nbowler@draconx.ca> =
wrote:
>>>   commit e461bd6f43f4e568f7436a8b6bc21c4ce6914c36
>>>   Author: Robert Hancock <robert.hancock@calian.com>
>>>   Date:   Thu Jan 27 10:37:36 2022 -0600
>>>
>>>       arm64: dts: zynqmp: Added GEM reset definitions
>>>
>>> Reverting this fixes the problem on 5.18.  Reverting this fixes the
>>> problem on 6.1.  Reverting this fixes the problem on 6.4.  In all of
>>> these versions, with this change reverted, the network device appears
>>> without delay.
>>
>> With the above change, the kernel is going to be waiting for the reset
>> driver which either didn't exist or wasn't enabled in your config
>> (maybe kconfig needs to be tweaked to enable it automatically).
>
> The dts defines a reset-controller node with
>
>   compatible =3D "xlnx,zynqmp-reset"
>
> As far as I can see, this is supposed to be handled by the code in
> drivers/reset/zynqmp-reset.c driver, it is enabled by CONFIG_ARCH_ZYNQMP,
> and I have that set to "y", and it appears to be getting compiled in (tha=
t
> is, there is a drivers/reset/zynqmp-reset.o file in the build directory).

Oh, I get it, to include this driver I need to also enable:

  CONFIG_RESET_CONTROLLER=3Dy

Setting this fixes 6.4.  Perhaps CONFIG_ARCH_ZYNQMP should select it?
I guess the reset-zynqmp.o file that was in my build directory must
have been leftover garbage from a long time ago.

However, even with this option enabled, 6.5-rc4 remains broken (no
change in behaviour wrt. the network device).  I will bisect this
now.

Cheers,
  Nick

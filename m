Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21500780C54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377041AbjHRNLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377083AbjHRNKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:10:33 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98E53AB2;
        Fri, 18 Aug 2023 06:10:25 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58c92a2c52dso9116407b3.2;
        Fri, 18 Aug 2023 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692364225; x=1692969025;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mpt86wIrKIVZouUkUmVRRXcSHu/03uN8N9LZwnmAsYw=;
        b=myBM98EdvIUGWdHu8rCU6jCTB1NaSdI7OZ9pu7odvzuJe90XnT57u1q4/PtoBvxNYg
         3MaSuPu7gULfcCeeUhDxbgV7c7xJD2gVopXaO2Ga5hJBg1kG1i4EDQ7zqc4pstquey7S
         tMPnKBwe2QabvVybuaHT9Il2JSj7m2EzK+mBGDGVqhWMUK17t+2rMTrJblMrszcrSq4F
         F5XjBdM0iqqKAnIgZzOzxJq/m7S8+fJu7dZ1dk+CRy9eAuShfTDWA08xIBBGIGPLoEpW
         Cfw9SKODfyy04qV4tCgnqbZNS7TFXBfB5IfYBQG5AAw4AG3Qf6G820wxqDO36IKWrw1W
         NFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692364225; x=1692969025;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpt86wIrKIVZouUkUmVRRXcSHu/03uN8N9LZwnmAsYw=;
        b=ab/3zLWm+lI8K+75mWPPuyXRA8Ayn//DdqMLEGwkkh9wys8sYAcg4dfEU/mpFTzqpN
         hFp7BUdF0pf+3knE3XoWv5tSJxsN/kVivl8FzgqNZyTNZIOgM//Gwd947JdfX26XIwQG
         BJclFb9wGa9sc94+L485WyKfj5Ej6vWE/+GebPbPXhWDvx2AMEXURdiTvqPoV/SoeYlS
         lSCJQ73XyB0eoo1uscKZfdJC6r/GEcHf2gjesjuhs+bQE2eaond5afyvIKHW+bhFgeZj
         aRPcvWmuSM5bf7NlKPUjieGI0/WDhWucFrWBWYzOjpEUOKXR63IdGxduLDqpByK5eTmc
         MNsg==
X-Gm-Message-State: AOJu0YwjIGLJf3cv+FgZBdN3u8OA1rLXLQkHUtJ/fmxfm1hligMkX4si
        kkQCyEqL1Ys2tNbfut55v+N23yIxl/kkhn8ayV9p/LkNmQs=
X-Google-Smtp-Source: AGHT+IGzHOIifCA7g9t9UCl6aDDSlE6/kZkTlVzqd+VY78USQvsZN7frITrnrGo+iyi3Jjk3/phCUdQqj10rTFLH+Rk=
X-Received: by 2002:a25:4191:0:b0:d3b:3f67:960d with SMTP id
 o139-20020a254191000000b00d3b3f67960dmr2566384yba.41.1692364224754; Fri, 18
 Aug 2023 06:10:24 -0700 (PDT)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Fri, 18 Aug 2023 18:40:14 +0530
Message-ID: <CAHhAz+jdBS3KPCDL2WZ8UBFRhu0hZyHqs0HAdnhamswswF6iug@mail.gmail.com>
Subject: Seeking Guidance for New SPI Driver in Mainline Linux Kernel
To:     linux-spi@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Kernel Community,

I hope this email finds you well.
I am writing to seek your guidance and assistance regarding the
development of a new SPI device driver for our hardware system.
Our hardware, implemented on an FPGA, features an SPI interface that
acts as a Master, offering two distinct modes for data transmission
and reception.
This hardware is connected to the Linux system via the PCIe bus.
This hardware offers two modes for communication: using registers for
debugging purposes and utilizing DMA channels for high-bandwidth
applications. Both modes leverage the PCIe interface for data
exchange.
The hardware boasts several noteworthy features, including support for
multiple speed settings, SPI port switching, configurable sample edge
programming, and adjustable SPI transfer sizes.

As we embark on the task of developing a device driver for this SPI
interface, we intend to follow best practices and leverage existing
resources within the Mainline Linux kernel tree. To achieve this, we
plan to refer to and adapt existing SPI drivers.
We kindly request your recommendations on which existing SPI driver
within the Mainline Linux kernel tree would serve as the most suitable
reference for our endeavor. Your invaluable expertise would greatly
aid us in ensuring the success of this driver development process.
Thank you for your time and consideration. We eagerly anticipate your
guidance and insights.

Warm regards,
Sekhar

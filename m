Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F307F78F43A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347438AbjHaUlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244299AbjHaUlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:41:52 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5904C1B0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:41:49 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-64c2e2572f7so6681006d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1693514508; x=1694119308; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MGb8UE4K7J1/tZAx27Ih4ZHLsp9ZwY6jXWa1wmWSSW0=;
        b=I31qRJi90wozqH18C1R2tr4ll/MxoMmVndKe/6SW3YuG7QaNd1U4Gm8hLS+LBJXvco
         Slk/Gh2F2dQ9vTYwiAukJdQQdf0CCU41Dfr8G2wzBqLZXgsHSmaGLel8c6Ru1LHn13it
         ohjZYq3nCmBlzTzxkpD7xowQw9kM2Gte6AmjtOPkW3OtmbsmePmlXAUv/nqwgbKD142k
         5fxxiUWyB9iNWBlVijTmRSgTTK4B2UDi8I+/xVJ06CFliv4p8gZvDae8+rGOXLQZwZjD
         UdDSJLXoMigRxUAzUs2aMLJBQxcNfYet7V8KXzV+T2Gv2fqfgP5KAkvL6PsHsl73amVC
         cURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693514508; x=1694119308;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGb8UE4K7J1/tZAx27Ih4ZHLsp9ZwY6jXWa1wmWSSW0=;
        b=MV1JglSwqQyv15+0wdF8cHQMHioxgrjfNrowLpdtQcmoqF5dZH3OixSKdkqSRHZuuE
         boW3rcF18Xn9IAJncjz34ndOO6AvvlU2H4Gm3cWbmshvH4vCB1rlaruB87wrZn9vTk31
         dk8NHReoF+Q7JarFcqVBdlX0cyLyn5RVXgsjL67moklljQ0R2JQ+zY98Xr+Xh+vGKUUY
         Tq+//i+Zhf7WhrZ9Z8uoiWxIF8FmuQrVb6dtw0aXGkYZSVA/BlYEfDNW6mpd4Ec7m9BF
         NbyS2yXfnfA1v9wXQz1Yr2K4Y2PUaEHPpu961xQSLu4qfyqu568RTkc3VMeozRaV7d+1
         +A+Q==
X-Gm-Message-State: AOJu0YwWZdwIPSJUQzDLALzBc5Z78e7JSCwTf5AgUvKYcWbAI3G5Mfaq
        2gRLenJYE72aBDngs2SN1DV7nA==
X-Google-Smtp-Source: AGHT+IFU9aOd57XMHkjUfgCesvQh4jI8dOaEF345CS48c+uA4Ci+ij/CalBUYdApLt8nWIG9HHvAmA==
X-Received: by 2002:a0c:8c8e:0:b0:641:8df1:79e3 with SMTP id p14-20020a0c8c8e000000b006418df179e3mr358262qvb.29.1693514508451;
        Thu, 31 Aug 2023 13:41:48 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:bae9::7a9])
        by smtp.gmail.com with ESMTPSA id u11-20020a0c8dcb000000b0064f45b8c02bsm899553qvb.49.2023.08.31.13.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 13:41:47 -0700 (PDT)
Message-ID: <fea0cb4a94ab9ba757f32ad5539d075089dc63e7.camel@ndufresne.ca>
Subject: Re: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Takashi Iwai <tiwai@suse.de>,
        Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 31 Aug 2023 16:41:46 -0400
In-Reply-To: <87wmxk8jaq.wl-tiwai@suse.de>
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
         <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl>
         <87il9xu1ro.wl-tiwai@suse.de>
         <CAA+D8ANmBKMp_L2GS=Lp-saMQKja6L4E6No3yP-e=a5YQBD_jQ@mail.gmail.com>
         <87il9xoddo.wl-tiwai@suse.de>
         <CAA+D8AOVEpGxO0YNeS1p+Ym86k6VP-CNQB3JmbeT7mPKg0R99A@mail.gmail.com>
         <844ef9b6-d5e2-46a9-b7a5-7ee86a2e449c@sirena.org.uk>
         <CAA+D8AOnsx+7t3MrWm42waxtetL07nbKURLsh1hBx39LUDm+Zg@mail.gmail.com>
         <CAA+D8AMriHO60SD2OqQSDMmi7wm=0MkoW6faR5nyve-j2Q5AEQ@mail.gmail.com>
         <CAA+D8AN34-NVrgksRAG014PuHGUssTm0p-KR-HYGe+Pt8Yejxg@mail.gmail.com>
         <87wmxk8jaq.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeudi 24 ao=C3=BBt 2023 =C3=A0 19:03 +0200, Takashi Iwai a =C3=A9crit=C2=
=A0:
> > 3. How to handle the xrun issue. pause or resume. which are brought by =
ALSA.
>=20
> Doesn't V4L2 handle the overrun/underrun at all?=C2=A0 Also, no resume
> support?

just a 2 cents comment. All our video m2m are job based. When there is no j=
ob
available they stop and resume when there is more work in queues. As there =
is no
time constraints coming from the hardware, there is also no API to know tha=
t
there has been a period of time without anything being executed (under
utilization). Only overrun can be detected by application, each chunk of wo=
rk is
in its own v4l2_buffer and the application will run out of buffer in that c=
ase,
and will have to wait for free space in the queue. Understand though that t=
he
larger the queue, the large the latency. There is currently no way to submi=
t job
ahead of the data (unlike DRM subsystem).

I have slight impression that all this seems rather inefficient for high ra=
te /
small buffer. I'd suggest creating a dummy benchmark driver to verify that =
the
overhead isn't just too much for an audio use case.

Nicolas

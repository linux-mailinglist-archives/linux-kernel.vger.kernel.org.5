Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E627576A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjGRIfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGRIfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:35:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5121810C;
        Tue, 18 Jul 2023 01:35:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-263253063f9so3825625a91.1;
        Tue, 18 Jul 2023 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689669305; x=1692261305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eMpOX6C6FYtAsj4g5lQl10VVb5hvzXz095FozRIR5PU=;
        b=DwimSEDVkIBfU0qaTsE+yPx0nYQT1QCX0UKdyX+stGt2gKMdLu0KxOsi+hCOgdWDnC
         ejUUJCFRbmMnoaBjAJuuZmDg45yXpoguxMzhG0OFw6yICEBHdMqGTuV3i5/7AXXkmtM2
         EMJsdQLhmAM5NEMO2yjL7sAkrvao6vMvnnLE8Ub3FAjDDR65QsRnqs+puQSHxFlJnKyv
         +1kUvk7zLDLOQ/rYuKjv27id8UPUTTFj9R9L9mR2An7OBaz8hL6IgwygCvucSU9Gyd2B
         RNrosT75Xwnnyt+R1FWxBbab7NHxpIPw/MJJ9QdXZoM2aRr3f72TLZ4hm40DtvLUE2hn
         J1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669305; x=1692261305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMpOX6C6FYtAsj4g5lQl10VVb5hvzXz095FozRIR5PU=;
        b=dtUElOh2Q9WLDqOZcn3eG46GvxAv7ZNYen8mXqn+TqjDkWzdCX7NiIQOsOb+eSYiaZ
         iF37IgFxCom5dGIVUZ+217mhnsU7PLICvSEdenGaWlZc1JV9yDHVPAXZBUULkdJpZCK3
         hTeHPCdAfBVGtqSKu2cVs/V7lt2e/cQg9aWlZrm2Ssf4YrZ4lYy+FP+IFVJgrEGY2cvr
         nP/7dUy9fbj2gU+El+vRwtZnaX30XSMl0KU1XSASjYTCFoJHAGZj7t4LFE2sbDludDpl
         dhbbHwj5B/r9VVvx6BxG/zBDqtoOopER/NRwJUL+4Zf0c0v6Of+mOZTG1HLXUvtXdogK
         7P6Q==
X-Gm-Message-State: ABy/qLblYNTExoLEInC2OroAA0VY9BH+19W8osz0Uy14Qw3src7pOL2J
        Lx/ZKcmt9d8Fh0UzeZHU9kdeFAiWiYaEkzb0nps=
X-Google-Smtp-Source: APBJJlGS8gVNY6wOq3wTAu77YtV4k3kOYTmOgon0h0cxJMmNVVysd6ICAyejQni8l5u9Fm0MnNHYbqxrv1jSa3ue0i0=
X-Received: by 2002:a17:90a:72ce:b0:267:7743:9850 with SMTP id
 l14-20020a17090a72ce00b0026777439850mr939949pjk.14.1689669304776; Tue, 18 Jul
 2023 01:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <64b5dc93.170a0220.243d5.1d63@mx.google.com> <87zg3tiv08.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87zg3tiv08.fsf@minerva.mail-host-address-is-not-set>
From:   Luc Ma <onion0709@gmail.com>
Date:   Tue, 18 Jul 2023 16:34:50 +0800
Message-ID: <CAB3Z9RKV4ptbwnyG2T1LsqcAFVmBsTFOGrVS5RR9PNx7FO8OfA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: remove unintended hyphen in the sysfs path
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Tue, 18 Jul 2023 at 14:39, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Luc Ma <onion0709@gmail.com> writes:
>
> > From: Luc Ma <luc@sietium.com>
> >
> > Signed-off-by: Luc Ma <luc@sietium.com>
> > ---
>
> Even when is a trivial change I would add something as commit message, i.e:
>
> "The kernel-doc mentions /sys/kernel/dma-buf/buffers but the correct path
> is /sys/kernel/dmabuf/buffers instead. Fix the typo in the documentation".
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

thank you for the review, I'll add the above to v2

> --
> Best regards,
>
> Javier Martinez Canillas
> Core Platforms
> Red Hat
>

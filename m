Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707437AA6A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjIVBtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIVBtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:49:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6A6F1;
        Thu, 21 Sep 2023 18:48:51 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7740aa4b545so78423985a.3;
        Thu, 21 Sep 2023 18:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695347330; x=1695952130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UiIUp0HnbqjxrLPRZup0L6ii6WvuXlyjebdFnom5owg=;
        b=LSKA3XmhuLSK6NXr9w+DGISGJcSdDoevBLBc8c64uH0o1O85BxF45om9oN4glud79b
         drqjd6jEr3JeAKm+FGSRJHl3VHV1WrJWR67WeBwuAjRX7iI5uGC/q2ZgCiLJvhoPRXgy
         roSf3n7aEExRQt0mnqOr88w1ZKZH9wb4phCUKQ1AA7WbadnNsLciGXX+n333SORQ/vHh
         xLHh1F9VjXHsU2xtWSiiBrGWoeVFDcoOSy3mfHtABJ4wkclSqIp4B4EjCuURjPuaLEIG
         qDn1sy3/B8ISo0rgXWmjBokRQDri5EsXCKoIMairexqQLPd/+WTq7sZ4ziSo6hBylVCY
         rOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695347330; x=1695952130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiIUp0HnbqjxrLPRZup0L6ii6WvuXlyjebdFnom5owg=;
        b=rXcVa7gP34Kwz3jDMsBdeNL9D/9qA+kpxkupfq23wyUU46M7i1wQLShlsJNGFSBH1F
         bxp+535Cb1uTzdhV9Q6vVnyO+36hEBYJIinUgdeZ+Op/ibcnEKbf0G/K6zJmML551kDx
         D2h7BfXNxMgOF87iTmzv176abQRD104DLW0YDlS0RTp++C4oojUcM9Cw20OoSOgDc4sm
         0LULRXX0ddGSsTz2EbhGVy+mxNxWBng86eYfB6stOd3jRxhhxaJf08pJ9bFf6Oo4YRRa
         YI4ZWMj188G/M393UurVms0l2u3FVLlPOW4Im++BBG+Gj8/R3r+rlEJ+UePhrkX0gwox
         PjLA==
X-Gm-Message-State: AOJu0YwfIZ96gLaOXM6xKy6atSR/RzyJz60VPxQ4exN9/aAuiphuEuCK
        LKFubSQRn2xS0rMQO85uWlrXb7cDSEHXaoKbIWo=
X-Google-Smtp-Source: AGHT+IG9+0LFH2o1wrTGPMeXClaqq89OO92QkLkFDzzSIfk8yDNld3wIXiH7/913d38LhvdxYw/3M/3o3o9M9xCMem4=
X-Received: by 2002:a05:620a:795:b0:76d:9b15:de71 with SMTP id
 21-20020a05620a079500b0076d9b15de71mr6693484qka.31.1695347330529; Thu, 21 Sep
 2023 18:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <c6aea83bb1df563b1f2a66c5f230c3861aed1e15.1695189879.git.wangchen20@iscas.ac.cn>
 <20230920-arrival-bonanza-e335686420f4@wendy>
In-Reply-To: <20230920-arrival-bonanza-e335686420f4@wendy>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Fri, 22 Sep 2023 09:48:39 +0800
Message-ID: <CAHAQgRASRhpDBj3jNBkj+faJGjc5Ms_jX+hcurnrUKFO9Tn3Xg@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] dt-bindings: riscv: add sophgo sg2042 bindings
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
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

Regards,

unicornx


> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 90f13281d297..b74d505003e2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20063,6 +20063,13 @@ F:   drivers/char/sonypi.c
> >  F:   drivers/platform/x86/sony-laptop.c
> >  F:   include/linux/sony-laptop.h
> >
> > +SOPHGO DEVICETREES
> > +M:   Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > +M:   Chao Wei <chao.wei@sophgo.com>
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/riscv/sophgo.yaml
>
> > +F:   arch/riscv/boot/dts/sophgo/
>
> Firstly, this directory does not exist at the time of this patch, so it
> should not be added here, but rather at the time that you create it.
>
> Secondly, are Xiaoguang Xing and Chao Wei going to monitor the lists &
> apply patches for these files? If so, you should add a git tree here
> that they will apply patches to & add to linux-next. Also, I'd really

Conor, FYI, regarding "add a git tree here that they will apply
patches to & add to linux-next.", I will not add in this patchset. I
plan to add this when we start to take the maintainece work. Let me
know if any questions.

> like to see some on-list signs of life from these people, otherwise
> I'd rather see your name here instead of theirs.
>
> If they don't intend reviewing/testing/applying patches, I can do it as
> a last resort but I would rather that someone who specifically cares for
> this hardware does it.
>
> Thanks,
> Conor.
>
> > +
> >  SOUND
> >  M:   Jaroslav Kysela <perex@perex.cz>
> >  M:   Takashi Iwai <tiwai@suse.com>
> > --
> > 2.25.1
> >

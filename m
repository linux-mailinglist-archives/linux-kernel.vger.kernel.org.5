Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3487CA199
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjJPI3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjJPI3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:29:36 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF42BA1;
        Mon, 16 Oct 2023 01:29:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b44befac59so1800890b3a.0;
        Mon, 16 Oct 2023 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697444974; x=1698049774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7tExwy9wC+leaGeeXkXVx7UiSNa6xLiULiPqzxIdmkE=;
        b=WYQIGrW9Zm+bv3oH8LoDLlL5Hl2Yt/pdpe5SOuT5cY0L/XgYCytDOVPILV6HshoDTJ
         FMOhzNEsuo4XBTywk1yiZDN0+qeZCD1DgOj31XXmct6Pfn7rpwQdY8fMorzCiMP4sQns
         sxHfckdipn9qLDGP1LPA3eVE+2lx8iJ+PsqUYoDqZ3vAkeDInd0yKTG17X1pbDjBwI5G
         XsOYVd6mX1+06t2C/tSSRyZC3MtjH8zVRgz7V0MktIjFYYMcNJ6WOBYXwWgEa41dENrk
         fhjfN1y5fw5c6oFDNMxQx0tpeQSaSMMH51b3j3HC7cUujyC0V9LQ3tVgal4ckbalv7kK
         Yt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697444974; x=1698049774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tExwy9wC+leaGeeXkXVx7UiSNa6xLiULiPqzxIdmkE=;
        b=XIoiR6djLbhe3sEu1mw9bcJ89mx7BEywig5Q45p3LYHPvBi4+fWj3tJ9keitdG1Y6Q
         GYV63/S8PgL2dgS+Dxp6pfg2YF8e4GGQrYJTVz8u9A0CyEglCi/KW9dMpxaadUwB0GOG
         qzCVFOPHQEl9lXcHRBPtvd/+S/hopUrbfEt9ICojN97KhloxUXZ0+lRmpxQ3qRE1Tkdz
         jRZd5x9yfcD6PIASdfRimLkc88v8h2wIlKC4iUx4kjmEk4FT+YNMjoBC2TKAXqHPtVM0
         Y47ZT57+9ebAWO5jsmqQbGIhIdXlKMvHmJrzGg0D6oWNGyCgZhY4yC6SlNSw0hKdQ/5n
         NwnQ==
X-Gm-Message-State: AOJu0Yyys+u0MwhXfAepq5wX9ApNoIL/4oGfPvs//jJZ1oV/tSi2EZbD
        gEIUwEg+3DfAEzJpfljiloRsdZ+gJyn2CbsvHGQ=
X-Google-Smtp-Source: AGHT+IG1LBb+Z83oZC08+j/rLz2EBviZp+rtUvi8Bi3IO2o5JBF8AqAcVmEs9XS9c4Ph2A92/2xPC5zxhtgDMGNSE3s=
X-Received: by 2002:a05:6a20:8f04:b0:155:1710:664a with SMTP id
 b4-20020a056a208f0400b001551710664amr9214784pzk.18.1697444974254; Mon, 16 Oct
 2023 01:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231013172033.3549476-1-robimarko@gmail.com> <20231016033202.i54nequofzea6mfd@vireshk-i7>
 <20231016082239.2onlrqp4bpcgxhbt@vireshk-i7>
In-Reply-To: <20231016082239.2onlrqp4bpcgxhbt@vireshk-i7>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 16 Oct 2023 10:29:23 +0200
Message-ID: <CAOX2RU5paPXyG-1Fbp+T9+Aycwno9DQ8ugMwUr_8iNhhc3HiHA@mail.gmail.com>
Subject: Re: [PATCH v6] cpufreq: qcom-nvmem: add support for IPQ8074
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ilia.lin@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
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

On Mon, 16 Oct 2023 at 10:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 16-10-23, 09:02, Viresh Kumar wrote:
> > On 13-10-23, 19:20, Robert Marko wrote:
> > > IPQ8074 comes in 3 families:
> > > * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> > > * IPQ8172/IPQ8173/IPQ8174 (Oak) up to 1.4GHz
> > > * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
> > >
> > > So, in order to be able to share one OPP table lets add support for IPQ8074
> > > family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
> > >
> > > IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
> > > will get created by NVMEM CPUFreq driver.
> > >
> > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > ---
> > > Changes in v6:
> > > * Split IPQ8074 from the IPQ8064 as IPQ8064 has additional dependencies.
> >
> > Applied. Thanks.
>
> And it failed to build, please fix it. Dropped from my tree now.

I am looking at the error and it should not happen as the ID-s have
been in linux-next for a month now:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/dt-bindings/arm/qcom,ids.h?h=next-20231016&id=b8c889bef9797a58b8b5aad23875cc4d04b3efd3

They are also part of Bjorns 6.7 driver PR:
https://lore.kernel.org/all/20231015204014.855672-1-andersson@kernel.org/T/

Regards,
Robert

>
> --
> viresh

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B877B10B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjI1CXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1CXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:23:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1F8AC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 19:23:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso11188862b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 19:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695867785; x=1696472585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+hj9qTuqnRQSSGkNOb4G4fEHCna/WgDEkDLNYGThRQ=;
        b=PwJP7uUnKYzg2ruY5E3msjNSZ/RqDGy+wk8dYLmxZTCTaaeugzD/eFkxLsaBd2pzh2
         CX5pAIgFBxMTnbhyDNiKKS30KGo0n/zutWTqgqxZq6w37FmQw8NQB2n4VmpvZMKQr0UC
         M1Y9zqAyiZjdzaqms0GOW8ec2rJ0HyNuijid/AyusbwiTiCRegzuBO/eGMgmePkDJV5a
         YHlljAeX/4cUqesWW06qsPLyAVHgbLpIqDOknmRMfLeiAwSpR3rbjA4uNlt3yZWWvkcj
         qIU3e0wrlhaJDzRtKAstUV3I5NsZ7m8ROX/FSDZi/6jeYyXdhUdvv3kh7ESgIP87v0DN
         hm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695867785; x=1696472585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+hj9qTuqnRQSSGkNOb4G4fEHCna/WgDEkDLNYGThRQ=;
        b=Bd6XObaOkG7iwej0qihK7TjC8q8nr/PyqyRPAwOA+eVwNM1dw8IX58eMFn27rc/+Dq
         66OAzce7mSgCqPedQSdS3b0ol+iDR6KwixFkkGVdD4m3yk2uMMkc5HSQhcHMDSH5371E
         eyV4JOsoPSauskU4l/ppnBk508NuKix1blVFrPzIBDmh4vcge9+KD013eEjSH2TGN24X
         kiNzSKOqGIOZQTGMZ9Sy7qEVL6eo7qx+V8PaIZ7qidGo5SvGuDyem7aBH4119d5YrBPF
         B+aMP6N0YEkJadVkPx/tV096IrVZin/zQP08X/92yxzj1ScrCL9QmGcWxVjga8Fx+prB
         YAaQ==
X-Gm-Message-State: AOJu0YwuFXmXgQDpqNLd6a6dFsnzzHrpyim0q6jvv2MLF/4ELGWZVNTO
        uBq8rz7daol/0hsuO7CtbzaXDfxjoPozL83K
X-Google-Smtp-Source: AGHT+IER8d0CJodywHfEgFp8sjl/pdhLJ5fmd/xBdsdOyRnU4ywkWVNs0vuNHFuEeXnw4kKl/nNNjA==
X-Received: by 2002:a05:6a00:10c6:b0:692:b429:390 with SMTP id d6-20020a056a0010c600b00692b4290390mr3943040pfu.29.1695867784603;
        Wed, 27 Sep 2023 19:23:04 -0700 (PDT)
Received: from MacBook-Pro-3.local ([111.108.111.133])
        by smtp.gmail.com with ESMTPSA id y15-20020a63ad4f000000b00578bb0066b6sm1260222pgo.71.2023.09.27.19.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 19:23:03 -0700 (PDT)
Date:   Thu, 28 Sep 2023 10:22:57 +0800
From:   Wei Gong <gongwei833x@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2] genirq: avoid long loops in handle_edge_irq
Message-ID: <ZRTjgdptO5jswGwC@MacBook-Pro-3.local>
References: <20230925025154.37959-1-gongwei833x@gmail.com>
 <87msx9f7a2.ffs@tglx>
 <ZRPfjC9JEeUx8zKY@MacBook-Pro-3.local>
 <87edijfxjv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edijfxjv.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 05:25:24PM +0200, Thomas Gleixner wrote:
> On Wed, Sep 27 2023 at 15:53, Wei Gong wrote:
> > O Tue, Sep 26, 2023 at 02:28:21PM +0200, Thomas Gleixner wrote:
> >> On Mon, Sep 25 2023 at 10:51, Wei Gong wrote:
> >> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> >> > index dc94e0bf2c94..6da455e1a692 100644
> >> > --- a/kernel/irq/chip.c
> >> > +++ b/kernel/irq/chip.c
> >> > @@ -831,7 +831,8 @@ void handle_edge_irq(struct irq_desc *desc)
> >> >  		handle_irq_event(desc);
> >> >  
> >> >  	} while ((desc->istate & IRQS_PENDING) &&
> >> > -		 !irqd_irq_disabled(&desc->irq_data));
> >> > +		 !irqd_irq_disabled(&desc->irq_data) &&
> >> > +		 cpumask_test_cpu(smp_processor_id(), irq_data_get_affinity_mask(&desc->irq_data)));
> >> 
> >> Assume affinty mask has CPU0 and CPU1 set and the loop is on CPU0, but
> >> the effective affinity is on CPU1 then how is this going to move the
> >> interrupt?

Can replacing irq_data_get_affinity_mask with irq_data_get_effective_affinity_mask
solve this issue?

> >
> > Loop is on the CPU0 means that the previous effective affinity was on CPU0.
> > When the previous effective affinity is a subset of the new affinity mask,
> > the effective affinity will not be updated.
> 
> That's an implementation detail of a particular interrupt chip driver,
> but not a general guaranteed behaviour.
> 

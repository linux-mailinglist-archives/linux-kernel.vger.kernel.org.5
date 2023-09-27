Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008E67AFD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjI0HyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjI0Hx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:53:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20017B3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:53:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690d2e13074so8234073b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695801235; x=1696406035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZRLdQK6qazaNPinO6LXmi+nSYV9tWOvmb55YOjLV7M=;
        b=k7iJm8D5SvRa5qnyWPoQgETTzfI4hV+IsIjs/p6OPx5vm95jQE/Q95u6xjIkSahp2I
         hXMA4IwFUFxxX2xGPPRlo71qGkP1aUECg67VmuzNCu7PHAw/Af6/Epn6zpcwoIaBM5TP
         INMPlW9aH5gMR32bSUubSMPWmirHV2RU8OP+k7T5SnL+LjuqrH9Fdmo3dEtuUf5Gw6Zq
         swn8OQfOPcVMZHDHNK98BTFpskTGYCYDajz81fUFIcCURYxzxdsR+dX7I3A1/vq38ktP
         NW2ZljKnvWheHtHBKw+9aK53pG8stnQhGF+J8051g7A8SVARihWi8AcrA7Btmojz1K2R
         MF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695801235; x=1696406035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZRLdQK6qazaNPinO6LXmi+nSYV9tWOvmb55YOjLV7M=;
        b=Fxde2Un8BtvhAVZXdRN1Lanm27WpnLtSEM6xLgzPAVpDifUiDN9wA5/dTwNAAtFoj0
         VFt62lS/h5DMjsw+caC8yx43ctCg4Yq3C/RnvXSogpAmEi7X7jsMGW2FGng05Zi36AJn
         v6rnUWp9ncWjn7dCiDVCYzBImcoYL03fLfX5dGBgJfymMDF8VhDgYjaQuQkV6Z8YeX6/
         x/puEuUGlZbWSkpQzejKSMtKBuWp2yxuVtE2a1MTFrlQceq2t8ZJNGwZn8jsEbYisIxh
         mACgUTT5FduI2b/1BHiAK1GhSKvRjWfWPh8c1DXvmY9KYflkMZTMmjHq1h5QPji6h66c
         a1SQ==
X-Gm-Message-State: AOJu0YzINdi/DYo1kddUbFI5HVmHeE3Enu8gmZuWxK+L61QAbf1IUKoG
        hRMuc47d2jD1lFmZdVF/qillUzl8XOubDQ==
X-Google-Smtp-Source: AGHT+IHr6eFKs/AO0Ddxyn9/4Oja39vaK4Tw1wLw8/3X0LbG4y1Wfeb5BDmeQZRFfigM/UvmwtH4kw==
X-Received: by 2002:a05:6a00:22d0:b0:690:1720:aa9a with SMTP id f16-20020a056a0022d000b006901720aa9amr1519384pfj.15.1695801235536;
        Wed, 27 Sep 2023 00:53:55 -0700 (PDT)
Received: from MacBook-Pro-3.local ([111.108.111.133])
        by smtp.gmail.com with ESMTPSA id s4-20020a056a00178400b00692b6fe1c7asm8653302pfg.179.2023.09.27.00.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 00:53:54 -0700 (PDT)
Date:   Wed, 27 Sep 2023 15:53:48 +0800
From:   Wei Gong <gongwei833x@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, gongwei833x@gmail.com
Subject: Re: [PATCH v2] genirq: avoid long loops in handle_edge_irq
Message-ID: <ZRPfjC9JEeUx8zKY@MacBook-Pro-3.local>
References: <20230925025154.37959-1-gongwei833x@gmail.com>
 <87msx9f7a2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msx9f7a2.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O Tue, Sep 26, 2023 at 02:28:21PM +0200, Thomas Gleixner wrote:
> On Mon, Sep 25 2023 at 10:51, Wei Gong wrote:
> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> > index dc94e0bf2c94..6da455e1a692 100644
> > --- a/kernel/irq/chip.c
> > +++ b/kernel/irq/chip.c
> > @@ -831,7 +831,8 @@ void handle_edge_irq(struct irq_desc *desc)
> >  		handle_irq_event(desc);
> >  
> >  	} while ((desc->istate & IRQS_PENDING) &&
> > -		 !irqd_irq_disabled(&desc->irq_data));
> > +		 !irqd_irq_disabled(&desc->irq_data) &&
> > +		 cpumask_test_cpu(smp_processor_id(), irq_data_get_affinity_mask(&desc->irq_data)));
> 
> Assume affinty mask has CPU0 and CPU1 set and the loop is on CPU0, but
> the effective affinity is on CPU1 then how is this going to move the
> interrupt?

Loop is on the CPU0 means that the previous effective affinity was on CPU0.
When the previous effective affinity is a subset of the new affinity mask,
the effective affinity will not be updated.
Therefore, I understand that the scenario you mentioned will not occur?

> 
> Thanks,
> 
>         tglx


Thanks,

Wei Gong

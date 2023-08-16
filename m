Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A32477DA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbjHPG3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242189AbjHPG3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:29:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965561FE6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:29:04 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-687ca37628eso5871915b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692167344; x=1692772144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/d+a+jmbHHXQIy1O4h/TrwUyediDeflM5J1gxycWe4=;
        b=bDQp7Xc8BerDlBHrdX+UJx91CzYphcHSg8BRRrhCao349U2swHK+DX4jRJnNO56il5
         9Vgx91zulM+Dfvt+QTd2Z3gEKEC1Dbe+tAQ564janlWKiinRElShOgS95i42PepmbUIy
         WY252H2RgJzSEjSi+Rjzg8u1sl3LEHQ1WcCbd/mCJ+AZCM0fsvp0RlIUg2wAGjbtsio+
         g83FMo46jTadq0qtDTjd2Wdz6hioj1HpvtRKY6AJZ7ho3MgrE2UcOk3RJAkkSBi5/18A
         KWdLYbvIuvcUll7/dkWvFKGLNfgZBHz75hJTdLZvs67PMfb/NPTnHH66xYpy2WP3pBAc
         Q4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692167344; x=1692772144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/d+a+jmbHHXQIy1O4h/TrwUyediDeflM5J1gxycWe4=;
        b=ANCxWiOeK/d+DeXrLlZ4Xg/pM9EzRbbDlo+jYe9nJE0lDT2eOIl/9M+gJil8MMJfF8
         YYWARuiaQkE83PObH9VrH09b1pZmqxLU+BRnk2CYk4zy3u8hQbLrWURZnnu60wcl7u/1
         ORGMl34bFub4hNQeMrMEOg2DhhLeZjeKi7W689HoS83x1ZpnXLEFnZcxTdy6IfRFVFn+
         V+1S+/EAlnDggQBIJFJHDe2wc/R/jartHya0HRzZtF24UyBWicsM6Pb7RvjefrecXzrO
         1fVhpukcz+1fLqtoaIm+dta8r/jpyu/Rs5aseD8dCfEmkp9IGoqvm6VZcx+Gj9mHTh/5
         h06Q==
X-Gm-Message-State: AOJu0Yyt7lLrVSNCmxrI7osNvaQHkt6MK0N1hQdzk25Mnxg6Dg85l8s+
        XDBVo2IMu749rEAZcB9AzOpNsQ==
X-Google-Smtp-Source: AGHT+IGv9NNha9nyyZ7UHMl67x37JKLaJ76BxEG6CMLPFU+FcqmItbkoPsoYbxcEreJmf873wu5aXw==
X-Received: by 2002:a05:6a20:4310:b0:131:c760:2a0b with SMTP id h16-20020a056a20431000b00131c7602a0bmr1666192pzk.52.1692167344016;
        Tue, 15 Aug 2023 23:29:04 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id z24-20020aa785d8000000b0068844ee18dfsm2349640pfn.83.2023.08.15.23.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 23:29:03 -0700 (PDT)
Date:   Wed, 16 Aug 2023 11:59:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] xen: privcmd: Add support for irqfd
Message-ID: <20230816062901.dkpzhhimnjf35jqy@vireshk-i7>
References: <d783b8689395e60d0c314f9dad476443ca7773cf.1690282439.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d783b8689395e60d0c314f9dad476443ca7773cf.1690282439.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-23, 16:27, Viresh Kumar wrote:
> Xen provides support for injecting interrupts to the guests via the
> HYPERVISOR_dm_op() hypercall. The same is used by the Virtio based
> device backend implementations, in an inefficient manner currently.
> 
> Generally, the Virtio backends are implemented to work with the Eventfd
> based mechanism. In order to make such backends work with Xen, another
> software layer needs to poll the Eventfds and raise an interrupt to the
> guest using the Xen based mechanism. This results in an extra context
> switch.
> 
> This is not a new problem in Linux though. It is present with other
> hypervisors like KVM, etc. as well. The generic solution implemented in
> the kernel for them is to provide an IOCTL call to pass the interrupt
> details and eventfd, which lets the kernel take care of polling the
> eventfd and raising of the interrupt, instead of handling this in user
> space (which involves an extra context switch).
> 
> This patch adds support to inject a specific interrupt to guest using
> the eventfd mechanism, by preventing the extra context switch.
> 
> Inspired by existing implementations for KVM, etc..
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3->V4
> - Drop the imported definitions to hvm/dm_op.h.
> - Make the caller pass a pointer to pre-filled "struct xen_dm_op" instance and
>   get rid of irq and level fields.
> - Enable the irqfd feature under a new Kconfig entry.

Ping.

-- 
viresh

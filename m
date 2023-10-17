Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949A77CC5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344075AbjJQOXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbjJQOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:23:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E93FA2;
        Tue, 17 Oct 2023 07:23:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-565334377d0so4287371a12.2;
        Tue, 17 Oct 2023 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697552599; x=1698157399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8x4u3Tgqxm/wT15hbhSA2dGVONGLw0lsKJBjy2cxi4=;
        b=U3Ub1etcxD6FxMXmVQF4wuWsnHpQwqcJ4EryaHbuMkmTuV5/O8E76cYMm2yA+i99Sp
         3lVwxO0GKAxHk8c2Dz0Prsdxqjmx9OkMPEiyUptnGGMOq2tFe9Z9jUVcKQIw1CMs1VRZ
         Y0n/72ipfPJ1zL9/9PV197Xm2lZJ8Smu0gqk5IS1fvKoWB9ZEYFqwVjkdCopbSaa0qfd
         HRYWDPMDKdgXOZitgfREJMYVfuRFW/dYto3HeZR1VeT8COWQuhG6l0GrcYSTaYVO+50h
         LX5TAL4aLLJw8tYd6TWp/AxwR12FSxSZlmIiukChsvfUgqgE3MtQslxEcaNYPgS5F479
         V6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697552599; x=1698157399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8x4u3Tgqxm/wT15hbhSA2dGVONGLw0lsKJBjy2cxi4=;
        b=eao8HGgB8fCPBR3MSpgSnfP/WMhZaubUL8kt3E/iErpuEzRGC32bBrS1bzRIxAfljq
         qvjHahp6yWrfO4dgmTtS2xOjlODFNhbuZGnKlCdc9o3BiDLcbmivpKcyBawRYdM/cdVp
         9irdXSIGCO9mMTY8HNDlNHwWZHs5znipaE4HMBspyOUIKTvKdvWxsKH6aImxoSg8fv8E
         qwBMLiGxo0PZUN1yjM/xPHGvjN9qahFUMJSOi2KD7Lz+Qt06D/0FsjY/so1GONB8HbgL
         8zf19yQ3BIUIwPb1A0MKlYLv7zSyrM9KPrY45oUgV+7k3TICwK7lm4D9PtmHnI7eHYxD
         hEGQ==
X-Gm-Message-State: AOJu0Yxxr/zYF5upd9prukOsw66S1g4eG16WYEUm0sMh80g2fxS5oRtb
        RYcyQq1bzgINF8w36WNovgM=
X-Google-Smtp-Source: AGHT+IGQ9rbPOMmVl+v2/m2m1wjMd3AyNTDDOmysGd0xpq/VkIt4k5dwSI61dpmOkHe71FK+0u4lpw==
X-Received: by 2002:a17:903:1cf:b0:1c9:d46e:d52d with SMTP id e15-20020a17090301cf00b001c9d46ed52dmr2487529plh.64.1697552598729;
        Tue, 17 Oct 2023 07:23:18 -0700 (PDT)
Received: from ubuntu ([223.226.54.200])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001c1f4edfb9csm1606814plb.173.2023.10.17.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:23:18 -0700 (PDT)
Date:   Tue, 17 Oct 2023 07:23:13 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH] staging: qlge: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <20231017142313.GC3156@ubuntu>
References: <20231015133558.GA5489@ubuntu>
 <20231017091814.GS1751252@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017091814.GS1751252@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:18:14AM +0200, Simon Horman wrote:
> On Sun, Oct 15, 2023 at 06:35:58AM -0700, Nandha Kumar Singaram wrote:
> > Adhere to linux coding style. Reported by checkpatch.pl:
> > CHECK: Prefer using the BIT macro
> > 
> > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> 
> Hi Nandha,
> 
> I am assuming that checkpatch clean ups are acceptable, perhaps
> even desired, in staging. So this patch seems appropriate to me.
> 
> I do, however, see a lot more potential uses of BIT() in qlge.h.
> Could you take a second look?
> 
> ...

Hi Simon,

I will look into it and update the patch

Thanks,
Nandha Kumar Singaram

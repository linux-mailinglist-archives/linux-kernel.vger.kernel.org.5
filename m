Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258A77D93B4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbjJ0JbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjJ0JbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:31:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7BFD6;
        Fri, 27 Oct 2023 02:31:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9cf83c044b7so183694966b.1;
        Fri, 27 Oct 2023 02:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698399072; x=1699003872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4F8FZ57kpr13z/xUt6ki2x46rIiQW8y2N6vuceQyfU=;
        b=OvsQvj73ugsiHHWXd1yzUS4H7vbC42hTDLkzk4hdOt+s9kLlGA5AsOn4oekGhx7iXq
         PZdh4+AS5fvcxbvNJBSri/yJVV91CEfka+R3AFff3D6PMyzoJ2IM5ljGyqf1MnAMp3Oi
         86jotOUrLYosvOsbdZcCfDHzMg+8UC90Q9NPMCcFvqvLqMXrmMVj/7o5/DJ8uZGs4us3
         XvlHLyI8rx+aR/+gkMW4+YlCF8/w/BjTQ5wcs2BTqoOslbXMLw8yEhDx8tyT1ho8lrfm
         oKSFJBz8HKBwvJXhoyQxeTovrE8BFTedmeyxDIxAjTwAfG/+MFHFycwF3NgmRwIXy443
         89ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399072; x=1699003872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4F8FZ57kpr13z/xUt6ki2x46rIiQW8y2N6vuceQyfU=;
        b=Xfk6XBtvD4NtegOjJi9E2Mbp6mHepaEmdkqMpyYzE8UgMmk/yPd2zHLJBSf0sfIzy7
         utvQyJzmsuGxykFWZ11XuPCjLOpDK2P3YvppwqiNpAYyZNKeOlHb563E9zowHUJwPcq2
         MXSKr49Hw4TL1jtQKwCnHXGOW8ZvLotLIEsab3tNKouRxrU4Mn/HxRDDdegy86XpN9jH
         ++i+Yblh8BdTQP+BiDWmU4gzz4Rytqv3ghOOWn/2sqjq/xYmGRzAuBQ9j0wjuaOoNX9g
         UeKl+RHmdCPyLv9lT70I366l72vWaLOU59230TsLlBKLVnC3NEfX0HbYmozE/VJavIWS
         sCIg==
X-Gm-Message-State: AOJu0YwElSH7TFJurmibPUyaaHuyRicL653yECnFvQslAB6pnomdnD4J
        EYtpGDMXQy562jfHYDYXr4I=
X-Google-Smtp-Source: AGHT+IEq90WuJ/Nx+toJPSBjsozZ5oAnVq7Mga1dbu0u4J9xw/FfBUz5Aih0KpYN8Q3HBum3dpWhmQ==
X-Received: by 2002:a17:907:36c9:b0:9c7:187a:c60f with SMTP id bj9-20020a17090736c900b009c7187ac60fmr1683229ejc.38.1698399071840;
        Fri, 27 Oct 2023 02:31:11 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id fd10-20020a056402388a00b0053e5a1bf77dsm928729edb.88.2023.10.27.02.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:31:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 27 Oct 2023 11:31:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com,
        suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v4 1/7] topology: add a new arch_scale_freq_reference
Message-ID: <ZTuDW8lXZLQP1Ruq@gmail.com>
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027080400.56703-2-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
>  
>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
>  
> +DECLARE_PER_CPU(unsigned long, capacity_ref_freq);
> +
> +static inline unsigned long topology_get_freq_ref(int cpu)
> +{
> +	return per_cpu(capacity_ref_freq, cpu);
> +}
> +
>  DECLARE_PER_CPU(unsigned long, arch_freq_scale);

So mind naming it in a way that expresses that this is indeed a maximum 
frequency? arch_scale_ref_freq_max or so?

Also, is there any particular concept behind naming one new symbol 
'freq_ref', the other 'ref_freq'? If not then please standardize on one 
variant.

Thanks,

	Ingo

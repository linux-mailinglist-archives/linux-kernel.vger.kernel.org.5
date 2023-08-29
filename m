Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DFF78BEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjH2HKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjH2HK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:10:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0B11A2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:10:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf6ea270b2so24473855ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693293025; x=1693897825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C53HtJ4DBXLp5KOrDxIzDofJkGbHCKgUwuQc6lINrPY=;
        b=c2LIbqdddC/y2boPhFLZSexkGaPMRzHa8WBhpPU/dW/a1f+8kRJLcS5xeC9Dz1Xt0i
         kVQI60RWq3RglgpsDAdIOVu/qtFEGCiXv1k1tA9zZ+vMW7HMsyOb2ucU0qFSVXsf5yqs
         HvQctBh4rFsG4XqD29Qi/93xA9En5ppiUAWnoF027+qsXQpMg6LHoBv+mrrB0TLl8Gvu
         6UV4wXKad8NkX8mcsag2nTs0P3L8RQPBXcStzhAhJA0cDbkqJnzAYWxSDHHpLYNptwxe
         Q84WBFj+ut/8CPX+ez4ka/+f+Hyw6GMD4E20P/C0vtNAg1rBXfxhKZ0y4DYfJEE70QlZ
         sOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693293025; x=1693897825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C53HtJ4DBXLp5KOrDxIzDofJkGbHCKgUwuQc6lINrPY=;
        b=KSUqL/jXVAFdLMQs6cVpwn+618u5efahEknb5OtahDpBCtlRkBwAP6ByUcIU0QceF6
         2nyeqBTy0enkcdS+L6ftHnteLQHgvkOMpAC9GIOX1gjG1JAm4HQC85ZyuTe+E3aidIcV
         WPapzxToG/L4SzEA6oLxSlxaF58kYvB/vqGrNP8fBkBIPLuAmNenTl8dZxIcxEZHsA0p
         KjYMolucdG01nCCyjFLxTGjcBWZBrazgKYQAyvm5g4J6kP4/aAOO/WxG/MIawdak/3aP
         zKXf5ybaMq+dEUhoCElWc4o97PkjHoYZsY2qfn3WFc4dDIFpUIAAFbii/HTsq/QTSI0t
         +98g==
X-Gm-Message-State: AOJu0Yw/oGV3MypWtntjDQ/4t05ouWiLq/pK8hH9Rl0qdSWFa4rPz7FN
        KFPTLXNCkX+nAUqz/g8PxdD9Aw==
X-Google-Smtp-Source: AGHT+IHbCUZX7SB7d9rJn3PhB9G08weUn078u6BH0+hYz6BRc/zp44JVfzvbFSI9yBYXEOv8nDZEbg==
X-Received: by 2002:a17:902:f7ca:b0:1c0:cf84:c9d2 with SMTP id h10-20020a170902f7ca00b001c0cf84c9d2mr8913767plw.8.1693293024989;
        Tue, 29 Aug 2023 00:10:24 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902e54100b001bf095dfb79sm8578085plf.235.2023.08.29.00.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 00:10:24 -0700 (PDT)
Date:   Tue, 29 Aug 2023 12:40:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chun-Jen Tseng =?utf-8?B?KOabvuS/iuS7gSk=?= 
        <Chun-Jen.Tseng@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sumitg@nvidia.com" <sumitg@nvidia.com>,
        "sanjayc@nvidia.com" <sanjayc@nvidia.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] cpufreq: mediatek: change transition delay for MT8186
Message-ID: <20230829071022.n7wubb2dhbt3ukyk@vireshk-i7>
References: <20230818020616.4748-1-chun-jen.tseng@mediatek.com>
 <20230828063904.r7huxclehlblkkjx@vireshk-i7>
 <86f49ce84f32941185c961da8a5c671e7aed46b1.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86f49ce84f32941185c961da8a5c671e7aed46b1.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-08-23, 06:57, Chun-Jen Tseng (曾俊仁) wrote:
> For MT8186 set freq must Big CPU -> Little CPU -> CCI like this order
> and it 
> takes 10 ms.
> 
> But in cpufreq & devfreq flow , when Big CPU or Little CPU change freq
> , it will call
> CCI setting by different policy. It will become Big CPU -> CCI setting
> or Little CPU ->
> CCI setting. Howevery, It will cause CCI setting to wrong value when
> per 1ms call governor
> and change freq.
 
> this patch (44295af5019f) , fixed cpufreq_out_of_sync() condition from
> 1000 Mhz to 1 Mhz.
> So, when cpufreq_verify_current_freq() call clk_get_rate() over 1 Mhz,
> it must to do freq sync
> by cpufreq_out_of_sync(). In MT8186, it offen over 1 Mhz when call
> clk_get_rate(), so I modify
> transition delay from 1 ms to 10 ms for make sure freq setting done. 
 
> In MT8186, if CCI freq is lower than Bit CPU freq 70%, it will causes
> kernel panic
> on Big CPU.

Okay, I get it now. First of all, the kernel shouldn't crash because
of a simple delay anywhere, like the latency delay here. If that is
happening it means something else is wrong somewhere else.

From what I understand now, your CCI have a constraint compared to the
frequency of the BIG CPU (and little CPU too). You need something else
that guarantees that the CCI is always configured in the right range.
Perhaps a devfreq governor or something else that takes care of this.
It shall evaluate the next state based on both big and little CPU
frequencies and not only the caller via which we reached CCI. Please
see how others have solved this.

I am very sure this is working by chance here and will break with some
other delay somewhere else. Fix the real cause of it.

-- 
viresh

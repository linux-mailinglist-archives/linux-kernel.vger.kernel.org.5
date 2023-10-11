Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78537C496A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjJKFtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjJKFtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:49:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A2E8E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:49:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-694ed84c981so4972851b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697003342; x=1697608142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3/xooCfzn+HEb84CSy8n1NiyDH9US0NidBeh+kHVYE=;
        b=DENHURHFEXIX2Casi1G4byCfgdWPbRWZ3fdZYmZbR/8y7e7K60CN4HF7DxokoU7PGz
         IQVwrSqYcd88epKDNfBsi0VP8dH8a7bbWOWuqCQqkU+woXUDNak5J1hEsePjzZNpk9iD
         TbNzpmdlRUqrwZC2BlhSiVOBPWMP0gexI4rnIIE+VIjRExMCHBH/C8LCzvSXvLrOBdXe
         1uE3Xg55EfqlMmMktQRFhx+wp3Fd+QDNRKyovrf40gh04QLaZdnuiELfVQnZ5mgFsZa9
         8tnc/nUfsrXf+ft+MgOheEmBzINuVDKju5Ql5cx9eEYxoBKBXCFHcQJFXiQVjpghcrCq
         +g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003342; x=1697608142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3/xooCfzn+HEb84CSy8n1NiyDH9US0NidBeh+kHVYE=;
        b=tQvaa/rEA1aKX2xfa8lpFyGflkLOPRQNeBYfmJFNJp7nbNbPMzZ3RGcyD6z0m7O+Lt
         5Qga9knljmhTAbU34BQo7oHUPBCZ0HSutXoyAwzVEL6mLPbfoRH0b1/gAKf1kwVDsRLf
         9Nh/n2B1yZjzZbLd6nZmH/bZTQELjVvwNNPYj8+5817f5t1JGLE8OZaFunme5BzfQuKz
         xiCIQSVvk/OFF92sDfBREuS8Nv0UcVwJnXjaTY5g5xwH2VA+nZVvb9BRvo7ZggxQOQ8t
         +x2Uv7O5dQnEivlrWpLG7pelOW7uxMAfAemOIL/oFF/jyQealhUoB6ohu70fvnZgeMdJ
         ppHQ==
X-Gm-Message-State: AOJu0Yys0Slc7055ta/tASHLqhJXS4aFw+PZQb9I8eiWSm0zXbB8TtwV
        cRcpRd5T6JWu+2sl4HSK7qTvNw==
X-Google-Smtp-Source: AGHT+IELb9UJT6sC7GTilNP+4QfWdcX9+gyN7cf4Rlq0B7kFgPDad3Hdi4I21cnODq4uhQcLWot/+w==
X-Received: by 2002:a05:6a00:885:b0:68f:e810:e86f with SMTP id q5-20020a056a00088500b0068fe810e86fmr21643745pfj.28.1697003341973;
        Tue, 10 Oct 2023 22:49:01 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id p6-20020a62ab06000000b0069302c3c050sm9172133pff.218.2023.10.10.22.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 22:49:00 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:18:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20231011054858.3vvnr76u5enu5lf6@vireshk-i7>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073946.GE11945@thinkpad>
 <20230125042145.hrjpnskywwqn7b6v@vireshk-i7>
 <20230216064727.GA2420@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216064727.GA2420@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-23, 12:17, Manivannan Sadhasivam wrote:
> Sorry for the delay. I've submitted the dts changes [1] to handle the CPU clocks
> for the rest of the Qcom SoCs.
> 
> For the Qcom GPUs, I've CCed Rob Clark who is the maintainer.
> 
> Rob, here is the background on the issue that is being discussed in this
> thread:
> 
> Viresh submitted a series [2] back in July to improve the OPP framework, but
> that ended up breaking cpufreq on multiple Qcom SoCs. After investigation, it
> was found that the series was expecting the clocks supplied to the OPP end
> devices like CPUs/GPUs to be modeled in DT. But on Qcom platforms even though
> the clocks for these nodes are supplied by a separate entity, like CPUFreq
> (EPSS/OSM) for CPUs and GMU for GPUs, there was no clock property present in
> the respective nodes. And these nodes are using OPP table to switch frequencies
> dynamically.
> 
> While the series was merged with a hack that still allows the OPP nodes without
> clock property in DT, we came to an agreement that the clock hierarchy should
> be modeled properly.
> 
> So I submitted a series [3] that added clock provider support to cpufreq driver
> and sourced the clock from cpufreq node to CPU nodes in DT.
> 
> Likewise, it should be handled for the adreno GPUs whose clock is managed by
> GMU on newer SoCs. Can you take a look at this?

Any update on this ?

-- 
viresh

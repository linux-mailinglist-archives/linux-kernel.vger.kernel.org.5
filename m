Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9069C7DFEA7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 06:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKCFM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 01:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCFM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 01:12:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73521A7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 22:12:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-28098ebd5aeso1620665a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 22:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698988370; x=1699593170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OixtEquTnHR2YZhEd0MDEhswdqqqsbVAp+5RHrt7SyY=;
        b=olZcH8W9AllPK4gFcgNwx+AWhkczLaehkgn321GTYcJk/ckcLrAFRmjOD0YQFQYNF7
         woOMIi00GXEyUCA/8BDlxiz6JI3anxj/zzYeXw16pmkL09/TT+GnVmynHnCX0UdEZFQf
         n23QaP0dyooFNYC0ShlkzZoUxSxEeii/4J4JkENreIVAtigByG4cLC8UuEcWw88BD64B
         hDZu2DFVjQltO7l/EWYrfpzpdzEs6Kt7Ym1RnVV5yh01C92KZqMUP73foEU7Ey5we70X
         bRgVI0GnG5wnHZZJrzpJyPaQ0rqlg1uR5/a6SPpLxC7JWcchODi2oR7nphd3K5cX8vAB
         jMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698988370; x=1699593170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OixtEquTnHR2YZhEd0MDEhswdqqqsbVAp+5RHrt7SyY=;
        b=GUMYaDjP2n6MQMq7ceFX3V6hKXsNyB3jvJqac3EBq3REhsBISIp5QnjGZvVi1V0ZTy
         RDrZiBwTLNjmDlfj76LoBbIbBIysBQWodfkaF5QjqTblbjllbaldHJ89OcxjlFxbCCf/
         fn9cdo6ixCMEIAzdpOyB+WD/9XYMylhT+2xIYmyFG5zViewYexisrHbb1bfBVzCPZVcb
         WSw9WY85KAp48/L3MMHK/2GX0sPsIpDnpiB9bo3wz7LqSjM+WF2rtXZhZLbMbsdpBMq2
         orJwLJW3hOhnwJWTS8iDtoIlBqog/ThwNpgPeOiowWqlPeKaqfiB2JgLp3+UfXU89qm6
         S1jw==
X-Gm-Message-State: AOJu0YwJ5UEe5NlT4M8eX4dODzjVRsw6pqH5388sRHeIh4ejvxw4JH6G
        7fDebhf9aXkc2vyWGznEg0QL1A==
X-Google-Smtp-Source: AGHT+IFExr8ybCriMSgOLlaz6WAWaai4oOiYuReMXnpbJnZEcRwsDQDCfUwG4Y7Q7LrrQj7TnqqbKA==
X-Received: by 2002:a17:90a:7e88:b0:280:c97:5968 with SMTP id j8-20020a17090a7e8800b002800c975968mr18934034pjl.5.1698988370217;
        Thu, 02 Nov 2023 22:12:50 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id js4-20020a17090b148400b0027d15bd9fa2sm626409pjb.35.2023.11.02.22.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 22:12:49 -0700 (PDT)
Date:   Fri, 3 Nov 2023 10:42:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v5 5/5] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20231103051247.u4cnckzstcvs4lf5@vireshk-i7>
References: <20231102053013.7yt7pxin5awlu7w7@vireshk-i7>
 <20231102120950.GA115288@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102120950.GA115288@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-11-23, 07:09, Bjorn Helgaas wrote:
> On Thu, Nov 02, 2023 at 11:00:13AM +0530, Viresh Kumar wrote:
> > On 01-11-23, 17:17, Bjorn Helgaas wrote:
> > > Can you expand "OPP" somewhere so we know what it stands for?  I'm
> > > sure everybody knows except me :)
> > 
> > It is "Operating Performance Points", defined here:
> > 
> > Documentation/power/opp.rst
> 
> Thanks; I meant in the subject or commit log of the next revision, of
> course.

Yeah, I understood that. Krishna shall do it in next version I believe.

-- 
viresh

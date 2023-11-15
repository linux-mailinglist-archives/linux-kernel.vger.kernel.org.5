Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172FE7DEC47
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348548AbjKBFaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348520AbjKBFaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:30:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B44E130
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 22:30:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-280137f1a1bso549276a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 22:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698903015; x=1699507815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKCEzf5yVHcpzkImikTuiO91O0VK+CR5uA5YIy3x1ew=;
        b=kU2w6Jhj8XZy/W2bEICFrHfug8qqWmT1twPkLkSsHbXASZ4b4Nmw4XyfHANykw7ON2
         ZANemY5oNRoXQQEB4XxPfUS5+kr6dZtGp+WGchK1phtfc+IRPMw9YtB/GRQPcn/tf+Gn
         sch+K7b7OAPTvYrSumF/83GyzifyKRfKCVy9WrrdK1vGPFHHCarMjMJYQ2bu1usCQSeP
         lcKaxfYC88Y3iC3Uet/q1llpCFpBEk9teiqCIvxHZNevLw4sVBML4t04kaW6qEuivMiT
         asCfSojo9rkXEW1KJ3/IqI/iS7Ig7DxtojT/gguGFCWLRjYLxRe45Te7XsotbqSBVUEM
         MPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698903015; x=1699507815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKCEzf5yVHcpzkImikTuiO91O0VK+CR5uA5YIy3x1ew=;
        b=kvk6f+Q0Aze3rBCq+Q3LA+V/J9pYpY2ZcdY5KbSLPtfXHXZ1zqui658mzkktY7hQvg
         RJxlIWn3J7DskaWlgyw4vtIyUTHWwIb2bTY3jcqOvFje+1qDsN7Ttr76j7KU6O5ug2ab
         bY5vgfgggoVhIMLwAVaLQ5SoyTx11tqpo2Zb5cexJ+H9vr7zzaZ30M53KAde2PlUrmeN
         NtWZ/CKDrGE6Kxtxu0mxAcV/QgkYZ7Uv66BeVfZab6fibr9RwXcbSHAILl/XYDCAErQt
         Jnd1Cl3Ehi2rGFZpuw0EGMn9yNDtoZODmwTN99sllekhF9q3UG2G6DMJgyDj8QOzhrv/
         skPQ==
X-Gm-Message-State: AOJu0YxPtGGc7WzAaZ6RvPyUhgfSJilmSTOj6RBUu4gn2z6zlMScwFca
        EqWGzcMcSqgvaqiO4VQh8141uA==
X-Google-Smtp-Source: AGHT+IG3F8uXNqd5WC2MJ/q+sokfpm9k5oUWZuAemt4onAJ/8yGMHkAdTP+qn3Wq/lucbP1uCp1EJQ==
X-Received: by 2002:a17:90a:9b03:b0:280:1d6c:a6a8 with SMTP id f3-20020a17090a9b0300b002801d6ca6a8mr13213526pjp.23.1698903015532;
        Wed, 01 Nov 2023 22:30:15 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090aee8100b0028012be0764sm1648185pjz.20.2023.11.01.22.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 22:30:15 -0700 (PDT)
Date:   Thu, 2 Nov 2023 11:00:13 +0530
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
Message-ID: <20231102053013.7yt7pxin5awlu7w7@vireshk-i7>
References: <1694066433-8677-6-git-send-email-quic_krichai@quicinc.com>
 <20231101221742.GA101112@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101221742.GA101112@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-11-23, 17:17, Bjorn Helgaas wrote:
> Can you expand "OPP" somewhere so we know what it stands for?  I'm
> sure everybody knows except me :)

It is "Operating Performance Points", defined here:

Documentation/power/opp.rst

-- 
viresh

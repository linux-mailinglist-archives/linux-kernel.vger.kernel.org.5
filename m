Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DBF7CFB95
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbjJSNs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345816AbjJSNs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:48:56 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F96131;
        Thu, 19 Oct 2023 06:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1697723330; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Wdx2UZFfAlgZFCVP1a17S/qlvThF9NU+4Il6PUktzwwFl6LB+Ozyunu8ecsu9xLitE
    VKNRL6jWZ7cftIc12eLTVN2cic68eqWlnemHiv+yZHMFnfgeE7HaKDSk0c6h5uNiFs8d
    79AZmJrRQnsVCNBo1l5OCJeazoda56xxufE+Am3UM9xAdCStR7OOUGR/1lkwdyIQsXAp
    83PGoNAYa9hUOAjH4feD+jjLVMnFaTBawoIk6l4fPre4OIN5Q22MYONXp6lJh3WTTS1x
    TeAscj6fYioPFa+QcNeMjQ0X+gNyOyPfpNRWdIk5/zVrO2SJUpF2puD7btkKl9B/K3PF
    kF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1697723330;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GObdimmw9pskjnof7wPSDzQDxLphrL/hHiKhEwm3O+I=;
    b=WQY4IBf1YJwomaGLBQuZSRYaCJx75EHSfCAzTNH+KhkADaAJHGnugXKQNZq1San3S3
    py+V5sAoPevNxYdeWimxjBfcg3u2fxWBXgE3ExS4HWq3OXTiaaek2dYIoW3fHwvDZWPv
    7UXk48+H+TRiKiusEDzJHIjQmG03wHkqHQPRGWIrV2lvflwJYmK34iWsolIXnnfSezFg
    Ovy2Fc1bqq62XewzDA+firZhWbYIeKj1YHL16BRL8B84l3U6SalDcsELS1kyFGhpZ7GA
    I+fgyC5If+zCrUW9gIAen58oXP7Br8jYbjU8Dk7KPXQCnfbyouf/j9mBgq2SLZip9+Jf
    CnoA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1697723330;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GObdimmw9pskjnof7wPSDzQDxLphrL/hHiKhEwm3O+I=;
    b=Q6o6ExnKKpvJAJOcQQjEXdjXP1Xj4dmGQW74FaaQJVqUq3roEHVpWf7qX8cWjCVP0D
    kBrFI/Djp+grrGKKwkUKdBcBXmoRJfzX1o6qd5cwpKWErtggRSDY32y3aOPTXd+4A41X
    pj9Uo9q4vpG/EhfAdp53x9bWNvofbKPALsf411MfgntUsLBk0RlVpJC7R3WQW1+zF4FE
    NmDV3RMT2CqCUk5S5vXUTGBgyfPoOOicY06Y/ce7hU4dynCvZ01ZUygFQ/igP7T/3DMW
    st6lgqQE0pqY9VTEDDwWsoWQgIGUOnrlmGKn05x6MBzC3/qbTfMfjY/PilMB8iq4VizB
    I1jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1697723330;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GObdimmw9pskjnof7wPSDzQDxLphrL/hHiKhEwm3O+I=;
    b=UV8LqNpI1mXnn7AO8BNXu5SCePcVw8yTRfKgNWVpdwZWG56Ag+77GLfHgWGlLIgLeY
    wQcHrG165UYWviT1pgAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9JDmoDqV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 19 Oct 2023 15:48:50 +0200 (CEST)
Date:   Thu, 19 Oct 2023 15:48:43 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] cpufreq: Add basic cpufreq scaling for Qualcomm
 MSM8909
Message-ID: <ZTEzuz7VrDGIoR7H@gerhold.net>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231019061608.wjlf4orkdlpnv3a5@vireshk-i7>
 <20231019102342.5f4oyxd6hmjcju6g@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019102342.5f4oyxd6hmjcju6g@vireshk-i7>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 03:53:42PM +0530, Viresh Kumar wrote:
> On 19-10-23, 11:46, Viresh Kumar wrote:
> > On 18-10-23, 10:06, Stephan Gerhold wrote:
> > > Add the necessary definitions to the qcom-cpufreq-nvmem driver to
> > > support basic cpufreq scaling on the Qualcomm MSM8909 SoC. In practice
> > > the necessary power domains vary depending on the actual PMIC the SoC
> > > was combined with. With PM8909 the VDD_APC power domain is shared with
> > > VDD_CX so the RPM firmware handles all voltage adjustments, while with
> > > PM8916 and PM660 Linux is responsible to do adaptive voltage scaling
> > > of a dedicated CPU regulator using CPR.
> > > 
> > > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > 
> > Applied patch 1 and 3. Thanks.
> 
> Hi Stephan,
> 
> I think your platform has exactly what I am looking for. Can you
> please help me test this, before it lands into linux-next :)
> 
> https://lore.kernel.org/cover.1697710527.git.viresh.kumar@linaro.org
> 

Sure, I will try to test it until end of next week, with both single and
multiple power domains assigned to the CPU. Is there something
particular you would like me to look for? Or just that the scaling still
works correctly as before?

Stephan

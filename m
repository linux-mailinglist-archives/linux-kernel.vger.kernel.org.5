Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7EF75D94B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGVDCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGVDCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:02:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116791701;
        Fri, 21 Jul 2023 20:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91F7361DC9;
        Sat, 22 Jul 2023 03:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E6BC433C7;
        Sat, 22 Jul 2023 03:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689994929;
        bh=ITlDvtYQcaS1d63hBlqr4vtLxAMsvJkpVR/H0tFzo38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNzviDvhEA0gENSUoToRW8ZhMN7x/3D+nX8kaqBQGeYPPmTe4YvQDNxUSi1B56jsd
         ze+UQOKr1fK9fYSHzeFl/7gW0hjA6FnXPrNeM8EGmlP/7EP3K+XyAtN0uv5m5XSYPl
         QgW4ktSbx9FORfFOpWglur83WbeGyxEZB8vIzq2YPMvkdgVVwJzNIB97K+bmkDB4d1
         ARqj8nO9CdWGBVubdgJwdahXHLOFOEiVQezLxurn5UNs4fSid81egfe9y2gVTr6uzT
         gtm7Cwanmw3myuwCEzvp3qZC8HK6abEoUS+1kRcLPAcs7Sow63fuFWc3HAwCqbpwwb
         JEnLFAAvX6ryw==
Date:   Fri, 21 Jul 2023 20:05:28 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: qcom,rpmhpd: Add Generic RPMh PD
 indexes
Message-ID: <a4zztrn6jhblozdswba7psqtvjt5l765mfr3yl4llsm5gsyqef@7x6q7yabydvm>
References: <1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689744162-9421-2-git-send-email-quic_rohiagar@quicinc.com>
 <e77c39fe-b7cf-49b3-9260-ecf4872e8fdf@quicinc.com>
 <7517b2ca-7d7f-dc0c-7f60-a6281b37ab40@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7517b2ca-7d7f-dc0c-7f60-a6281b37ab40@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 06:47:42PM +0530, Rohit Agarwal wrote:
> On 7/21/2023 11:14 AM, Pavan Kondeti wrote:
> > On Wed, Jul 19, 2023 at 10:52:41AM +0530, Rohit Agarwal wrote:
> > > diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
[..]
> > > +
> > > +#endif
> > > -- 
> > I see the PD performance levels (RPMH_REGULATOR_LEVEL_xxx) are still
> > coming from qcom-rpmpd.h. Which means Socs with RPMh also need to
> > include the older header for these definitions along with this newly
> > created header. something to improve for the clarity sake?
> Agreed. I think we can move these to the new header so that the new SoC with
> RPMH can completely
> move to rpmhpd.h.

Sounds very reasonable, please do that in a follow up patch.
I'm picking this as is.

Thanks,
Bjorn

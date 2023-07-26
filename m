Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F16A762AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGZFVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGZFVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:21:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CA71FF3;
        Tue, 25 Jul 2023 22:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 956516142E;
        Wed, 26 Jul 2023 05:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C01C433C8;
        Wed, 26 Jul 2023 05:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690348863;
        bh=9tnFNXSUclTx4dPB0bkbDkhLdl1cycMtiJarM2UDCjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PwhIh2FjWWwVq2ZmmSrooXgU9udbde9AdEXaTQL7q/KeRv0vBxc5yR40M0fLMWBUQ
         gDYQMR1ERmqSttiVW/bAWwH7n/wWpsibIRaAVff9gH5+YD0XuSysCoprKJN71U9NzR
         Jz7LBOEP3NQM5OF+jjkExaGL0qmrNlQDhOh0S01G0kzOthEToE+YOzY/UaWSt7Rodb
         gax5LVfKNepZyQg2BuYnZENwOoCPd1sDkznREmi1lWRXm6nHUBn3A8PAHVGGD4HjPo
         qd9RVxF0BHttnFgQqce4w1sh23ZTxqmrglKMFQW3MAxVoMkjokEMJaSudU5hNmsb0F
         Rrbs13QNkwyaA==
Date:   Tue, 25 Jul 2023 22:24:15 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, p.zabel@pengutronix.de, arnd@arndb.de,
        geert+renesas@glider.be, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        quic_srichara@quicinc.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/6] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
Message-ID: <cst3d76ong32lzcatxlcr5gbakmh3grm5tehvd36wrdza5ozd5@gfl4ysu7hdo6>
References: <cover.1689913334.git.quic_varada@quicinc.com>
 <131eb1694229436919ac88bb9920fb54d6808388.1689913334.git.quic_varada@quicinc.com>
 <ymbcafqqhc6hgrfhpef4byehvfyjzovs5zeprmj343erdv5ti5@tj2iunu6whvi>
 <20230724160136.GA3619408-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724160136.GA3619408-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:01:36AM -0600, Rob Herring wrote:
> On Fri, Jul 21, 2023 at 10:10:57PM -0700, Bjorn Andersson wrote:
> > On Fri, Jul 21, 2023 at 10:05:27AM +0530, Varadarajan Narayanan wrote:
> > [..]
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
[..]
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
> > > +    usbphy0: usb-phy@7b000 {
> > 
> > usb@
> 
> You mean phy@? But 'usb2-phy' is accepted too.
> 

Yes, had the controller in mind, sorry about that.

Thanks,
Bjorn

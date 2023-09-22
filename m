Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872DA7AAA5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjIVHfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjIVHfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:35:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44507C2;
        Fri, 22 Sep 2023 00:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695368108; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=n9wVQ3pfoBvTx0TdZ/TxHP6hT3lhos3psc+qkOV0quLn7NsePI0XqchVGr0/LnuMrk
    LLikuqSUkfpVCKWyUItXDvTpbJHUKwVDmqLfmYG+g0Fr2iZnfT1T2zPL5gJUbK0fuQrv
    6vaXu8TEtsp52iupfMy1RuHjpk56g6rlGya42CgYGNJvvIzB5e2lBKpRKPglTLW+46Ib
    RpT+L/5k+hNnSjw0KcAsML5ElpNGx4WsnBaJZfyFkHYx5TZEea99pUvS5Zsa8bk38hgn
    2PyciDMH5qgqQxL9NccVF6tuTEtWIy7jNumuwpEXW82SI4/qmzYQexo0d6YHz0rOFS+E
    WSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695368108;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=D5ImVpCLkXISi+bVaGBTi//vA7N/Q4GRoHQQ/PDmcPs=;
    b=QfB6OuDjfOB6mHRQvBtWHUnpuFYUjR4G8sqfu6t92UvpeOugOKv5k5Fd9YiX55g/yK
    WAAxdJlVPDOY8aFEf2y7kZcuHMW2TgHF69O0vSSEIy9yvhscrRQcTK8O+uMRudu0E4zY
    KPf/yBcBQ6rF+lcEIsOqDzxgpPbQC8vYDv71dGDMacaUxr/anDii5pVyDIy1B5UGmYyk
    +iGunZH2EtwR4Sr+FPuJuuHD3YG/gZv/BWflYXAZZoWgkpaDYBmg6ybiuoe4nAETCNrX
    jsMgugHQjs+EtFIPB4JQ+LeR4uPaP7qAuWzrRfXxuRF7OPvS111pxb57Vh750wH4iUtV
    o/0A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695368108;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=D5ImVpCLkXISi+bVaGBTi//vA7N/Q4GRoHQQ/PDmcPs=;
    b=XJ1sqLV1E8Dj637EjSGDAqpbhqAs8QRS2vB7zIme/lMYXkameCECFzaOqPT29LfUig
    auZpEtc5iPtjOp8kalhSaHohNOHUhZkZyTBQH08nolPI29bXonEul+56shpYjXZ3c3BT
    18d0L98XjXqqG+sM0B0UoCXU6rjrlN+MFVb8w8WVw/318u1cghWWRqVPbIEwcNU2C6T4
    CmpSA9JUgbuDxRzcKzijNUcMe5WdbJF+syRFEb10MjSS5DMVXjBDTOSJyhczxqHZ633h
    4qCAizgCJKwHgK9nIuhC3uvom9Yset0nJHhkTD3uk874JJF9YX+mYHpg7oQQtibc69qG
    3prA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695368108;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=D5ImVpCLkXISi+bVaGBTi//vA7N/Q4GRoHQQ/PDmcPs=;
    b=EzxYb4tdhahf+ur3fB66cA1oawZQAIYRED3kEOoCLax7JuSldBrhdcjlKFzZN2poAq
    ICAF0V7s5lEL2IWDy2Bw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8M7Z8Sa3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 22 Sep 2023 09:35:08 +0200 (CEST)
Date:   Fri, 22 Sep 2023 09:35:00 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] soc: qcom: rmtfs: Support discarding guard pages
Message-ID: <ZQ1DmSRIe56WQmnK@gerhold.net>
References: <20230920-rmtfs-mem-guard-pages-v3-0-305b37219b78@quicinc.com>
 <20230920-rmtfs-mem-guard-pages-v3-2-305b37219b78@quicinc.com>
 <ZQyFliFYV7dUwGJg@gerhold.net>
 <j5ivvbjprgdcekujzjiobk7gpoaz3jxpnda5dsgoh6f4hsn5id@3ug5i74ubkqf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j5ivvbjprgdcekujzjiobk7gpoaz3jxpnda5dsgoh6f4hsn5id@3ug5i74ubkqf>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eOn Thu, Sep 21, 2023 at 07:51:42PM -0700, Bjorn Andersson wrote:
> On Thu, Sep 21, 2023 at 08:04:06PM +0200, Stephan Gerhold wrote:
> > On Wed, Sep 20, 2023 at 07:37:31PM -0700, Bjorn Andersson wrote:
> > > In some configurations, the exact placement of the rmtfs shared memory
> > > region isn't so strict. The DeviceTree author can then choose to use the
> > > "size" property and rely on the OS for placement (in combination with
> > > "alloc-ranges", if desired).
> > > 
> > > But on some platforms the rmtfs memory region may not be allocated
> > > adjacent to regions allocated by other clients. Add support for
> > > discarding the first and last 4k block in the region, if
> > > qcom,use-guard-pages is specified in DeviceTree.
> > > 
> > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > ---
> > >  drivers/soc/qcom/rmtfs_mem.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> > > index f83811f51175..83bba9321e72 100644
> > > --- a/drivers/soc/qcom/rmtfs_mem.c
> > > +++ b/drivers/soc/qcom/rmtfs_mem.c
> > > @@ -200,6 +200,15 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
> > >  	rmtfs_mem->client_id = client_id;
> > >  	rmtfs_mem->size = rmem->size;
> > >  
> > > +	/*
> > > +	 * If requested, discard the first and last 4k block in order to ensure
> > > +	 * that the rmtfs region isn't adjacent to other protected regions.
> > > +	 */
> > > +	if (of_property_present(node, "qcom,use-guard-pages")) {
> > 
> > I think of_property_read_bool() would be more fitting here. Right now
> > of_property_present() is just a wrapper around of_property_read_bool().
> > Semantically reading a bool fits better here though. :-)
> > 
> 
> Are you saying that you would prefer this to be a bool, so hat you can
> give it a "false" value? Or you are simply saying "it walks like a
> boolean, quacks like a boolean, let's use the boolean accessor"?
> 

The latter. I would expect that of_property_present() is used for
properties which usually have a value, while of_property_read_bool()
is used for pure bool values which can be present or not but must not
have a value. I think a "bool" in terms of DT is simply a present or
not-present property without any value?

For example consider

  regulator-min-microvolts = <4200000000>;
  regulator-always-on;

Then I would expect

  - of_property_present(..., "regulator-min-microvolts"), but
  - of_property_read_bool(..., "regulator-always-on")

Does that make sense? :D

> > Feel free to fix that up while applying.
> > 
> > FWIW I don't really have an opinion if "qcom,use-guard-pages" is a good
> > way to describe this in the DT. For the implementation side feel free to
> > add my
> > 
> 
> Right, I don't think I commented on your suggestion to make the size of
> the guard page configurable. I am not aware of any current or upcoming
> reasons for adding such complexity, so I'd simply prefer to stick with a
> boolean. Should that need arise, I think this model would allow
> extension to express that.
> 

I must admit I forgot that I suggested this until now. :')
I don't see a use case for a different "guard size" either so I think
it's fine to have it as a bool.

Thanks,
Stephan

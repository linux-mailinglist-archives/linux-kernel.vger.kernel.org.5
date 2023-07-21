Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2FE75C0D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjGUIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjGUIID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:08:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19BB2706;
        Fri, 21 Jul 2023 01:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DDBC616C1;
        Fri, 21 Jul 2023 08:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92352C433CA;
        Fri, 21 Jul 2023 08:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689926876;
        bh=o1cZvieMYPYBkZJebOJ6isrBwhpPfnwvQn0FB1kHdAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cRtnUhX26OscJYsPDIKSIA5KnE04vQQ58tmAaJfEE/H25IPTW91wAE6HgXvsOhyP0
         AWjixPyco0ckgw8k0qpVAvbevNJSBCa6BrOPyOQjf+WdLt9fSxzKpnh73+InHfZKiO
         cvUsYF8RwltcQ5j4qwr15MHDl3CDMCG/1AFGm1WTLhWYl101k3awGEPzIV5xAnOEDp
         aaDHQFoybLPA6nI5lFzfB2uJdLckcWzAl1jpLhDbgnlxo4vatCeSYk0jHmscCzd85K
         a9556tNlzTOoakK6RZNH6mj3ZEpORpW9XeTDlJlyEGDFG3oVrE1+C14UBNuavfOIa1
         iCpvgNP6tDOTQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMlBE-0003LY-1G;
        Fri, 21 Jul 2023 10:08:05 +0200
Date:   Fri, 21 Jul 2023 10:08:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
        quic_harshq@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 08/10] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Message-ID: <ZLo85M-4ZzfTyHQ9@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-9-quic_kriskura@quicinc.com>
 <2eab503f-fa0d-990e-bed2-2445c5496798@linaro.org>
 <b183a130-6237-7d15-5d5a-b56582b92b35@quicinc.com>
 <ZJr9Xiv6_0nG0Pui@hovoldconsulting.com>
 <622288dd-cb3c-b673-5544-46ff10106dbc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <622288dd-cb3c-b673-5544-46ff10106dbc@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 12:40:19AM +0530, Krishna Kurapati PSSNV wrote:
> On 6/27/2023 8:46 PM, Johan Hovold wrote:
> > On Sat, Jun 24, 2023 at 12:43:23PM +0530, Krishna Kurapati PSSNV wrote:
> >>> On 21.06.2023 06:36, Krishna Kurapati wrote:
> >>>> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
> >>>> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
> >>>> platforms.
> >>>>
> >>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

> >> Yes wakeup is supported by all ports now, but I didn't make those
> >> changes now as I wanted to keep driver code diff minimal and don't need
> >> wakeup support for the product currently. But for sure, will update
> >> driver code to handle wakeup on all ports in near future.
> > 
> > Why didn't you include it in v9? I thought you had a working
> > implementation for this?
> > 
> > Since wakeup will be another case where glue and core need to interact,
> > it's good to have the wakeup implementation from the start to be able to
> > evaluate your multiport implementation properly.
> > 
> > Right now it looks like you only added wakeup interrupt lookup and
> > request, but then you never actually enable them which is not very nice.

>   As mentioned in one of my comments on earlier patches, wakeup is not a 
> requirement I currently need to work on for the product. I added 
> multiport IRQ support only because my pathces need to modify IRQ names. 
> If there is a customer requirement I get in the future, I will 
> definitely implement the wakeup part. But for now, I would like to stick 
> to what is necessary for getting Multiport to work.

I think you need to implement this now as this is a basic features of
any USB controller and one which is already supported by the driver you
are changing. We've also had a long of history of Qualcomm pushing
incomplete implementations upstream and then they move on to more
pressing deadline and never actually complete the work.

This very wakeup support is a good example of this as parts of it was
merged years ago and when someone later tried to get it to actually
work, it turned into a complete hack of an implementation as no one had
thought about the overall design.

Johan

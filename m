Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143057F327E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjKUPjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKUPjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:39:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742411A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:39:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D662C433C8;
        Tue, 21 Nov 2023 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700581181;
        bh=w0swN4qP3atepJXOMo4YxoHycOEd59DUpo/tQX9xLX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scX+T4AYN8zUTppLdAsG0fdse7jcHGsPZah7ukehkVcV2DLf68Y2jiwf9UjFLFwiI
         LfjqbBCMkeYkNJom3G7XZMZQWBky3tLPkt5YpfMVzwTP6RoJa9WV+7OqeG16cBNXrX
         5O7dM80aKeDs0Ap8+/aEIDJrtxIKXr9q+meS4G7AOAeies+daGjBF+32/cZx/R82oR
         MLS2Q0oxm0psoZa5W1vNwYsw9/ht7zuyzfDGO9O9xfPFrHhPPLM+wolUAXIOED87t7
         WHpe4ZHjo+h+Mszkzd+A0GnP6gHJYxFOVBYgKbA++b9+2w8iLw0R3UexfdK/eRvUNK
         HcfaIGz3fQnMA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5Sqv-0000nP-0a;
        Tue, 21 Nov 2023 16:39:53 +0100
Date:   Tue, 21 Nov 2023 16:39:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sa8775p: Mark PCIe EP
 controller as cache coherent
Message-ID: <ZVzPSQeyVytoyuk7@hovoldconsulting.com>
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
 <1700577493-18538-4-git-send-email-quic_msarkar@quicinc.com>
 <ZVzE0c8UsW4HXV_u@hovoldconsulting.com>
 <f742b95e-dd42-cbd3-61ef-d5255447ea4e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f742b95e-dd42-cbd3-61ef-d5255447ea4e@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 09:02:41PM +0530, Mrinmay Sarkar wrote:
> 
> On 11/21/2023 8:25 PM, Johan Hovold wrote:
> > On Tue, Nov 21, 2023 at 08:08:13PM +0530, Mrinmay Sarkar wrote:
> >> The PCIe EP controller on SA8775P supports cache coherency, hence add
> >> the "dma-coherent" property to mark it as such.

> > What tree is this against?
> >
> > Both controllers are already marked as dma-coherent in mainline so this
> > patch makes no sense (and the context also looks wrong).

> Yes both the RC controllers are dma-coherent and this change is for
> PCIe EP controller and it is inside pcie0_ep node.
> Actually the pcie0_ep node change is yet to apply on linux next.
> I just made this change on top of that and the same I mentioned in
> cover letter.

Ah, thanks for clarifying, and sorry for the noise.

Johan

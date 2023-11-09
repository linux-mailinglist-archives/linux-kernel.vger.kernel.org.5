Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0D77E6E71
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjKIQRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbjKIQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:17:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FD935A9;
        Thu,  9 Nov 2023 08:17:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424CFC433BA;
        Thu,  9 Nov 2023 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699546634;
        bh=MHoWuekJf7fZq+eCzFMo8ejeVfJQEuG6O0L8sRZ3zdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DqAcvwh7gcbigIUgyDm0Ck7aJoA4cCqzACaIpsw3g6pDS3duLYNexl9TunWAd0Yvk
         PjAyS+/TfSLFabNdbHPo4F9JO6hKZP9jsn0xeAciukKn/Y00maYsvLoegWa0vfkWpG
         JW/TOSvV1FpH7yx6m1s97E720GZEvIJNVd+wtiNwr6rSL6RNUpL5ZrVwmyTlwkN7cy
         AYbVC5PeVt043B5OA9if0qFzxRCQNccX75V9/dAcwgGOmjrNYof17yHvc6YpdHpLtn
         fDO/j8cwBHfluPB5JYQxy9D6UlltFK9P66LmSwo03Ia0oYL9e8x96yxB4+Jda+tWlJ
         Qte/CugKciSww==
Date:   Thu, 9 Nov 2023 21:46:56 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ziqi Chen <quic_ziqichen@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com,
        linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: ufs: Add msi-parent for UFS MCQ
Message-ID: <20231109161656.GH3752@thinkpad>
References: <1698835699-28550-1-git-send-email-quic_ziqichen@quicinc.com>
 <20231106144831.GA317907-robh@kernel.org>
 <5850d5ac-e735-4358-866d-f410b00ba39d@acm.org>
 <CAL_Jsq+XB5p_K3C+rc5XetQ-Xfxu4umNFzcF0idB2hhZvS7HLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+XB5p_K3C+rc5XetQ-Xfxu4umNFzcF0idB2hhZvS7HLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 07:55:14AM -0600, Rob Herring wrote:
> On Mon, Nov 6, 2023 at 11:56 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 11/6/23 06:48, Rob Herring wrote:
> > > On Wed, Nov 01, 2023 at 06:48:13PM +0800, Ziqi Chen wrote:
> > >> The Message Signaled Interrupts (MSI) has been introduced
> > >> to UFS driver since the MCQ be enabled.
> > >
> > > Not really relevant when a driver supported MSI, but the when the h/w
> > > did. Has UFS always supported MSI? It was added in some version of the
> > > spec?
> >
> > MSI support has been introduced in UFSHCI version 4.0 and I think that
> > the controller vendor can decide whether or not to implement MSI. Does
> > this mean that the patch needs to be improved?
> 
> Yes, this information is what should be in the commit msg rather than
> driver details.
> 

Yes, agreed. Ziqi, please update the commit message to incorporate the hw
details about when MCQ/MSI got introduced. Devicetree binding should describe
the hw, not the driver.

- Mani

> Rob

-- 
மணிவண்ணன் சதாசிவம்

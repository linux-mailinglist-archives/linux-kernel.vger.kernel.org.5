Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5933680D507
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbjLKSLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345257AbjLKSLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:11:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C187993
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:11:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23130C433C7;
        Mon, 11 Dec 2023 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702318315;
        bh=d/QXMCGNkdm/FGe7jzUVoJUZiNL9n1uu27MJIv/ZnTk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S9tGGdET6EYJ55LzwK2/6jfxwPY+v+UcpfAbKynnvMOUhoOe2P8ilqjibT0NLSTJj
         QLidBZPKeGrLTGQxJEI53/xFK3DZJbUjj1SiZ4htdSipxIzQEejCKmQ03bAEu/lYH/
         kjuiwJcaZM2bpjRMWAiztjJsL0kKtCc+YKeDir83oI+THSvfhgt2rTwEcll+Gz4DIV
         uB8QbR3AUdPlEYvgSEfIrEgyfUS8HUoEfoSpZJit2hqXYcd5XR2/ghn2EWiIo3aDiI
         sPPOdqERtbM1i6/ghc5OnEJMroC0rf3AhU3bIeZlAh5z4FP7fKS3hrabAahAgQ5Kvs
         QpxY4WJPvK/0A==
Date:   Mon, 11 Dec 2023 12:11:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: Fix deadlocks when enabling ASPM
Message-ID: <20231211181153.GA959586@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXdIcle5oKJTaQB6@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 06:35:46PM +0100, Johan Hovold wrote:
> Hi Bjorn,
> 
> On Fri, Dec 08, 2023 at 11:53:12AM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 28, 2023 at 09:15:06AM +0100, Johan Hovold wrote:
> 
> > > Johan Hovold (6):
> > >   PCI/ASPM: Add locked helper for enabling link state
> > >   PCI: vmd: Fix deadlock when enabling ASPM
> > >   PCI: qcom: Fix deadlock when enabling ASPM
> > >   PCI: qcom: Clean up ASPM comment
> > >   PCI/ASPM: Clean up disable link state parameter
> > >   PCI/ASPM: Add lockdep assert to link state helper
> 
> > Applied to for-linus for v6.7, thanks, Johan!
> 
> I've noticed that you're pretty keen on amending commit messages.
> 
> For this series, for example, I noticed that you added an American comma
> after "e.g." even though this is not expected in British English that I
> (try to) use. This risks introducing inconsistencies and frankly I see no
> reason for this kind of editing. British English is not an error. :)
> 
> You also added a plus sign after the stable kernel versions in the
> comments after the CC-stable tags even though this is not the right
> notation for this (see the stable kernel rules).

Fixed, sorry.

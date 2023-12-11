Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A2E80D3F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344730AbjLKRfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbjLKRez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:34:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8D7107
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:35:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF17FC433C7;
        Mon, 11 Dec 2023 17:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702316100;
        bh=C+xcU0YxoxqS8wlJs7ViUOBkcKRqhoDYHPQNqHhIU7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EgSMMg5SQJwi9ZJO7tXgJEZ8pHAb3w7OZkogzS3Vi50kwtTf5HzMgpP5nN5vWAACB
         Pyqh7ZY1N0JJW//s5JpHyEWGivj5qKUnPZwMuMawSeLSxZfzAWUtekk03NYwWZW7fh
         HCmTvpukqTsjl/PGl+tlwztLweC4X2P1pkS50mmfQlyq+yxRTcDqPLLuA4Wuo6GkD1
         nUL/EFoKOQgGjFjeBMa1XyCflVMHEM/CBaI0I3ZKdIhQC7RawnnwuqhzgudYwxaj+y
         ovVrVLkKBqLhpce2H6hxJb4GMaIilOVFDuWXqLBcoh75FfAUTqzjwrE6WBnXcJiwXl
         KLmZ4++vOhNww==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rCkC2-0006Jn-1R;
        Mon, 11 Dec 2023 18:35:47 +0100
Date:   Mon, 11 Dec 2023 18:35:46 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <ZXdIcle5oKJTaQB6@hovoldconsulting.com>
References: <20231128081512.19387-1-johan+linaro@kernel.org>
 <20231208175312.GA803148@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208175312.GA803148@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Fri, Dec 08, 2023 at 11:53:12AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 28, 2023 at 09:15:06AM +0100, Johan Hovold wrote:

> > Johan Hovold (6):
> >   PCI/ASPM: Add locked helper for enabling link state
> >   PCI: vmd: Fix deadlock when enabling ASPM
> >   PCI: qcom: Fix deadlock when enabling ASPM
> >   PCI: qcom: Clean up ASPM comment
> >   PCI/ASPM: Clean up disable link state parameter
> >   PCI/ASPM: Add lockdep assert to link state helper

> Applied to for-linus for v6.7, thanks, Johan!

I've noticed that you're pretty keen on amending commit messages.

For this series, for example, I noticed that you added an American comma
after "e.g." even though this is not expected in British English that I
(try to) use. This risks introducing inconsistencies and frankly I see no
reason for this kind of editing. British English is not an error. :)

You also added a plus sign after the stable kernel versions in the
comments after the CC-stable tags even though this is not the right
notation for this (see the stable kernel rules).

I'm more OK with you preferring to use function names over free text in
commit messages even if that is not my preferred style.

But generally I find it a bit odd that you insist on rewriting commit
messages like this and would prefer if you did not (especially since
there's no record of you having done this in the commits themselves).

Fixing typos and grammar issues, or rewriting bad commit messages, is
another thing of course.

Johan

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E490980DB54
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbjLKUNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjLKUNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:13:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE59F5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:13:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BB5C433C8;
        Mon, 11 Dec 2023 20:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702325586;
        bh=DNj1uX5WZmLEQAxZNomgj9zi2OAe5+dmPakPq58kCUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KaYrkV0BT2wFort5fq9lbHfTu0hAVBfT/HbBCXFDjUvEHb4HJLwKcthbHd1RKEO4k
         ImbJIABUpwPRUKPUn2Cm45jZkw2tw9H8nId02/zNhQ40uWg0oNkCClqVJ2oot1KWPu
         b3Y4N+zkfIWKiAUJtAVQ1esxAgL8AzMGbkycHvipe5gP2uqoMK9X+kMoROC1hyAY6J
         4IJfRDKjm8ddQnkkgIkIvCnGgFe3/lizUomUFIl4xLQ1nSDCZ8ULJIi2/pEIycXCRJ
         mVhoTKNHmcfr3KOCVC5hBbQZysXKUdsQ0rEbCPpj+OVRTLtx2Vs5NqTNZSLouGMQ/X
         D8FrIhgXp7LcQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rCmf3-0006eS-2D;
        Mon, 11 Dec 2023 21:13:53 +0100
Date:   Mon, 11 Dec 2023 21:13:53 +0100
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
Message-ID: <ZXdtgdqLWikHR8tp@hovoldconsulting.com>
References: <ZXdIcle5oKJTaQB6@hovoldconsulting.com>
 <20231211181153.GA959586@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211181153.GA959586@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 12:11:53PM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 11, 2023 at 06:35:46PM +0100, Johan Hovold wrote:

> > I've noticed that you're pretty keen on amending commit messages.
> > 
> > For this series, for example, I noticed that you added an American comma
> > after "e.g." even though this is not expected in British English that I
> > (try to) use. This risks introducing inconsistencies and frankly I see no
> > reason for this kind of editing. British English is not an error. :)
> > 
> > You also added a plus sign after the stable kernel versions in the
> > comments after the CC-stable tags even though this is not the right
> > notation for this (see the stable kernel rules).
> 
> Fixed, sorry.

Thanks!

Johan

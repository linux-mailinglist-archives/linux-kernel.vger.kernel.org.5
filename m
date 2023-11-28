Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578057FC474
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjK1TwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjK1TwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:52:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92641988;
        Tue, 28 Nov 2023 11:52:22 -0800 (PST)
Received: from notapiano (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC19B6602F2B;
        Tue, 28 Nov 2023 19:52:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701201140;
        bh=lTlr8qen9KRZ2EZ5Mj/C5s4YyiYXfeKPKLVSZIrbTaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BWFbCeo0pR89kb8EP/q48zvjI3cmzqzkOP5Ssg6KCYoxmkYsWhGw7YnYwnK0Ydqx9
         shS65Zdg/bf6ykTyCPIAoN+VgUo6f2E5W0QcfQUeciCr3rka0YrpUzn+HSv/Bj7Zct
         H7Infuv8i02YACPgJR2RW94Pq1aXDa0SK6yC1DMGOERLw6n3KijfKvg4e7UliZB2FY
         gALs+B7NKhpeP+t7oyOtEriPW0ZcVjhpIUPqzuejbdo7CDI5XAGpOkkGmtxmvMbKR9
         Y183UDfOcNi0JPgzAIknumKFCAi/HtwqTGlS66GpmKmxmcaHod/LOIaopU07q5hAKg
         UIW+brHODLCag==
Date:   Tue, 28 Nov 2023 14:52:12 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
        David Gow <davidgow@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/2] kselftest: devices: Add sample board file for
 google,spherion
Message-ID: <3f22eea4-121d-4d5b-b7af-71961a2ab5e9@notapiano>
References: <20231127233558.868365-1-nfraprado@collabora.com>
 <20231127233558.868365-3-nfraprado@collabora.com>
 <BN8PR13MB27384F089C7DAAF06DF9DDECFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
 <ee913bc5-c752-4da7-a140-7492f429c2cb@notapiano>
 <BN8PR13MB273808C3B81BABBAADACC6B6FDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN8PR13MB273808C3B81BABBAADACC6B6FDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:54:57PM +0000, Bird, Tim wrote:
> > -----Original Message-----
> > From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > On Tue, Nov 28, 2023 at 12:10:46AM +0000, Bird, Tim wrote:
> > > > -----Original Message-----
> > > > From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > > Add a sample board file describing the file's format and with the list
> > > > of devices expected to be probed on the google,spherion machine as an
> > > > example.
> > > >
> > > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  .../testing/selftests/devices/boards/google,spherion | 12 ++++++++++++
> > >
> > > Overall, while trying to maintain a comprehensive set of board definitions
> > > seems hard, I think having a few as examples is useful.
> > >
> > > I'm not a big fan of naming these with a comma in the name.  Is there a reason
> > > you are not using dash or underscore?
> > 
> > I'm using the name that we get from the DT compatible, so the right file can be
> > automatically selected by the test.
> > 
> > >
> > > Do you anticipate a convention of  <producer> <board-or-product-name> tuples for
> > > the filename?
> > 
> > I'd just stick to the DT compatible as it's the simplest option and should work
> > just the same, assuming I understood correctly what you mean.
> 
> OK - I see that was mentioned in the original submission.  I should
> have read more closely.
> 
> It makes sense.  Maybe it's worth mentioning in the commit message that the
> filename is the compatible string from the DT for this board?
> 
> This convention, IMHO, should be documented somewhere.

I have that as part of the comment at the top of the test script in patch 1:

# The per-platform list of devices to be tested is stored inside the boards/
# directory and chosen based on compatible.

And also in the commit message of patch 1.

But I guess this sample file is the most likely one to be read when someone
writes a new board file, so I'll document it here too for next version.

Thanks,
Nícolas

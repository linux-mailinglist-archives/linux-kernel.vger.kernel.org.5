Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17B17FC14D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbjK1Ooq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345841AbjK1Ooo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:44:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D88E;
        Tue, 28 Nov 2023 06:44:51 -0800 (PST)
Received: from notapiano (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8FC1F66072A7;
        Tue, 28 Nov 2023 14:44:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701182690;
        bh=Og082W+PSa4+5mTtMkeABO/eaXozRb0GXaqspZ1T4tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YM44BhIk4AoBxZhrTRTnU7Agoo7aoXPbUC+kkVuglrVw1oxHaC3sN8xCREdcJsw06
         nkr38YpWD1IqnnPUZg0U1xrL42f2YkAagOaXzZbmapAdkdOOKx72TS7W6/NKBrQdGi
         pSdVYBGbsAOUQmzKiYu686WEzswrT9EmB4QGR734x0tqIM5IVwVMJkIlN9wWe8M1Zf
         QUEA1zCVt8AMmHKT4XbcFIJlEqyaQI+ygZlTOWLpatmlemGPx8hz/ZtFkBWT4zx/FP
         k+trbQUknlfB3LDKn9G2JLuIf7r5XxE8bJy3BSPLEmHviNzpgOMQZ1rYkKOJOV5FUA
         SSysqpsfwHfrA==
Date:   Tue, 28 Nov 2023 09:43:53 -0500
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
Message-ID: <ee913bc5-c752-4da7-a140-7492f429c2cb@notapiano>
References: <20231127233558.868365-1-nfraprado@collabora.com>
 <20231127233558.868365-3-nfraprado@collabora.com>
 <BN8PR13MB27384F089C7DAAF06DF9DDECFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN8PR13MB27384F089C7DAAF06DF9DDECFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:10:46AM +0000, Bird, Tim wrote:
> > -----Original Message-----
> > From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > Add a sample board file describing the file's format and with the list
> > of devices expected to be probed on the google,spherion machine as an
> > example.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > 
> > (no changes since v1)
> > 
> >  .../testing/selftests/devices/boards/google,spherion | 12 ++++++++++++
> 
> Overall, while trying to maintain a comprehensive set of board definitions
> seems hard, I think having a few as examples is useful.
> 
> I'm not a big fan of naming these with a comma in the name.  Is there a reason
> you are not using dash or underscore?

I'm using the name that we get from the DT compatible, so the right file can be
automatically selected by the test.

> 
> Do you anticipate a convention of  <producer> <board-or-product-name> tuples for
> the filename?

I'd just stick to the DT compatible as it's the simplest option and should work
just the same, assuming I understood correctly what you mean.

Thanks,
Nícolas

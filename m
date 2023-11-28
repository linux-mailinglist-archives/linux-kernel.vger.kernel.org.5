Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660207FC6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346480AbjK1VFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343838AbjK1VFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:05:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DFFDE;
        Tue, 28 Nov 2023 13:05:44 -0800 (PST)
Received: from notapiano (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB2F66602F24;
        Tue, 28 Nov 2023 21:05:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701205542;
        bh=s7rR2Rat8SrAjrdLaEbiFvlrPgXrqFu53OZ4LGKJWWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kh7dkKyQX4OzBE18csALgyO/a/ZQcAgejLadYxotEYVWGHXi6CIeFRmzTqvrEYcNs
         W5l5c2H4zmP5KyL60WN4jxIJX4gslSDDOMPWb5cTGkYKEC62WeGrUU6Zwh26GOuBBO
         8fQhFeiomH+EO1UHTSylTMoBDWTGeHFfeZh6qoUbn6G6lPTNTAQ+GASZ23+IhNCh4L
         WBYGLVAxEiiylzwSjbl56RUS/Ktp5dIl8v9sv9gl5LI8TBaX5o83t/HViUqjeQ11ej
         ImEsktfwPxvyIbIv4aMtH/f6Jx+oknva3/fPfAMGSRrLc9ozl4LQl6TPh7AsZQNx3T
         ple876rAgvx0g==
Date:   Tue, 28 Nov 2023 16:05:33 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Christopher Obbard <chris.obbard@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
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
Message-ID: <ca434109-7f98-42a3-98b1-eb39480d707d@notapiano>
References: <20231127233558.868365-1-nfraprado@collabora.com>
 <20231127233558.868365-3-nfraprado@collabora.com>
 <897e404e0097a0c422bdb1d0e2d6cbb996500e8e.camel@collabora.com>
 <BN8PR13MB2738FFDE8693A90B781CCADDFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN8PR13MB2738FFDE8693A90B781CCADDFDBCA@BN8PR13MB2738.namprd13.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 06:33:52PM +0000, Bird, Tim wrote:
> 
> 
> > -----Original Message-----
> > From: Christopher Obbard <chris.obbard@collabora.com>
> > Hi Nícolas,
> > 
> > On Mon, 2023-11-27 at 18:34 -0500, Nícolas F. R. A. Prado wrote:
> > > Add a sample board file describing the file's format and with the list
> > > of devices expected to be probed on the google,spherion machine as an
> > > example.
> > 
> > Did you consider using some machine-readable & extensible format like yaml?
> > Surely we don't need to invent yet-another file-format? :-)

For this RFC my focus was to gather feedback on even more basic aspects of the
test, mainly:
- Is using a device's match properties (the ones that constitute modalias) a
  good way to encode a device in a stable way or can we do better? (See cover
  letter for comparison to HW topology approach)

So I just went for the simplest format I could think of. Moving forward, I agree
YAML might be a better fit and I can try it out for the next version.

> 
> I went back to examine the test more closely.  These board files are loaded via
> the shell's 'source' command.
> 
> If I'm reading the test correctly, the format is machine-readable and extensible, since
> it's a fragment of a shell script.  The 'usb' and 'pci' first entries on the lines are
> actually function calls, and the other items in a test line are arguments.
> 
> So, as an RFC - how about calling the board files: "<compatible-string>.sh" to make this
> clear, and maybe adding a comment at the top about the nature of the file?
> 
> There's probably a use case for reading this file not in this original shell script context,
> so I think Christopher's point about a machine-readable AND easily human-readable
> format is valid.  Personally, I find this format not too bad to read (but then I'm a
> shell junky.)

That's right, the board files are shell scripts that are sourced. I went this
route for simplicity rather than necessity. In fact, I'd prefer to have the
board files be dumb files with just the data necessary to describe the devices
on the platform moving forward. For this purpose I'll try using YAML for the
next version and seeing how it goes.

> 
> I believe, Nicolas, that you were already planning on putting some comments in the
> file to describe the line format (function arguments?), based on feedback from Greg KH.
> IMHO, knowing that the format allows comments is useful, so adding a sample
> comment would be welcome.

Well, the text added at the top of this file describing the format of each line
was already done in response to Greg's comment. Although I didn't mention
anything about comments indeed, I'll make sure to document that for next
version (even if it is in YAML it doesn't hurt to have comments as part of the
example).

Also, I've noticed that my patches show "(no changes since v1)". Please
disregard these. There have clearly been changes since v1 (the whole approach is
different), which I've documented on the cover letter, but those trailers were
added by mistake when generating the patches.

Thanks,
Nícolas

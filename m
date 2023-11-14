Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AAE7EB909
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjKNV5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbjKNV5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:57:39 -0500
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Nov 2023 13:57:31 PST
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A0C110
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:57:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
        t=1699998601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZFb1YUmP4PlD7cm7heieX6s0LPelSFaQRLcm3e9dz4g=;
        b=QtSRvO/wGtINt13M+YQyuNDK7xWRKsty2mDJvMHCBiORnfZPpBuJ7ZBR3QWtEuX8NYwe8g
        5DuNkQ3dOQfdVSR7rMJwYjD/2TjN9RZ3PqL5+aPO0R4SzmBhk236cBgZhU8FOZp0VBAomz
        Pjirdoi5RzVXkMYRf/JKrNr1gWop9P6hCITTw0iIZPPLVI4rOme4ZPmci1PSiULJfjOM7E
        sRnptivoDhpj+nImxQuxC32rI1cC/AP6m3oxd/BS7kq22MoTycGM9If66w24X2x3V1BUer
        YsMJ9PPrvi4eC7/nwk/mPE8XTiWg/YpzpC6wUBAacrgBuRpJbiNZiOO6hrRahA==
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        debian-kernel@lists.debian.org, Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, ath10k@lists.infradead.org,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: ath10k_pci logs errors about missing pre-cal and cal firmware on a laptop
Date:   Tue, 14 Nov 2023 22:49:50 +0100
Message-ID: <73921857.09T0xDi13r@bagend>
Organization: Connecting Knowledge
In-Reply-To: <58d017a1-cae6-46d8-9cee-515dbf607051@molgen.mpg.de>
References: <7158e5e9-8bdc-4660-ac5d-5e3f81cf6158@molgen.mpg.de>
 <2e4be606-68a9-455b-a43d-20b8375efc49@quicinc.com>
 <58d017a1-cae6-46d8-9cee-515dbf607051@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10502693.KXfdfZlzAl";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10502693.KXfdfZlzAl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
Date: Tue, 14 Nov 2023 22:49:50 +0100
Message-ID: <73921857.09T0xDi13r@bagend>
Organization: Connecting Knowledge
In-Reply-To: <58d017a1-cae6-46d8-9cee-515dbf607051@molgen.mpg.de>
MIME-Version: 1.0

FTR: I do NOT speak on behalf of the Debian kernel team.

On Tuesday, 14 November 2023 20:58:58 CET Paul Menzel wrote:
> > Based upon the message:
> > [   14.401143] firmware_class: See https://wiki.debian.org/Firmware
> > for information about missing firmware
> > 
> > it seems you are not running a stock kernel. So perhaps Debian has
> > modified the firmware loading such that it ignores the FW_OPT_NO_WARN
> > flag and warns even when told not to do so? This does not appear to be
> > an upstream kernel issue.
> 
> Thank you very much for the analysis. It seems to be indeed a Debian
> specific patch [1].
> 
> Dear Debian Linux kernel team, is my observation about the error log a
> result of the patch and intended?
> 
> [1]:
> debian/patches/debian/firmware_class-refer-to-debian-wiki-firmware-page.patch

There are a number of Debian patches wrt firmware and *I* think they should get 
a (serious) review. In https://bugs.debian.org/1040738 I requested a review of 
the firmware related patches and described one of the issues I encountered 
myself. I've also been involved in triaging Debian kernel bug issues and there 
I've encountered several more such cases.

AFAIK quite a bit of work has happened upstream to make the firmware messages 
more appropriate and I think the Debian patches haven't been (properly) 
adjusted for those changes.

So they are (very) likely caused by the Debian patches and thus expected, but 
I'm hesitant to call them intended ;-)
--nextPart10502693.KXfdfZlzAl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZVPrfgAKCRDXblvOeH7b
boiXAQDA1uG7ZfQM5AYj9rUiuH0ukanafGQ2IiEA/RJJ4CiqrQD+LQCWZ+QZJF2n
ZI0Wzz8jlYnQUxCwRfbYW9pRT6Oo9go=
=ZsyL
-----END PGP SIGNATURE-----

--nextPart10502693.KXfdfZlzAl--




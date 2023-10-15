Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ACF7C9A1D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjJOQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJOQyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:54:19 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA65AB;
        Sun, 15 Oct 2023 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5lYjWxgb2hkXC5DfKD5kKE3Wbfr+WClUFqRfhj+rB+s=; b=jmuClvXqMWBUDuIPZDs9nfLbZx
        hjb7QTF7MymsYfsF/OJuQXdV88VqHni3iDXxdHUtt9q6im1T712xDgjUItnqW2hl9apB9ywu9TbeQ
        sr2RZROehujHH78Woi4uB8vVcs8plmMMm9M7WoQSEVC6xdD7WNH3kWqjZtJ5JG7M5abwqWrzWtxTm
        bkHBPVRsNBMYNE6HqRn5lPhRLwNU9qGVHpaiWFZ4t9DtuucqG4i+GrKeifflRcSOiP6+/EMNA39g+
        KWcSnitPC6Uypshus4cSnXjZ8XMA5xEJNhoS4pIgWfe0bok2zX1oCC2///YU2U2XofQJdTZ2s71js
        PbgtAOVg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53444)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qs4NV-0008KF-33;
        Sun, 15 Oct 2023 17:54:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qs4NV-0004gk-9y; Sun, 15 Oct 2023 17:54:09 +0100
Date:   Sun, 15 Oct 2023 17:54:09 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     chenguohua@jari.cn, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sfp: Clean up errors in sfp.h
Message-ID: <ZSwZMdX0oxdrxzaT@shell.armlinux.org.uk>
References: <1a7c167f.942.18b26fb3ec9.Coremail.chenguohua@jari.cn>
 <ZSt1GkmyO_6iit3-@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSt1GkmyO_6iit3-@debian.me>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 12:14:02PM +0700, Bagas Sanjaya wrote:
> On Fri, Oct 13, 2023 at 11:01:21AM +0800, chenguohua@jari.cn wrote:
> > Fix the following errors reported by checkpatch:
> > 
> > ERROR: spaces required around that '=' (ctx:VxW)
> > 
> > Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>
> > ---
> >  include/linux/sfp.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/sfp.h b/include/linux/sfp.h
> > index 9346cd44814d..725c8381a347 100644
> > --- a/include/linux/sfp.h
> > +++ b/include/linux/sfp.h
> > @@ -289,10 +289,10 @@ enum {
> >  	SFF8024_ENCODING_8B10B		= 0x01,
> >  	SFF8024_ENCODING_4B5B		= 0x02,
> >  	SFF8024_ENCODING_NRZ		= 0x03,
> > -	SFF8024_ENCODING_8472_MANCHESTER= 0x04,
> > +	SFF8024_ENCODING_8472_MANCHESTER = 0x04,
> >  	SFF8024_ENCODING_8472_SONET	= 0x05,
> >  	SFF8024_ENCODING_8472_64B66B	= 0x06,
> > -	SFF8024_ENCODING_8436_MANCHESTER= 0x06,
> > +	SFF8024_ENCODING_8436_MANCHESTER = 0x06,
> >  	SFF8024_ENCODING_8436_SONET	= 0x04,
> >  	SFF8024_ENCODING_8436_64B66B	= 0x05,
> >  	SFF8024_ENCODING_256B257B	= 0x07,
> > @@ -306,11 +306,11 @@ enum {
> >  	SFF8024_CONNECTOR_MT_RJ		= 0x08,
> >  	SFF8024_CONNECTOR_MU		= 0x09,
> >  	SFF8024_CONNECTOR_SG		= 0x0a,
> > -	SFF8024_CONNECTOR_OPTICAL_PIGTAIL= 0x0b,
> > +	SFF8024_CONNECTOR_OPTICAL_PIGTAIL = 0x0b,
> >  	SFF8024_CONNECTOR_MPO_1X12	= 0x0c,
> >  	SFF8024_CONNECTOR_MPO_2X16	= 0x0d,
> >  	SFF8024_CONNECTOR_HSSDC_II	= 0x20,
> > -	SFF8024_CONNECTOR_COPPER_PIGTAIL= 0x21,
> > +	SFF8024_CONNECTOR_COPPER_PIGTAIL = 0x21,
> >  	SFF8024_CONNECTOR_RJ45		= 0x22,
> >  	SFF8024_CONNECTOR_NOSEPARATE	= 0x23,
> >  	SFF8024_CONNECTOR_MXC_2X16	= 0x24,
> 
> To be consistent, other enum's indentation should also be aligned to match
> the longest ones (MANCHESTER and PIGTAIL).
> 
> In netdev, though, checkpatch fixes are not welcome (auto-rejected) as these
> make stable backports more convoluted.

And I, as the author of the file, prefer the "=" to all line up here
without being indented excessively. Given the low number that are
like this, on balance, it's not a huge problem.

That's the thing with coding style - does fixing a coding style issue
make the code more or less readable, and does it introduce a
maintenance issue going forward to fix it. Arguably, indenting all the
constants by an addtional tab _could_ be done, but that becomes a big
change, which as pointed out, can make future maintenance in terms of
backporting a nightmare.

Does fixing the style make the code more readable? Not at all, it's
no different.

So on balance, the right answer is definitely to leave it as-is.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

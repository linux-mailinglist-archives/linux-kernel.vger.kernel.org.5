Return-Path: <linux-kernel+bounces-45666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F78F8433C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4201F2AA70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1DF21101;
	Wed, 31 Jan 2024 02:20:06 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C48210FB;
	Wed, 31 Jan 2024 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667606; cv=none; b=HqKSD/e1iNKoS3irshjlyyA6GfkPXys9tnRq6OREfW1qCQhQYnjidH2eH7vP3g9h5r4zmPQBeLicw2GFcNnCE0j4SYZCUV3hE/WeiKnSnpPK5+poM9ywkXIJNd18X2TcnMslE69zexclF3RHelT3pVzwXun/TCguARuFW0yT2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667606; c=relaxed/simple;
	bh=Ajpwnv0gwKbippqNfFMTevv6la3TWLEQs6Y9B4054dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DILQNV52ErddbF6KbwRfXRnA+TO504LL7huk5E7Nms52a5MbTsS3cLq2S7ozMUdWTaikEcAmVC4q6uCGAN4BK8QSzyMUeHlUC1Iv4aFCrVUjugx37uVXZlHAEPDH7zQzCGj4PsE3b1n0UwZE4ooWN6FU4FTikSd8ONblM9Ii91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp71t1706667564tuzayzwi
X-QQ-Originating-IP: QNMkXqcPISn2NlShiBY6BqGXBtpTFbQCDuaw0bcBF6o=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jan 2024 10:19:22 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: q+EIYT+FhZoIfcWF+K44PK3gx7w0YKb+bngT1uWGc5zMecqNLQEwFwxc1UdT7
	tUijgknzZ7XPnlPNZZp1yqLZSzaRPLgow+TVY0+4nbZN6IJzOjHZ9zv0ATAvwbNI7vI9Ea1
	CkG7jIFx06ChP/VItidltlMAPbyJ1EYJQgBf1KpYXKYw4+2pcb/+bK4oudMiIhGRAtKDo2I
	86UVzoltJ8sgEpv5SCg9iVG3FVU9MkSOyJKbDfcyDZArCn0gr/xY6D/VLUVbLqAxDtll6K9
	XTMgEXAhnPrPQ+jjvTxEc6ttM+6rqJuwmOX2v15ky+XN45ketNBsK8Tr3eHbnyAB8FIBRvR
	H0ySlloZo0A2GeE8pLEK57LjUkvLRxgECg9eurv3RZ3/w84h5mym/iTw7NWT8ZgqW+vndov
	0WcA2ZB9fdk=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7977306663875139372
Date: Wed, 31 Jan 2024 10:19:22 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, fancer.lancer@gmail.com, lkp@intel.com,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] misc: eeprom/idt_89hpesx: Convert data structures to LE
 explicitly
Message-ID: <3A58BAAB108DEC6B+ZbmuKg9jkVmHHN0Y@centos8>
References: <20240130040632.3039911-1-dawei.li@shingroup.cn>
 <2024013039-asleep-rally-39c0@gregkh>
 <03B279416A25E958+ZbmjvFafk44HBl4b@centos8>
 <2024013030-paternal-robotics-7fdf@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024013030-paternal-robotics-7fdf@gregkh>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Greg,

On Tue, Jan 30, 2024 at 06:07:18PM -0800, Greg KH wrote:
> On Wed, Jan 31, 2024 at 09:34:52AM +0800, Dawei Li wrote:
> > Hi Greg,
> > 
> > Thanks for reviewing.
> > 
> > On Tue, Jan 30, 2024 at 06:04:17AM -0800, Greg KH wrote:
> > > On Tue, Jan 30, 2024 at 12:06:32PM +0800, Dawei Li wrote:
> > > > For data structures needs cpu_to_le* conversion, its prototype needs to
> > > > be declared with __le* explicitly.
> > > > 
> > > > Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/
> > > > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > > > Cc: <stable@vger.kernel.org>
> > > > ---
> > > >  drivers/misc/eeprom/idt_89hpesx.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
> > > > index d807d08e2614..327afb866b21 100644
> > > > --- a/drivers/misc/eeprom/idt_89hpesx.c
> > > > +++ b/drivers/misc/eeprom/idt_89hpesx.c
> > > > @@ -129,7 +129,7 @@ struct idt_smb_seq {
> > > >  struct idt_eeprom_seq {
> > > >  	u8 cmd;
> > > >  	u8 eeaddr;
> > > > -	u16 memaddr;
> > > > +	__le16 memaddr;
> > > >  	u8 data;
> > > >  } __packed;
> > > >  
> > > > @@ -141,8 +141,8 @@ struct idt_eeprom_seq {
> > > >   */
> > > >  struct idt_csr_seq {
> > > >  	u8 cmd;
> > > > -	u16 csraddr;
> > > > -	u32 data;
> > > > +	__le16 csraddr;
> > > > +	__le32 data;
> > > >  } __packed;
> > > >  
> > > >  /*
> > > 
> > > Declaring them this way is nice, but this doesn't actually "fix"
> > > anything at all as no code is actually changed.
> > > 
> > > So how is ths a bugfix?  How does this patch do anything?
> > > 
> > > confused,
> > 
> > Sorry for the confuson.
> > 
> > This commit is to address the issue reported by kernel test rebot[1].
> > 
> > Partially quoted from it:
> > 
> > sparse warnings: (new ones prefixed by >>)
> > >> drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] memaddr @@     got restricted __le16 [usertype] @@
> >    drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:     expected unsigned short [addressable] [assigned] [usertype] memaddr
> >    drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:     got restricted __le16 [usertype]
> >    drivers/misc/eeprom/idt_89hpesx.c:671:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] memaddr @@     got restricted __le16 [usertype] @@
> >    drivers/misc/eeprom/idt_89hpesx.c:671:31: sparse:     expected unsigned short [addressable] [assigned] [usertype] memaddr
> >    drivers/misc/eeprom/idt_89hpesx.c:671:31: sparse:     got restricted __le16 [usertype]
> > >> drivers/misc/eeprom/idt_89hpesx.c:769:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] csraddr @@     got restricted __le16 [usertype] @@
> >    drivers/misc/eeprom/idt_89hpesx.c:769:24: sparse:     expected unsigned short [addressable] [assigned] [usertype] csraddr
> >    drivers/misc/eeprom/idt_89hpesx.c:769:24: sparse:     got restricted __le16 [usertype]
> > >> drivers/misc/eeprom/idt_89hpesx.c:770:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] data @@     got restricted __le32 [usertype] @@
> >    drivers/misc/eeprom/idt_89hpesx.c:770:21: sparse:     expected unsigned int [addressable] [assigned] [usertype] data
> >    drivers/misc/eeprom/idt_89hpesx.c:770:21: sparse:     got restricted __le32 [usertype]
> >    drivers/misc/eeprom/idt_89hpesx.c:834:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] csraddr @@     got restricted __le16 [usertype] @@
> >    drivers/misc/eeprom/idt_89hpesx.c:834:24: sparse:     expected unsigned short [addressable] [assigned] [usertype] csraddr
> >    drivers/misc/eeprom/idt_89hpesx.c:834:24: sparse:     got restricted __le16 [usertype]
> > >> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
> > >> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
> > >> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
> > >> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
> > >> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
> > >> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
> > 
> > [1] https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/
> 
> Ok, so this fixes a sparse issue, how is that needed for stable kernels?
> 
> Please be more explicit about what you are "fixing" in the changelog
> please, as-is this didn't make any sense to me.

Yes, it's my fault not making it clear in commit message. Sorry for
that.

> 
> Please fix up and send a v2.

Will do that.

> 
> thanks,
> 
> greg k-h
> 

Thanks,

    Dawei


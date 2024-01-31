Return-Path: <linux-kernel+bounces-45598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766F88432D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95011C259F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C45673;
	Wed, 31 Jan 2024 01:35:36 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0685224;
	Wed, 31 Jan 2024 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664936; cv=none; b=G86lw/Wi2WMEXiw7VfeQOTupQmG+KIloUAkOJGMdJcJJORahpFyITcyBFxn7biLgRuU9GlrO16FUyGLKlks2Se0zaI4XwNSnbmKwMVqxNHzu4iK/0Wb7qr6YhoEl9EO8VEC97Cb+y2PEjjzq0yhN6VQ2IkEgHONDge2I5UBlg7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664936; c=relaxed/simple;
	bh=JABR628JhKfDEauT8EwSw8z5YLEql3Ddf6/Lsazad+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiGpeLyUNnLYY7UE3LgU4mrBCGC8yfNdXEtlHY2srsjEc6MVCEqq3rBuBNvDuhAKiriHxBx+xrhlq7Kp+mIfCYt+kBN6+TIjERe5CpLAwHDcnCCgK/e7xgnE96ppSvtxFIbJW1FNt1LATLLN8HHQ2cIIN6gdWctGP0FG/HqmoDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp79t1706664893t5ec4qpb
X-QQ-Originating-IP: KLWLno1z+YBwajOmzBSk8syMSjZewzrtPUskMRnxhGk=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jan 2024 09:34:52 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: xwvWJGGFd7Nhngy97HaDG0YFqzS8IYQiaIhfPpcCmo6nrTjJeTHE7WYcUmrxy
	h7NIHa6HDO5KrWMR1TzSGuBh4eJC2AlxMDIvxcYwn+S1TNw/ecLu4p5KWiRfY75o0rosD8a
	/Rf8ksG5TTxTKPVxVXBiCJPg5o8OR+OJYS2EnXuDy3KBL8cfc7RRF60HgyL3tDm4/h1GExo
	TbLUvniXWAkItLmL1CSWRROttiS4Ay2WYiTrABCR9+77f7MSYLvCd0aUzg380F9QASDYLQ+
	DbLnNE7T4VR66ALkmPL7MZ/AqMLpPKldSX9jBVdNHr8zT1amTqg9MlmnwTAQVoR+cnFXS2z
	lkk4mgEP24PFmDwJ2ZbGTuV2kFNbDRRIjnGlM9fxw/Xllp/cZwe92zujTz52NwHsgh4n9BG
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5899189523940205269
Date: Wed, 31 Jan 2024 09:34:52 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, fancer.lancer@gmail.com, lkp@intel.com,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] misc: eeprom/idt_89hpesx: Convert data structures to LE
 explicitly
Message-ID: <03B279416A25E958+ZbmjvFafk44HBl4b@centos8>
References: <20240130040632.3039911-1-dawei.li@shingroup.cn>
 <2024013039-asleep-rally-39c0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024013039-asleep-rally-39c0@gregkh>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Greg,

Thanks for reviewing.

On Tue, Jan 30, 2024 at 06:04:17AM -0800, Greg KH wrote:
> On Tue, Jan 30, 2024 at 12:06:32PM +0800, Dawei Li wrote:
> > For data structures needs cpu_to_le* conversion, its prototype needs to
> > be declared with __le* explicitly.
> > 
> > Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  drivers/misc/eeprom/idt_89hpesx.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
> > index d807d08e2614..327afb866b21 100644
> > --- a/drivers/misc/eeprom/idt_89hpesx.c
> > +++ b/drivers/misc/eeprom/idt_89hpesx.c
> > @@ -129,7 +129,7 @@ struct idt_smb_seq {
> >  struct idt_eeprom_seq {
> >  	u8 cmd;
> >  	u8 eeaddr;
> > -	u16 memaddr;
> > +	__le16 memaddr;
> >  	u8 data;
> >  } __packed;
> >  
> > @@ -141,8 +141,8 @@ struct idt_eeprom_seq {
> >   */
> >  struct idt_csr_seq {
> >  	u8 cmd;
> > -	u16 csraddr;
> > -	u32 data;
> > +	__le16 csraddr;
> > +	__le32 data;
> >  } __packed;
> >  
> >  /*
> 
> Declaring them this way is nice, but this doesn't actually "fix"
> anything at all as no code is actually changed.
> 
> So how is ths a bugfix?  How does this patch do anything?
> 
> confused,

Sorry for the confuson.

This commit is to address the issue reported by kernel test rebot[1].

Partially quoted from it:

sparse warnings: (new ones prefixed by >>)
>> drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] memaddr @@     got restricted __le16 [usertype] @@
   drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:     expected unsigned short [addressable] [assigned] [usertype] memaddr
   drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:     got restricted __le16 [usertype]
   drivers/misc/eeprom/idt_89hpesx.c:671:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] memaddr @@     got restricted __le16 [usertype] @@
   drivers/misc/eeprom/idt_89hpesx.c:671:31: sparse:     expected unsigned short [addressable] [assigned] [usertype] memaddr
   drivers/misc/eeprom/idt_89hpesx.c:671:31: sparse:     got restricted __le16 [usertype]
>> drivers/misc/eeprom/idt_89hpesx.c:769:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] csraddr @@     got restricted __le16 [usertype] @@
   drivers/misc/eeprom/idt_89hpesx.c:769:24: sparse:     expected unsigned short [addressable] [assigned] [usertype] csraddr
   drivers/misc/eeprom/idt_89hpesx.c:769:24: sparse:     got restricted __le16 [usertype]
>> drivers/misc/eeprom/idt_89hpesx.c:770:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] data @@     got restricted __le32 [usertype] @@
   drivers/misc/eeprom/idt_89hpesx.c:770:21: sparse:     expected unsigned int [addressable] [assigned] [usertype] data
   drivers/misc/eeprom/idt_89hpesx.c:770:21: sparse:     got restricted __le32 [usertype]
   drivers/misc/eeprom/idt_89hpesx.c:834:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] csraddr @@     got restricted __le16 [usertype] @@
   drivers/misc/eeprom/idt_89hpesx.c:834:24: sparse:     expected unsigned short [addressable] [assigned] [usertype] csraddr
   drivers/misc/eeprom/idt_89hpesx.c:834:24: sparse:     got restricted __le16 [usertype]
>> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
>> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
>> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
>> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
>> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
>> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32

[1] https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/

Thanks,

    Dawei

> 
> greg k-h
> 


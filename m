Return-Path: <linux-kernel+bounces-45621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C6684331C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E911F27389
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202605240;
	Wed, 31 Jan 2024 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mGirAuWh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566FA4C98;
	Wed, 31 Jan 2024 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706666840; cv=none; b=totEpOyow/qowSurvM/A34/Fnynek0EQulSTU+5ZSotpzwR/nyIdjPJul0XCdiMDoUqN8Yza8WwQbWEQrAKsqVNSMc03/9RvIhARpO0L5h/2M8hoLocWvIPwLwH4vNK4WacnZagm61Yv7nvjBn+zy7cNDxfeizQUanNPEg73JwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706666840; c=relaxed/simple;
	bh=a84fhSd5NWwuU528F2aAkVgPYAT/j+h1xrXm8mMAM4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUD9X0RoJI/UVXHOsoBoNpzbfAa9dtzFfUt1Xf7f2nLA8c6FaNF+4fUDLoe3USpqM4V47R3j6XrfCYxqRw8UWmbjIbNU/jm174wUFC+8hS+mvTOxR0Rhqw3sNCOoNv6SrWXYJASBIzpAlGJMhK0RJ589uUBwHCbHePuvbxn7M0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mGirAuWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924B3C433C7;
	Wed, 31 Jan 2024 02:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706666839;
	bh=a84fhSd5NWwuU528F2aAkVgPYAT/j+h1xrXm8mMAM4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGirAuWh9b+91QHJz+wOG3Zbxa5ebhd2TM34ES7jIXe/6+U6Hq4o1IyANwKO9d/si
	 9JZR6ys4q5eQJ1wsm+jxlBHK24UXgjkHC8uyBuf3ERx0jYznsUZsSMU8seMSJH/R3d
	 S70YJONkgHJX+CHh+s2He9fBS52P12a3r+F44oHE=
Date: Tue, 30 Jan 2024 18:07:18 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: arnd@arndb.de, fancer.lancer@gmail.com, lkp@intel.com,
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] misc: eeprom/idt_89hpesx: Convert data structures to LE
 explicitly
Message-ID: <2024013030-paternal-robotics-7fdf@gregkh>
References: <20240130040632.3039911-1-dawei.li@shingroup.cn>
 <2024013039-asleep-rally-39c0@gregkh>
 <03B279416A25E958+ZbmjvFafk44HBl4b@centos8>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03B279416A25E958+ZbmjvFafk44HBl4b@centos8>

On Wed, Jan 31, 2024 at 09:34:52AM +0800, Dawei Li wrote:
> Hi Greg,
> 
> Thanks for reviewing.
> 
> On Tue, Jan 30, 2024 at 06:04:17AM -0800, Greg KH wrote:
> > On Tue, Jan 30, 2024 at 12:06:32PM +0800, Dawei Li wrote:
> > > For data structures needs cpu_to_le* conversion, its prototype needs to
> > > be declared with __le* explicitly.
> > > 
> > > Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/
> > > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > > Cc: <stable@vger.kernel.org>
> > > ---
> > >  drivers/misc/eeprom/idt_89hpesx.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
> > > index d807d08e2614..327afb866b21 100644
> > > --- a/drivers/misc/eeprom/idt_89hpesx.c
> > > +++ b/drivers/misc/eeprom/idt_89hpesx.c
> > > @@ -129,7 +129,7 @@ struct idt_smb_seq {
> > >  struct idt_eeprom_seq {
> > >  	u8 cmd;
> > >  	u8 eeaddr;
> > > -	u16 memaddr;
> > > +	__le16 memaddr;
> > >  	u8 data;
> > >  } __packed;
> > >  
> > > @@ -141,8 +141,8 @@ struct idt_eeprom_seq {
> > >   */
> > >  struct idt_csr_seq {
> > >  	u8 cmd;
> > > -	u16 csraddr;
> > > -	u32 data;
> > > +	__le16 csraddr;
> > > +	__le32 data;
> > >  } __packed;
> > >  
> > >  /*
> > 
> > Declaring them this way is nice, but this doesn't actually "fix"
> > anything at all as no code is actually changed.
> > 
> > So how is ths a bugfix?  How does this patch do anything?
> > 
> > confused,
> 
> Sorry for the confuson.
> 
> This commit is to address the issue reported by kernel test rebot[1].
> 
> Partially quoted from it:
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] memaddr @@     got restricted __le16 [usertype] @@
>    drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:     expected unsigned short [addressable] [assigned] [usertype] memaddr
>    drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:     got restricted __le16 [usertype]
>    drivers/misc/eeprom/idt_89hpesx.c:671:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] memaddr @@     got restricted __le16 [usertype] @@
>    drivers/misc/eeprom/idt_89hpesx.c:671:31: sparse:     expected unsigned short [addressable] [assigned] [usertype] memaddr
>    drivers/misc/eeprom/idt_89hpesx.c:671:31: sparse:     got restricted __le16 [usertype]
> >> drivers/misc/eeprom/idt_89hpesx.c:769:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] csraddr @@     got restricted __le16 [usertype] @@
>    drivers/misc/eeprom/idt_89hpesx.c:769:24: sparse:     expected unsigned short [addressable] [assigned] [usertype] csraddr
>    drivers/misc/eeprom/idt_89hpesx.c:769:24: sparse:     got restricted __le16 [usertype]
> >> drivers/misc/eeprom/idt_89hpesx.c:770:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [assigned] [usertype] data @@     got restricted __le32 [usertype] @@
>    drivers/misc/eeprom/idt_89hpesx.c:770:21: sparse:     expected unsigned int [addressable] [assigned] [usertype] data
>    drivers/misc/eeprom/idt_89hpesx.c:770:21: sparse:     got restricted __le32 [usertype]
>    drivers/misc/eeprom/idt_89hpesx.c:834:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] csraddr @@     got restricted __le16 [usertype] @@
>    drivers/misc/eeprom/idt_89hpesx.c:834:24: sparse:     expected unsigned short [addressable] [assigned] [usertype] csraddr
>    drivers/misc/eeprom/idt_89hpesx.c:834:24: sparse:     got restricted __le16 [usertype]
> >> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
> >> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
> >> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
> >> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
> >> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
> >> drivers/misc/eeprom/idt_89hpesx.c:859:17: sparse: sparse: cast to restricted __le32
> 
> [1] https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/

Ok, so this fixes a sparse issue, how is that needed for stable kernels?

Please be more explicit about what you are "fixing" in the changelog
please, as-is this didn't make any sense to me.

Please fix up and send a v2.

thanks,

greg k-h


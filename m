Return-Path: <linux-kernel+bounces-65021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610A28546D1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9ED7B22D70
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A331798E;
	Wed, 14 Feb 2024 10:06:51 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049E7168BC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905211; cv=none; b=GMsu248nRpA2YWosUPiqbuRGjUN3fNs+lLN5hcpheAdgMd3rtTcr/CpMkC6rN+PqpE4OMhG4wmmZea3Nr8hok1orO4DUyom+zDZF6cGtdatvKzeEVT3v9R6kPUCSDtPCrzbLJ6DHGjSJfRD9F4szbUrWj6y0wZHZcCcI1Y3GD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905211; c=relaxed/simple;
	bh=goS8bAK1n5A466dFSGmajAHPoVZCtr8W5Tvk/HsQ9nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQXGqaFYowZjg8ho67O0Kvu9q+BguRIeuXEVRi5AP3ODMn+zwOc5SSUJBKBzaRbyYh3jRmufB0kzqcgQcNON6xxloFsbDnAAcweiwD99NrHl2O65JN3QrUJFjtPIqmZQBxxYzRMLsfpNZrGlgk7K6YNVvSGL4tunK1GklWOzQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp82t1707905147tm9huc1i
X-QQ-Originating-IP: WyFKD7/z1B/HiNMRMcyq0Fhg/dFCBjdoKWsB3R+UnvA=
Received: from localhost ( [112.22.30.30])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 Feb 2024 18:05:46 +0800 (CST)
X-QQ-SSF: 01400000002000504000B00A0000000
X-QQ-FEAT: 3M0okmaRx3gZjUgebYN+4CRUMvLOmeYVy5GpH82cW2ucc4e+ZgyvUOcpzh82T
	+50h0gTlQ0B9fBNYefdu95HMx2RHMz1BZKNRkUPx83gH63Zl/SERnL7+UstY7yOhx3+faMV
	t2LnCfMKFwBMUG9cQE4roBpuOg9rvrpwXEO92Ye8g15M1mVB4ysDwgORQ0idLIQZFtaxrXp
	AoVzcDDru5Gygtd5RX465YcvguBDLz3l7AR439ObKsppJoCysLWGlGak+lrmHJ9JGncHK5+
	nbdw3ReGlRxbmtYw8i0T25glxbwXPwDrUUqH41Jk+SUL+8snLvktdbRYdNHEkKVN3kwqYAO
	SVZINvazJs8Q3DGqlKtPTMKiBM1jmUW7GrEBpzo3yaN+Uy+7gPeZL6vsMBLvu2G4Hmaa2iT
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8966854215807188254
Date: Wed, 14 Feb 2024 18:05:46 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: arnd@arndb.de, gregkh@linuxfoundation.org
Cc: fancer.lancer@gmail.com, lkp@intel.com, linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com
Subject: Re: [PATCH v2] misc: eeprom/idt_89hpesx: Convert data structures to
 LE explicitly
Message-ID: <C0067E9E28DB5E80+ZcyQegaiH2DvYACQ@centos8>
References: <20240131033028.3099156-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131033028.3099156-1-dawei.li@shingroup.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Greg,

Sorry for bothering.

On Wed, Jan 31, 2024 at 11:30:28AM +0800, Dawei Li wrote:
> Kernel test robot reports following sparse warnings:
> >> drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse: sparse:
>    incorrect type in assignment (different base types) @@
>    expected unsigned short [addressable] [assigned] [usertype]
>    memaddr @@     got restricted __le16 [usertype] @@
> 
>    drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:
>    expected unsigned short [addressable] [assigned] [usertype]
>    memaddr
> 
>    drivers/misc/eeprom/idt_89hpesx.c:599:31: sparse:
>    restricted __le16 [usertype]
> 
>    .....
> 
> For data structures needs cpu_to_le* conversion, their prototype need
> to be declared with __le* explicitly.
> 
> Declare data structures to __le* explicitly to address the issue:
> - struct idt_eeprom_seq::memaddr
> - struct idt_csr_seq::csraddr
> - struct idt_csr_seq::data
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401261250.b07Yt30Z-lkp@intel.com/
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> v1 -> v2:
> - Add sparse warning info from Kernel test robot.
> - Remove Fixes & cc stable tag.
> - Add Reviewed-by from Serge.
> 
> v1: https://lore.kernel.org/all/20240130040632.3039911-1-dawei.li@shingroup.cn/
> 

Any comments on this?

Thanks,

    Dawei

>  drivers/misc/eeprom/idt_89hpesx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
> index d807d08e2614..327afb866b21 100644
> --- a/drivers/misc/eeprom/idt_89hpesx.c
> +++ b/drivers/misc/eeprom/idt_89hpesx.c
> @@ -129,7 +129,7 @@ struct idt_smb_seq {
>  struct idt_eeprom_seq {
>  	u8 cmd;
>  	u8 eeaddr;
> -	u16 memaddr;
> +	__le16 memaddr;
>  	u8 data;
>  } __packed;
>  
> @@ -141,8 +141,8 @@ struct idt_eeprom_seq {
>   */
>  struct idt_csr_seq {
>  	u8 cmd;
> -	u16 csraddr;
> -	u32 data;
> +	__le16 csraddr;
> +	__le32 data;
>  } __packed;
>  
>  /*
> -- 
> 2.27.0
> 


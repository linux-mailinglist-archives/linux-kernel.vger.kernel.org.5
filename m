Return-Path: <linux-kernel+bounces-32494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61437835C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6A61F22F34
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62681AAC9;
	Mon, 22 Jan 2024 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8qIxTf+"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861B1A5BA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705911188; cv=none; b=OoCpCzvHWsGnri3kjlCCtTnnYXUqTdgKdOHKt3eZihNUkRsdqZOKW6KsfZQSJrtEMf9Hcj5GqvM7jNWMkZHxRXNUZG/IKUw/ozt46yvn1AsrVukoyj7a+dhXiFH53w3agUomSEbDGac7G1oRvt6cNj2ni4NfhsLIKxGRcRwybD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705911188; c=relaxed/simple;
	bh=3cRrw0cHWQn+cK7d5PNQX3dC1AeMdE5G7mqfe1DLWq0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cbps228hVo6OEyxF6ptBIYoy+BMzCK3hdB/LlwfnnBRuZhT2T5oly4/L9iCBowwyb1SxJCnmblt3LrRmGsC96G6qcItmfp2GEJarnuudy2qXwJHzr0HQcfQWSxGigDKCgIjdC1SQb4LAN9aZ4kqOSDBRjJ97XyM8cw36ynmZYpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v8qIxTf+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so2656153f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705911185; x=1706515985; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Le+VGGy4jaBeLxGf8XEn/QIwzoPXkfhsyE8WPths7mA=;
        b=v8qIxTf+3MeqQo+2yt2yvLtFCf4mU5zJIVByHnzaEvfC25w9g07EiYsCTEom46p//I
         Z/MZ/XSLK/V+tx+Lkb64GBmrJ81rU04H70yfTJ9RhB48tLOAE6ViGDvQhOsLn3GqNZqR
         GFoHOYe3kKWvza9Fq/+hR6D0LyR2yMzsYHvnp7v5WCcHuyaaPIjviLZ7IXLtKZTQMR23
         iSnHCTaXaAzmyASFVWgQv941SubR1wmuTfxuD1S58CsGgwPiT0hfjqedWYs9zdq5Ycrh
         U1lC8AQAJN9tKyVUVwoDnsFN2lDiFOn/iluMRlhn/CsN9kcg7/1CazSGE/Yd9Bw0nSKR
         BPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705911185; x=1706515985;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Le+VGGy4jaBeLxGf8XEn/QIwzoPXkfhsyE8WPths7mA=;
        b=NbUnS9ZkBhCwogHX6PsBmz4lwmqVvZIbWJUwp6z7PCttyR5+/y0tEaDYM0jufmyae5
         Fi7A6iKAW021RwYew1sbbH/zoXCmE+wHjQ9KIg9LkW/USMlcodY+02U3UeYYN9svDp6m
         ecrD6FZqIFhtGBS11EUUCfu0CzS8hD/u4/u5GAE16he7xFlyum1ItRaxwvza9R4/C+jl
         +DiMOa+cfVCGt7s6hz63R2af78pIzDv3bDTpYMd//VDIBPR9MyP3zumr8MhY4KpIGtUZ
         vKzgmBAUcEv6eHOJ9nxIJNcjL33UkmPo9FK5VpnXKE916IJ6G7erRvnBxzyPg95NsPIW
         tY5A==
X-Gm-Message-State: AOJu0YyjPf5NA7nc3elgTkND65zIpuWa2Ems0aYCYlDYwdcsPXszWNnT
	66D+NEOSI2z+v6IK+OFSSk+UVHe0kWVq8BmAZlleFXErehnC87WhQVGQUTpSfQ4=
X-Google-Smtp-Source: AGHT+IF977NpNX+JrUqSrTbnSB/ycvIm+HkYZ2A/R1a5lYJmowh/lHmjTVWi+Nb89yEWmbkjt6/nNg==
X-Received: by 2002:a5d:608f:0:b0:337:d6d9:bf3b with SMTP id w15-20020a5d608f000000b00337d6d9bf3bmr72529wrt.117.1705911185509;
        Mon, 22 Jan 2024 00:13:05 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id f11-20020adff98b000000b00337d5cd0d8asm10038112wrr.90.2024.01.22.00.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:13:05 -0800 (PST)
Date: Mon, 22 Jan 2024 11:13:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Deepak R Varma <drv@mailo.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drivers/staging/wlan-ng/prism2fw.c:625 mkpdrlist() error:
 __builtin_memcpy() '&pda->rec[pda->nrec]->data.mfisuprange' too small (8 vs
 10)
Message-ID: <4a0b9870-b946-46e4-99fe-25bb8a03e2e7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d64bf433c53cab2f48a3fff7a1f2a696bc5229a
commit: 049e40ef203ebdf530cb37a3f5f7752d0c07b288 staging: wlan-ng: Remove unused code
config: x86_64-randconfig-161-20240120 (https://download.01.org/0day-ci/archive/20240120/202401202022.g64TD42E-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202401202022.g64TD42E-lkp@intel.com/

New smatch warnings:
drivers/staging/wlan-ng/prism2fw.c:625 mkpdrlist() error: __builtin_memcpy() '&pda->rec[pda->nrec]->data.mfisuprange' too small (8 vs 10)
drivers/staging/wlan-ng/prism2fw.c:634 mkpdrlist() error: __builtin_memcpy() '&pda->rec[pda->nrec]->data.cfisuprange' too small (8 vs 10)

Old smatch warnings:
drivers/staging/wlan-ng/prism2fw.c:951 read_fwfile() error: buffer overflow 'tmpinfo' 4 <= 4

vim +625 drivers/staging/wlan-ng/prism2fw.c

ae24e13a6485a6 Devendra Naga      2012-09-09  603  static int mkpdrlist(struct pda *pda)
76e3e7c4095237 Karl Relton        2009-04-17  604  {
76b4580bf4eaf1 Maciek Borzecki    2017-04-08  605  	__le16 *pda16 = (__le16 *)pda->buf;
76e3e7c4095237 Karl Relton        2009-04-17  606  	int curroff;		/* in 'words' */
76e3e7c4095237 Karl Relton        2009-04-17  607  
76e3e7c4095237 Karl Relton        2009-04-17  608  	pda->nrec = 0;
76e3e7c4095237 Karl Relton        2009-04-17  609  	curroff = 0;
4ccb726c728cb4 Tillmann Heidsieck 2015-09-23  610  	while (curroff < (HFA384x_PDA_LEN_MAX / 2 - 1) &&
75f49e07520d03 Mithlesh Thukral   2009-05-25  611  	       le16_to_cpu(pda16[curroff + 1]) != HFA384x_PDR_END_OF_PDA) {
b586fbd3968a32 Sergio Paracuellos 2016-11-07  612  		pda->rec[pda->nrec] = (struct hfa384x_pdrec *)&pda16[curroff];
76e3e7c4095237 Karl Relton        2009-04-17  613  
cf66823dd22429 Devendra Naga      2012-06-06  614  		if (le16_to_cpu(pda->rec[pda->nrec]->code) ==
cf66823dd22429 Devendra Naga      2012-06-06  615  		    HFA384x_PDR_NICID) {
76e3e7c4095237 Karl Relton        2009-04-17  616  			memcpy(&nicid, &pda->rec[pda->nrec]->data.nicid,
76e3e7c4095237 Karl Relton        2009-04-17  617  			       sizeof(nicid));
b1bb2e33ae1fa9 Thibaut SAUTEREAU  2017-05-12  618  			le16_to_cpus(&nicid.id);
b1bb2e33ae1fa9 Thibaut SAUTEREAU  2017-05-12  619  			le16_to_cpus(&nicid.variant);
b1bb2e33ae1fa9 Thibaut SAUTEREAU  2017-05-12  620  			le16_to_cpus(&nicid.major);
b1bb2e33ae1fa9 Thibaut SAUTEREAU  2017-05-12  621  			le16_to_cpus(&nicid.minor);
76e3e7c4095237 Karl Relton        2009-04-17  622  		}
76e3e7c4095237 Karl Relton        2009-04-17  623  		if (le16_to_cpu(pda->rec[pda->nrec]->code) ==
76e3e7c4095237 Karl Relton        2009-04-17  624  		    HFA384x_PDR_MFISUPRANGE) {
76e3e7c4095237 Karl Relton        2009-04-17 @625  			memcpy(&rfid, &pda->rec[pda->nrec]->data.mfisuprange,
76e3e7c4095237 Karl Relton        2009-04-17  626  			       sizeof(rfid));

So &pda->rec[pda->nrec]->data is a union which used to hold a bunch of
different types in it.  At least two of those types was 60 bytes long.
So when we removed it, then the total size of pda->rec[pda->nrec]->data
became 8 bytes and it triggers a read overflow warning in Smatch.

Here is who ->data is defined now.

drivers/staging/wlan-ng/hfa384x.h
   886  struct hfa384x_pdr_mfisuprange {
   887          u16 id;
   888          u16 variant;
   889          u16 bottom;
   890          u16 top;
   891  } __packed;
   892  
   893  struct hfa384x_pdr_cfisuprange {
   894          u16 id;
   895          u16 variant;
   896          u16 bottom;
   897          u16 top;
   898  } __packed;
   899  
   900  struct hfa384x_pdr_nicid {
   901          u16 id;
   902          u16 variant;
   903          u16 major;
   904          u16 minor;
   905  } __packed;
   906  
   907  struct hfa384x_pdrec {
   908          __le16 len;             /* in words */
   909          __le16 code;
   910          union pdr {
   911                  struct hfa384x_pdr_mfisuprange mfisuprange;
   912                  struct hfa384x_pdr_cfisuprange cfisuprange;
   913                  struct hfa384x_pdr_nicid nicid;
   914  
   915          } data;
   916  } __packed;

And here is how rfid is defined.

   359  struct hfa384x_caplevel {
   360          u16 role;
   361          u16 id;
   362          u16 variant;
   363          u16 bottom;
   364          u16 top;
   365  } __packed;

Obviously it doesn't match.  So probably the code works, but obviously
something is defined incorrectly.

b1bb2e33ae1fa9 Thibaut SAUTEREAU  2017-05-12  627  			le16_to_cpus(&rfid.id);
b1bb2e33ae1fa9 Thibaut SAUTEREAU  2017-05-12  628  			le16_to_cpus(&rfid.variant);
b1bb2e33ae1fa9 Thibaut SAUTEREAU  2017-05-12  629  			le16_to_cpus(&rfid.bottom);
b1bb2e33ae1fa9 Thibaut SAUTEREAU  2017-05-12  630  			le16_to_cpus(&rfid.top);
76e3e7c4095237 Karl Relton        2009-04-17  631  		}
76e3e7c4095237 Karl Relton        2009-04-17  632  		if (le16_to_cpu(pda->rec[pda->nrec]->code) ==
76e3e7c4095237 Karl Relton        2009-04-17  633  		    HFA384x_PDR_CFISUPRANGE) {
76e3e7c4095237 Karl Relton        2009-04-17 @634  			memcpy(&macid, &pda->rec[pda->nrec]->data.cfisuprange,
76e3e7c4095237 Karl Relton        2009-04-17  635  			       sizeof(macid));

Same thing here.

KTODO: Silence Smatch warning in mkpdrlist()

regards,
dan carpenter

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



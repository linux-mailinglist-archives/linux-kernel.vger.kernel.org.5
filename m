Return-Path: <linux-kernel+bounces-106424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD3F87EE78
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468D2284D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B69854FA4;
	Mon, 18 Mar 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCWb+peo"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2496054BC5;
	Mon, 18 Mar 2024 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781761; cv=none; b=pl+DgRtJdloBMLpblXRLQ8JD+TRm4R/QulNjgpJsCAP/bPjeu2CDYfRFTpyxLTz1RIU11qS09PyxmGUAczvMAa44i2jAX905sZPGGWL+dbapIjWIP0slTMK4da43A9GYV/r1m9Om4aNPQmqO4fieXidPgwwrE6P6pdusXZimF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781761; c=relaxed/simple;
	bh=jNRe2ju3Zcf7G54gDt0tR7LNFlKhal3eQR/I3o+piho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+6H7IQkrkog4+Dt5HE+rSeTDCr/E65/HXKImpaj4iTH5h4C9K8p/5iI9dSL1/LCptQBDlasBnNnx3dieXMD2VWZqjL5hjkkCcRmIDrG+Ruug3OX26I2V31DZz3S2sTkSF2BfT89XQJsddP9Q48iQldSKukWYoTpzvHc8P84C1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCWb+peo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dff837d674so14502185ad.3;
        Mon, 18 Mar 2024 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710781759; x=1711386559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vfm8aqSFTZhq4k8QDQrwA8cmUmmr2go/ov1JbIvzwB4=;
        b=cCWb+peoIxZFez2M2qCmPeVyD+CRjH0MwMdh+hUA//X1/hn7iJhwtX5M2RoCjw8nkm
         HsJIfbS58YI0viS3NqmPpLEnz27T8mdYij1O94Xoypd5n+oFPa0n8HJhtIWcwMnJKV17
         OAGtxAnmEKQJLVifrxuLKs/hJFDRjGccsOzujxj4iloAC1ENOgh6TCT0aWN0jKDlB2kb
         9manIB+WYoBBkETDZg8opODJh8WmoeEOdTn1Z3mYJK0gUkpKgEGmInVcPN3xEjslwGNt
         JfozWTYGZciZ6VjBb2gPGkC11FXX8JV71eL1GR4mg31Lf7tNQuQNl7himyUptXwQ+Dpt
         OdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781759; x=1711386559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vfm8aqSFTZhq4k8QDQrwA8cmUmmr2go/ov1JbIvzwB4=;
        b=KgyzRKjYfvGczUlI16h69ULFolvBRB0tT1OeiDuDzgTV6dAclk8Xte9uS0HOCTNw0G
         VCGRPJ20SFH6fL/h+9n5EROmZp448x3AGyc0wiDZ13JnoxfcB+goMW6D9QyYRTt9IjXD
         ny+2hQ3skA16br1g6ZfP/ioqrvEawU9Amil5py8zQvs3xKKdGYCpaBPf6G9HdbaeDhpu
         Ox51jONTFPzFq/2w2CRlsBL9KuKAtfFoydmtSfP040RYX+vqUIx+qV3eg1KtYtm0N51N
         wWuTVn8dCbVqsdrSOBnYVDkZFQXitG2YrPMA3uyT3dpnb+V0MQ3oyhAsCbvW+xeVe05s
         pP+w==
X-Forwarded-Encrypted: i=1; AJvYcCWG+zTBI8d2tYLJ+HemQmHOqf6KIm4qaJ08gKpwH7OJe1lAnxy9F7BrDIWR6Xxr4VzxTg8XWZU0MJdWtq0dZ5JXUtCrrVxsBy8kWLk+XtLP0dcLZKHbw6BEyUjvpNvTRxmSoPIDOr8RCQ==
X-Gm-Message-State: AOJu0YwWD2DOWw6Ijbp1zsNIw99mDR8dNiZ7JcntLFQWPjOJhAciyZUE
	MgVYrbfQlq9kcb7+IOUC6wI9gjpPUk4y0pnPgbfJZd/b9DZ27NcuBWtbRlRy
X-Google-Smtp-Source: AGHT+IGWYQREuCQkK5LgsEXAibyefc0q3DE3EHrwCJvnmWmhe5CGw8hhYIJ1LtOZhGE8IkQ49cD4eQ==
X-Received: by 2002:a17:903:8cb:b0:1dd:e159:3e3b with SMTP id lk11-20020a17090308cb00b001dde1593e3bmr348889plb.49.1710781759531;
        Mon, 18 Mar 2024 10:09:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mi16-20020a170902fcd000b001dd578121d4sm9552101plb.204.2024.03.18.10.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:09:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 18 Mar 2024 10:09:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lizhi Hou <lizhi.hou@xilinx.com>,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/2] of: create of_root if no dtb provided
Message-ID: <886049ed-4f5f-4e17-86f4-1245024ade3a@roeck-us.net>
References: <20230317053415.2254616-1-frowand.list@gmail.com>
 <20230317053415.2254616-2-frowand.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317053415.2254616-2-frowand.list@gmail.com>

Hi,

On Fri, Mar 17, 2023 at 12:34:14AM -0500, Frank Rowand wrote:
> When enabling CONFIG_OF on a platform where of_root is not populated by
> firmware, we end up without a root node. In order to apply overlays and
> create subnodes of the root node, we need one. Create this root node
> by unflattening an empty builtin dtb.
> 
> If firmware provides a flattened device tree (FDT) then the FDT is
> unflattened via setup_arch().  Otherwise setup_of(), which is called
> immediately after setup_arch(), will create the default root node
> if it does not exist.
> 
> Signed-off-by: Frank Rowand <frowand.list@gmail.com>

This patch results in a crash on nios2.

Building nios2:10m50-ghrd:10m50_defconfig:10m50_devboard.dts ... running ...R failed (crashed)
------------
qemu log:
earlycon: uart8250 at MMIO32 0x18001600 (options '')
printk: legacy bootconsole [uart8250] enabled
Linux version 6.8.0-11409-gf6cef5f8c37f (groeck@desktop) (nios2-linux-gcc (GCC) 11.4.0, GNU ld (GNU Binutils) 2.40) #1 Sun Mar 17 23:38:59 PDT 2024
Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed to allocate 72 bytes align=0x40
---[ end Kernel panic - not syncing: early_init_dt_alloc_memory_arch: Failed to allocate 72 bytes align=0x40 ]---

Reverting this patch fixes the problem.

Guenter


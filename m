Return-Path: <linux-kernel+bounces-19141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB882689D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA65281E61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5C8C09;
	Mon,  8 Jan 2024 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9f8nQHZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C0B642
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3368ae75082so1295522f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 23:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704699208; x=1705304008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VsT49imzj00s7Yll7mY42k837UkAbQah3cdA20IzaIY=;
        b=e9f8nQHZBzZH4C2cMvbRd881dsgqU9IP1r/38dI6m6mex4LH4v7m19OWwgYH/z5Dgx
         ruC8nKsLUfz+7Mo0+XJuJMHwzb1HQtJgMzhvcyYRE0jM4qgdRv27EUtNoSd/PR4+0OS8
         PeLXOP2857FJTinYK2wHt8DKJt4JMoHLj2JXJ9rCxTK1hXq4vRXPryjsDiZyMxv9k+rZ
         R4SilUbCiEaHO0fHbVqWfgf43Vhh/UeRIB/HHyoLF/l7Wc29PQLPQMzYLLtg9NehAUpT
         y8W3yFwOCkSwJrGrbt34/ID7H9RoEjpi21pL0lpZyb3UHrNevQ1eSqz4BJsorus4xLDq
         q8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704699208; x=1705304008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsT49imzj00s7Yll7mY42k837UkAbQah3cdA20IzaIY=;
        b=w4B/nkW5MGySUGnHy7OcVYHLQMukQwosHasY0ndbrdLc+k9rxBa4FNrSifYVuXQh+x
         8dl2f62dIRLDLTiNih40ZGKtkE/EP9xHFb7pfAKtpjOhJ8DeSKutlDziWvlOngQeX8jY
         TECCck7KsaJCv5FkXonsU0NwU1ZTzhgZPKhyNVQFBKcBuK0JyratznGg4A+cXlSmNW13
         zHMfZXuLFafYEvHEAqfZ094FeZULMZ0JF8bom9/jmxv4wtpK4JYMG2AKwVky5T+RxQz4
         EA6OeAN0nYuRNA4npxEH72v12MLBZ2dH2SOWrR2Ys4sAkkIVjGfdITYCuQTG6TTGaRGd
         XEYw==
X-Gm-Message-State: AOJu0Yzv1hIz9O0puuVowDqK1eNdWpl1UyOAcv986QM8loFCrclfbMke
	aw2eWZwrniIr3pzLH3SSNIp/oxWb0ipEGw==
X-Google-Smtp-Source: AGHT+IFEon0WJ044xjZRsrBXv1jCnpkHNL4f/KhLfxPPOLM0AFbplbDzxkpS+LR9wL8/p34pMOxh9Q==
X-Received: by 2002:a05:600c:1c92:b0:40d:8f0c:db84 with SMTP id k18-20020a05600c1c9200b0040d8f0cdb84mr1437440wms.184.1704699208301;
        Sun, 07 Jan 2024 23:33:28 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c4e4900b0040e38859c47sm9998015wmq.16.2024.01.07.23.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 23:33:27 -0800 (PST)
Date: Mon, 8 Jan 2024 10:33:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: linux-hardening@vger.kernel.org, keescook@chromium.org,
	error27@gmail.com, gustavoars@kernel.org,
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, vegard.nossum@oracle.com,
	darren.kenny@oracle.com, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in
 dg_dispatch_as_host()
Message-ID: <fc132bde-d42d-4aac-ba91-7a939a18091a@moroto.mountain>
References: <20240105164001.2129796-1-harshit.m.mogalapalli@oracle.com>
 <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>

On Fri, Jan 05, 2024 at 08:40:00AM -0800, Harshit Mogalapalli wrote:
> Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.
> 
> memcpy: detected field-spanning write (size 56) of single field "&dg_info->msg"
> at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)
> 
> WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
> dg_dispatch_as_host+0x88e/0xa60 drivers/misc/vmw_vmci/vmci_datagram.c:237
> 
> Some code commentry, based on my understanding:
> 
> 544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)
> /// This is 24 + payload_size
> 
> memcpy(&dg_info->msg, dg, dg_size);
> 	Destination = dg_info->msg ---> this is a 24 byte
> 					structure(struct vmci_datagram)
> 	Source = dg --> this is a 24 byte structure (struct vmci_datagram)
> 	Size = dg_size = 24 + payload_size
> 
> {payload_size = 56-24 =32} -- Syzkaller managed to set payload_size to 32.
> 
>  35 struct delayed_datagram_info {
>  36         struct datagram_entry *entry;
>  37         struct work_struct work;
>  38         bool in_dg_host_queue;
>  39         /* msg and msg_payload must be together. */
>  40         struct vmci_datagram msg;
>  41         u8 msg_payload[];
>  42 };
> 
> So those extra bytes of payload are copied into msg_payload[], a run time
> warning is seen while fuzzing with Syzkaller.
> 
> One possible way to fix the warning is to split the memcpy() into
> two parts -- one -- direct assignment of msg and second taking care of payload.
> 
> Gustavo quoted:
> "Under FORTIFY_SOURCE we should not copy data across multiple members
> in a structure."
> 
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
> Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This patch is only tested with the C reproducer, not any testing
> specific to driver is done.
> 
> v1->v2: ( Suggestions from Gustavo )
>         1. Change the commit message false positive --> legitimate
>            warning.

The commit message is fine.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

But, I mean, it's not really "legitimate".  It meets the fortify source
heuristic, but it's still a false positive.  Fortify source is
*supposed* to find memory corruption bugs and this is not a memory
corruption bug.  It's just that these days we have to treat foritify
false positives as crashing bugs because people enable it and we have to
fix it.

Let's not pretend that fortify has helped us in this situation, it has
caused us a problem.  It has taken valid code and created a crashing
bug.  I'm not saying that the cost isn't worth it, but let's not pretend.

regards,
dan carpenter




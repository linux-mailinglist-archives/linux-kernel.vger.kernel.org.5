Return-Path: <linux-kernel+bounces-50121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5661E847487
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881F11C266B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839201474CB;
	Fri,  2 Feb 2024 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfKmQUq5"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132F146910;
	Fri,  2 Feb 2024 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890670; cv=none; b=QTvFd0k1NZ8pfxA/FAVml9jAL8uFyZ0b/s9Abp5bvGtv+rdssfvXclVK77OpJBJ+eIFQGWHyILNiFgo5J2jE9/RynAzYSxYGXhAnyWqFCyYAD3bSfeSIHJjY9maosyEN5hjvwq16Te8TR7VoBuS6Dj0sBvJ+pbwWunGn0on6GV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890670; c=relaxed/simple;
	bh=usSbcGb3RaqV2RSxPABIImzxqQW1/1sLUrrVWBoBbA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClC0MV9cteTl84Ugcgc3GzGdeRxhglujelQsXKtTtyAgj4eCztydQCLhxRHH+l+H6lXAtQxRXaOXoIb/FYXsmplN04Mj1KiZSUby2Sub8oq4zN8DwaVmOQj6gxj4vduWBdTd30HNJG0bxLGJ8D2o/vo+FyOGEKubjQSmfuN9LvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfKmQUq5; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c2f4c3282so11054556d6.3;
        Fri, 02 Feb 2024 08:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706890664; x=1707495464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=usSbcGb3RaqV2RSxPABIImzxqQW1/1sLUrrVWBoBbA4=;
        b=dfKmQUq5W4Jbji25529djB8EKLpQgzwsweRjVIDp4BNXKQ7CjoO6Z04eJz4cPbZ6Pa
         5QzosVnCOLSzjfvvPqDB4GshMcT5uTTlSnYNW1mnvcGFtjaHNaodkhmZjFDEbm5ydNwH
         xJwJzWAsxFL3oUzDWiaFFKtMRis+25Ft979VpxEWgwKS9CNKh6N+hiJ1uTR3l0xM5D5v
         ZoauHgO1H9Zo/tPZyIk2yskTGcU/FS0nLJLDzZDfyPt8yhcrEgMPOd/A0megjIuIFwHJ
         Z/CKbfjIchNj3J6wnz5wL4wSKPVZ0EdEJdCSAn6IJtnxj+r/hzg44cwme+t+G2oDm8MT
         +/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706890664; x=1707495464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usSbcGb3RaqV2RSxPABIImzxqQW1/1sLUrrVWBoBbA4=;
        b=QEKdTnhtst/7BA7QvA28F1AkMo2ysNDcMzIccOfHAAFWocBVVcHL6YW0uq+I7jlWVk
         QyIwMQBBGk9JNMsMLTOk+XslV/70NGVv6S6rOixi/WKNdd3Zk6FhsAmAMpT32Ia8SzJP
         h6mrYds4Jky6w7YhLdt8oB6h4+eEHAneZOLW0ga7JQUPs0x+FfdLUAZPQ6Lcz6WNbJHm
         lKg7InTgyRBLuuRoE4gF0t2F2/7YRTuIkF8xKWYWaWAXgcZt24QItxD/8t4WEWvZ27QL
         Yugq8xNS4c11N5EXY4dX85eq+AgcRtq7J+/PXUWs2jhLdCdE0dIA5l8L5wp0yVZZEPAg
         YPNw==
X-Gm-Message-State: AOJu0YyLm3vWh0RIo0Bqre6FnVFztwGOMrr6+As+4JQ9QVmqFpNE+piT
	wNPCFHTYAE8Z0egpJwMtzOTZllFo6nyBflE6WGUvpUL+AoDf7i67b4IzyuS0ZSXPIxVxhrGCWB0
	8Ch3NlDjWW48hQwMOpDLuxuzcE3M=
X-Google-Smtp-Source: AGHT+IGPE48giiqSuCufFbQaL0qfEqgGzTrzgurzMKsBxGt3N8VOVH62E0SDm+BFgqdR0ISODr6eTnmOFy6VvHTqFeU=
X-Received: by 2002:a0c:cc94:0:b0:68c:8904:69ed with SMTP id
 f20-20020a0ccc94000000b0068c890469edmr1434169qvl.39.1706890664563; Fri, 02
 Feb 2024 08:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-5-stefanb@linux.ibm.com> <38230b4c-54ae-45ed-a6fb-34e63501e5b1@linux.ibm.com>
 <CAOQ4uxiYARZBSgzb4_W-RKvB1XLSF3GUBqeLw2kH+eVeZ_8ARQ@mail.gmail.com>
 <c018b014-9ba8-4395-86dc-b61346ab20a8@linux.ibm.com> <CAOQ4uxi6Te8izWpXROthknRaXrVA9jho5nbc+mkuQDrcTLY44Q@mail.gmail.com>
 <CAOQ4uxigdNeE+2nfr4VxS9piQf5hez=ryT0a-jzW+tW0BT-zuw@mail.gmail.com>
 <492ea12a-d79d-47da-9bbe-a7f33051bd3f@linux.ibm.com> <CAOQ4uxgiO1RbsmqOu4F4Foy-MBPecnEXO7BvgDGz-Lzb1Eysog@mail.gmail.com>
 <4c584bfb-d282-4584-bb20-18c26b1033c0@linux.ibm.com> <CAOQ4uxjftr7GGx6tuW_yB_MTaVB57m6p_d=UHhN3Z23YVXY0QQ@mail.gmail.com>
 <11abffea-15c5-4d13-9d0f-edbc54b09bf3@linux.ibm.com> <CAOQ4uxjZ6p9+H54G0LNTUnU56WRaoLtWOUj2nOaKJ4JvBGqLVg@mail.gmail.com>
 <427ce381-73fa-48f9-8e18-77e23813b918@linux.ibm.com> <CAOQ4uxggqa7j0NS1MN3KSvF_qG1FMVmFxacEYSTx+LuvuosJ5g@mail.gmail.com>
 <4ce0e20d-ed14-490d-9446-a6cfbd532bca@linux.ibm.com>
In-Reply-To: <4ce0e20d-ed14-490d-9446-a6cfbd532bca@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 2 Feb 2024 18:17:32 +0200
Message-ID: <CAOQ4uxhkyh19rMXnZ+Ou-Z0DgraBJAvL53K_PK9zRUB2O-Lsqw@mail.gmail.com>
Subject: Re: [PATCH 4/5] evm: Use the real inode's metadata to calculate
 metadata hash
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"

> The odd thing is my updated test case '2' seems to indicate that
> everything already works as expected with CONFIG_OVERLAY_FS_METACOPY=y.
> After causing copy-up of metadata changes to the file content on the
> lower layer still cause permission error to file execution on the
> overlay layer and after restoring the file content on the lower the file
> on the overlay again runs as expected. The file content change + copy-up
> of file content also has completely decoupled the lower file from the
> file on the overlay and changes to the file on the lower cause no more
> file execution rejections on the overlay.
>

Sorry, you lost me.
The combination of IMA+EVM+OVL must be too complicated to
explain in plain language without an explicit test spelled out...

When you write "The file content change + copy-up of file content also
has completely decoupled the lower file from the file on the overlay",
what do you mean by "copy up of the file content"?
Why was the file content copied up?
I was asking about use case that only metadata was copied up but
lower file content, which is still the content of the ovl file was changed
underneath ovl - this case does not cause data content to be copied up.

I don't think we understand each other.

Thanks,
Amir.


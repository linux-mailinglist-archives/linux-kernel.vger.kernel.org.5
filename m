Return-Path: <linux-kernel+bounces-62123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E964A851BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A557B28BEF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE43F9D3;
	Mon, 12 Feb 2024 17:42:26 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE23D556;
	Mon, 12 Feb 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759745; cv=none; b=f20mYbHdp4SOID7gk83zall+T5KtH3lTjBfWok3WBJl/0VEJ+A8ZV6HCgpwHwBBCDlei9a59ZZPUFJ5liZA+juTGQLuDGlw1+xLTiC366094juWtnpFBzuwoWaiH1AHVBPKugAziGIFALAmGpDPW7zfFyLH+pxnShNKwp8cyJp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759745; c=relaxed/simple;
	bh=ly3Up1sfS/t0Ew2QUK9qHHhWYqwOqPvJTdjalcmytT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFhTzLaAOKDKg9+LkWfE70p5bk9hYRZ+uHipPNFIA/pKEg5/NK20rBNwRu4DV9ex8mpOKXXPHN6Uci9byGjtXhhQ46rLRqeh2fPBkXaCJNzqFxsA0or9dB8J173mhtUxx6W2CYRPr7Z6nUFQviU0mrb7eluvNgwli5utBMc0YHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e0f4e3bc59so200395b3a.0;
        Mon, 12 Feb 2024 09:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759744; x=1708364544;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+yDrwQxT+r65vGr0MaMzBCjRWtVjm1bDPgdPwFGnDo=;
        b=SCwRHSx2uIUL7e7PnDqNjt3p6lXsUznUTYoAdUTV7Tfi47oOZ0KQt+stq3EfReQJDQ
         vj1Toya4eemchOywZWFynaFVusA3b6vw9DlYkHkvdojwZB48Z1NaZulfDRyE8HqrJ3Kh
         phAQAuUjh6J3ae2vrrt63nXtR96m/q6VldKZ2wSDgzNby4KraHIj340syrFWD4VGvUyi
         AWcnNzcRlSH2DL1reJm6I5PaakV3hJ0R+rwtV8vn+J1iBnGXG0wIkC0t7RAKrogy0mDd
         FCRZk0205nUyJbF6x1ZcIFYt3RQ4x2M+ci0OVQsvRUYBGChcYjZjnn1FAOoABRiYvQM0
         554g==
X-Forwarded-Encrypted: i=1; AJvYcCWm66zvLRzQcVP5de/asmy2tLihLw7WLV/PlPB2KnPlJ64l1GAfpwxpqitkE9E2sydn5lfb2tb4eBELBfDsqqQZ848T5KPrAtPrBUjIawRpMW0f/0fh9BrkjCHHYgjtQFeEdnfAakJEzQ==
X-Gm-Message-State: AOJu0YwMd9Ek1itsdxJQD1RQszwU95ZIVbzb8YcAcanjQ5PM+96NKQS3
	gYXwUkcLIoelzuna2hkBUA5HoG4f7KP/wpffGP+4pt4571HBfenB
X-Google-Smtp-Source: AGHT+IHeu5WG9ht/2W67QHSLGkApe2Px033H86wK3RcPbjWAf3ERtoqZPjI9PA9iJ7cI/UHgB4CJ8A==
X-Received: by 2002:a05:6a00:b4e:b0:6df:dde5:6025 with SMTP id p14-20020a056a000b4e00b006dfdde56025mr9235968pfo.4.1707759743568;
        Mon, 12 Feb 2024 09:42:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9hkS8/zX1VOHiOmNf7IbxPpipF42pDkzt1vYKUkNaSW+joFXK3Z/SkJ49z6D2O/OYSdpL1Hz++flcysBc+j2K9aJO4CX87LtPCW39mES+b4/eLxv4cdtI13fDqPdYP0k6h7zbhIAkxbim3mCUSkA/W3BJCZeuBym+kUzrlUTFWNyu3RKsKA+4cl9Rl5maRAda2p/Gmhq6PbXWfl7MxIs/
Received: from ?IPV6:2620:0:1000:8411:dfc4:6edd:16dd:210a? ([2620:0:1000:8411:dfc4:6edd:16dd:210a])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78712000000b006db9604bf8csm5768946pfo.131.2024.02.12.09.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 09:42:22 -0800 (PST)
Message-ID: <8d86ebfa-98bc-4752-b413-1ebb98276082@acm.org>
Date: Mon, 12 Feb 2024 09:42:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: Make scsi_bus_type const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240211-bus_cleanup-scsi2-v1-1-dd04ee82e6b0@marliere.net>
 <2024021246-canon-planner-2bf6@gregkh>
 <zcv7kteidcnqj3kpiwwmpdytuirhxbdnzri2rfmumujftthyft@xvcqzmyr2clb>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <zcv7kteidcnqj3kpiwwmpdytuirhxbdnzri2rfmumujftthyft@xvcqzmyr2clb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/24 03:30, Ricardo B. Marliere wrote:
>>> Remove some extraneous whitespace.
> 
> I saw some patches did this, thought it would ok to add.

Please don't do that. Each patch should only make a single logical change.
Additionally, making unnecessary whitespace changes is controversial because
it makes reviewing and backporting patches harder than necessary.

Bart.


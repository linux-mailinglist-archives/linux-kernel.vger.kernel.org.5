Return-Path: <linux-kernel+bounces-30-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 522AD813AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8471F1C20FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730DA6ABA8;
	Thu, 14 Dec 2023 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8UOl1RW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624A6ABA3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d37a6926f7so3816915ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702583253; x=1703188053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qrPBczk1nxet5XoyXxFNY9gkm5lWkc+HoFoBvfRSd8=;
        b=i8UOl1RWFnquohnNp84J2fSzILpbzcn9U1OaGGQQGqkrmBopj6sZoWbrOxwT8zStlI
         D/vYV6qE8tCUBRSsnlWGlkHycUwAzxrv62reoJXEIptVg45w6naqOgXRREVgxtstyB2u
         8WPk3Xhyw4NE0lkXTsnsHcryBYGAMdhTXvmekUSqE8AFntJfX5CCNAHXqViWVfFSiB7v
         hHw8IVz3gMsC8U6MNB9hkxn4+u5GmJE244EGY2r59mSs/q6iVj+tJIAAbRIXxSbs57w4
         iiQkeRi1htFbEy56YUbidH7LBc7YzLVhfkahCf31D197/b4MFYfQKCMjL4Y+ny/S7lSG
         AuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583253; x=1703188053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qrPBczk1nxet5XoyXxFNY9gkm5lWkc+HoFoBvfRSd8=;
        b=QC7pM1yLmbmGy24ltGUG67F86y9iYSPlMHuyMDQhW9zPiDYNfCj6M6kPoStP4SCAH5
         ZSPuv8BP+fszZac4qps90Gn016RVofanvYGq+D8EHRtWrtRw5/XoaATvBaRfnC6RVfC7
         OK88X9p7GTVVshgatZlmfhEgzCj0yN7K9q+yH6b2S13oHMlz0t2LNKHzGC5tyRkvWSHO
         o/fDWKJwqMk54w+vlgXDbT6zprmHl8Gm8bMMGe3rVYort3AlVTEGS2kuo1EY3koG/kh6
         pHNkUqDqFjjjF6ZNjdLlbrtK8N41X0/SLyUaf7mAHRPLeJW24lnRiiWzNGZWqaRPQTjc
         VzuQ==
X-Gm-Message-State: AOJu0YyQou+rqtYJm8SPlNI16FX40qz/m21GmREb6kJj/Z47bENet0QQ
	O8gO7MwjU4pYK/VZVgXLWUov3T4fBFg=
X-Google-Smtp-Source: AGHT+IGgeZvuA3aUPbVYWm1BXjUrO53kh4PLYOTQkNMya8St8EW7UOZ3m5UATt1Fdi1WB7lcMiQKJA==
X-Received: by 2002:a17:902:ea05:b0:1cf:9c0b:b3dc with SMTP id s5-20020a170902ea0500b001cf9c0bb3dcmr6971798plg.69.1702583252873;
        Thu, 14 Dec 2023 11:47:32 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001d349fcb70dsm3887760plh.202.2023.12.14.11.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:47:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 14 Dec 2023 09:47:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
	jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZXtb066P-ZnjxfgK@slm.duckdns.org>
References: <20230729135334.566138-1-atomlin@atomlin.com>
 <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
 <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
 <ZXguMgcKLCLn16T4@localhost.localdomain>
 <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
 <ZXlyfjDsFGbYcMU6@localhost.localdomain>
 <ZXnPVtISKQ2JFDNn@slm.duckdns.org>
 <ZXn4qiMetd7zY1sb@localhost.localdomain>
 <ZXn6J5bN-dPC1WSk@slm.duckdns.org>
 <ZXrmJYvekzrLSaGo@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXrmJYvekzrLSaGo@localhost.localdomain>

Hello,

On Thu, Dec 14, 2023 at 12:25:25PM +0100, Juri Lelli wrote:
> > So, we have to use set_cpus_allowed_ptr() but we still don't want to change
> > the affinity of a rescuer which is already running a task for a pool.
> 
> But then, even today, a rescuer might keep handling work on a cpu
> outside its wq cpumask if the associated wq cpumask change can proceed
> w/o waiting for it to finish the iteration?

Yeah, that can happen and pool cpumasks naturally being subsets of the wq's
cpumask that they're serving, your original approach likely isn't broken
either.

> BTW, apologies for all the questions, but I'd like to make sure I can
> get the implications hopefully right. :)

I obviously haven't thought through it very well, so thanks for the
questions. So, yeah, I think we actually need to set the rescuer's cpumask
when wq's cpumask changes and doing it where you were suggesting should
probably work.

Thanks.

-- 
tejun


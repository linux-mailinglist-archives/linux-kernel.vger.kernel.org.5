Return-Path: <linux-kernel+bounces-58386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B1484E59C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC26CB29148
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FBE81ABC;
	Thu,  8 Feb 2024 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjZSofCF"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08C7FBAF;
	Thu,  8 Feb 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411380; cv=none; b=ATrPgHlvDljjMs8q74QoK1z1bzAe8Jq6KNMRtc+R4udzbgwW5R99EtkyYL+PUNxK+dPW08y7hknt2IJiZRCe3ewUeKZeN0IcKBgYac4hy7+aVrvqfgSA4DkwAUr49I3A7Iic1kobJ+yoHNspsUpw542EvzsAw+XE3dSIdYofiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411380; c=relaxed/simple;
	bh=BWu/28fRzjkSvdnGNYlpR0IqiCP38+waS7beyb9M788=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVTe2pZvlZrUu2ztKUdEoRp9mS3OmH+czXA0WmCU2ssmm//ZtPUxqC3j4YCtr3RYG2NrLE8XiPKLs9t4SBti7RSGRf7CdMxMHrgbxRF3ZgiNsI9oLT6OqBRF4BRFqt22hFi7KNDQPEf0gZ/GEKTkBbqPT75UmB0B5eCPwo1U+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjZSofCF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d94323d547so18878375ad.3;
        Thu, 08 Feb 2024 08:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707411378; x=1708016178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4xRu64XxLbwyXH7oYCu6PRDtlp7yUhISnlJKKI/0Tc=;
        b=mjZSofCFCF65DXVvicEdVrSOBM/2KU6+r3LjnwCz+Thlven8vWsHZ1MqcEiu2jPSX+
         deLD0Ys9/5W0BPtXV7zeShp00e0jaF3dhCC7w1iDbZoK5udahorRIf6feQhcAOGnTzD0
         e5Eryey6actlTF/YfrIYkZ++BE533a/y/Tyzg4BSatIEds3Utd/qS4KDVT3mxcMviXwk
         WoCs3ujZhdJFrVSTXoo8ziYF2EVtPSxKil+KGOd4cz/j7PVLQ7DDw5aUm9hPGj4RzvhM
         6+ETj7JjtognXztJvWykPH1MpeaWPGCf4wX7RRItYUKvRg3CT2+mA1M5EZYybkHV2J1u
         64+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707411378; x=1708016178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4xRu64XxLbwyXH7oYCu6PRDtlp7yUhISnlJKKI/0Tc=;
        b=gIZEIbz0I3CQ36xtjEBtM/uao3XxMiIAgZ/j1O0ED17bGslxVxKzWiYYBPa2SsJC9T
         ROkdRarRWoOtG1ohvYlg0ke7juIsm2CP5oaHZ8c7Wt3fbUF3y+O/QOkU0iUJLdgl9n48
         1U5XKrmUWb+fKtP9WBa/AGPWE/sjYEC/dDARwLGB2XWY+MZMQY6u86zV+edIq0ckA6zO
         W9T8IhfeALXPZQzWoI9f8L5Af4cgHamS4WNLZpEJfw+RJufa14R+RcoXzkYsRD7179Ag
         nHHiRKxu3PbCGn04CqvYR27jWe4FBHJTgO67pXhgmQ2gyCUvCWZNH13y0v+JXcX1uj60
         WVJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkTME7Fo2eNsqhayDB6F6tKjOkY6a3iun3DW5YywBPIxHBwmyYenwE1CncZtCBtqxnSZ1Y8hZtG/MiVOcKrstlfS6Rvrl76yevaCZuuA30ZiEhML0iFGMxaqzh+HL/PB2KxuIE
X-Gm-Message-State: AOJu0YwnEjmoVUp6rAJSs1SLJ5TGjYFnImY6KGld0nNI8HpfjXzPBrfW
	S6TYEeApZPdAq6ya4XwZBCBpzu98TQ/RuefgDJnF4nmtzhGgj5iL
X-Google-Smtp-Source: AGHT+IHOzIx5Ag+DssraT1KoaXuGtKOQFpMJMlaapfeV7Mba5cBbHY7UXR37Bl9QXvIi0G8qvZShSA==
X-Received: by 2002:a17:902:6bc1:b0:1d9:b89c:1bd2 with SMTP id m1-20020a1709026bc100b001d9b89c1bd2mr8331484plt.63.1707411378283;
        Thu, 08 Feb 2024 08:56:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXW/GNbCDzV0WwQk4yUkzYM+KTU+52Xlbx7rNGl0IimjaMAKSmnUrqBf5JekcRV0M3g8ZYMeRo9E9LhChbKrDG5J+PK5X4WuPAtlxRcjY5f67ZpTNya395BntBypX2JwlSkE4vJl7KymTrEX2CzKtnxHIaac6PvS82qQ8nx056xBI9KfVWOmeLXl2+Q9tl6yyAQYLll5xPmvUvXUokP+BF38Hr9L0pFFlkMrAJg5lR7nq+l9HiwjdyDAMavs7h+au4Oo15mCEMN0VyEP7DHukUs/1aN+li9tP9KcmQAYXjTFGabTO+KqQuHWHrIMk4PdodOhY1POZoJvXct+SW64h5aGy34nkJ9ot/NI/2A91ae5D06U77mMUq2/xfqAhoDxTS8nbO93V1MLtm+vm3wNVSMN0176ekXPLFYa5IWxeRaqi0LU8Ir6EZfvndgzcM=
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id ko4-20020a17090307c400b001d9606aac46sm9840plb.212.2024.02.08.08.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:56:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2024 06:56:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen <allen.lkml@gmail.com>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCHSET wq/for-6.9] workqueue: Implement BH workqueue and
 convert several tasklet users
Message-ID: <ZcUHsHzlLpE7meaW@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <ZcACvVz83QFuSLR6@slm.duckdns.org>
 <CAOMdWSLNMqsZNJ-oCLN2RjckZmJSvdU_Yq0F0frmqMqa67Oy1g@mail.gmail.com>
 <ZcFPKaWwxJhgy8HQ@slm.duckdns.org>
 <CAOMdWSKQC4UWXp57qubcSOHmPj0E7wHZWWbCz+yCZqROhoPSGw@mail.gmail.com>
 <CAOMdWSLF9AaQF0ux03-tonw-Jy+4rXdKEZGzPrp_v+fnas6SnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWSLF9AaQF0ux03-tonw-Jy+4rXdKEZGzPrp_v+fnas6SnQ@mail.gmail.com>

On Wed, Feb 07, 2024 at 11:02:37AM -0800, Allen wrote:
> https://github.com/allenpais/for-6.9-bh-conversions
> 
>  I am holding on to the patch that converts drivers/media/*, as I haven't found
> a right way to replace tasklet_[disable/enable] api's. The rest should be ready
> in a day or two.

Yeah, we'll need to add something to workqueue to support that. As for the
rest, looking at the code, I think tasklet_kill() should be converted to
cancel_work_sync(), not flush_work().

Thanks.

-- 
tejun


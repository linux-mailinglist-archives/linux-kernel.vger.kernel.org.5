Return-Path: <linux-kernel+bounces-14525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B34821E47
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9191C2241A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A8814AB5;
	Tue,  2 Jan 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy1WfJXo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B7214A9C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d98f6e8de1so2813974b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 07:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704207979; x=1704812779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwt7CszV/J46V/JfrZ4yi4aU/mOorO6zMh2f6qpUKyY=;
        b=fy1WfJXonc+xySrGW8ly6KHOYwIdtq0JGyJmjdVkQ/IANyF/SZUGK8XACq0U38ObrN
         /E2dmwJav26EsCj0YL4ARrOIZAzEK3Gn6Fh+zYWBHyygfEmWKmA0gHuMEeiIAMbqRi8q
         eGNLjyWe9/uXnO/UgEtvJOsCfrhR6GN1wozLLDnvdhH9IBOyShitlt2/QfkozNzop4w+
         6LL9ehuZ/WtBFGex+1/HwZ5exoFl5C15GkD/zcRG4g3fI8KCas+U7Sci0YdEvuxod/2e
         YLNh+oWu374ruxV0ejiIrzt/nSUHXCUtpBpxcytXZTd9JSWQ7xCqgF4j4jaO3Nq3ELhd
         KKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704207979; x=1704812779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwt7CszV/J46V/JfrZ4yi4aU/mOorO6zMh2f6qpUKyY=;
        b=JldU4ukVgGpJjDlgfR3OLyAZiYMfW4On1tKVaGNbALZcdFfqA7AX1N/hJqGjP4z0Wr
         j3C5Q5yGWMmSBWbQqNNjRFQBdHyWTWWv0OZ5c2r5Y8ur1XBFZlaw5E8CL1fAWNrJZibv
         7PM/xE8xDyBvqB4EwByGBYOTKA7Zk5sXhrQWcY8IFaRPG+VYYuXVNwmUxhCpDKUhGyUv
         Z80lx5X/zzC/letXQtcrShHapYWDlhtkGN1xROMUuljWioqOoOOTyNT5pLW+nxwUamJe
         CQ7wYQT4SqM1r7W0c9qz8GBYgsIs1YUGdG7YJKVfIY85P/+S5n5SRfrMp3Wlhz2JzW2X
         alqA==
X-Gm-Message-State: AOJu0Yx2Rm3JCazAby9CLbiHMsqyhnUt0acT/VKycQxGJ/cL2brdZRyT
	LunnyxsUONVDw7JWiMBSpiE=
X-Google-Smtp-Source: AGHT+IHE48un0LDnENnIvmj49RY3BQYS/qjj1IT4T8V/k7ITKJInhKWS1Armej+LFz9LzsQqfAVA5A==
X-Received: by 2002:a05:6a20:9784:b0:186:bd68:facc with SMTP id hx4-20020a056a20978400b00186bd68faccmr7802964pzc.28.1704207979190;
        Tue, 02 Jan 2024 07:06:19 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id e12-20020a63500c000000b005ce998b9391sm2884851pgb.67.2024.01.02.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 07:06:19 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	eric.devolder@oracle.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	lijiang@redhat.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	sourabhjain@linux.ibm.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
Date: Tue,  2 Jan 2024 23:06:05 +0800
Message-ID: <20240102150605.111256-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZZPMLextp0n3lwbD@MiWiFi-R3L-srv>
References: <ZZPMLextp0n3lwbD@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2 Jan 2024 16:41:17 +0800, Baoquan He <bhe@redhat.com> wrote:

> Hi Yuntao,
> 
> On 12/30/23 at 06:16pm, Baoquan He wrote:
> > On 12/29/23 at 12:10pm, Andrew Morton wrote:
> > > On Sat, 16 Dec 2023 11:31:04 +0800 Baoquan He <bhe@redhat.com> wrote:
> > > 
> > > > > > Imagine we have a crashkernel region 256M reserved under 4G, say [2G, 2G+256M].
> > > > > > Then after excluding the 256M from a region, it should stop. But now, this patch
> > > > > > will make it continue scanning. Not sure if it's all in my mind.
> > > > > 
> > > > > Hi Baoquan,
> > > > > 
> > > > > Thank you for such a detailed reply. Now I finally understand why the code is
> > > > > written this way.
> > > > > 
> > > > > However, if we can guarantee its correctness, wouldn't it be better to use the
> > > > > generic region removing logic? At least it is more concise and clear, and other
> > > > > people reading this code for the first time wouldn't get confused like me.
> > > > > 
> > > > > As for your concern about the while loop, I think it wouldn't affect performance
> > > > > much because the total number of loops is small.
> > > > 
> > > > Well, see below kexec-tools commit, you wouldn't say that. And when you
> > > > understand the code, you will feel a little uncomfortable about the
> > > > sustaining useless scanning. At least, we should stop scanning after
> > > > needed exluding is done.
> > > > 
> > > > Or, we may need add a generic region removing function so that it
> > > > can be shared, e.g e820 memory region removing, memblock region removing.
> > > > Otherwise, I can't see why a specific region excluding need a generic 
> > > > region removing function.
> > > 
> > > So where do we now stand on this patchset?
> > 
> > The patch 1 and 2 are good clean up. The patch 3 plus below one, the
> > entire is a good code improvement patch.
> > 
> > [PATCH] crash_core: optimize crash_exclude_mem_range()
> > https://lore.kernel.org/all/20231219163418.108591-1-ytcoode@gmail.com/T/#u
> 
> Can you repost this patchset with some updating, e.g adding ack in patch
> 1 and 2, and squash below patch into patch 3? This will be easier for
> patch merging.
> 
> [PATCH] crash_core: optimize crash_exclude_mem_range()
> https://lore.kernel.org/all/20231219163418.108591-1-ytcoode@gmail.com/T/#u
> 
> And, you may need to drop below patchset since patch 2 conflicts with
> this patchset, and patch 1 is conflicting with fuqiang's patch.
> 
> [PATCH 0/2] crash: fix potential cmem->ranges array overflow
> 
> Thanks
> Baoquan

Hi Baoquan,

I've reposted this patchset, the link to the v2 version of this patchset is:

https://lore.kernel.org/lkml/20240102144905.110047-1-ytcoode@gmail.com/t/#u


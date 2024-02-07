Return-Path: <linux-kernel+bounces-56966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052C884D1EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB24B2540C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8190285281;
	Wed,  7 Feb 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJXMG0tg"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058984FB4;
	Wed,  7 Feb 2024 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332572; cv=none; b=cw6TQdgD+dPkx89YS1NpIYtzh4Hr1e6eLnx1OyVfhE45a+bzYv/iV6CRYC8cdCsRadVlSY7rQTiElGIW3B7Pxc2LNxFTVRXa2CB9IThJWmykzBvCzEZ6PDa8mBuWsRk8u5UMmzUEvb8YkHMbX7RI9ogQswd9YDP9SQsl3SMMnvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332572; c=relaxed/simple;
	bh=0WP3GhnoPTDV0+joY1N49lbD3qna4WrhBLUKcV4NQ7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFo9IYavE+xDSFpwERMWw35hoAeCCsneLe9qWsAlEZ33tkGb81YKp3yrSEOtgyDceD96EwqFYMMAl+JaFKg/hbnhEB9CSDKebPWf2E31/9E2sCpliM3SQnBljCQwyR+D6kKA82CX50m4XMrvbLAredtSJHDnUileC6B88T3xh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJXMG0tg; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4c02be905beso345136e0c.0;
        Wed, 07 Feb 2024 11:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707332570; x=1707937370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ujAb35RnTLt8ZUbzta1x6PdsdJ+WhetZSVI49IXzaL4=;
        b=TJXMG0tgr90Y/gti2h7kNxMOgy9AGBY7/WDOaipS0/hDPOUr19A3kCnrx5bqqD90tu
         jgXryeJtdCobqpc1z6vn5fw69MgiBNAdkZgbnqfSwULXiag5Ku/LvfYO0f9XhXc2Y6y1
         6qasx3Y4I5+ehPkZ+qUI3OLw1W+f97waWKaiAd4nz3tHtfdMPqBBtlojdWHXWiTGXQlM
         LWqo+H8MIPs0W7rfG1DaZ1R+xj3CQE7RYNpZPjFmxPQI1JfjfeO9Xa9Fww8KOjRbuiXg
         YC6HcC5rumzhAcd2LjjlIPtig4SPStHPLCKs8SnENH22xj5E4lZa0FLjHqkJ8SdoMgeo
         kFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707332570; x=1707937370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujAb35RnTLt8ZUbzta1x6PdsdJ+WhetZSVI49IXzaL4=;
        b=V9PpW6Z6RmwbtFXBx8Kbuermy0LZqc2OvtTkfBLbbccTx3Zprcekby8Cjj2l87UATP
         aZsnSQuQr+xwRa0dynK1yQAplsEFZ7zCr50GVavF/6g2duUba8hQZDA6dUyvZC0wW5Ds
         7OCq8XLiysehHrKvPhF4JatcHPSTeBEek1OCVFHp+d9uqnoQctkQlkW9X5qrd1XAXDJO
         S2CUYizNooae8IF3+oiInBU/l1/PnJoW02F2VR8VOYSE+0+84IYGoiAOvIaLh7hrNNcX
         BOhxUTN5gb+JA1V4nQEmSQkrK8dPgu7317Q/w8PGMQck+UzfeBhNmfXqA48xrjEMDLQK
         WHdw==
X-Forwarded-Encrypted: i=1; AJvYcCX2Nr45Qa1IyU3DaJNqzz41oyhUKGx2kKHV/bmC/V+sB1zLMb6fIR0BC04e0BbB0UHIQsTNf/hTxnRcel0KrmVqMffV16bU9gZMS25wUhCUqtCqeqNqZeqRKdy6hLVZhRAI9qtJ
X-Gm-Message-State: AOJu0YzjP2pfecmNPBJu1PFTjAE8aUUqroiG7dpX/ZndC+AKQdfdDsxy
	gwTczIO4JHvnAlzAtHiO6scemMlnnLFH8NPVwqS3lh+e0iuLUOoHb2sCmG/j/GCPAS4XLdPW5fs
	vr/wC751ohhM8Z48jHO56rZJI6AM=
X-Google-Smtp-Source: AGHT+IEGjaS2wfaJL/3N0IjNMSRVZR1yOOmxYjAVKnt3O04KW4cnozm5HRpUgMBIQTf4a+F1nGQe1OZy405NekISujs=
X-Received: by 2002:a05:6122:1699:b0:4c0:2553:3b19 with SMTP id
 25-20020a056122169900b004c025533b19mr3739687vkl.13.1707332569959; Wed, 07 Feb
 2024 11:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <ZcACvVz83QFuSLR6@slm.duckdns.org>
 <CAOMdWSLNMqsZNJ-oCLN2RjckZmJSvdU_Yq0F0frmqMqa67Oy1g@mail.gmail.com>
 <ZcFPKaWwxJhgy8HQ@slm.duckdns.org> <CAOMdWSKQC4UWXp57qubcSOHmPj0E7wHZWWbCz+yCZqROhoPSGw@mail.gmail.com>
In-Reply-To: <CAOMdWSKQC4UWXp57qubcSOHmPj0E7wHZWWbCz+yCZqROhoPSGw@mail.gmail.com>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 7 Feb 2024 11:02:37 -0800
Message-ID: <CAOMdWSLF9AaQF0ux03-tonw-Jy+4rXdKEZGzPrp_v+fnas6SnQ@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.9] workqueue: Implement BH workqueue and
 convert several tasklet users
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, 
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org, 
	netdev@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

Tejun,

> > On Mon, Feb 05, 2024 at 12:50:28PM -0800, Allen wrote:
> > > Thank you. I am basing my work on the branch you have
> > > pushed.(or-6.9-bh-conversions)
> > > https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/log/?h=for-6.9-bh-conversions
> > >
> > > In the order of priority, I have started converting drivers/media/*,
> > > drivers/dma/* followed by drivers/net/*
> > > which constitutes the majority. Putting my plan out here so that the
> > > work is not duplicated.
> > > I will write back in a day and share the branch for review.
> >
> > That's great. Thanks.
> >

  I have the first set of conversions ready. Kindly review the patchset
before I post it to the list. These convert drivers/dma/* to use the new
Atomic WQ mechanism.

Based on
https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.9-bh-conversions


https://github.com/allenpais/for-6.9-bh-conversions

 I am holding on to the patch that converts drivers/media/*, as I haven't found
a right way to replace tasklet_[disable/enable] api's. The rest should be ready
in a day or two.

Thanks,
  - Allen


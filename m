Return-Path: <linux-kernel+bounces-29374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE178830D64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10B91C21B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B352B249FD;
	Wed, 17 Jan 2024 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvqs+3t8"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE1249EC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520555; cv=none; b=fNYGyCXBFMu9PcmNX4Qe4VEDSB8mTLcbJBa2nJ4sfnXP6p4dM/lf60TcYY7eaCF8b4S5JYa7jfEGL7rSLhiQlrl48dZzZorXknMn4N0OgZwBAzlgy2WDJtbXTLiG5RcwPzYCA0L16MUizj2Yf9Ha+1VXZ2qVYTrg1Lnr3TI1AXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520555; c=relaxed/simple;
	bh=nHukp7ABSGZgox+voQNgZSwLeGnZqG7L9T1fJ25Rnh4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTVrZRnKCXBvYN6q/EqLzclncM2KIzwedOMXGl3ARevTF7PlQnwfekvJDPqLTXd3anT3sHe4oz5rFzijQrBprgVZmpArdpgd9S4Xf182OMCPKu+1PQ0nsNhb9j82yKnGnuzxu3dEr29hGLOegezbm/PrcQ4vsJkGrfxBwWR8kwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvqs+3t8; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-598a5448ef5so4424332eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705520552; x=1706125352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViFOzshsdI0neEHKP5+T/Kud83KXCwEJkLxP8fjCi9Y=;
        b=Gvqs+3t83Iqq3QEuKfbnRb40FuzSM1nYmFdltCkNUGLD/SHChh8ygtL7eDhGJQC4F0
         /V2lp4TnFx3wHqkfNb5uF1fEjPzXJku2LFTfKycPpCA0OkPZY3L1OlN699tRrd5iVsJD
         ldv5N3RdVPVw4nnuqmdApEqbLcTHxEohRzzPq7RLetFpRQgTZOgODNnkHjNSoj/SclwS
         sMntLH6qmCGa4nFB7gj+wBm8fT5J6NXGT4KlKR4H6lCRGIjDJOgtkixnVdM/SEfBxj4H
         KHugDJOpe36vm2zyUL4M22NuwLtma8c37N8RfI0RDNN2oOrltI6T9uFttRkYyAvljGRH
         t2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705520552; x=1706125352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViFOzshsdI0neEHKP5+T/Kud83KXCwEJkLxP8fjCi9Y=;
        b=gbZlRTGjuzPYifnTw2i7Loxm4HTqORoFdyoEjMQ7NGUQFjMFuvqDhjlBfvzT+KVL4l
         t0MNX5zXb9mSJ4HD12mQz+QJTEWDobt6YGyCwEojM4uYGFSuVHc/C279y+SUQWNObqIJ
         QM3nxPzETYRQUwD54Bmw4LQfXQ45jpDXo/OFVEc52/0lQGUlzdH2OU6sORBdf8rRb/PH
         +B4n7T8kdyIvUuJ4n4S17anS/Q+pLVITdr6pDEkOF3y0TNoYQNb10SPdxE9AnnmpZGR3
         +71UrapMHAKXik/o+FR9MlfgArfQJJ59eziHNWJZxdtaqABWLW0dWQsDVrgpovHR2pCK
         GPFQ==
X-Gm-Message-State: AOJu0YxdoABlUFMdjpx3Ow7ECv6gbTlIlXN44Hxz731TOas29mV/qg2r
	SIroo0Awn6lblKeyFsChFS4=
X-Google-Smtp-Source: AGHT+IEkZ6A0SVWHrplsXqg9e1EHz1I2sQTfnYGourX2+NwbKELbeBuu8qDYTs4RHTAymlGeMVEsJA==
X-Received: by 2002:a05:6358:9b47:b0:175:bfd4:8d6c with SMTP id k7-20020a0563589b4700b00175bfd48d6cmr11587810rwa.40.1705520552496;
        Wed, 17 Jan 2024 11:42:32 -0800 (PST)
Received: from localhost (dhcp-72-235-13-140.hawaiiantel.net. [72.235.13.140])
        by smtp.gmail.com with ESMTPSA id w26-20020aa7859a000000b006dad993d91csm1821882pfn.129.2024.01.17.11.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:42:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Jan 2024 09:42:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] kernel/workqueue: Distinguish between general
 unbound and WQ_SYSFS cpumask changes
Message-ID: <Zagtpw-JQvdpFseh@slm.duckdns.org>
References: <20240116161929.232885-1-juri.lelli@redhat.com>
 <20240116161929.232885-4-juri.lelli@redhat.com>
 <ZabRlEklmuqwFPj-@slm.duckdns.org>
 <ZafQwMw8ZKztunMU@localhost.localdomain>
 <ZagKbRlBxZHsKiw5@mtj.duckdns.org>
 <72e4a971-96e5-44b7-b348-bbdb68e54b40@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72e4a971-96e5-44b7-b348-bbdb68e54b40@redhat.com>

Hello,

On Wed, Jan 17, 2024 at 02:32:34PM -0500, Waiman Long wrote:
> My impression is that changing the workqueue cpumask of ordered unbound
> workqueue may break the ordering guarantee momentarily. I was planning to

Ah, you're right. Changing cpumask would require changing the dfl_pwq and
that can introduce extra concurrency and break ordering and it's exempt from
unbound_cpumask updates. We likely need to add a mechanism for updating
ordered wq's so that the new pwq doesn't become until the previous one is
drained.

Thanks.

-- 
tejun


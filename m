Return-Path: <linux-kernel+bounces-125615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999D58929B1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4290A1F22055
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA08F56;
	Sat, 30 Mar 2024 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="pmf/Wuuh"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AF79D8;
	Sat, 30 Mar 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711787131; cv=none; b=o1cgqdyb4xKzZ2zBgY+h4XHuowBt3PvSEBMWc3l5K3wm9m2MqI9CMobgoRrFz8m4cKkIYtlVjbDbVDAt8wBXRQewWJUr1AEgZZxB4hvGhi6lS65r48z/WZlGq8QkyUtrUjGTf1nvxo8rJPfxgLm+8rTYteZy9McuMNg9IA8sy+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711787131; c=relaxed/simple;
	bh=ajK3qZPjABu64x0qWUWrYS5lGxEpXNu8G6mGAqricqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAeRmJ1KzGZvJpDnftXrlEspwOWVB/BoM9+pCrP1u3BjlurYvNIiGb6zQqsB3yOYK+IG7gpBGFNxooZYHmfOzcRwLKuRaOf2PkjQj/Zd4WwqF1JrUrmgOliIbiWLRHCIdhbc5WO3dKBcJCSjp1j4K3ZptXkhMV3VHCpeLDpTM40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=pmf/Wuuh; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id B7D811B7FA4;
	Sat, 30 Mar 2024 09:25:19 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1711787119; bh=ajK3qZPjABu64x0qWUWrYS5lGxEpXNu8G6mGAqricqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pmf/WuuhsXc8LnJnE6qLaLZ4Pue7JbRDKnma60f7ae9f7g2632uGjtV+HrKvmMeZ0
	 SJrt113HgiT3XR0YwBuvaT9pBXCWcEnOhW41HxDO/ngPWkfxkOVzFB/vfb+QVZElNA
	 mmr6N3ijXNOQ3oCROrv6/01y6j8Sxt4xjqZCveQ/Qy5TqJFYCb5kMvJNntTRu7r5xc
	 tAyYshOGa1Fd0Qzz5gkLA7LM0fduIdL68j9nVsD3rPfMg0NqJzmhdtANpjrWNH7MmN
	 +oEpWyeM0sKSA1yTB6Fx8N0fUcpijZQbyisP8JAINOI7BpoVJsdDv9gKtCq80lhmsf
	 VvorcihuMULdw==
Date: Sat, 30 Mar 2024 09:25:18 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Dexuan Cui <decui@microsoft.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 zhangpeng362@huawei.com, iommu@lists.linux.dev, mhklinux@outlook.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
Message-ID: <20240330092518.71b5f0c0@meshulam.tesarici.cz>
In-Reply-To: <20240329192809.17318-1-decui@microsoft.com>
References: <20240329192809.17318-1-decui@microsoft.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

V Fri, 29 Mar 2024 12:28:09 -0700
Dexuan Cui <decui@microsoft.com> naps=C3=A1no:

> Sometimes the readout of /sys/kernel/debug/swiotlb/io_tlb_used and
> io_tlb_used_hiwater can be a huge number (e.g. 18446744073709551615),
> which is actually a negative number if we use "%ld" to print the number.
>=20
> When swiotlb_create_default_debugfs() is running from late_initcall,
> mem->total_used may already be non-zero, because the storage driver
> may have already started to perform I/O operations: if the storage
> driver is built-in, its probe() callback is called before late_initcall.
>=20
> swiotlb_create_debugfs_files() should not blindly set mem->total_used
> and mem->used_hiwater to 0; actually it doesn't have to initialize the
> fields at all, because the fields, as part of the global struct
> io_tlb_default_mem, have been implicitly initialized to zero.
>=20
> Also don't explicitly set mem->transient_nslabs to 0.
>=20
> Fixes: 8b0977ecc8b3 ("swiotlb: track and report io_tlb_used high water ma=
rks in debugfs")
> Fixes: 02e765697038 ("swiotlb: add debugfs to track swiotlb transient poo=
l usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

FWIW I confirm that the transient_nslabs counter does not have to be
initialized either.

Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Petr T


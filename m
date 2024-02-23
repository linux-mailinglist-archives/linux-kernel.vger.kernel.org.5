Return-Path: <linux-kernel+bounces-78925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC222861AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6CD1C25BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B888513EFFA;
	Fri, 23 Feb 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="REvmuwwi"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F162713A27B;
	Fri, 23 Feb 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710716; cv=none; b=eHdS36ANzjAmHa29848FylXePJjBb0NdbGnvHnllPb3cuA+n2YOYUUppKxTcJdORjuPlfkpkyB9JoOcP5GEjIPrQqtSNh0gb4xGf46RZRmqFG82GjoWBXl08OR8nddo/SBaHBQ5KvtLSZh51z2FJbbDEi190CcCqcDFVlm+3S7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710716; c=relaxed/simple;
	bh=3MtOstKPgk5E7lxshF6YUvjFhLxlyzflm8vH2Ep6Y+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbldMXqtwStEIXNBBPAS0AXnbSgKOirrdzKBqW3kQPf9tqDht+kVLpYzct2odbVNO0VVYIDY9EgHw6JcyueJxKNSVHJb93FV+QPn+ZE4AvlJpb5anDLj6btcmjEtngCv/KKaSugTHcR7C+kaRKVz2OcsGTWlTo8RWVblQRQRjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=REvmuwwi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CCFD840E0192;
	Fri, 23 Feb 2024 17:51:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DZ5q3Q_bndI4; Fri, 23 Feb 2024 17:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708710708; bh=rkpeN08zur0iQ6scKcdTzeAW6Eskv9jZ3rMpviIPZ0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REvmuwwiIVCNBSNUYb4BQZvSTePGuN67Jq3SwEjLRx0f+MfQ/cIibpbyRJ6SZTyS0
	 36vKn1G/RUNTHLYGa3xvAl5kCoQ3J9V8COgDQyHUy4qQHqLhc9cuVd2XdfDS7Mef0Z
	 lTMvoOhhLo24Pb/yuEL87DXMS3kECR9R+DcoshvfB38qk3uxbzscyenXhyB6JPVDWY
	 g3wcylGYqPc4fICZ7MYqhYK/EWn1ZUWvK0d+Z8Dp9lmbqCwBWHDdluKcTMpgOi+b3M
	 VMikameDf9QqMVG2zVD/2tTgJoIXfLFHsBwtbklcLTdrWj60wn19J79QkjEAJtpx8T
	 So69gS0MYPXU+QGQJRpGI4D6Awwt1HN9uppVYBQCs7PzupvccW2lfecuWblFIYHCAE
	 21A0Nv0B37601ZHjh0giIOVN+O2RoigGTqW2Azf8ZqX88umpT3RuQE15rpQlIr4lOe
	 DBhYCd1j0c1ejHlZxLxrb4NN0akDG1eTZI87AhfXlDDfG5Aa4QmkYPUY6J+wdV+2Je
	 UVzQog0zRxpaLEVmkRj4nDhND2H3Fq7HNGG+R02dz37EXYroYTU/RVs89zuDB61jmQ
	 Li4V1I/7YR44hh3U73R4cDOE4n5MG0V3xdCVwIw6O+PGuvDJ3hQUgPukerqoMqVc5Q
	 XlynR/rd6OkpptLyqAixACWE=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE93040E016C;
	Fri, 23 Feb 2024 17:51:07 +0000 (UTC)
Date: Fri, 23 Feb 2024 18:51:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	dan.j.williams@intel.com, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, david@redhat.com,
	Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, tony.luck@intel.com,
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com, rafael@kernel.org,
	lenb@kernel.org, naoya.horiguchi@nec.com, james.morse@arm.com,
	jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	mike.malvestuto@intel.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [RFC PATCH v7 00/12] memory: scrub: introduce subsystem +
 CXL/ACPI-RAS2 drivers
Message-ID: <20240223175100.GCZdjbBNlS0hluk3_B@fat_crate.local>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
 <20240223154251.GAZdi8--NPaMAK_ZBp@fat_crate.local>
 <20240223162551.000013ec@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240223162551.000013ec@Huawei.com>

On Fri, Feb 23, 2024 at 04:25:51PM +0000, Jonathan Cameron wrote:
> So in short, it's an ACPI spec defined interface for controlling 
> Memory Scrub engines.

Ok, let's call it acpi_ras2 then so that it is clear. We shouldn't be
perpetuating the ACPI poor naming in the kernel. This way at least it is
namespaced and says exactly where it is coming from.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


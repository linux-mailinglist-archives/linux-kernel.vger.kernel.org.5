Return-Path: <linux-kernel+bounces-59968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466184FDFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F73F28B5AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9C7107B3;
	Fri,  9 Feb 2024 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ey7Qu9Sw"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034D11CA1;
	Fri,  9 Feb 2024 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511893; cv=none; b=gQxU0LTafZfX9TGgy32o3zLWpR7MumwYlNf8sjopCGbeWmwCKXXu4h40O+w/+pNJH6OYirByzLWdgZzQzY5VZRB7kqRSt2NFeoJa15Q/1q2/ZdkQIqBQSjIXKWXzlQ5gSyN/28Ct75Va2dOKZivPOsw0MBVgFRjZphfj9SREjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511893; c=relaxed/simple;
	bh=aUO2tQWoagVu38p7XEo447RN2Jh0AqQIhLQmEataQvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHbJ5sJ0GYSaI4SDbbZkVCdo/M0HZrMQ/7VvixHq8lmo9t1addwGAViNyk1iKNWCEgNi/Gix3MyrYSmQ3b4379gl3AIQbPLhKAORjNvvpdbgsAQTlHI/XGOu6I9P4xcgQc8Lzoh4i0TX7Zh8FIo38bhrJ0PwvJ1Si42AMS3uWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ey7Qu9Sw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3B1B840E01F7;
	Fri,  9 Feb 2024 20:51:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yfERvYSsb0NL; Fri,  9 Feb 2024 20:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707511885; bh=WoEsY6Grt89Wavd7goGgdeie8Ypipy2F5o0F+eDkAQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ey7Qu9SwEkjFDyZOwM3kcE9LvtCRKvouzYIvRLyFuG5zhySHvvZ5aZFI6zwwIy+B3
	 BDt4/3GyUBnUCxDdX+QzFkO8V5qVv3O7cxeZeo4GFsePH/PnmoJYZp3bpVxBNQh2fb
	 soT2cu7+WdkW9lsyywnbU1NSsgcyo3rY9lKBufjZbQo9vuvWtstDp9xRf1JSvOEnV6
	 wEcxb9y0hqyuzBQ9pQNM5NVCwO8bXgswy0DEcRJBGn8jrjOuSHHQXImhg5F6VnuhzW
	 nkGL4zkFc1Qb6PxQy5RWVxCzXDVvmGM1u3NbU//gS5/7yBB8T6bUPIEzMEe/Y3XPtK
	 3lG9dznE4N2UOZKwU9WzWVNrCRIQeLBVYTDsLDoJbX7ldjkhx0XjQBSI0XiMLmY5AZ
	 HKiEiTP1hKRn6nbbau5Sf2DPmnGOZwMaTAIFBR3/i4CXvwqSGoHZppTSdRHyLu6YY4
	 n55+erAW9RoBCkMOiFMxBRZJ5ikKuOO2t7I6oXoYZ9XAz5U7iKU3WffKBmiICo7Y8/
	 +2FbODMaE+yoq+XEQcTx8Ga/50RnDtikp+fL9mLQ+J5KlAvX18/5K1H8+HAFINKYu9
	 uIi+WK057N+nZCJB+Jon2x6N96ajkFr2ARRWY57k/7A1KfTsLbBh4LRss6Rla5Nntz
	 Naefn8fCy94bEMq1UTHeXXs4=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBE9040E00B2;
	Fri,  9 Feb 2024 20:51:17 +0000 (UTC)
Date: Fri, 9 Feb 2024 21:51:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>

On Fri, Feb 09, 2024 at 02:35:12PM -0600, Naik, Avadhut wrote:
> IIUC, this is exactly what the first patch in this series is trying to
> accomplish.  Please correct me if I understood wrong.

Yes, you did.

I don't mean to extend it - I mean to allocate it from the very
beginning to

	min(4*PAGE_SIZE, num_possible_cpus() * PAGE_SIZE);

There's a sane minimum and one page pro logical CPU should be fine on
pretty much every configuration...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


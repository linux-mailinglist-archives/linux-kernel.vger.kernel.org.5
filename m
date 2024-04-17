Return-Path: <linux-kernel+bounces-148875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772A08A8874
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7142DB22313
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8981487FF;
	Wed, 17 Apr 2024 16:08:50 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C01487C0;
	Wed, 17 Apr 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370129; cv=none; b=OBYG9RI4iAxmNRwjEb+LQfy42s0R1BcUsliKjz21LPTN+7RRiFA5ySK3YwUAqYgq1/yiR4TQD0p2I73vvJKk5v5rgrAao2tdnQLfUPZ7HNtlBFLOu4LMKTvMTI3q6IWhzP8Mfxz1hPEQbcknnbgzzIIqxfBiOc1CMR0ljYikffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370129; c=relaxed/simple;
	bh=26a4q1b+qSqumSamso89ZepY6YnikGWu88avFTTGmt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAa3BVDjNfHCOU+NZYzQDDP+HKCwqAoM7du7a5JL5cm/jmWNkLzOmWb0OHic+ngGlLCsN7Z2erc0FSSAOfm8W+/ZJ8Jo8/PmXg2XuyPci17ASUywd0/zdMbNK3yL7Koxll8O0mz9nZMdHqKRKR91C+ZJ/Y6QY8AX+bFexzSVGPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.18.169.210] (ip-185-104-138-26.ptr.icomera.net [185.104.138.26])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4500961E5FE05;
	Wed, 17 Apr 2024 18:07:50 +0200 (CEST)
Message-ID: <23faa727-4b1e-4eb2-9e43-c10b8fadaa23@molgen.mpg.de>
Date: Wed, 17 Apr 2024 18:07:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 42/74] x86/cpu/vfm: Update tpm files
To: Tony Luck <tony.luck@intel.com>, Peter Huewe <peterhuewe@gmx.de>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212202.9452-1-tony.luck@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240416212202.9452-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Tony,


Thank you for your patch. It’d be great if you changed the commit 
message summary/title to be more specific. Currently, the short log, 
`git log --oneline`, is not very meaningful. Maybe:

tpm: Use new VFM macro INTEL_ATOM_AIRMONT

or

x86/cpu/vfm: Use macro INTEL_ATOM_AIRMONT in tpm


Kind regards,

Paul


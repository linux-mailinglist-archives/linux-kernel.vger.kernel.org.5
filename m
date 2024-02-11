Return-Path: <linux-kernel+bounces-60644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8596F8507F6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729C51C23CF0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 06:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8418625;
	Sun, 11 Feb 2024 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jhMFIIBl"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00021182BD
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707634196; cv=none; b=huWPX0QNO7Y2kgMZ0FkO5EqHjbwI/3Gpf1zp1KvWxsErOkR/6RX25waIAgrIBDXj/+peMKRFSzu2qIFDc6zzrnrU7TXAp7YZoNdkEgsUaVsp4cySDqHZdJA3T/UejIjqm9jvux6vLvhpJsCoDKtp6XZwUGhyHbAWg68T7fcbOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707634196; c=relaxed/simple;
	bh=fKSC+2Az93r9DlOnjUhkcARO+nCg9NJ+ZhuWfvc6P7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=py66s1YGHDVwZ8HBN9l68W0AcUICvDrUuGJuOLgTVD6xA/Jq1MD7c8Ossi5CzORSm26vKQCGLXETC/h/T1HQCNcsX2zrbfGFfTiDGVniiWN4gsqXTe2ZndCFlm2Dn+NMaeQi+Ornbf9ha3yzon/+MGOU0Nl0EIAhfS+cOci/UyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jhMFIIBl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=RPcJqvwoST9wCChzzsCBxIVXoZ9qVjJGW0thxxVGU24=; b=jhMFIIBl2+57ndStopF11nK6ph
	AZhhirXdSv55y/phEJ2JyHldUqToS/iX0JnFsx6yToz8aEG/M/zzx9Me84Qx2NbyJtuYSv3fR1YKO
	2SHtHFUuOKnrivY26cdMvtDQSgjwmpJbTMf7yoTKNUUQRNfnydPm08Apahxc0ZnFh0ET1bWuWurB7
	TzolSD9VllNwzro6tZB6QRG3quHQJ76LZ26zhfcHanCow4hBv4UYtjXCOcD/CXjEhH+Ni52ZXI6WE
	LSpmU18RfBF1kBh65lrwalHK+gUKib/TtnJp8Pl8EONTobbf3CeAAG493fGP8ucUi57/OFLEoeYaF
	YYxO1SyQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZ3ez-00000002Q23-2E3b;
	Sun, 11 Feb 2024 06:49:53 +0000
Message-ID: <7b17f021-cff8-4110-ac8f-c8f635263293@infradead.org>
Date: Sat, 10 Feb 2024 22:49:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: drm: display: indent fix in comment
Content-Language: en-US
To: Kousik Sanagavarapu <five231003@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20240124183659.511731-1-five231003@gmail.com>
 <ZcTxUDb3_Xtqk8uW@five231003>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZcTxUDb3_Xtqk8uW@five231003>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/8/24 07:20, Kousik Sanagavarapu wrote:
> On Thu, Jan 25, 2024 at 12:05:56AM +0530, Kousik Sanagavarapu wrote:
>> The comments explaining the function "drm_dp_mst_atom_check_mgr()" had
>> uneven indentation which made "make htmldocs" complain:
>>
>> 	Documentation/gpu/drm-kms-helpers:296:
>> 	./drivers/gpu/drm/display/drm_dp_mst_topology.c:5496:
>> 	ERROR: Unexpected indentation.
>>
>> 	Documentation/gpu/drm-kms-helpers:296:
>> 	./drivers/gpu/drm/display/drm_dp_mst_topology.c:5500:
>> 	WARNING: Block quote ends without a blank line; unexpected unindent.
>>
>> Fix this by getting the indent right.
>>
>> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
>> -- 
> 
> Ping again.
> 
> Thanks

Hi,
This seems to be fixed by commit 1a84c213146a.

If you don't agree, please explain.
Thanks.

-- 
#Randy


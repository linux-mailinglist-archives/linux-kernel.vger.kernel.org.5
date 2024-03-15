Return-Path: <linux-kernel+bounces-104452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D8387CE16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E9C1C2118C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCD4364D9;
	Fri, 15 Mar 2024 13:28:45 +0000 (UTC)
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF5536113
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509325; cv=none; b=Jwf++9g8lD3PB8GAvDZSF6PEUkEOPi5F81LjOjD2XEwaXEZIpqCOZa8XwfEZNolultuMyAUuJc2kxql9vqo0I718JuWJihUElZVcSpVav8cVey3huaxEFrNI/iucvRu/aWyjD8FAN5gW0rxi+U04/3gIkA2M7EhxBatJwyr3CjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509325; c=relaxed/simple;
	bh=O2yLTuHryKNgwQFOPgw1KN/Mr2BrUh8deYtzv9G8CJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NVewCBrNCU7LPP4JnDF5MWpNdyJaszWBKFiqRxueH4RA2TESvDrjnT3EOxXZ1w7pUt84Rd6m4FqST8jQOTW/uEFgiO6sJpgRqjJBp6gB9Ki1kvBCKkqrDwqyDLb2xWqS+1iucv5pBp0kUUfd05cdeh/PO5KZe3HfZsd8msDexR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id E34D0205DB9A;
	Fri, 15 Mar 2024 22:28:34 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42FDSXpc288466
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 22:28:34 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42FDSXnV1717364
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 22:28:33 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 42FDSXEP1717363;
	Fri, 15 Mar 2024 22:28:33 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fs: Add kernel-doc comments to fat_parse_long()
In-Reply-To: <20240315075249.111059-1-yang.lee@linux.alibaba.com> (Yang Li's
	message of "Fri, 15 Mar 2024 15:52:49 +0800")
References: <20240315075249.111059-1-yang.lee@linux.alibaba.com>
Date: Fri, 15 Mar 2024 22:28:33 +0900
Message-ID: <87r0gbd3pa.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yang Li <yang.lee@linux.alibaba.com> writes:

> + * @bh: Pointer to the buffer head that may be used for reading directory entries.
> + *      May be updated.
> + * @de: On input, points to the current directory entry.
> + *      On output, points to the next directory entry.
> + * @unicode: Pointer to a buffer where the parsed Unicode long filename will be stored.
> + * @nr_slots: Pointer to a variable that will store the number of longname slots found.
> + *
>   * This function returns zero on success, negative value on error, or one of
>   * the following:
>   *

Beyond 80 columns is common now?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


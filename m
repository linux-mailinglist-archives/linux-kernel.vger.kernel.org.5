Return-Path: <linux-kernel+bounces-106457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383F787EEDE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AE61C220C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF6D56749;
	Mon, 18 Mar 2024 17:32:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33C855E62
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783165; cv=none; b=Z7y3d/hu6QotnQxa1gf/vuEdpKBcVVp8ngIkNI8RAIrP8NPd4jftkS3vJvOgNoDXZQX23ZRamTOTzaF06AZqFJe1Fqr1RNDUgNFnInXVcrhpxhOSNA28OQhsZf9qIzOoztHBZm1Qs19g56c/uAgbAKAREJd+7Z85Wphm0IIEg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783165; c=relaxed/simple;
	bh=UdEL9U6GTSy9xNGEw1Rs9fM2hw+a4kvjnV4O1seSU1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mobRq2631gGU2KCyZqfUoO0JMKhwY2P5MMamAZ7jiN5wyp/pMYffFGgT2q+Oah9/X8zeNO/285Hh3AenJV+F2Ok2QHLqtUEkKpIX5hB+TJAVLq1LoDFVLjmeoua4kSash99cGULQ3+sBMmwdRxxJ9Z3HCRbB+nfNdD/QovtLeF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE8B61FB;
	Mon, 18 Mar 2024 10:33:15 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B5B83F67D;
	Mon, 18 Mar 2024 10:32:39 -0700 (PDT)
Message-ID: <d0277225-199a-4175-a43b-a09c1445138a@arm.com>
Date: Mon, 18 Mar 2024 17:32:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBmcy9yZXNjdHJsOiBVbmlmb3JtIGRh?=
 =?UTF-8?Q?ta_type_of_component=5Fid/domid/id/cache=5Fid?=
Content-Language: en-GB
To: Rex Nie <rex.nie@jaguarmicro.com>
Cc: "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
 "rohit.mathew@arm.com" <rohit.mathew@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240311081839.937-1-rex.nie@jaguarmicro.com>
 <e731b262-c201-4294-9b1e-abfa0c6ac817@arm.com>
 <KL1PR0601MB577382D132A25E055856C543E62B2@KL1PR0601MB5773.apcprd06.prod.outlook.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <KL1PR0601MB577382D132A25E055856C543E62B2@KL1PR0601MB5773.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rex,

On 12/03/2024 02:52, Rex Nie wrote:
> 	Thanks for your reply. Please check my inline reply.
> BTW, can I know the progress/roadmap of mpam driver upstream?

The series to change the monitor code in a way that allows MPAM to work, and split the
locks has been merged for rc1. I plan to post the next series shortly. Once that is
reviewed and merged the refactoring of resctrl will be finished and I can start posting
the MPAM driver. (it has a few small dependencies on cacheinfo and PPTT parsing code).
I anticipate the MPAM driver will be merged fairly quickly as it won't regress existing
systems.

Any help reviewing the x86 changes would be appreciated - these are the changes that can
affect existing systems. (Shall I CC you on the series?)



Thanks,

James


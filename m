Return-Path: <linux-kernel+bounces-132782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA60899A17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3791C20B49
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D23161335;
	Fri,  5 Apr 2024 09:56:06 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D6161303;
	Fri,  5 Apr 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310965; cv=none; b=nENW4L6jC7azkY39hZheeEQVAWmSnHuaNvw+4JYmwBxXcmBKbHB3XzwAJ+G3F9oJENz4StZqb8ICDA9hQLIY8kFHzXGTSx+f67o3qBR05gkTLEFl2eRXSRhDPpJ8tuDbOGN3wq/cvypJhUP6oesUhGpys3chO+dvIdfDyqRVtio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310965; c=relaxed/simple;
	bh=nAKV/KIjO0niNMWNTOLLP1H2qDBqS7M9ULvho+EQ1zA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qj3k1MIp6haMEKg5L6flYwVM+Am2/NCgERIJk+FLa28Ul6saT/47zDMy59Zd1smbdcAGyGVSkwCF3SXzAHUtQCmtrHRtLjnoGqSg6rlnJ9dtJbuoptBAjEQQAzDQJxWA39EwKVHn3I7hygOVk02QMOHkGdd347YltowE0GQy2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9tzY2lJqz6J7pn;
	Fri,  5 Apr 2024 17:51:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CEFDC1400D1;
	Fri,  5 Apr 2024 17:56:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 10:56:01 +0100
Date: Fri, 5 Apr 2024 10:56:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lukasz Luba <lukasz.luba@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<dietmar.eggemann@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
	<linux-samsung-soc@vger.kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <quic_sibis@quicinc.com>
Subject: Re: [PATCH 0/2] Update Energy Model with perfromance limits
Message-ID: <20240405105600.000019fd@Huawei.com>
In-Reply-To: <20240403162315.1458337-1-lukasz.luba@arm.com>
References: <20240403162315.1458337-1-lukasz.luba@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed,  3 Apr 2024 17:23:13 +0100
Lukasz Luba <lukasz.luba@arm.com> wrote:

Typo in patch title.  performance


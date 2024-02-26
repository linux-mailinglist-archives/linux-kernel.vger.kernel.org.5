Return-Path: <linux-kernel+bounces-81782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027C867A10
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6730F1C28375
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA28B12AADA;
	Mon, 26 Feb 2024 15:20:07 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C67129A95
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960807; cv=none; b=WSILdadFHbNua+d5Tmvi4KI4l8QFDkQNJ+vn37ts2L5LfUb+f5wa/vwnfADfm95/JdvZKn8+gF6uEUmm7gyCrocLXEt7lAjl370cRogY6Z3OPyNck/HRbLvclo8+VJpUD1cgYGZ+XGTppOGNbVYmcc/mldlcX76NOTLL77EPuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960807; c=relaxed/simple;
	bh=lEWujmTydmsCs9peV/67471UuWNywwT+7gSoC1MHj/k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuqBlEHHER6sQ+jk6hlrVXK0N4CZg5y3JiukNTuPzoyJ7toDCpHN2qn87/Jln/CUlDNpMETJeLrnHs/ixtrCZsheSInSOQAMbkRU6d1kK9enD5uo7moxl6UIH3KiMdLTnxbz52ZiSv/PGISuq4IWlOPyvY0b/4tkT1NU4pZOjkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk41s0Gqjz67ClW;
	Mon, 26 Feb 2024 23:15:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E1DF31400DB;
	Mon, 26 Feb 2024 23:20:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 15:20:03 +0000
Date: Mon, 26 Feb 2024 15:20:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH v2 8/8] docs: perf: Update usage for target filter of
 hisi-pcie-pmu
Message-ID: <20240226152002.00002c54@Huawei.com>
In-Reply-To: <20240223103359.18669-9-yangyicong@huawei.com>
References: <20240223103359.18669-1-yangyicong@huawei.com>
	<20240223103359.18669-9-yangyicong@huawei.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 18:33:59 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Junhao He <hejunhao3@huawei.com>
> 
> One of the "port" and "bdf" target filter interface must be set, and
> the related events should preferably used in the same group.
> Update the usage in the documentation.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



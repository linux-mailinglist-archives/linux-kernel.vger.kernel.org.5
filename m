Return-Path: <linux-kernel+bounces-4969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ECB81847D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6B61C23C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC713AFB;
	Tue, 19 Dec 2023 09:32:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A6A14298
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SvWfd4C4qzvSLB;
	Tue, 19 Dec 2023 17:31:37 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D0B3180060;
	Tue, 19 Dec 2023 17:32:28 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 17:32:27 +0800
Subject: Re: [bug report] GICv4.1: vSGI remains pending across the guest reset
To: Oliver Upton <oliver.upton@linux.dev>
CC: Marc Zyngier <maz@kernel.org>, Kunkun Jiang <jiangkunkun@huawei.com>,
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, "moderated list:ARM SMMU
 DRIVERS" <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>, "wanghaibin.wang@huawei.com"
	<wanghaibin.wang@huawei.com>
References: <7e7f2c0c-448b-10a9-8929-4b8f4f6e2a32@huawei.com>
 <87a5q983zc.wl-maz@kernel.org> <ZX8w1vfQzeXP5klL@linux.dev>
 <ZX8xLhFFqTXRFQtd@linux.dev> <878r5s8xvc.wl-maz@kernel.org>
 <ZYB_RKR5CqlVS-lV@linux.dev>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7ed01ec1-76b1-cef9-05b8-2068f67e1c33@huawei.com>
Date: Tue, 19 Dec 2023 17:32:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZYB_RKR5CqlVS-lV@linux.dev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)

On 2023/12/19 1:20, Oliver Upton wrote:

> Anyway, I'm happy with your fix. I'd like Kunkun to give it a go but
> either way I can pick it up for 6.7.

+1. When applying, feel free to add my

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

and perhaps

Cc: stable@vger.kernel.org # 5.10+

Thanks,
Zenghui


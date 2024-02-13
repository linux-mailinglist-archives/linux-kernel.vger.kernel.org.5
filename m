Return-Path: <linux-kernel+bounces-63514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C32808530A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80431280A11
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F403EA76;
	Tue, 13 Feb 2024 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="JP083YBl"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF72E3F9;
	Tue, 13 Feb 2024 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827844; cv=none; b=IAMoLRTb260G+AusXOt6rnknVZ/4Cdj2VM2KEW+67q/ntoO+KjoxUACHlqfV7l7s6bNLNuNqs3YhOvrNpUuqo7gzUhgxXjBJ2lrxIqdav8tXONlvqc4CnT1xsmzouutpkSo8XAVAuSE2txkUo01V/IecmAGP4wIKJYrrPzp29Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827844; c=relaxed/simple;
	bh=DE/XHWHvRtXunMaKVv0ppouHZYiHawO0ONJKt/8dNns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qqv4OLkXAJ0vj6UIh8xayIyYfNzRQvygztHPHkdFp9XTb6/tDDZ5kMi5kfWbfMqWOHNx9ZFsWOLDTxwCW2eUQAuUWMGofUwv9hXuNQtk8CHBumKeeQUpIiHBai2O/oEDzs8UiGIXpaenWikJSlRfb8JdklzgW/pAeR71nD1pVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=JP083YBl; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DAHOsc007195;
	Tue, 13 Feb 2024 13:37:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=WCLzMa4S8B9LE+l6Xk7TCbMua2Sf8tUF9rmm+m0Qjlk=; b=JP
	083YBlPgUXhg+wSpAUUhfRxaA+2rpPFIKjMyywEsQGjKC3OoDajahLXEejnnThS3
	UCuV53IRKiBQRGbmqjpMEKS5Hj6qrhRKl/L02chk/IBIZGvHe+grGXItX0iXV75U
	Uzux9n048u2lwtdZnyVbY0K49kpoJuVfyCEV4J4S3X1eUkgj6ER49TEZ7fB0J/uT
	VWPM9VIElouyuuH0hFAcMwCR72T28/HW0Sn9efUzR9zGEr1jnQKe+6GPt0CiboTC
	j4I931v4D0ATAB61a5SRtR06Mwj2TUIjEFaxs2CFuYAoVs7NmxVtFS2KIr4rB8Gq
	g9K5KW58Js2lWPD1k0Yw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w6kk4rgpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 13:37:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4E49240044;
	Tue, 13 Feb 2024 13:36:59 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 988B723D407;
	Tue, 13 Feb 2024 13:36:17 +0100 (CET)
Received: from [10.201.22.200] (10.201.22.200) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 13 Feb
 2024 13:36:16 +0100
Message-ID: <18ec4d01-717e-440b-bc54-8652fb68965e@foss.st.com>
Date: Tue, 13 Feb 2024 13:36:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] memory: stm32-fmc2-ebi: update the driver to
 support revision 2
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-6-christophe.kerello@foss.st.com>
 <6bc91742-66d8-425b-ba40-fe5fa6ba18c4@linaro.org>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <6bc91742-66d8-425b-ba40-fe5fa6ba18c4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02



On 2/13/24 08:46, Krzysztof Kozlowski wrote:
> The function is not really readable anymore. Please split it into three
> functions: for v1 (so original code), v2 and wrapper choosing it based
> on revision). Or two functions and some sort of ops with function
> pointers (so you call ops->check_clk_period). Or just parametrize the
> registers with two different "struct reg_field" and use appropriate one
> for given revision (the code looks the same!)
> Or just two set of stm32_fmc2_child_props...
> 
> Anyway the duplicated code just two read different register is it not
> the way to go.

Hi Krzysztof,

As I said in patch 4, I am going to rewrite this patch and I am going to
use the platform data to distinguish between each variant instead of
checking the IP revision.

Regards,
Christophe Kerello.


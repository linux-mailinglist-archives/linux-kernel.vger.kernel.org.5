Return-Path: <linux-kernel+bounces-25337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE0082CDCD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 18:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CD01F22652
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DA44C80;
	Sat, 13 Jan 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kyuhyuk.kr header.i=@kyuhyuk.kr header.b="rGG4FD6R"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECDA4C65
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kyuhyuk.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kyuhyuk.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyuhyuk.kr; s=sig1;
	t=1705165205; bh=rk1IHF6mZGWlBgZYgq2bepEQ66x9m0Dv71w4HAlD3Oo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=rGG4FD6RgDzucbeX1xzpFkXncTHoqRRl/5ATSR6P1eU6ETot97Cxazu+wKMI6txgm
	 C5wNjsuIj/JveeUwck6HAGbhhqyJmI/Exm3rUDn4x9KClMiQp4uYk/RiT45EMsEsNM
	 QwYOEODA9EGdaEQNx9TG6NnBCa216YbH+a2OsjzFeUWUOwSuo5MDG8wYLFLhPT56u7
	 fojaXpN2jJeeq/wEJFTl8Vs1UgEPxq+IduGoYO3ApIr36el4SpfZD57CZU++2rxxPf
	 J7DHPQ/yIirGgqRHZpbtDvrSFOdGtJjAOuodozwsY93NB0/ZhFd0zGllyDq1hLUZCy
	 UgH+XkAWB8k8Q==
Received: from kyuhyuk.kr (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id C67DC4A01A9;
	Sat, 13 Jan 2024 16:59:59 +0000 (UTC)
Date: Sun, 14 Jan 2024 01:59:42 +0900
From: KyuHyuk Lee <lee@kyuhyuk.kr>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jagan Teki <jagan@edgeble.ai>, Tianling Shen <cnsztl@gmail.com>,
	Andy Yan <andyshrk@163.com>, Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: rockchip: Add Hardkernel ODROID-M1S
 board
Message-ID: <ZaLAMRi+HzfSj8sl@kyuhyuk.kr>
References: <20240112134230.28055-1-lee@kyuhyuk.kr>
 <0ba3e9aa-4546-461a-a90b-0c99bfa9da48@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba3e9aa-4546-461a-a90b-0c99bfa9da48@linaro.org>
X-Proofpoint-ORIG-GUID: 1FWd14Z6YbyKI7QvVdGicmRaqIYR6T5A
X-Proofpoint-GUID: 1FWd14Z6YbyKI7QvVdGicmRaqIYR6T5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-13_07,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=740 bulkscore=0 mlxscore=0 clxscore=1030 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401130143

On Fri, Jan 12, 2024 at 06:44:26PM +0100, Krzysztof Kozlowski wrote:
> On 12/01/2024 14:42, KyuHyuk Lee wrote:
> > Add device tree binding for Hardkernel ODROID-M1S board based on
> > RK3566 SoC.
> > 
> > Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
> 
> Your system bounces emails from Conor, so just formality:
> 
> Fix the vendor prefix.
> 
> Best regards,
> Krzysztof
> 

Thank you for reviewing.

Ok. Will fix it.

Thank you,
KyuHyuk Lee.


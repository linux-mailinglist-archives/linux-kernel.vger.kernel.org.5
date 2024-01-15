Return-Path: <linux-kernel+bounces-26194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CEF82DC9B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4795A1C21DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E981774E;
	Mon, 15 Jan 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kyuhyuk.kr header.i=@kyuhyuk.kr header.b="JQlNQZqM"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A481774C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kyuhyuk.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kyuhyuk.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyuhyuk.kr; s=sig1;
	t=1705333733; bh=yxNM4ChCxcfO1k8Hlw537DgVXRAXIZRMKWfvKsTXyrE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=JQlNQZqMl+B2aYMVXWvFwnRZIExG1g/izHCe19R87x7oy0OItSlfdn9Zx9NQnfvzy
	 IfSbbLTnTFwVj81JEvEBrQQWKvd10Szg39wte6sNhsyhc3rzkFyzwDwJBjHoS1JUL6
	 U05Jtq1tjR11qRPVKms3rl6zeGcfxfSWy8dxymZbzDONWjQiiMxcBsKui70c+dpeL4
	 ipWuXcpN0h2tB1wNbPgpSmHZyR00+3qUadrrCbuLi3HCk1RKyJtY86SIUQIHv3DhiA
	 451YJPZcjxMIe3d351mCnlErLO2Th8i8tTK4vAbpzRNoligIbitVEPlXwf2YeskG1v
	 mSg8gpI2yD5Dw==
Received: from kyuhyuk.kr (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id BC2FF4A0176;
	Mon, 15 Jan 2024 15:48:49 +0000 (UTC)
Date: Tue, 16 Jan 2024 00:48:37 +0900
From: KyuHyuk Lee <lee@kyuhyuk.kr>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Tianling Shen <cnsztl@gmail.com>, Jagan Teki <jagan@edgeble.ai>,
	Ondrej Jirman <megi@xff.cz>, Andy Yan <andyshrk@163.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rockchip: Fix Hardkernel ODROID-M1 board
 bindings
Message-ID: <ZaVT1S7bb6qZ++FK@kyuhyuk.kr>
References: <20240115145142.6292-1-lee@kyuhyuk.kr>
 <b4f97202-43ec-4f04-af95-b1ccd3b5d203@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4f97202-43ec-4f04-af95-b1ccd3b5d203@linaro.org>
X-Proofpoint-ORIG-GUID: xfG1gLpxLCaQEbJ_kmI3LhtxShXho3-8
X-Proofpoint-GUID: xfG1gLpxLCaQEbJ_kmI3LhtxShXho3-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_10,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=785
 mlxscore=0 clxscore=1030 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401150115

On Mon, Jan 15, 2024 at 03:58:56PM +0100, Krzysztof Kozlowski wrote:
> On 15/01/2024 15:51, KyuHyuk Lee wrote:
> > The vendor in ODROID-M1 is hardkernel, but it was incorrectly written
> > as rockchip. Fixed the vendor prefix correctly.
> > 
> > Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
> > ---
> >  Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> You need to start testing your patches. Your last M1 fails as well in
> multiple places.
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> 
> The DTS change will break the users, so would be nice to mention this in
> its commit msg.
> 
> Best regards,
> Krzysztof
> 

Hello, Krzysztof.

I am truly sorry for wasting your time due to my mistake.
From now on, i will carefully send PATCH with testing.
I'm really sorry.

Thank you,
KyuHyuk Lee.


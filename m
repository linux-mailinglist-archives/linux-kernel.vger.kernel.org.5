Return-Path: <linux-kernel+bounces-129000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE9B8962FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13CE1C22C66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A66E3716D;
	Wed,  3 Apr 2024 03:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bUtKMepZ"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123863D76;
	Wed,  3 Apr 2024 03:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712115033; cv=none; b=R5ebhLU5muLu4z0h4SfA0FTITGHvVJ9GXrzE9I6Rx7OITeQdApLUQKgEtfPnITNMLPECDND72evkbBisF6l3X76MUKQVnU70JHvzFjvI4vrNGEV1TTAyja51Oy/qT+7xIhKKEuWhJFtk8zrMtNyqfJMRezX8x2SGjqla41+zMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712115033; c=relaxed/simple;
	bh=XF2D2sPHroXYyefKd2obQ6jfostNnDcPvmsVRN+demg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GerTBr0uqlnduCo+vetoSjnsg6DfvuBgGrQFZvdO+kIb/l6Jex1uBigJayxXhFrPbb6zueTAI3Vtl8emuYXx362Z4+cCOZ2v4weKSdc5KoVpcDBf3ii2jwqSSsscnUVVXrM/y1TEwEZ5fmwxL0sDlsJ6m10rgLH5HKp7vPL6jH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bUtKMepZ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 270AD20075;
	Wed,  3 Apr 2024 11:30:21 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712115030;
	bh=XF2D2sPHroXYyefKd2obQ6jfostNnDcPvmsVRN+demg=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=bUtKMepZv0QM4/yWwRsJfffJODorh+VnQ7PWH5h4y7I8LiyqOPHErNZc8RoCdrYNV
	 m3w3BPIdVJeB8st3TTGIi14C0r+Vy8hM1A48aGJvquQazkqJZJNvoqF9JySyY1YDjx
	 gNBWjuR5fJyJjcm6AK43GRlHcAM5Te5GREv4X2NPL546io6ZjatZgov2kYGaKbd6Mz
	 lJLFs9fEDvYOt4+Wm7ktzT6txkoQB7QNof2DkRL76tJqkh9TZKTEmiSqzwpURhQC2r
	 oMZc30ylO4yhBm2F3QvYNg2ElHq1bRKBlx7OCH2hkGg03w7P4jPO6vfZ4JXdujSTaM
	 +uSCQWIy/EpyQ==
Message-ID: <3593e51f6e63dfd2b163d422032203d75e8bfb25.camel@codeconstruct.com.au>
Subject: Re: [PATCH 3/3] ARM: dts: Modify I2C bus configuration
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Renze Nicolai <renze@rnplus.nl>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, arnd@arndb.de, olof@lixom.net,
 soc@kernel.org,  robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 joel@jms.id.au,  andrew@aj.id.au
Date: Wed, 03 Apr 2024 14:00:20 +1030
In-Reply-To: <20240329130152.878944-4-renze@rnplus.nl>
References: <20240329130152.878944-1-renze@rnplus.nl>
	 <20240329130152.878944-4-renze@rnplus.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Renze,

On Fri, 2024-03-29 at 14:01 +0100, Renze Nicolai wrote:
> This commit enables I2C bus 8 which is exposed on the IPMB_1 connector on=
 the X570D4U mainboard.
> Additionally it adds a descriptive comment to I2C busses 1 and 5.

checkpatch on this one too :)

Cheers,

Andrew


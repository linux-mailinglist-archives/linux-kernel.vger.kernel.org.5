Return-Path: <linux-kernel+bounces-163798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0521C8B710D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC771F20F96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B312C80B;
	Tue, 30 Apr 2024 10:52:28 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25874176D;
	Tue, 30 Apr 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474348; cv=none; b=j4cmfATjkn9SSubc4fmUnAJVXppx2v2NlZAgqh40o4QU3irML1hkzYX4Frz4E8HVGLUivFXe6xIOFPvnePDUd2S2krl/HULbWJd12i8+u2DUgIxMPLN4m1LKtFIHqpbfcXE7ubNH0x+XEmbuj1/rDkEMeRd69zofqVrRY/wWX+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474348; c=relaxed/simple;
	bh=KB51eK7mCO9v665GGmj5THmfNw/9GfUqwpasbF7imQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qH7wc6+w/4DDRvW2z9muJNzDd7u1u4DGhF+ecnn1ZkoheZpPVz7YzVNCMIOxB6pRi7TktTXd0AnfoQSaf5kFr/TZQpnjag4cv1Cx2MG9IWIglL620hHdGMleaybdc6vP3znnW4Qhp13LEOdnOEEPMsvdtsxcNdeSouOqmgadjvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:6c50:5089:6cd8:506a:48e6])
	by smtp.qiye.163.com (Hmail) with ESMTPA id CEF5A7E015B;
	Tue, 30 Apr 2024 18:36:21 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: krzk@kernel.org
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: rockchip: add Radxa ROCK 3C
Date: Tue, 30 Apr 2024 18:36:15 +0800
Message-Id: <20240430103615.1626648-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d6004beb-2e7d-4f26-a202-0c5baabd4023@kernel.org>
References: <d6004beb-2e7d-4f26-a202-0c5baabd4023@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSh0aVk8ZHx1CTR1LGUpMH1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0tBTRhOS0FOS0NCQU0YH0NBTktNGkFPQx5NWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8f2e93b0dd03a2kunmcef5a7e015b
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohw6MBw*FjNLHBk5Fg1OSx8P
	NSIaCSNVSlVKTEpPT0xISENJT0NKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBTRhOS0FOS0NCQU0YH0NBTktNGkFPQx5NWVdZCAFZQUpDTk03Bg++

>> The Radxa ROCK 3C is a similar board to the
>> Radxa ROCK 3A with the Rockchip RK3566 SoC.
>> Add devicetree binding documentation for it.

> For future:
>
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit)

Should I compress these three lines into two?

> There was some big renaming of these boards. I assume you are using
> correct naming?

According to the link below, the model name is now correct:
https://lore.kernel.org/lkml/B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com/

Thanks,
Chukun

-- 
2.25.1



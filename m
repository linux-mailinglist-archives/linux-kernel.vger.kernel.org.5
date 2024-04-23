Return-Path: <linux-kernel+bounces-155432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6088AEA60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37FC3B23699
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D522813C69D;
	Tue, 23 Apr 2024 15:13:28 +0000 (UTC)
Received: from 6.mo560.mail-out.ovh.net (6.mo560.mail-out.ovh.net [87.98.165.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57313BAE2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.165.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885208; cv=none; b=t2dX9qE3NkFvSuDLHIm7lYrxG5AUDK/9o8/oJgw3vfPQuipqX3/kruUkc/C9Sj460QBM2W0DuyfhvU8yH09I+lYGu1qufB8Pet7xg8DVWAd7HaaO2uJeHjvYQ5+rlr2Ix5UzwGEYdwpRfOW+8yKf/VAtitzkYjuXFzMmg4XQuf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885208; c=relaxed/simple;
	bh=AwUAUzpHBOsc1lMca4BINuz9URPqQhgCUVu2azAuauE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AEaKM52FDI50aa50J3oO89QVl8ZW0nXGonI/qe3go9cbjf8Fm4HZ3l6FgB1reJPzV2eIDVaost2YDfNUR1bckwzVq4Q/KaaHKusrNqqlV2jTaKfWcuBhZPzZrOsbLBl0KaxVQo6/CeyXesVlwmeMgvv6L3IErS82T1uowO5c1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=87.98.165.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director1.ghost.mail-out.ovh.net (unknown [10.108.9.101])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4VP4QJ6WzDz1W5C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:34:48 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-bhrm4 (unknown [10.110.113.89])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 407C11FEC9;
	Tue, 23 Apr 2024 14:34:48 +0000 (UTC)
Received: from etezian.org ([37.59.142.97])
	by ghost-submission-6684bf9d7b-bhrm4 with ESMTPSA
	id Bgz7CQjHJ2bTTwEAbTVA8Q
	(envelope-from <andi@etezian.org>); Tue, 23 Apr 2024 14:34:48 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-97G002eebf7df8-33da-4965-bbcb-682bf0db39b3,
                    C447AC6F663E29B5B072953094682C3B23667ADA) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Piyush Malgujar <pmalgujar@marvell.com>
Cc: sgarapati@marvell.com, cchavva@marvell.com, jannadurai@marvell.com
In-Reply-To: <20240423074618.3278609-1-pmalgujar@marvell.com>
References: <20240423074618.3278609-1-pmalgujar@marvell.com>
Subject: Re: [PATCH v7 0/5] i2c: thunderx: Marvell thunderx i2c changes
Message-Id: <171388288720.439949.15428292378589168497.b4-ty@kernel.org>
Date: Tue, 23 Apr 2024 16:34:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Ovh-Tracer-Id: 14341713015152839280
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeffteehudffvdfhudfgffdugfejjeduheehgeefgeeuhfeiuefghffgueffvdfgfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekledrvddujedruddtledrudeiledpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht

Hi

On Tue, 23 Apr 2024 00:46:03 -0700, Piyush Malgujar wrote:
> The changes are for Marvell OcteonTX2 SOC family:
> 
> - Handling clock divisor logic using subsytem ID
> - Support for high speed mode
> - Handle watchdog timeout
> - Added ioclk support
> 
> [...]

Applied to i2c/i2c-host on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[1/5] i2c: thunderx: Clock divisor logic changes
      commit: 1e82de6368238dfcca306fc66dc6c3f8c21e1b4b
[2/5] i2c: thunderx: Support for High speed mode
      commit: 305b1350c49993bbc879270764aa59e8de00a904
[3/5] i2c: octeon: Add platform prefix to macros
      commit: 8c82edccf99ad4395cf943dad48c47b44a1c920a
[4/5] i2c: octeon: Handle watchdog timeout
      commit: b6ea602a1100c6241c47a8b4326a050ff3379c4d
[5/5] i2c: thunderx: Adding ioclk support
      commit: 8d49135d177dbfee92bd84fef32b47d656e6b314



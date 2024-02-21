Return-Path: <linux-kernel+bounces-75374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC685E75C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F71C23037
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32F886139;
	Wed, 21 Feb 2024 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8dLBJBp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C985C58;
	Wed, 21 Feb 2024 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544205; cv=none; b=NTePhB3zxb1huDZtx5sKeTf0npKmAYbQ729IYQ9JXT2PdkcrkVJWimL4JQvgVgukKkeh4IKxZvgIoqisucGSQ9hSqJ4oWnIO1aBVyqXpQyfZwiaMcwmRdd0oA7z3BTvR09gZmFKPFoUeI+IyXodDs5YzCkPzUUJ4a/irs2enTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544205; c=relaxed/simple;
	bh=7G9uAWaMMmE2mODGAFT5Amp5y8BNqQnlSsXn4zUonjs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tt3cH40J5K+LxKMhnillxx2njAsbIYgbtlx1KJ6J6qhfrc7EjgGZf9lKNs0kptwKgOn2dFKtpA8P5ud24JC9kcsVfH0SmhDY0tl9h2yH3eq/xwauU568ANORugIAIeS72+bvlURqrsDDBul/TWixcCzWcczCj/EVMGnc+QcKtEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8dLBJBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA31C433C7;
	Wed, 21 Feb 2024 19:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708544204;
	bh=7G9uAWaMMmE2mODGAFT5Amp5y8BNqQnlSsXn4zUonjs=;
	h=Date:From:To:Subject:From;
	b=Q8dLBJBp1p2eVU6ul6Q6WlRl1p84CGokCjHMkZX0gy0Jx6X949S5cr5zuUMVN05Yb
	 0rtkzDF/076qsLs9uH3bzPsHp81abxS8IZnVDKBuALdhQfRYG+/4Kf25ORPrBEqYXL
	 F6TaJrr0mY7Chi3bq0SNq5Bkm7AG0+AXYBlbBgH2G8DYFkcbn0C1LUDAk75RPNDE3A
	 bqdWYh8yvJrKDYbuCXQ5Ts+AWrHYflAaG/UxGovIXLcbCz9VGSggmH5W/EDv+Ek4Eb
	 DmJQ0bwLk9Fv+L4Er4uCJwK/wbNx27ZwZpt0q3Y0IrGk7qZZVDnBXZrV64l2Ibh0+f
	 Z3F2A5eonyxGA==
Date: Wed, 21 Feb 2024 12:36:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Prebuilt LLVM 18.1.0-rc3 uploaded
Message-ID: <20240221193642.GA2138843@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded a prebuilt version of LLVM 18.1.0-rc2 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

This release is the first one to have SystemZ (s390) support in ld.lld
and llvm-objcopy, so this release will be the first one to allow
'ARCH=s390 LLVM=1' to work properly, along with several patches to the
kernel that are pending in the s390 features branch (targetting 6.9):

https://git.kernel.org/s390/l/features

Another change in this release is the inclusion of libclang.so on the
packaging side, which allows bindgen to be used with these toolchains:

https://lore.kernel.org/CANiq72npYCD-zKqcXPNOAxnKiUCCXGbFQaGo-8=0-171ni+ncQ@mail.gmail.com/

As with Linux -rc releases, this is not the final version that will
ship. If you run across any issues, especially ones that were not
present in earlier LLVM releases, please consider reporting them to us
so that we have a chance to investigate and fix them before the final
release.

Cheers,
Nathan


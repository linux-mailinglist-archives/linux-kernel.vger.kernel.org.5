Return-Path: <linux-kernel+bounces-57342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBB784D728
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998A41F22E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C992AFC18;
	Thu,  8 Feb 2024 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eU6pLsEl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C4D50F;
	Thu,  8 Feb 2024 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352124; cv=none; b=HuOTDzWeatxGElCv0kvkmLWLDqEx9eSc5w44bDwgKGc90xtsCpdFkg0FTrwBimfg7AOy/UM4ip5G7OEiKm7KnbhwHKnlRI1uECVtyeWH0XfMurWTNk97yVeaVO0Pdy6T89Vp1bShrgZC+9xTWjqSo0SCFzZc5dmFn+pnmPmvDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352124; c=relaxed/simple;
	bh=cPz3cntvgTaqX86dInJeHWpqJqDb0A2mhivO4Y7prAg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=er6yFWWjhvy5poBvZ8jgeC6TG112rtxSq524991hUwVdtp9crY81ch5uuAzADIh4tMnJSZ2tRLX4UiKuNkpcfz3PPHoR32jxPNf8oCNIrQM9gekC6+6xOrTZpZcMYI2QotdqWeYWNhQzL4RzxstdA0SqQo3jSB4uFyqESFw9KxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eU6pLsEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D301C433C7;
	Thu,  8 Feb 2024 00:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707352123;
	bh=cPz3cntvgTaqX86dInJeHWpqJqDb0A2mhivO4Y7prAg=;
	h=Date:From:To:Subject:From;
	b=eU6pLsElZGOUNsZcqoXY9fE8nOY+mklOADD/QYfV5WFUYlHHyi8vi8il+BmvEq95G
	 +DpCHPFtI8trQpiXnyGQokJyComMSjCKzWPY6FnLE/8UEzwCQYi+xO89hWOL0fSEst
	 mh7J7TXeyr3RYZ896Z8fKMW78lVvJ4yZoLrTPlLEobSZwro+iCwhXYygwnz5Ynb/xo
	 v60Kc796bSwvKubRAFANVA80d4fybPuQws0xruniBbCmWPFNTbGCVY8xnOlLIPvtM5
	 lLCKcJFAHKyxWg98pnxH85MnhSKF3ZdmE+bRwcrHoEltvj2CgKYDj07xyh00W9cwbm
	 JrUsEWZowxjzA==
Date: Wed, 7 Feb 2024 17:28:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Prebuilt LLVM 18.1.0-rc2 uploaded
Message-ID: <20240208002841.GA2601476@dev-arch.thelio-3990X>
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

As with Linux -rc releases, this is not the final version that will
ship. If you run across any issues, especially ones that were not
present in earlier LLVM releases, please consider reporting them to us
so that we have a chance to investigate and fix them before the final
release.

Cheers,
Nathan


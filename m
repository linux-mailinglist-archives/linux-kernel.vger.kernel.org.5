Return-Path: <linux-kernel+bounces-75289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D6F85E5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BD11C213C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F861272A3;
	Wed, 21 Feb 2024 18:24:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36501272A5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539888; cv=none; b=rnf5BAjVd80iNoHQ/KMPKFHCvmozoG0z/CzlEgNOwr8jkcdCeB0sne8qvRnRc8bGY03QQSdx3Yze3cbicD4o9Qcr+/CIfBeA5lqK/ySVKbQtro6iIf/bfU0MqoRN120b+t/DgGIZEDeNaxs7SZiMNfADyttgeOf+Rxq0BUvjPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539888; c=relaxed/simple;
	bh=rnEeoyQdx8skRmD54l9is3hH2QGmmI0xyJU3Mhfnozc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tA0k/hdyHXNVzEb32vhr5CamUFQL+1jcZhak50nIJ9uFNL8wNGJ3UOCosaPgrVVNlk5C8R2S5dvmj67PUahPiFz/Hf0MpB0igVHQdl62KWexZ6EhTcgT2JW+LhonS+v/y1scdUHNl9Nto2b1e3GmjKznHnl/qiO4zIxhjDUdSlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F165C433F1;
	Wed, 21 Feb 2024 18:24:46 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/sysreg: Update ID_AA64DFR0_EL1 register
Date: Wed, 21 Feb 2024 18:24:44 +0000
Message-Id: <170853986942.1224167.17230898618001754181.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220034829.3098373-1-anshuman.khandual@arm.com>
References: <20240220034829.3098373-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 09:18:29 +0530, Anshuman Khandual wrote:
> This updates ID_AA64DFR0_EL1.PMSVer and ID_AA64DFR0_EL1.DebugVer register
> fields as per the definitions based on DDI0601 2023-12.
> 
> 

Applied to arm64 (for-next/sysreg), thanks!

[1/1] arm64/sysreg: Update ID_AA64DFR0_EL1 register
      https://git.kernel.org/arm64/c/358fee291705

-- 
Catalin



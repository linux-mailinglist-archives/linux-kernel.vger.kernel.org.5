Return-Path: <linux-kernel+bounces-75285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCA285E5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8571A28583C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5E58662A;
	Wed, 21 Feb 2024 18:24:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ADA7FBD5;
	Wed, 21 Feb 2024 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539845; cv=none; b=Lek/Vyr3qbRIHdCEFVS2fT5/4y+f5YnK+Cu8txsplDKUc/yrQBx/LhbxHsXjrlS7x2cm7RZItOELihiKWaqmEXSOoMVoLP3c5MupHLuSGoBErlQHmyNdE+0JQ07qRxUTUrwukcS1e22xNxLHnt6ptxg49Tq1+hDZF6tWe3MInhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539845; c=relaxed/simple;
	bh=E1ArZyyjtZkf3+xZcM2P4wMjX6AlHb7l/2arGthSJEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OO10UaiWDkkKlMJziUqBf8bRo+K8Or5+LANt/Ukdh+VhMMz13hrJpho5Nvke483ojjTwlcbzkFSyvWy8/W2QdDJfPwuxGDcVaJwkcHovL9PZ5M8/qYlQ5hErCZ5HbGjAbaQm04Z2rVHc2DndSufHnFaYbNI/J2KbAoRw+V5UOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EDEC43394;
	Wed, 21 Feb 2024 18:24:02 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Brown <broonie@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edmund Grimley-Evans <edmund.grimley-evans@arm.com>
Subject: Re: [PATCH v2 0/4] arm64/fp: Documentation cleanups and clarifications
Date: Wed, 21 Feb 2024 18:24:00 +0000
Message-Id: <170853983553.1221430.7165446374929012835.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
References: <20240124-arm64-sve-sme-doc-v2-0-fe3964fb3c19@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 24 Jan 2024 18:12:34 +0000, Mark Brown wrote:
> Edwin noticed some issues with the SVE and SME documentation which are
> corrected by this series.
> 
> 

Applied to arm64 (for-next/documentation), thanks!

[1/4] arm64/sve: Remove bitrotted comment about syscall behaviour
      https://git.kernel.org/arm64/c/b4725d3e4603
[2/4] arm64/sme: Fix cut'n'paste in ABI document
      https://git.kernel.org/arm64/c/ae35792764bc
[3/4] arm64/fp: Clarify effect of setting an unsupported system VL
      https://git.kernel.org/arm64/c/3fd97cf3234c
[4/4] arm64/sme: Remove spurious 'is' in SME documentation
      https://git.kernel.org/arm64/c/e47c18c3b25e

-- 
Catalin



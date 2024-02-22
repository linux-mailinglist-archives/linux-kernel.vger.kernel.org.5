Return-Path: <linux-kernel+bounces-77441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D3686055E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D6F1C242E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F80137903;
	Thu, 22 Feb 2024 22:05:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4212D21D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639513; cv=none; b=kskkwbqxrYGpid58kgrMvaGMGev2vfkYn7Ck+sUKTJmf7f1Y71xQmfkvY0nR/AZ+Nk6vqX7RTDKEqGF//sjhUes2lXDgyDBPInb4StjsYUTAB5V1IgYTfL5aDkLBu/JuY6EuNtSdjaYM56mGVXtfVSio9EYs0k//1EWDqcD3d5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639513; c=relaxed/simple;
	bh=YtA+AeSqzXc3bwacRegNHrvIDwoGkuarX3bDwKgnlcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwdloWn5DFZ/7L8bR+84Phvl36cB0mjBVlOI28NdmwxZHCPfSXkcYAU+Z3PJEHmIBmzLlImrvcoZoPQBSjGurcwmpcEzcTAySA0w8W+iAbyAHbLd/aRde1/oI2rcRTwwpW2jcu6hgDG2zTqNTPp/pflYxytn4tPJDyXjd8Sxhz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAA5C433F1;
	Thu, 22 Feb 2024 22:05:10 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/sve: Document that __SVE_VQ_MAX is much larger than needed
Date: Thu, 22 Feb 2024 22:05:08 +0000
Message-Id: <170863948635.1616990.16270415841585916103.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209-arm64-sve-vl-max-comment-v2-1-111b283469ee@kernel.org>
References: <20240209-arm64-sve-vl-max-comment-v2-1-111b283469ee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 09 Feb 2024 16:53:36 +0000, Mark Brown wrote:
> __SVE_VQ_MAX is defined without comment as 512 but the actual
> architectural maximum is 16, a substantial difference which might not
> be obvious to readers especially given the several different units used
> for specifying vector sizes in various contexts and the fact that it's
> often used via macros.  In an effort to minimise surprises for users who
> might assume the value is the architectural maximum and use it to do
> things like size allocations add a comment noting the difference, and
> add a note for SVE_VQ_MAX to aid discoverability.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/sve: Document that __SVE_VQ_MAX is much larger than needed
      https://git.kernel.org/arm64/c/21eb468e9fc1

-- 
Catalin



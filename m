Return-Path: <linux-kernel+bounces-142154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C98C48A282D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691B71F24279
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71EC4CDEC;
	Fri, 12 Apr 2024 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivea1Bws"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355236AEF;
	Fri, 12 Apr 2024 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907257; cv=none; b=hdgaqUsVO6aIdG3adrEjdfff4VSh0qm344oZhSn/CucsTsioCSjkjOpSD7YDGjBe+2lWC+v6EvQ68s2upGUdq3R/QPHQpGdUgmacS7IEaOQyjepRb5CRSc45K7ofMuEXUjhjx78jxXwXeYb7PfUAO6SFNUPWgIkEl+FY3da/4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907257; c=relaxed/simple;
	bh=w1lIadg9vFyCZlOc49Hriwu+EbwJmqXkOFt9/Hp73YE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s1AMtsbEMakAwT2+59PGKUyHiZHuWeJf/6NX/dJVInNwPutOTgJsTE+1pFpXGKkP+v0cMQVakY/u0dveknOldAJsMpzb9JhD/0nM8sxDOecEq03dINvecib1qLMqk5gQGsdW516DbfdOctQ2X0bXZmn9KhxlJHyOBaeKPv3Jq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivea1Bws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB9DC2BD10;
	Fri, 12 Apr 2024 07:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712907256;
	bh=w1lIadg9vFyCZlOc49Hriwu+EbwJmqXkOFt9/Hp73YE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ivea1BwsvjvOeUz3ESVhOaiEgwlkfMRBYZ+FZNW8C/LqlTjTuVJy6SFOBxzGLf7Xw
	 JL6+V1PuzfqkTwMqBcve7o47UiGRL+wvHFuM+tiW9x81Xnf/1HOGKwFBud5v+QOtcz
	 7V3wTh0l6DC/rmn6UUQsl5saMkG1aPwx501vrvzuftYMeLSX1EcYhpQl6Oi4qvJE5W
	 HXBDV3FskKNQWiWQAx2c4/sbqaHsnA/tLkCzST9guZhuWrR6ecX1OA2r/Ct/Nhdh5i
	 QAGIpy5DaPWPr90MN12pOtqYzaf0OSMKL4kmsOdqxbnwwer/L29Fx6ew9i6BEZjWBb
	 /h+yLMvuvV2IQ==
From: Lee Jones <lee@kernel.org>
To: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
 Lee Jones <lee@kernel.org>, linux-fpga@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peter Colberg <peter.colberg@intel.com>
Cc: Russ Weight <russ.weight@linux.dev>, Marco Pagani <marpagan@redhat.com>, 
 Matthew Gerlach <matthew.gerlach@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20240402184925.1065932-1-peter.colberg@intel.com>
References: <20240402184925.1065932-1-peter.colberg@intel.com>
Subject: Re: (subset) [PATCH v2] mfd: intel-m10-bmc: Change staging size to
 a variable
Message-Id: <171290725366.2913077.13035135180909218343.b4-ty@kernel.org>
Date: Fri, 12 Apr 2024 08:34:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 02 Apr 2024 14:49:25 -0400, Peter Colberg wrote:
> The secure update driver does a sanity-check of the image size in
> comparison to the size of the staging area in FLASH. Instead of
> hard-wiring M10BMC_STAGING_SIZE, move the staging size to the
> m10bmc_csr_map structure to make the size assignment more flexible.
> 
> 

Applied, thanks!

[1/1] mfd: intel-m10-bmc: Change staging size to a variable
      commit: 770bb9cf4e857ac76f0671309cec689d2a3a4b46

--
Lee Jones [李琼斯]



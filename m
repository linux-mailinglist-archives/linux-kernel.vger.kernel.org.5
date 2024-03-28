Return-Path: <linux-kernel+bounces-122932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C188FFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096C81C28EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F47FBB9;
	Thu, 28 Mar 2024 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak1sbqmT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4C5FB99;
	Thu, 28 Mar 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630653; cv=none; b=DIsjIs6KB80P6WYgNvkMpqq8FFA+exfHXm0q1dgBRlwTT+2lNJNGw4FPiR2NgxxY24/9kXleT2HMqh6dOUUOFUV9A/JRGQLNMYZWy2O2gN6UsD+2gnxclgFAUn+lZXk6FQV2Xl2LBqDWSt8iwY46jUalUvR1xXXbyuyiVTtz/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630653; c=relaxed/simple;
	bh=NqFtcA01L6YHAkspYOeRJlzOjy89j+1aJ2esOXYp47g=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=bhQ+6sH0hTyAR9dp04JldtSJe+HoLa2NNaZIDpYpGkmigpD8T6TVnJ69KiL1lqq6hzF47dTMuo0kbfhUZP9afZkyYZMfqrKCU+BI2bkQnuGvfDi2Ubnaj2E+uQs93UfxBE5oVMzyfZ+sGzmsO/+QSnIyvg4eQS0+w5DMlAFNgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ak1sbqmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDCCC433F1;
	Thu, 28 Mar 2024 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711630653;
	bh=NqFtcA01L6YHAkspYOeRJlzOjy89j+1aJ2esOXYp47g=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ak1sbqmT2oNRt2EEk/n1QfSYg2WTASl9KJskAVfH+qD+2kE8i8hvY7xBI78j5G1oV
	 Hk2dx1IBkSVNDqcq+IVUX6KLJf1GWo+5y7jrDiRq7yS/MbUSXeiJ17T2j2oVDLNXdB
	 HnA/lleZY/E1rKdpZxlEMNETzRGMSfRg1gSo+yblcsGF14hiRgwpr+JnFpZw6BKYsB
	 CPyLcVHrySf9uqFqZr10T1fJ5vb4FNYSr7N2G4ZskQGK67A9Ss1eMiqroPSOnFUs4A
	 04JQSvDMUjbYmw5mZM5rq8KhlpG+6Ed1thYeof4fpTEwiYlZugDxIqi59Bue6RtfOM
	 shK49zMqFYc1A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: wil6210: Annotate struct
 wmi_set_link_monitor_cmd with __counted_by()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZgODZOB4fOBvKl7R@neat>
References: <ZgODZOB4fOBvKl7R@neat>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171163065000.129280.2362402378382558964.kvalo@kernel.org>
Date: Thu, 28 Mar 2024 12:57:31 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I'm dropping this because it looks like you sent a different patch, but
it's quite hard to know for sure.

Patch set to Superseded.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZgODZOB4fOBvKl7R@neat/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches



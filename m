Return-Path: <linux-kernel+bounces-46085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90363843A19
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AF51F2F7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBAB69D00;
	Wed, 31 Jan 2024 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnoU/8AT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B636629FE;
	Wed, 31 Jan 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691419; cv=none; b=mq/3Qe5zarq30jCR8UInVUgwx+ZO+Ss7+Jx2rdzfB+aB8dbZFkWMUhWfgfXzySV9/qBFQqM4q08jb/EyrY5B4sZuOi5Jzp4Bm0KQgve0Ds2uONFCpCl90MCejR6hCu2taK7Jbn47a/EX7w9pNvfHR7ssAUbB6DEfbcqtLVV+wZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691419; c=relaxed/simple;
	bh=5IwHoHhAaOUvqb5LH+q/D/hYRD9jixazumE1nV6Qdl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Snd2EHTd4o3G2n89znVZpd5xs8fIS4875jgLbR1MX1K7lj8h7eAFcR/51sRqp8yR/DG47CZbrm72L8o41ns9Crskf+08v8rF6tkJuR6hxDebVWKF/Q56vVFNhb0pCVRrSCXYrtYwr8w+eyaRDHHggdTiKeb8VWRVZLVMkyUo1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnoU/8AT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C20C433F1;
	Wed, 31 Jan 2024 08:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706691419;
	bh=5IwHoHhAaOUvqb5LH+q/D/hYRD9jixazumE1nV6Qdl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnoU/8AT2AW8gLEZqwyHoDHyyK8SY0hagyrGfyk/M9V1KYXLMwpivFsrh4yeAA3P8
	 PFMhSIzKgtOkdZ6fEnguzwpt41uDrNJgcBVP0a9GhTu8wY8+OsfcGfF3JtYVfFuiwt
	 hrd4lc0EKrn28Ju19Hia18Ybzhz83nmhSKxuFdtNKNN8ODvRBAQMC7KC3DiqWD/Jhs
	 LPLtWxiWVoJbRx99Tj2VBeY/aBbyqMkuh/0P/WbMLHuz7Ef73QwcS+QNmRHPjVXPh5
	 ZIMFF+JEh2xyHpTTda9RznaDPcyKIUdNbyZS2HuaqsTqcwFuDzP42NN7VHamtaxbC1
	 emwaIGMGSVIlg==
Date: Wed, 31 Jan 2024 08:56:54 +0000
From: Lee Jones <lee@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Anjelique Melendez <quic_amelende@quicinc.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the leds-lj tree
Message-ID: <20240131085654.GE8551@google.com>
References: <20240129131054.14bc453e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129131054.14bc453e@canb.auug.org.au>

On Mon, 29 Jan 2024, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the leds-lj tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/leds/rgb/leds-qcom-lpg.c:17:10: fatal error: linux/soc/qcom/qcom-pbs.h: No such file or directory
>    17 | #include <linux/soc/qcom/qcom-pbs.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   8148c8234e10 ("leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM")

I'm holding out for a little while:

  https://lore.kernel.org/r/20240125130432.GG74950@google.com

> I have used the leds-lj tree from next-20240125 for today.

Thanks.  Please keep doing this for "a little while". :)

-- 
Lee Jones [李琼斯]


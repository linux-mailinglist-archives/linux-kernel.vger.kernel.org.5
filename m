Return-Path: <linux-kernel+bounces-9209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3583681C257
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8511F24C96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0923C17;
	Fri, 22 Dec 2023 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRK05lUW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D3033CF;
	Fri, 22 Dec 2023 00:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DEDC433C7;
	Fri, 22 Dec 2023 00:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703205261;
	bh=sZ4sSOnLTX9EH4nYNAnnZbaYq0kigO0AODfJzFxYRE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRK05lUWesMFRWi0QMT/ssDYfz3Ei+MCSzysS1zznKaeTTwDn9TZwOqBSqnujWZda
	 wj8G/e7v4HcyB3UFBTMZVfWQNYRGS2SfUJO5jzX45utDzVa8itIcc2yQT/AzukXgjN
	 wEyYPmEuJm7YQr6eCFMHCNrcBBZcI5mU+TLa+e7jhbBO2obcgkRxj9DQlS2vyORKr7
	 D0zQx1CU6f0pTZJ47hZpC0MZgEwWnn2yvqgY5TyRP1DC2ooDtZnPGGtg76A1qko7MS
	 CD/nPY0duv4y40aaglbkK1i1NwJV5eYemWjxxsYyNgmzpCdujpDo8nq34TIRdqB8J1
	 CeZXaEqBPK9AA==
From: SeongJae Park <sj@kernel.org>
To: Tanzir Hasan <tanzirh@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nick Desaulniers <nnn@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm/damon/vaddr: changed asm-generic/mman-common.h to linux/mman.h
Date: Fri, 22 Dec 2023 00:34:19 +0000
Message-Id: <20231222003419.69272-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAE-cH4o85OkMAZ5sH0SiakQi_FqauNYcQ+KhniEd2g5e8kSF1Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Dec 2023 16:29:57 -0800 Tanzir Hasan <tanzirh@google.com> wrote:

> Hi SeongJae,
> 
> On Thu, Dec 21, 2023 at 3:49\u202fPM SeongJae Park <sj@kernel.org> wrote:
> >
> > Maybe we could add below Fixes: line?  I guess stable@ is intentionally not
> > added and that makes sense, but please let me know if you think differently.
> >
> > Fixes: 6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schemes")
> 
> Yes, that makes sense. Just confirming that I understand, would you like it
> to look like this:
> 
> Fixes: 6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schemes")
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>

Yes, this looks good to me :)


Thanks,
SJ

> 
> Best,
> Tanzir


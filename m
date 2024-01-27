Return-Path: <linux-kernel+bounces-40920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B6783E7E8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794B41F22AA4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D387463B5;
	Sat, 27 Jan 2024 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO3GLItS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84633D1;
	Sat, 27 Jan 2024 00:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313801; cv=none; b=lXqsYP9EI4Ttwpta5cTT2ZfXfitpvzNZYDyoOYiPlHCL2hj7dH6FGgcWRRHAs9QNkusg9CHkHih3sdUe+xKV729Y9E8EvbBZtLFpQDH2ojfBZqrnY/p8URvCxZ5wf3ZEWaDhguySM1I3sno05QyztzOvw92n8AApud999jZ6FKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313801; c=relaxed/simple;
	bh=yXzHV+To+Bf35AcBbLv/hgMCRQ8f9/i5+DnGHKeqink=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgphklnfQqWVI7060gwLb3GNGi6zbA2mCG+bpwovjZr78o6zzqNfWXzz9ka+HN4wB3Y+hYc3tYn7Pf0a8C+MZ/ecRxYigNcr86zFqmIEW1RL/FUIh//4jMS3MaOgQE3CUD0ZWwefKVN+g5lbOYqUSEDvSvQYdoE5sTMw/qE3524=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO3GLItS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ADEC433C7;
	Sat, 27 Jan 2024 00:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706313801;
	bh=yXzHV+To+Bf35AcBbLv/hgMCRQ8f9/i5+DnGHKeqink=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QO3GLItS8D9pjuHnVAH0T9crdlP/3wzsDJKrClqNlJuPSVk4pmR9GMdk6f4KP6b3r
	 CjNxlg+lqg0PgY7unlhP03t7DRa5bj2IPE9oF18bU9Y+0EeYZIs5fnMiwyfgvKbwLg
	 mw23j3qTjHPItBJ9ztwBMaIzKjEvB8fHXq5mLlkl8eyHHqD0LRsbWXq/j9F88j2SkR
	 Uw4qrU+O04PHzfFqMtyMJhmHs/vsdGedyjAuO/g4MJfuLhns4q7BnsOJaSk4jwx3Rf
	 vV1seWz5FaqkswJjBpNJoT3hQPW7UvzVUlZoR+dHfU0sBt+wAQDJCvokYx5m7t6Dkd
	 5pjzDOYa7713A==
Date: Fri, 26 Jan 2024 17:03:18 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, llvm@lists.linux.dev,
	keescook@chromium.org, arei.gonglei@huawei.com, mst@redhat.com,
	jasowang@redhat.com, virtualization@lists.linux.dev,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
Message-ID: <20240127000318.GA1561706@dev-arch.thelio-3990X>
References: <20240122235732.009174833@linuxfoundation.org>
 <6b563537-b62f-428e-96d1-2a228da99077@roeck-us.net>
 <2024012636-clubbed-radial-1997@gregkh>
 <2f342268-8517-4c06-8785-96a588d20c63@roeck-us.net>
 <20240126203436.GA913905@dev-arch.thelio-3990X>
 <0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net>
 <20240126223554.GA1320833@dev-arch.thelio-3990X>
 <bef7737e-4b8e-4a89-b538-cd8e75874fd2@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef7737e-4b8e-4a89-b538-cd8e75874fd2@roeck-us.net>

On Fri, Jan 26, 2024 at 03:55:02PM -0800, Guenter Roeck wrote:
> Anyway, how did you find that ? Is there a magic trick to find the
> actual code causing the warning ? I am asking because we had seen
> similar warnings before, and it would help to know how to find the
> problematic code.

The easiest way I have found is figuring out what primitive is causing
the warning (memset, memcpy) then just commenting out the uses in the
particular file until the warning goes away. Sometimes it is quick like
in this case since there were only two instances of memcpy() in that
file but other cases it can definitely take time. There could be
potential issues with that approach if the problematic use is in a
header, at which point you could generate a preprocessed ('.i') file and
see where fortify_memcpy_chk() or fortify_memset_chk() come from in that
file.

Cheers,
Nathan


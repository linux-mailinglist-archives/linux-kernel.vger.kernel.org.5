Return-Path: <linux-kernel+bounces-75173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5975085E41C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D501C22A72
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CF783A1F;
	Wed, 21 Feb 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/BrxkNi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D333F7;
	Wed, 21 Feb 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535563; cv=none; b=AEhyNyKOz8B3ZwAwXeY94Ep99AKcuo0bEgbxpSDHCIb/BZHp1SKBkNipgzAuho77vVk67new6zf+w2p3T0Tu7CRuYhp8fcPfggPS5OEA54oHn4tjbvygSNNsc3HqTXTxsX0DgR+ohvT/SQ/Euf5/9PenbyY3yu/eUEq5+APYjq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535563; c=relaxed/simple;
	bh=3cF0hRg56ey3XRtvjCjE/Ic1fV37b1kLU7pCfhtoO70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WruCJ01yGaWVRYTDQVAEjVpBzlAbUywm6S/nleP0TpXySsxpVqjvzaamPnA4M9//hwLrWh+se1HFJJziu6n2rFO6Lw7Q8L6ij+rhB3thjPIt/w1cOsln+yXsN7K0JkRelcptzp4jBR0CRqh+Hf59kqGWYq4CKLY5iZTR+nnM4As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/BrxkNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D465CC433C7;
	Wed, 21 Feb 2024 17:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708535563;
	bh=3cF0hRg56ey3XRtvjCjE/Ic1fV37b1kLU7pCfhtoO70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/BrxkNihtwQQtUeea/ap70cG2lB+Lp1ay+916sE2U97a+BUeCfy7K65/V2HibWeN
	 osntBmWEGwdPPehz3vNWJMz7r0DLZ2/BmMhMRpVu9IyjmjXX7c4bwW+hONt1hzaGcq
	 vWSf5aySZ3ZXWsA2KsOgZfzttKb9TlpmnTD+tZqYGgSUZVGXL27ylQ5nU1JHy4CwMk
	 l9Q0tndvycMpJ3PSdanL++IkWVokCKiroFVyUFMbj+2YOqwnf9V577TA88ABkvnsjp
	 xLSNprHSmJDsGw8lb+KyMpumrOsZf36bRhUXTd++NLamSiQvUfHDN7ArfsE6MSiQON
	 pLkR5Dvs34KYg==
From: SeongJae Park <sj@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the mm tree
Date: Wed, 21 Feb 2024 09:12:41 -0800
Message-Id: <20240221171241.55658-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221162745.4332955c@canb.auug.org.au>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 21 Feb 2024 16:27:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> --Sig_/rZSz2XyBy4/Li.uOi0DLWDM
> Content-Type: text/plain; charset=US-ASCII
> Content-Transfer-Encoding: quoted-printable
> 
> Hi all,
> 
> After merging the mm tree, today's linux-next build (htmldocs) produced
> these warnings:
> 
> Documentation/admin-guide/mm/damon/usage.rst:186: WARNING: undefined label:
>  'damon_design_confiurable_operations_set'
> Documentation/admin-guide/mm/damon/usage.rst:369: WARNING: undefined label:
>  'damon_design_damos_quota_auto_tuning'
> 
> Introduced by commits
> 
>   afc858f0e6db ("Docs/mm/damon: move DAMON operation sets list from the usage
> to the design document")
>   d50e871bd78b ("Docs/admin-guide/mm/damon/usage: document quota goal metric
> file")
> 
> from the mm-unstable branch of the mm tree.

Thank you for this nice report.  Just sent fixes:
https://lore.kernel.org/damon/20240221170852.55529-1-sj@kernel.org/


Thanks,
SJ

[...]


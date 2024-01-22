Return-Path: <linux-kernel+bounces-34119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53FF8373DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB971F2601A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B24405C1;
	Mon, 22 Jan 2024 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa1PL9oV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8747A40;
	Mon, 22 Jan 2024 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955715; cv=none; b=okI0R6pWgDx1cjmmFHA6dvwsZb9WwEJuoSbMERYNeodiKMciXxI79fa7XoaFqcuxdKPDXUhl5aGbOetUYmv28TwUt2XXqW5R0FrTis6RvnyQzTBBHJvAfylBA3RLCKdGHlf8GoEZQ1VzdniXZE6t29Dfe7s7N0ExqX+5MXVXnc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955715; c=relaxed/simple;
	bh=ibfFotzuiwAZb47N/hapoyQ/3VMQ31E1CrfYpEAAork=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVmtAPN7B3V9ww33qXm/koCDM3BwanLR/RmoM+C6uUdOkJ7bsUuGBA7CFFhcLhVYet5YQDvzYLkLvHnab5pD6l+ZRxoLIn7xUd+oxNyqbMGeEzbcf9bd5LMYnT1ea1Yks2s+R3ESHa0Onj0bE3MDEzZLF07wWuYIzxnZX/L9isY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa1PL9oV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF5EC433F1;
	Mon, 22 Jan 2024 20:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955715;
	bh=ibfFotzuiwAZb47N/hapoyQ/3VMQ31E1CrfYpEAAork=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oa1PL9oVcc6isCJv6ebZu/3r2vyaAFA5Jf3umRLCLYx86S6mJGKBYY3xEQl+6lp4A
	 lFu1nNpceqglMiHgpxJwl3o4cfr5KIUSbG3S+QIFTbpGc+Q70VxmzwNcH60JX0Ce/R
	 ZWfaltx8YQufnP6ki2eRoM0v8dDl9VQUrmshuMtzvHd/lA2I3wv1JBQw4pzAYWwW+5
	 oxl+EYqQbw1nU0vZ0RKVfv4WXbQw9GPcIR6wZEzdif8xWWor/c66FOfzTsro5F4vQq
	 Hvp0/Hp8xDmNZ8YzslFWgmk8mJ34HAjbXUcdRXX5fvKJVVzjgMdSXWSEbV/aLun5Ow
	 YTMENW94oKWig==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>,
	acme@redhat.com,
	acme@kernel.org
Cc: hca@linux.ibm.com,
	svens@linux.ibm.com,
	gor@linux.ibm.com,
	sumanthk@linux.ibm.com
Subject: Re: [PING PATCH] perf test: raise limit to 20 percent for perf_stat_--bpf-counters_test
Date: Mon, 22 Jan 2024 12:35:11 -0800
Message-ID: <170595558508.377262.16864811982251292801.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240108084009.3959211-1-tmricht@linux.ibm.com>
References: <20240108084009.3959211-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 8 Jan 2024 09:40:09 +0100, Thomas Richter wrote:
> This test case often fails on s390 (about 2 out of 10) because the
> 10% percent limit on the difference between --bpf-counters event counting
> and s390 hardware counting is more than 10% in all failure cases.
> Raise the limit to 20% on s390 and the test case succeeds.
> 
> 

Applied to perf-tools-next, thanks!

Thanks,
Namhyung


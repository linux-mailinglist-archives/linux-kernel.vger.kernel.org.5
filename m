Return-Path: <linux-kernel+bounces-41367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BB783EFB8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B751C20AE4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5B32E62B;
	Sat, 27 Jan 2024 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poyQW8U5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3292C6AA;
	Sat, 27 Jan 2024 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706383532; cv=none; b=ftgvt5S3k8SVUGamrpQgikc04VhOIBpcYDkvwSEi3BgllqTSKlxjzsvgYkOBPAljpfG8d2ezzzZXWdXFJxEIeV9lobDcaLIXhnj76Vb3B4de6us7r2n1Xsh59aRslBpCog5sQiFZRjgEP6y1IrA5/sS2enY/f+LshDy235mJ+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706383532; c=relaxed/simple;
	bh=DHmv1TnFgVaDahN54d8UFLW6+0KsvgWYwjRJ5YnxEos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrtQnMiDiV9xIk3xLIkM6cql+DPAt3xizoPXmm79j0BsyZONNeUmlKVgcRlguVLRpDl1/DtkBXv3ststX58JzR6aEizQDTnJ/NDvSKq1zTz0yk2Yx4nHbBIoouOmSTkpqLg2BAIoB3qhVuRbd0wOqzDYqNeLGUA4QZgby7tdIzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poyQW8U5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F673C433C7;
	Sat, 27 Jan 2024 19:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706383531;
	bh=DHmv1TnFgVaDahN54d8UFLW6+0KsvgWYwjRJ5YnxEos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=poyQW8U5xCs621ezCeQBI5TYv48YY37cSuQ36niktiVd+14ivD5i86B+U4exhr4jE
	 Z+inZrs3MPpovwTrkPjZCv/Gc1c1KXLUNa8NM11a2r2axIDYpBKAKe2cv1eSXtFykb
	 bhmRFmv0lO+f/4JgBl1Wg4U/LIgonuWpHYKnTN5VCsVKp7ypfJtHNHLtJ7GXkfr1oN
	 EVnSi6O5lgsMVh7hvgXbfwlYlnv6DvHO0bqtrSBXIJ6DWqDlH1giTdHjNdI/+H0iiK
	 QeG5wvEvL2+YmNgF+p4Sfr41YqXlL4NPBt7wZkeb0Xx+IuANDdrF36R3/VcmiCtKyM
	 RXKqjL99PqkdQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 42D2940441; Sat, 27 Jan 2024 16:25:29 -0300 (-03)
Date: Sat, 27 Jan 2024 16:25:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: "perf test 103: perf all metrics test" failing on hybrid i7
 14700k
Message-ID: <ZbVYqYEw_w4eTSdf@kernel.org>
References: <ZbVYhxQzodvh5Cob@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbVYhxQzodvh5Cob@kernel.org>
X-Url: http://acmel.wordpress.com

Em Sat, Jan 27, 2024 at 04:24:55PM -0300, Arnaldo Carvalho de Melo escreveu:
> FYI:
> 
> root@number:~# grep -m1 "model name" /proc/cpuinfo 
> model name	: Intel(R) Core(TM) i7-14700K
> 
> And see after that another hybrid machine, a Lenovo Thinkpad Carbon X1:
> 
> root@x1:~# grep -m1 "model name" /proc/cpuinfo
> model name	: 13th Gen Intel(R) Core(TM) i7-1365U

Ah, this is with was in perf-tools/tmp.perf-tools, that I'm prepping up
to send for v6.8-rc

- Arnaldo


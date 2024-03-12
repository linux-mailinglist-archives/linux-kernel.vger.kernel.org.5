Return-Path: <linux-kernel+bounces-100538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F9A87994A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0699B238E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934617E58D;
	Tue, 12 Mar 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss0PSS6c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8D81CD33
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262064; cv=none; b=k/KN08HAb50o5mBTQROANHRZ3mOEonR/ywb8NwE5qG/eOJ7Yh0/9u1cdMiNU46Sb1t7ntPo7nKdZIPrfgQYNg+dSuJpttnxHueZRpq4i/oiKyetHVcp+yUcj/lQq10X9VkMrUnDNbj5cV7MWwv96/V0Ay+hX4N717OrwwNj+qK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262064; c=relaxed/simple;
	bh=AjEc8WzKZBklnGB74AAXQNXUopwI3gbXU6RHFA3VrRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kcuem//NzwAQHVsUbowVFeBiIaGucoxXdhKBnRC4Dg4tjmlEmd0Q7bPEcdSb06cT1oRj6XzHZVE/6+pEDeUgXR8WpcHdMWiS1rlak2oSsx4xwItjjmUORsPODZXsjKGIFqlRkTa+ICNPTK/9w+eZzXQDj7OL/xnxpPdO3wywIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss0PSS6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051E7C433C7;
	Tue, 12 Mar 2024 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710262064;
	bh=AjEc8WzKZBklnGB74AAXQNXUopwI3gbXU6RHFA3VrRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ss0PSS6cEKKnrfMjN9apy5mw+EmLqMn7cbQzeUW+UWVj8p6LVXFRzaJA647onk+h8
	 Vu1rcccOEBWzZkyzM2hG1NOoQ9vpz3y8J9N6bWv4TlSIPODHmROFgt3X4rxqkbtlzq
	 D6vV9wfdS5OhfsMdM5hEnPiIBgT9M0PdVd8I0vwNLwbIZdeKP+TuC4YmKOwb5zGGUt
	 kGS2Su7gw9MBU5MAjDd/5E42iSofustBcRTQrqjTBB0NgORvLWp0xc/Y12gJ2JnD9u
	 W4Tf3ggYpYFYf34DQTBUYiI+T6X362QcKTf4dHqfbWUkq6oyGMVvyW83Ts5MtWiZu6
	 QkktxBlvGZ93w==
Date: Tue, 12 Mar 2024 13:47:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf beauty: Move uapi/linux/fs.h copy out of the
 directory used to build perf
Message-ID: <ZfCHLHqP78EKynS7@x1>
References: <Ze9vjxv42PN_QGZv@x1>
 <Ze93VPYpegMMt5kk@x1>
 <CAP-5=fWw8qGB4Djm34_Apjf6jEk+LdhKP2pSkF2Z2q-qWW1UPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWw8qGB4Djm34_Apjf6jEk+LdhKP2pSkF2Z2q-qWW1UPA@mail.gmail.com>

On Tue, Mar 12, 2024 at 08:42:36AM -0700, Ian Rogers wrote:
> On Mon, Mar 11, 2024 at 2:27 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > It is mostly used only to generate string tables, not to build perf, so
> > move it to the tools/perf/trace/beauty/include/ hierarchy, that is used
> > just for scrapping.
> >
> > The only case where it was being used to build was in
> > tools/perf/trace/beauty/sync_file_range.c, because some older systems
> > doesn't have the SYNC_FILE_RANGE_WRITE_AND_WAIT define, just use the
> > system's linux/fs.h header instead, defining it if not available.
> >
> > This is something that should've have been done already, as happened
> > with the linux/socket.h scrapper, do it now as Ian suggested while doing
> > an audit/refactor session in the headers used by perf.
> >
> > No other tools/ living code uses it, just <linux/fs.h> coming from
> > either 'make install_headers' or from the system /usr/include/
> > directory.
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lore.kernel.org/lkml/CAP-5=fWZVrpRufO4w-S4EcSi9STXcTAN2ERLwTSN7yrSSA-otQ@mail.gmail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!

- Arnaldo


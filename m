Return-Path: <linux-kernel+bounces-109354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A108817F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165712824DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD71785928;
	Wed, 20 Mar 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQvNDRbu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAC485651;
	Wed, 20 Mar 2024 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963303; cv=none; b=HNQjzoxJltqos1LR4DkKmk6t+uOPgezgmqeCkaBRncNwZrgreBJBpMvFrtafXxpm7t8Cvc2umuqw/ceqbSkTPeNQXcePQyF6nXkHtUWwEpeolSfGdq5x8hfyrweG8OQG2bPlFiW3WjX4IK8aeRRbjKZu/mQyj0WhJQoIY2SjI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963303; c=relaxed/simple;
	bh=Hzv4nYUlXWx6PbH044pOECb6/zc0T+L/UTtBzoHs6mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/E0seafKAS4KSrLfBDJwEXRgdgMguac1/hE6vECX7NXHjnN9WGJwuR/YNFHMz1MqakNsbqXjTqGb1I+kTsWby0aWrAj00BGmKbthkBPowPzuGgTtpL8BS+Vj0NmDXwUwarV7g7FcD3aOLsxZAi+eQ0XKTCwZbTpEJxp+NAjFUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQvNDRbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE52C433F1;
	Wed, 20 Mar 2024 19:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710963302;
	bh=Hzv4nYUlXWx6PbH044pOECb6/zc0T+L/UTtBzoHs6mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQvNDRbu9P0Tbkb7AFaHjIs/g02AHMsvd5OaGgeZvRHNRvl4ObtRbRatQEwiRGita
	 IyjgPj7+grFVMcOdrzQ9uFxEp8de2sX3I7bOrxdC3H6K5OkCkiP2Tjx+xVwxf8oGDb
	 zUJfMU4R06GBUiCNbIV+f4K3Co40kZHX6bjGbx5QvgZo0wJveZbLcT2Nsz7GJphV4L
	 NzYuF2lj7r3JEuy1slDdcpk8uZf/qPUnpLnuPks7Z2umTC2C++YujHk+PgYlJfBXRh
	 PKsKfjmmXoiml133Ypy6eQcEJK5cidX9oaPtheXvzpwfcOvjwml0Dmf2yAdnKtRQqg
	 6/ohGfum4k7dw==
Date: Wed, 20 Mar 2024 16:34:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: Suggest inbuilt commands for unknown command
Message-ID: <Zfs6Y3ZxHL7g4BZ0@x1>
References: <20240301201306.2680986-1-irogers@google.com>
 <Zfr4jX_b8FCOG_x_@x1>
 <Zfr5__Ej3-0C8sJj@x1>
 <CAP-5=fXXrJRH=Dto2ajD_TUDE1YmkkJZO5Ey2pq5YB0wbVAzeg@mail.gmail.com>
 <Zfr-sQJPbZzbtk8K@x1>
 <ZfsBopALY3whsst5@x1>
 <ZfsDtr5ejAwGySOR@x1>
 <ZfsEWoi6eevwLRQC@x1>
 <CAP-5=fUbiudT+ocbGEauca2aX8PJSV9rHQUCCxQ4bxWXL6eoyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUbiudT+ocbGEauca2aX8PJSV9rHQUCCxQ4bxWXL6eoyA@mail.gmail.com>

On Wed, Mar 20, 2024 at 10:07:55AM -0700, Ian Rogers wrote:
> On Wed, Mar 20, 2024 at 8:44 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Mar 20, 2024 at 12:41:45PM -0300, Arnaldo Carvalho de Melo wrote:
> > > ⬢[acme@toolbox perf-tools-next]$ perf raccord
> > > perf: 'raccord' is not a perf-command. See 'perf --help'.
> >
> > This works with the second patch.
> >
> > - Arnaldo
> >
> > > ⬢[acme@toolbox perf-tools-next]$ perf ricord
> > > perf: 'ricord' is not a perf-command. See 'perf --help'.
> > >
> > > Did you mean this?
> > >       record
> > > ⬢[acme@toolbox perf-tools-next]$ perf ricord
> > > perf: 'ricord' is not a perf-command. See 'perf --help'.
> > >
> > > Did you mean this?
> > >       record
> > > ⬢[acme@toolbox perf-tools-next]$
> > >
> > > So I'll add that and go on from there.
> 
> Thanks, let me know if I need to send a v3 with the 2 uninitialized
> variables fixed.

No need, its all in tmp.perf-tools-next now, will go to perf-tools-next
soon,

- Arnaldo


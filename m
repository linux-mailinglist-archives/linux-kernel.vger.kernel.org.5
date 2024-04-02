Return-Path: <linux-kernel+bounces-128738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FB4895ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88B6284C79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F3915E5D9;
	Tue,  2 Apr 2024 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7ShGO7p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7953F15B146
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093955; cv=none; b=Y1jJqwimxWENJyhjSowCgqwVOJtZCMeQWDd3JLr1sYjhro7TW0079htH+R6mp3KnMlDyz8objNwO4XxYCQkxTz4iHYtFg5YFFqUxtnH2PnQtc8dmao0kluwEGw9Ni1BWkbvdGPKyRpw7AAosKV5QmuSs/ewUmrRJ2oSaY08/SIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093955; c=relaxed/simple;
	bh=j6cH16H7GHSiZVSFBdi1O5KhMFam2IL7zvbUIj4ykVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDCmbwlTV6z29Hj+wq02I2zNSKnEOcXyBciQ75stu3pyOKutecmz7cCgiFZARjDYinmYq8Oo8mHRFRayFcxONi58wSyppoxeVyhr5SDvsVGcqvLfU/ABll0D1zv1x58aF44P5e+Vc6EKeE172E0JAnwL/3i4QwK7leaWydgAoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7ShGO7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77BEC433F1;
	Tue,  2 Apr 2024 21:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712093955;
	bh=j6cH16H7GHSiZVSFBdi1O5KhMFam2IL7zvbUIj4ykVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7ShGO7pPWtSTWkEE9LQlUVftmxkRWl7DYsjetb+KKoFKtUcNHflmDWrKENndHR1Z
	 E8Qa/Stew1EOUQxiMlwJ8vnn1OrcoSqkQDK68P8UvAXnx+1Mh+k93eRaCBVVAuoBLz
	 ubH4AAvk8/jOKN/+8p9mxgl9zcQkf71P4+RSZ0NPwvUfATa1zOLJnBGKGn++sXQP94
	 UDEg6bDrIIuzDYD54ME2v21Vv+9Yx7qfKh2kA1SX5EJM1i+EJIqSh/W+kSx43ouCAg
	 fCS7S4KKbSglGThP3O8ojAKJMQVWe7DufS6x7XNpDzOo8KQKFGIDIe55c5RLCvUdr4
	 8wf97Fm4vkNhA==
Date: Tue, 2 Apr 2024 18:39:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH fyi 1/1] perf trace beauty: Sync linux/vhost.h with the
 kernel sources
Message-ID: <Zgx7APFHoWQgVEDw@x1>
References: <ZfybkuM8DKsdX_yO@x1>
 <CAM9d7cjSN6M4VvKRifwQ=bpvbc92pLoghnjCwWiOE7SFSzXWRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjSN6M4VvKRifwQ=bpvbc92pLoghnjCwWiOE7SFSzXWRg@mail.gmail.com>

On Tue, Apr 02, 2024 at 02:04:39PM -0700, Namhyung Kim wrote:
> On Thu, Mar 21, 2024 at 1:41 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > tldr; Just FYI, I'm carrying this on the perf tools tree.
> 
> Have you applied this to perf-tools-next?

Nope.
 
> >   +++ after     2024-03-21 17:34:07.687563333 -0300
> >   @@ -49,6 +49,7 @@
> >         [0x7B] = "VDPA_GET_VRING_GROUP",
> >         [0x7F] = "VDPA_GET_VRING_DESC_GROUP",
> >         [0x80] = "VDPA_GET_VQS_COUNT",
> >   +     [0x80] = "VDPA_GET_VRING_SIZE",
> 
> This gives me a build error:

I noticed it and removed it.

⬢[acme@toolbox perf-tools-next]$ git log --oneline perf-tools-next/perf-tools-next torvalds/master.. | grep vhost
4962e1949608fed9 perf beauty: Move uapi/linux/vhost.h copy out of the directory used to build perf
⬢[acme@toolbox perf-tools-next]$ 

Thanks for double checking!

- Arnaldo


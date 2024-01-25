Return-Path: <linux-kernel+bounces-38719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621383C4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1031F24F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D2563507;
	Thu, 25 Jan 2024 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+LbDEj9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76621634E2;
	Thu, 25 Jan 2024 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192751; cv=none; b=XZdgQWOEVRjTEIL/9ThxCp7z5OvlM/Zb/Oms1umu0VW+cucuB2B0mWLXGCbQldGoMpQdYyggiaeEsajx4T+zsghHs6UppoLSr4TvMP236QaKwtbp9nisTJry0MlaSZKYJOo/Dtv1IxwPrpkEPhTb16C1HhFALXTSB1BVaWWJzcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192751; c=relaxed/simple;
	bh=y0AHJz/cSEFxr9QLzShQYbT6jnUa7PBGIUzcQ3GpxJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzVw2Bwqv7a0/N8egPTLp8f27RgnnNQN8jAiLv+gCCAImMigPkA2coHdZZd230upeiSOXsr7UcsMt41kZb/J8JnlMveT2wmaANmEUPdpLrZ109YLAdnrZ4S4QIwDp/yFXo4XogxvJ7Fwbf/umlillZAA6U4cEFMOkShqiYkekGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+LbDEj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59AEC433F1;
	Thu, 25 Jan 2024 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706192750;
	bh=y0AHJz/cSEFxr9QLzShQYbT6jnUa7PBGIUzcQ3GpxJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+LbDEj958J3cKPesoEGPWoY516viVcaQ2v4BZtJ3puY+iYQ/eF5ou7WbSWVgINnb
	 FK56NRvdMl3O6SbCFFYjYMp4NXMXhByYrvFIdt0akFUqSBzqZX+jvZXFnOsQj9HPPj
	 BS0y60q3fsxArpF+wD5AFdrRjtvt+R/Vr+Uw3F4uiZycjjrdFnAtTN6iTA3Rfzyeso
	 IedlfbNYQjxx+8C2PnX0s2B7GAH2UNGIq20Cf3zFHP1+NvwpVDAp9SdwxbgCY8Fo9z
	 TgYBUTm62da8BGH2CbWZYoz7x/K1ugN7NSRthmDJeWd1Z33YeyeL7coMdfW6cjybv4
	 tS1Y7y4cWmY4g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id BEBB9405B2; Thu, 25 Jan 2024 11:25:47 -0300 (-03)
Date: Thu, 25 Jan 2024 11:25:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	namhyung@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com,
	Ian Rogers <irogers@google.com>
Subject: Re: [PING PATCH v2] perf test: Fix test case perf script tests on
 s390
Message-ID: <ZbJvawngTmVC4pN7@kernel.org>
References: <20240125100351.936262-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125100351.936262-1-tmricht@linux.ibm.com>
X-Url: http://acmel.wordpress.com

Em Thu, Jan 25, 2024 at 11:03:51AM +0100, Thomas Richter escreveu:
> In linux next repo, test case 'perf script tests' fails on s390.
> The root case is a command line invocation of perf record with
> call-graph information. On s390 only dwarf formatted call-graphs
> are supported and only on software events.
> 
> Change the command line parameters fors s390.

Thanks, applied to perf-tools.

- Arnaldo



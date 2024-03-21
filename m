Return-Path: <linux-kernel+bounces-110212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A7885B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949A81C21E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7465D86252;
	Thu, 21 Mar 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/WxVTvC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F5A947;
	Thu, 21 Mar 2024 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034626; cv=none; b=DkLec4vSfKLoD3dYQ68dNDNVUW8r5v9qPHCsNDOWoQLe2GrO06nc8c0iESfJrpSccpH2kdKoUqTARivDfk3cRletSPyK1hM6om0YF2UAZibG8wR/CSo45VDyI4CtodwxCVkcmXHGPzfLI76RWTH4kIv9rA6kEgQyzN0LEtS6V08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034626; c=relaxed/simple;
	bh=+m9kWk3iS2HPFwiXLggGjYbe+7JtOa3E70CJ3D/8dAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssMitwOKT6ne6cPovVK4/iNRXGdDFGSIQz/9A/sstoS1r2MbxjXeAK9qKRZ4L3agc9svD5jj0uW16/PQIuW9Mcbt/3rzoXQ+QDg0Vlam/ufaGHHjrJ9eDT8gXJogyJEcWR4dVtU/ySfKo2ELiAIpnv/25wayumFBrvF8q+fXv+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/WxVTvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98C4C433C7;
	Thu, 21 Mar 2024 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711034626;
	bh=+m9kWk3iS2HPFwiXLggGjYbe+7JtOa3E70CJ3D/8dAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/WxVTvC2Xh2unxOwqNeieRonBCU2/RpcwsCg5RvX89aEfLHCpaS/WbVUojtRdMKs
	 bK08zB4+vI3atQSuXzIvEMa3YlF2h9uu65OKHxp/yUBXI0qkI9PU/97xGi7lACelUv
	 RuHRDr+qBM1mMesbxvUxKKKQuaL/q4l7hJNpfxwAOg7rX9mN7KR/Xs/qzlb86tzdID
	 ch6WumuOxPnSXXtCLevcNT3qOpf+w8GJx8tOwJA6GFXq0k6rnwLCb8UatFxQm+4ziZ
	 KVpmpPzoP8VJOOeLjAI9wdaygqj+YFwqJqjWZYEdYtqn99CODLmHp0arDJL/KnDluc
	 bK71bq5rNX2ig==
Date: Thu, 21 Mar 2024 12:23:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Edward Baker <edward.baker@intel.com>
Subject: Re: [PATCH v1 00/12] perf vendor events intel update
Message-ID: <ZfxQ_68hcyag2itr@x1>
References: <20240321060016.1464787-1-irogers@google.com>
 <ZfxDX--WFVDlGad5@x1>
 <c1ade566-111a-46b2-81b7-c165890c84ce@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1ade566-111a-46b2-81b7-c165890c84ce@linux.intel.com>

On Thu, Mar 21, 2024 at 11:14:35AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-03-21 10:25 a.m., Arnaldo Carvalho de Melo wrote:
> > On Wed, Mar 20, 2024 at 11:00:04PM -0700, Ian Rogers wrote:
> >> Update events to the latest on:
> >> https://github.com/intel/perfmon
> >>
> >> Using the converter script:
> >> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> > 
> > Kan,
> > 
> > 	Can you please take a look and provide an Acked or Reviewed-by?
> > 
> 
> 
> Sure. The patch series look good to me. Thanks Ian!
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks!

- Arnaldo


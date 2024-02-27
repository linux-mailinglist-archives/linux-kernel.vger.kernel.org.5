Return-Path: <linux-kernel+bounces-83717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0812C869D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBA028688F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778D04EB41;
	Tue, 27 Feb 2024 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1CrSK+z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F264E1BA;
	Tue, 27 Feb 2024 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054766; cv=none; b=AuuQdNlhROgsAOerbRFQoRQewnrH1ts41nzQB2mcUptsMxgUtKTDg/sQ8+dzUrkLqLbDbxgPhByQsgfyunmBsWpjZ3ZY3f2Etwm77TlkJlmVwNNa0bLrP7I+nciOq4gSNtEVGUDv6E6Jin++5ESA8Og/P5mxR/lcSAIsF6hkusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054766; c=relaxed/simple;
	bh=UH1cf71yVZ+IE48mE2u9YsgYD+cbHTinf+arR0nEbeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sh4hzvg/nAUm1Whck/KdqJo+nVxpqxYnTYjt1wiCozNFkJFS8vfNfHAU0ZF3V8K7I4wSWcCTUEvilceZJMSCS34/qQfnhof0IKPzoIslOM6CrdtCYNGUqsRiJFxvhLA9xxUyw4C6OB3F/z96Mdm9+h/C5EQI7zJBPqRnZXuaTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1CrSK+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2205EC433C7;
	Tue, 27 Feb 2024 17:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709054766;
	bh=UH1cf71yVZ+IE48mE2u9YsgYD+cbHTinf+arR0nEbeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1CrSK+z+mVXBevddBCSKX7U2BVrksMh+NRk4AhCK0Uv+aKuno3yUn5yt3hxgcWoS
	 tizbR/OeBf+RgoYnzPUpDK6ujxvp6zG2zHpBbGETQhM4g8ZEYZC2e3PGKMGbhJci5V
	 nz1TxZ6Jpx70/6IOQDFbd0ZlWzl3DbBLTRTtCeRrgH6mWCOGdqDTAp6XY7WqEmNDc+
	 dLY6yXkyxnhkmctWftp90V350T3InCH6BvJ/oltXh6v8ga6n48VwvLEazx83R8fMst
	 lgGu67H1UGdWpEizd4z/ldkdB9biZYna0q/iCl431r8Y6+UkKAqkpElx+FSPMwclyg
	 JC2UREjXRGc3A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/1] perf test: Use TEST_FAIL in the TEST_ASSERT macros instead of -1
Date: Tue, 27 Feb 2024 09:26:04 -0800
Message-ID: <170905469226.501091.7003094916625866194.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <ZdepeMsjagbf1ufD@x1>
References: <ZdepeMsjagbf1ufD@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 17:07:20 -0300, Arnaldo Carvalho de Melo wrote:
> Just to make things clearer, return TEST_FAIL (-1) instead of an open
> coded -1.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>


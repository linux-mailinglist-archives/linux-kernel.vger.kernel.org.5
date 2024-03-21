Return-Path: <linux-kernel+bounces-110799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B37886419
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050C51C21A82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD6E31A8F;
	Thu, 21 Mar 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAM/R0Et"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB821DFCF;
	Thu, 21 Mar 2024 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711064939; cv=none; b=esT9O4LSD4EABO6ejXMDl3f8SoekjfEy+Et+xUNH/geBTgJOVBe8OQbxbMmTFLFeyjfOtsEYwXFQT063MBQ2//bZwNIyYFNjyokxcDDj3gpxhstXQIW2jGeRzSxMvbifdRFCQXQpy4FZSolGUOEs5fbAxSzGN7DJjzOUibWwQPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711064939; c=relaxed/simple;
	bh=seeqnGTcDLz4a/rppsPc92YSU07db1oeeNuwzgP8j1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ghxgagp75YO/riFwt2dvb6I17gd2SlWRmpISi2OLSInoDxGq9ABNIHtH7Vos/uochbqz5n+PaMNjv95S3+vp2FUVBADMKkNFhReYZ4LxIqLWHE1yZKBZSAWyHbwyIVWpvZuWPzYXgICDwfRCD2fx2zW+4e2SuIJVH8sJtV6ihpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAM/R0Et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547A5C433C7;
	Thu, 21 Mar 2024 23:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711064938;
	bh=seeqnGTcDLz4a/rppsPc92YSU07db1oeeNuwzgP8j1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAM/R0EtWOxziSlUjp9h0jUxc+Z0ON16vuV1pEuheS9ugJyJ8oYr2r0CFEE33Z7Yf
	 TMts9heNV+RsLG3lPOZy0Q0jUoNMffCFLdOjmD/CK6NtHknvO9Q0aF+1NWJzxdMgPR
	 cRnQh8kVsjVKivjUsBNczuJVnyeEoQhWHcDLyY/y+qr6K2eFz9laqj8klWbzdWkCnK
	 g/67InuVea3h0Q4Jr4LUPPuKLZbmEJviKpCTH5xU7WrEZDN56OJV5gP3hHn+VUzvJG
	 nqM39/lgISTR5hcgp0lUzrtzYIVUgCbBLqyUnR4d/LpKfphYJyZqQthkSx7E48yqTl
	 uOvLLA2TResiA==
Date: Thu, 21 Mar 2024 20:48:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <ZfzHZzk524biyKKv@x1>
References: <20240322084131.2316eb8f@canb.auug.org.au>
 <ZfzAKMlYY7IkWXUg@x1>
 <20240322103636.020aa9d2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322103636.020aa9d2@canb.auug.org.au>

On Fri, Mar 22, 2024 at 10:36:36AM +1100, Stephen Rothwell wrote:
> Hi Arnaldo,
> 
> On Thu, 21 Mar 2024 20:18:00 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Ok, maybe I opened perf-tools-next for the next merge window too early?
> 
> Yeah.

Ok, I got it back to:

acme@x1:~/git/perf-tools-next$ git log --oneline -3 perf-tools-next/perf-tools-next
1bbeaf83dd7b5e36 (perf-tools-next/perf-tools-next) Merge tag 'perf-tools-for-v6.9-2024-03-13' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
63bd30f249dcf0a7 Merge tag 'trace-ring-buffer-v6.8-rc7-2' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
01732755ee30f086 Merge tag 'probes-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
acme@x1:~/git/perf-tools-next$
 
Sorry for the noise, I'll move to perf-tools-next when -rc1 gets
released, I'm acumulating new stuff on a different branch.

- Arnaldo


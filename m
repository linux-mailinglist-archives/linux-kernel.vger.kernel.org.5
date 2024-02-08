Return-Path: <linux-kernel+bounces-57547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 059BE84DA91
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59DC8B23EAE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67496930B;
	Thu,  8 Feb 2024 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="IeoAvghv"
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C504069301;
	Thu,  8 Feb 2024 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707376320; cv=none; b=qwpuuHaicrZOOJ4usk87ac1tQ9VxLDZlrZsBGqDIEfjh3lOYOdYHOB5Ox3jopaDZuGgsw1U7WA9CjIDEEYcaq8A3qDc5jZnNNph9GRofwqhOIHQIqq7mWdYC4Rkm9tMWVC6+bjSLhlJzEeKUToCsYYt4UFxNVKvoFoUqpXx5MzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707376320; c=relaxed/simple;
	bh=ShM33PMN46d+9yqD9fzFYzTn61mrTpXnOh8vT8+O6bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRKX3S9sb9zn9+XjGzls/ZWXMPgaZ3//lgqFfq4jzl7nB85w+QLBjqt2PJX8fbZJcqXb5adNtqPOKI5ruxs+JPCcmrgG/zwv3Jc7egwsmhJBNIk3eyzAugH1dOGMbsn//ctNXexi25Q+CvJpHS4DMB6S3tnY2gJruCm/lOtvv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=IeoAvghv; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1707376313; bh=ShM33PMN46d+9yqD9fzFYzTn61mrTpXnOh8vT8+O6bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IeoAvghvH2rkGp2cI7YQXcxrS0yAvRmdb9GjZCOXtZfaioyUcgqvcLwgYbH9vsxkq
	 j34DmjFopYNHm0eJODfRmHJ+G+GnbNXot7NltkD91Hlt/twKzYQ03mFTodB3UB403h
	 ieB1E9k8RL2VmmS/L8YukDM6vT2NImdk6bCXPLd8=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 08:11:53 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id A2EEB801E8;
	Thu,  8 Feb 2024 08:11:53 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 980E1181359; Thu,  8 Feb 2024 08:11:53 +0100 (CET)
Date: Thu, 8 Feb 2024 08:11:53 +0100
From: Nicolas Schier <n.schier@avm.de>
To: William McVicker <willmcvicker@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kbuild@vger.kernel.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v2] checkpatch: allow build files to reference other
 build files
Message-ID: <ZcR-uS3AqD8ZNG0d@buildd.core.avm.de>
Mail-Followup-To: William McVicker <willmcvicker@google.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kbuild@vger.kernel.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org
References: <20240112221947.1950503-1-willmcvicker@google.com>
 <ZbduU15kw5R42awj@buildd.core.avm.de>
 <Zbl165bfizOauIlf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zbl165bfizOauIlf@google.com>
Organization: AVM GmbH
X-purgate-ID: 149429::1707376313-B1632608-25043249/0/0
X-purgate-type: clean
X-purgate-size: 1083
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Tue, Jan 30, 2024 at 02:19:23PM -0800, William McVicker wrote:
> On 01/29/2024, Nicolas Schier wrote:
> > On Fri, Jan 12, 2024 at 02:19:46PM -0800, Will McVicker wrote:
> > > Add an exception to the EMBEDDED_FILENAME warning for build files. This
> > 
> > As far as I can see, your patch fixes only the checkpatch warnings for
> > top-level Makefile and Kconfig (and leaving out top-level Kbuild).
> > Other build files are not affected, right?
> 
> Since $realfile includes the full path, I wasn't able to find a case where this
> issue happens outside of the top-level build files. The same goes for Kbuild
> files -- the top-level Kbuild file doesn't include other Kbuild files and the
> other Kbuild files don't include other Kbuild files within the same directory.
> If you prefer to protect against this warning in the future, I can include
> Kbuild as well if you want.

yes, I think it would be more complete if top-level Kbuild is also
included.  Could you also mention 'top-level' somewhere in the commit
message?

Thanks and kind regards,
Nicolas


Return-Path: <linux-kernel+bounces-16894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDBB82458D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601A61F23717
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAF224B39;
	Thu,  4 Jan 2024 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Nqs1ehuW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3BE24B2D;
	Thu,  4 Jan 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3B7DD736;
	Thu,  4 Jan 2024 15:57:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3B7DD736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704383868; bh=dyA/rPuEEojVPCJ5lWc5tdwj4Jg72ccSzIE9agGaaoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Nqs1ehuWnpQ7Xz+FM387s8kT0sarIR6g74ZKOjz2gCzGNa+vYiOmb3WY+SOuJq1na
	 gNM0jNMdXUgaTBDWzqtvpf4sYIq63HeLkjo6yPTElZeKTWpDgEGhvZydHtUFvwvJbX
	 469sH20cILOmUWHQwSMiekgTtJ2JcNlCKry/oMM/w/jvHpJ5nbZ3KB8L1iL8KkWIjp
	 y6vb64SilEh/tstQdUN/JfSS3HcTn8iArzoXHAeorbyh6Ft+z0YqRCxJM4mwK89/sf
	 xA+/6Keb0zm4Oc2MeIuHZtKzPa5e8EGqy/3U8FID2uDJCE+0J4UZH5M8/RTLoKDRyT
	 vBjvugTr+QCDg==
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@linux.intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, Mauro Carvalho
 Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] scripts/get_abi.pl: ignore some temp files
In-Reply-To: <871qax6t6k.fsf@meer.lwn.net>
References: <20231228233113.5218-1-rdunlap@infradead.org>
 <87plyi86zg.fsf@meer.lwn.net> <87v889z7h3.fsf@intel.com>
 <871qax6t6k.fsf@meer.lwn.net>
Date: Thu, 04 Jan 2024 08:57:47 -0700
Message-ID: <87o7e15bwk.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> Jani Nikula <jani.nikula@linux.intel.com> writes:
>
>> On Wed, 03 Jan 2024, Jonathan Corbet <corbet@lwn.net> wrote:
>>> It would have been nice to create all of those files with a .abi
>>> extension so we didn't have to do this kind of blocklisting, but so be
>>> it.
>>
>> Alternatively, we could switch to yaml instead of using another homebrew
>> format with another homebrew parser, and rename them .yaml.
>
> But ... we didn't invent that! :)
>
> That is, of course, a better idea.  It would be a good project for
> somebody.

Thinking about this a bit further ... is there anything other than
get_abi.pl that parses these files?  If so, that would, of course,
complicate a switch to YAML.

If not, though ... and if we're changing the format ... maybe we should
just turn them into RST and do away with the extra processing step
entirely?

jon


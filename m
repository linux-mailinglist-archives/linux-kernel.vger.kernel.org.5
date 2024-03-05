Return-Path: <linux-kernel+bounces-91731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839D78715C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E00B283766
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63C97C085;
	Tue,  5 Mar 2024 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="nooo8JGX"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C38329437;
	Tue,  5 Mar 2024 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619627; cv=none; b=rYO+7mAkkXnVvBt1KzYNp1diCN/REDWo1Ag+UjDD/OiL8PRVMylaaCQ+INdMIokNHiw3oW6syqF5ZLvGHPKWZkk9I7b6mpJ706h+MzswelpBldyab49LT7wsxif6z5ykyyQEAQr5cdwLBXeMt5HEMyvJklR/vSmQNjIUy7HXT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619627; c=relaxed/simple;
	bh=XtxMs+32eXb+O0tOlP+RiquoUnx+cPRNE8UtljjeICU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXEL9x/S/1636O5GgxDhLUrkhzsXiTZ/AHPbEzrrE6aJ6qqab1VuVe2IgbXWTuTBPZ6UKt1r5bxMCcJ+mKDM+O5aCPF4N6KLUmmahxvFEmCGspMtQRhTqbEcFyCafzHTGeBtAB9D4KVsydB05Nd6/MLSu/CmjuFkUGS2Jor2/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=nooo8JGX; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=/Yy37cKtsYVqB5e9llo9kr/9z30Da+A+PjrUO4HJ8S8=;
	t=1709619625; x=1710051625; b=nooo8JGXcCd72Jvydg/3fl/7m62P/uJ+Y6LI0vdqRYH44zu
	BfHakO/jVzfW6fpZ5DHC7+9vyp8pxIuvrtFaYFi03Y5GLFdJMUlpDbyZ/46j6novUvZU5Q2GayfM/
	m0H3aaF05mH9UsgmtwL0/7wIOP8reC/5eG3nNDoF86vYzsZfrf7tVT2ThesHoZX6JAPXZik5Sfoes
	51yC9ncz5KTHc8ATaifjcJaEPC+09s3ZIau+zrXHHizTfaoNWcrGT/h9Tjg9V9WpXdVn2tkUdudFI
	0At4fUtUvTIAdEGeYJCQnHlxdd6lz5AJ3s2tWSs8i5firxbEof+Dr4kQ7DgTZGBQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rhO9x-0008AZ-9Y; Tue, 05 Mar 2024 07:20:17 +0100
Message-ID: <1c13f4f7-fa02-4864-8621-bfd738546fc2@leemhuis.info>
Date: Tue, 5 Mar 2024 07:20:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "Input: bcm5974 - check endpoint type before
 starting traffic"
Content-Language: en-US, de-DE
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Henrik Rydberg <rydberg@bitmath.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <20240305-revert_bcm5974_ep_check-v1-1-db4f0422588f@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240305-revert_bcm5974_ep_check-v1-1-db4f0422588f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709619625;30703a26;
X-HE-SMSGID: 1rhO9x-0008AZ-9Y

On 05.03.24 06:52, Javier Carrasco wrote:
> This patch intended to fix an well-knonw issue in old drivers where the
> endpoint type is taken for granted, which is often triggered by fuzzers.
> 
> That was the case for this driver [1], and although the fix seems to be
> correct, it uncovered another issue that leads to a regression [2] if
> the endpoints of the current interface are checked. The driver makes use
> of endpoints that belong to a different interface rather than the one it
> binds (it binds to the third interface, but also accesses an endpoint
> from a different one). The driver should claim the interfaces it
> requires, but that is still not the case.
> 
> Given that the regression is more severe than the issue found by
> syzkaller, the best approach is reverting the patch that causes the
> regression, and trying to fix the underlying problem before checking
> the endpoint types again.
> 
> Note that reverting this patch will probably trigger the syzkaller bug
> at some point.
>> [1] https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622
> [2] https://lore.kernel.org/linux-input/ab9d758c-3ce9-42f6-99af-877055a589e6@leemhuis.info/T/#t

FWIW, these should be Link: or Closes tags, as explained in the docs.
And there is a better lore link. And there is the bugzilla entry as well.
Hence...
 
> This reverts commit 2b9c3eb32a699acdd4784d6b93743271b4970899.
> 
> Fixes: b516b1b0dfcc ("Revert "Input: bcm5974 - check endpoint type before starting traffic"")

you might want to add them here like this:

 Link: https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622 [1]
 Link: https://lore.kernel.org/linux-input/87sf161jjc.wl-tiwai@suse.de/ [2]
 Link: https://bugzilla.suse.com/show_bug.cgi?id=1220030

In an ideal world we also would add a "Reported-by: Jacopo Radice" before
the bugzilla line, as the details in the suse bugtracker apparently is
public, but it's likely better to not go down that path.

> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Ciao, Thorsten


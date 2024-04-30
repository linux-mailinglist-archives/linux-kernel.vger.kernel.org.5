Return-Path: <linux-kernel+bounces-163808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2078B7164
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C909AB220F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCC912D1E8;
	Tue, 30 Apr 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="I+RQsCn6"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24012C462;
	Tue, 30 Apr 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474560; cv=none; b=VakEU3gGNLk94uMCsbmb/An5O6v4I3ku/Fr07W/yoUUkh0mRWlPi4qByIKs/54GmYxLJbiev+4Mv8tUh+aPin8b1a4e0BiHJaQcsJ8Iwm/n0zMOnX2KvKXZKCnbzig3EWvC0dLrywagc4nAUvDavw7BeQSxD1vUxffV3KPwe3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474560; c=relaxed/simple;
	bh=M4tcGalAkeE3B21UYRee9Btfw9X/fgSIoYzeS4J3/tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFh+HT2ILUs2MEAslIpSKFuFvCoon3YazWFSOOBTNyc/peTO3/PE6PHWdjc1LKreyeaVQ7YbZa9q1N4oendWj5g7yBcw1A2aGqN2/e/gxIITS0BQXUaPeSz+vmd/jYb7gQR77QVaRphzh5/t5uoK5LY36kWoxG438xLJ7OCYbCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=I+RQsCn6; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714474543; x=1715079343; i=markus.elfring@web.de;
	bh=M4tcGalAkeE3B21UYRee9Btfw9X/fgSIoYzeS4J3/tE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I+RQsCn6Vr4Tv8FRy9yYhxqSL1X6MuuiH3dhmx7qRbsDXZdAsbMMK1gIDe8kqC4E
	 2ebJaJNDAPudT1MgyQ2xlTSzvep7eP60P0xIQ5mJlRRxgTI2mBY7J0HxGniaF3a86
	 /xWa8cjWBFI24ejk0nWPlh41c6C+fyuPtmfwJVkLB/wIMBOqDwGeS/35xnJ9PvM2+
	 miJxHLzizUNGvoVEoEbVxgb7o8eglEzRrsbnwOrQSmzLYMd88LSxge/AWmm1QLHke
	 iEujA6oXe263xQR/ocFqvnyzBuKhFUCsNHtzxKY8BT5AAmP6ikC+eKoki0mIaLKek
	 EBTYZMVfwGLA9vccBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLARS-1sJpzp2Lzu-00WQ26; Tue, 30
 Apr 2024 12:55:43 +0200
Message-ID: <60d57ce3-5d87-47f0-9f89-4856aad2bfdb@web.de>
Date: Tue, 30 Apr 2024 12:55:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bcachefs: Fix error path of bch2_link_trans()
To: Youling Tang <youling.tang@linux.dev>,
 Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Youling Tang <tangyouling@kylinos.cn>
References: <ww5fcxuzfcgttglsr6cpnrxufeusw4ixe76iqp7mab3djlyfje@zozue6qvxhzy>
 <7d4a29a1-26d2-4b22-8823-ce8e7f9ac534@web.de>
 <89354794-c53a-4935-a961-818710ba2fd3@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <89354794-c53a-4935-a961-818710ba2fd3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K1g0Kh5CslyT8QY1UnogVNnWdUF3feUoQP3VTLQucYPg6KbzxtK
 FSanToytWrFEP+U4Q4i2maMxyk0TkL/JQ2K8t60lW4paMDsPshwEi1iMO0I/U/TCLbWAgla
 D3lJ49ZszP6N9xkBxcLi4lqefLJ2vB/tm0pE/RB10IW3MNB1cQvgZQYCrHm5wmrByqJQhaz
 yP5S3QOnaH7UJPt9HnMXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7tBGyjAn8Ew=;IdFySBHvVgQpxDaoeaWQAUZ3W2U
 8RUY9jRI6Gjdr7yLQgwnK2FM7PY16H+/v6LAj0QPFMmwnMcI4ISBiS1JSYN9LHo6Ei1+Q6nY4
 0mu4nhkZ4iuzxrJ8Kdox0kmIfscOUpqbeuTq3c3AQW0ukN3FMN3kpCey16GPy5WWLmAtOZ1FS
 ihIMErQWYnH/MdvnKHWAEY2a0AgiOE90OBVRAxFXAC5CHkJwwqlvc3Cbf8wm9xLoyZLJ3pUk+
 gXi4/Ej/fqOYyZhGYFO8255s3AU75l3ZGlJlh4eooTkN/CYP8iDTy7vMIfH/UKeIgccK/jEoP
 zD478wq/XNF9YP1cnSloSviDXYZGRqznugB0NZ0hBzS8B99SeQ0HDEKn4wntAnOBwS9L0mhsZ
 1gVWybVCsAo/PjJiVXmuguGtwrgEO6qVvHtAtFLhPv9XXB/LuVNAgJ6vBCvDWImDRL1axtImR
 fzH0Ljn3b/LziMTZkaXHz2cRv8HaAxirPIA2+86tyktZV/p0hHNFpsC8CmTbY9jvMAUjYmqYJ
 19Bz15OhpJQTHYc0CGf+Hk0zbbBz9HtZkmfPUFePtfLFS50Cx9IrAkb7QmTv3b2k3zfxwSFbX
 U+ATzgTKIwBsNITrf+KUFJcaxbPwcjd5K9eiK4oW0eT4wGv+zVyH6TGziLWWfvJfS0OmrXtdU
 K4XcrFvrd+m8hRdLXUIsiIPdzyL8BSMh76FLbDqWVa3FdImzojHvCelb2s66CIESYT10KWpza
 HJ7m/ALKivbIyIao7EmNOJ5/4hxGo6MQclh6Rbe6O6aSNrlksbHRxRV6OiFgT+BjsiayOODM/
 m5li5QF/s9ORoUB3Ub8kEHpRHGtHNkGsp7IAmEnwCOH3w=

>> https://evilpiepirate.org/git/bcachefs.git/commit/?id=3Dd04db1c7653dee5=
ee5f918ce951c05eefddad7eb
>>
>> Would it have been nice to add the tag =E2=80=9CFixes=E2=80=9D (besides=
 an imperative wording) accordingly?
> The following labels can be added:
> Fixes: 962ad1a7666 ("bcachefs: Don't BUG_ON() inode link count underflow=
")

May the corresponding hash be longer than eleven characters?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc6#n145

Regards,
Markus


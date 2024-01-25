Return-Path: <linux-kernel+bounces-38407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FA883BF1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F421F2877C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EDD2C6A1;
	Thu, 25 Jan 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oDbb8o9W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zswWPLOJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33152C698;
	Thu, 25 Jan 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179257; cv=none; b=bNmW97erwcopXOlrE5SwVVgAh2IokJBP1Qy386Gdwflhg++bQbKMAVoGmOoViS0Jmq+R5mXa9hLAkpjWXJVSOH9NmtvSnFbxDJ+R4JMMTiwKW1XouvquXvo8I1N4dhz9E3HQfb3pKD775LL0ggtYc4nZjmhrN569l5+mUxlrLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179257; c=relaxed/simple;
	bh=fJ33SB8sYEgeOex9arqhLcNYaHmtGrWA+ihwQMm6bzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvK7uyeM0Y8DfVu5WNOjVu/Vw5lMU2WAirtgngL0LVNIb1ZUWWJfIktNycaHm9oSoXIFIVsrAve8EtWROphKgd7RwXDeFXlw9bVIHPDcM7MxrUvUBtB2mZ2lV1hsLDoTDaQC5t0sU4Y0I5t8YIWfHVu95f8xHmN8magFCgwza+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oDbb8o9W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zswWPLOJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706179253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kxrqdRBZtGW871Ak7zSVqgqY1Pn7CCg4bYb7EmLawU=;
	b=oDbb8o9WeuG3CBzXlxYNnq5OPG9fi+RxVy/KQ40gORvMcrzuu4Q3gq9dP0wz3h7M8yUbwn
	XKtG/5kRQxhZkso+9N2DH2eRQnwMeZ49IG7A9kx4L8gRIl/ci5N11IbfDTp8sV/jPamawB
	ei/ikZgzk04rqI5bfu59ZZk4x12MiQEq0+CkJeBM49o1s/xBvow7TTxQ+INLLs0HbaiBLM
	U6T3pP/2lkCXTOgjism4hKl4O22WCKfJaWD12sIQFH79rceBN4Gc7j9ZUQ+yB5W4+Ql2fS
	+7Y5FGylioIk4wZ6bMpwWfSqnYEw0+2ein/J3GeafO7K8Rsv0nyPl4buCgcqEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706179253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kxrqdRBZtGW871Ak7zSVqgqY1Pn7CCg4bYb7EmLawU=;
	b=zswWPLOJPRSuWhplhYYmqIRELeJjAV8z457lQTFPS+GnujYqX2eGNMX2iaXGvM03UwKuKI
	ae9vLvVDcK0bPWAg==
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Clemens Ladisch <clemens@ladisch.de>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 7/8] Documentation: Move "core core" api into a separate
 file
In-Reply-To: <71285bc1-bf38-49ea-ab77-3258727339e3@infradead.org>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-8-anna-maria@linutronix.de>
 <71285bc1-bf38-49ea-ab77-3258727339e3@infradead.org>
Date: Thu, 25 Jan 2024 11:40:53 +0100
Message-ID: <87le8dd7be.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> On 1/23/24 08:47, Anna-Maria Behnsen wrote:
>> Some "core core" API as timer API is documented in driver-api. This is
>> definitely the wrong place. As the subject description in
>> core-api/index.rst mentions, is also core-api/kernel-api.rst a collection
>> of leftovers. Therefore create a new core-api file and start to integrate
>> timer api. As this contains a lot of functions, it is separated into a
>> timer specific API file.
>> 
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> ---
>>  Documentation/core-api/core-api.rst     | 14 ++++++
>>  Documentation/core-api/index.rst        |  4 +-
>>  Documentation/core-api/kernel-api.rst   | 12 +++--
>>  Documentation/core-api/timers/api.rst   | 63 +++++++++++++++++++++++++
>>  Documentation/core-api/timers/index.rst |  4 ++
>>  Documentation/driver-api/basics.rst     | 24 ----------
>>  6 files changed, 93 insertions(+), 28 deletions(-)
>>  create mode 100644 Documentation/core-api/core-api.rst
>>  create mode 100644 Documentation/core-api/timers/api.rst
>> 
>> diff --git a/Documentation/core-api/core-api.rst b/Documentation/core-api/core-api.rst
>> new file mode 100644
>> index 000000000000..4fe00d084dc7
>> --- /dev/null
>> +++ b/Documentation/core-api/core-api.rst
>> @@ -0,0 +1,14 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=========================
>> +The Linux Kernel Core API
>> +=========================
>> +
>> +.. note:: Some Core API is still documented in :doc:`../driver-api/basic` and
>
> I'm getting this warning from the line above:
>
> linux-next-20240123/Documentation/core-api/core-api.rst:7: WARNING: unknown document: '../driver-api/basic'
>
> Ah, it should be "basics".
>

Oh no! I fixed it - but didn't update the patch... I'm sorry!

Thanks,
        Anna-Maria





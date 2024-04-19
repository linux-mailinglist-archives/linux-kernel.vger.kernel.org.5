Return-Path: <linux-kernel+bounces-151867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC438AB507
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB571C20A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D8313C3EF;
	Fri, 19 Apr 2024 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tuF4lAOI"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C713B5BE;
	Fri, 19 Apr 2024 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551131; cv=none; b=TYVy4yHacEBuA2aEW7Uz7fyaTRqFeGn2Ev0L30BhjZPvtFm/lC2EvMdTMXx11RiWGw1hxO8jszdeLP/k5gjSxpHOv0Dwv2/xrK9Sl2YJukyfbouWLRdpBwLM26QzggHD2RfkfTakHMI6VPjEyuWyUM9wU3VgTVE9aulNjiWpcs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551131; c=relaxed/simple;
	bh=NiUB2jWvX+wsKtvOZdF+F2qUCl/RH7QB2FrO/Tls7mo=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=DKLUqCBpfTlGSI2ESeX0Kv0I73rvKf+LEsSAyz4Aths09ZUv55IHazXAIS57XzVUsAdwYcVvEhRbGBCdTzJw6nQ3LHIEPbz76GX1OI8J+ldWAKp68RT+rdGvSPPbt88VF5JMWjsUblsSa1I/EVKbOZBFTTVHnX9fOgeXpjKPXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tuF4lAOI; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1713551119;
	bh=NiUB2jWvX+wsKtvOZdF+F2qUCl/RH7QB2FrO/Tls7mo=;
	h=Date:From:To:Subject:From;
	b=tuF4lAOIGv+fqCJFeFcTDr5vaGt7+dtnYKsSZq+tohxkCMu0kty2/yUq3Ogbcycrl
	 fvA4+99B0l1jWj4SRXcAXLEQVJWbGn+zUgh763EsKmfRrQ83laF0k8S3HTptGXM3Rj
	 VkfYYQ18EK4oBLUUTJ35U/3JRrmL4fGaK6HQRj7amiDxAVkn5R2RdNX1Mw6/hvCp11
	 mvbWQCZwCCBl+e5KdK5h4KIwuo820k9/7BCr81XsGmz1NTgk1Ufpr9lTyaEVvW3obI
	 eps7VhAdsOlAj56k7yZyQAZ58NXlx65Z6PREm5QAtiU8tqljmk4J02YwQxtIKjUQHO
	 yk/CaNohbN/zQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4VLjk70MsCzwgk;
	Fri, 19 Apr 2024 14:25:19 -0400 (EDT)
Message-ID: <8987e081-13bb-4af2-80d7-5819ad5d4784@efficios.com>
Date: Fri, 19 Apr 2024 14:25:24 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng-UST 2.12.10 and 2.13.8 (Linux user-space tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

New in both 2.12.10 and 2.13.8:

* Add close_range wrapper to liblttng-ust-fd.so

GNU libc 2.34 implements a new close_range symbol which is used
by the ssh client and other applications to close all file descriptors,
including those which do not belong to the application. Override
this symbol to prevent the application from closing file descriptors
actively used by lttng-ust.

* Fix: libc wrapper: use initial-exec for malloc_nesting TLS

Use the initial-exec TLS model for the malloc_nesting nesting guard
variable to ensure that the GNU libc implementation of the TLS access
don't trigger infinite recursion by calling the memory allocator wrapper
functions, which can happen with global-dynamic.

This fixes a liblttng-ust-libc-wrapper.so regression on recent
Fedora distributions.

* lttng-ust(3): Fix wrong len_type for sequence

`len_type' of a sequence field must be of type unsigned integer. Some
provided examples in the man page were incorrectly using a type signed
integer, resulting in correct compilation, but error while decoding.

New in 2.13.8:

* ust-tracepoint-event: Add static check of sequences length type

Add a compile-time check to validate that unsigned types are used
for the length field of sequences.

Detailed change logs:

2024-04-19 (National Garlic Day) lttng-ust 2.13.8
         * Add close_range wrapper to liblttng-ust-fd.so
         * ust-tracepoint-event: Add static check of sequences length type
         * lttng-ust(3): Fix wrong len_type for sequence
         * Fix: libc wrapper: use initial-exec for malloc_nesting TLS

2024-04-19 (National Garlic Day) lttng-ust 2.12.10
         * Add close_range wrapper to liblttng-ust-fd.so
         * lttng-ust(3): Fix wrong len_type for sequence
         * Fix: libc wrapper: use initial-exec for malloc_nesting TL


Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


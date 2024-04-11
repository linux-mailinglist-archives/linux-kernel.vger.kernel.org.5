Return-Path: <linux-kernel+bounces-140424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35EF8A1444
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35011C2221D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3414B07F;
	Thu, 11 Apr 2024 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Iw7uPJ72"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB1D13FD66;
	Thu, 11 Apr 2024 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837901; cv=none; b=q/qhL5q7tG8PDfHTl1JWjV5cCIruMmpSmSrSKdOtgZ+mrM6+hBtBoR68bfaXZTzBzpTK1kGLcSzBvMEIOKJvmutfNYHb5dvSQAIRLCbjaLANt0hUvYVP9IC7cGBpUApE2RKjYR0iqeb15/VLi1KvMgGvhkGKe7gRfUq1V0o5wWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837901; c=relaxed/simple;
	bh=Ue+kPqa5ovpPl3Sfsh1uMsxDRpeY+X+tUrHJcKDmYWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rAAMgcz9A8/jTnKhoMVzfFLxeDygqZe9B1aXNf2H7vg2k8bj9rSEMPOL/LTP6PqiquDODmKwda0FX0E+UzlruYxpC2cXr0DxU0VHwfwb/RJmICmFpl81WV9dQs6znL9jO/5AUAg3Kmts6Lr+6J3OqzqmwJUA/iNsgeAmRn9mXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Iw7uPJ72; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aHsQbmA+wnCbMY5ngUe0xXk3sGyXlVb12AhxDVR+FNs=; b=Iw7uPJ72Z/zjJvP+Avqb/nFiC7
	O0qAVLkHcUbujC1EGyQRHk2ga5/TAsRgQIeIvOUrVGCOPq5CgjX5JagbiHsepkSFeYhtsENtKJrGZ
	hd2/asM7+6oLI+ZHMJcZdVH594rDd2IAXnLRT4Px63y3C2HmvLi7HSW7cMRB5NlSqV42bAevlgHWz
	t3U2bacRtL55ityZH9qAlvh8rQGyHAB/9D2zp73cZc12SuHKZoIgMtCW43NySVOjZZC9i90qO17//
	+rfDDr+LxuGYIoM66b4av1/SE5sQVZCYFXTwMF9EkKIJb/FhUKdPrNqeq3F5a71DbEIDBRHjnCmhB
	0O3SOhLQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rutNX-000NqQ-UZ; Thu, 11 Apr 2024 14:18:07 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rutNX-0002kv-1e;
	Thu, 11 Apr 2024 14:18:07 +0200
From: Esben Haabendal <esben@geanix.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,  linux-serial@vger.kernel.org,
  imx@lists.linux.dev,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] serial: imx: Introduce timeout when waiting on
 transmitter empty
In-Reply-To: <2024041122-transfer-diffuser-781a@gregkh> (Greg Kroah-Hartman's
	message of "Thu, 11 Apr 2024 14:06:50 +0200")
References: <76cf9ce9cbf9dcdf78bc00ce7a919db1776ebce1.1712309058.git.esben@geanix.com>
	<cf197182beab7acf6ea7ead54fb4324e97e18cbc.1712733269.git.esben@geanix.com>
	<2024041122-transfer-diffuser-781a@gregkh>
Date: Thu, 11 Apr 2024 14:18:07 +0200
Message-ID: <87il0o6qkg.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27242/Thu Apr 11 10:25:12 2024)

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Wed, Apr 10, 2024 at 09:18:32AM +0200, Esben Haabendal wrote:
>> By waiting at most 1 second for USR2_TXDC to be set, we avoid a potential
>> deadlock.
>> 
>> In case of the timeout, there is not much we can do, so we simply ignore
>> the transmitter state and optimistically try to continue.
>> 
>> v2:
>> - Fixed commit message typo
>> - Remove reference to patch series it originated from. This is a
>>   stand-alone patch
>
> The "v2:" stuff needs to go below the --- line, so it doesn't show up in
> the kernel changelog.  The kernel documentation should describe this,
> right?

Right. It is described in Documentation/process/submitting-patches.rst.
Sorry about that.

> Please fix up and send a v3.

On its way.

/Esben


Return-Path: <linux-kernel+bounces-145544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A608A579D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E55283AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797C080BF0;
	Mon, 15 Apr 2024 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="1Q1xlOw6"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025F3E48F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198119; cv=none; b=tMhZQawAm4tlhXISnizznoVpP8V82dOZlv48r+kj+rMhaqggbhCNlavnrSUiJ7PEVduSw/8j2oMO7APBoxBTxw9NawzxpyK2K1R/GMvehugzYS0g6FQJRTK4pWPPv/Tly/t6vy96YpXR65fPr+rcTH6J1UL58uK0uOsSB3u/8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198119; c=relaxed/simple;
	bh=49wBF7ETWIbvhYXhdoUzf3PHmI2RzJqJ6hg/xPslkn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/t/23/rPmMN5AXE7IakiWkrsdgcwQbTK9peuVnfHX18/cZF5jSRvvFLjikPtatfA2sn5ZqWvMNVsP/acdjdrKWRa1DXW/XakAYEM7kv/lvSaeXJNpmAJr6sngLGq2COusn/J7Lwhxy9ddmnmfACiR+tEAmeaAKrkJfopag+Aeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (0-bit key) header.d=zytor.com header.i=@zytor.com header.b=1Q1xlOw6 reason="key not found in DNS"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43FGL5xT2477030
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 15 Apr 2024 09:21:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43FGL5xT2477030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024031401; t=1713198066;
	bh=s8TZ5pnM8hKiFX3Jje3ZRxOCl+tkEojjH/6DtaJtRg0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1Q1xlOw6fohkdTv0BTocNV+SXRZcfesd/TgPbuZlnbw6WyeSEIJdrQax/ExiQgCfI
	 k7ZehbiPfiJ5cmaJZqu4qTY3ixossinX1shA7MBaJo5fL7K77yzPYP+D2btGQdPTLF
	 /oIpxJnitnmdGiDhM5sEAjswFu+tId/qtQHKTKlqDXe5I8hi3QBXvl8tq76F0x1oT6
	 WdqYd1IiGEn0dg+AHWqqeGHtZi7RuPkT/RVOSn9zSjuB2SDGadcodVEq//isBXhgsR
	 mh2DzT6x9GMggTD6KiFqmYRzmeSODWFziPZHoHh7GCgA8PbUOKfVcGYQJs8DTP49ds
	 HlAMi3x9IH5XQ==
Message-ID: <1fbb0c1a-998f-4424-82aa-12483fafb197@zytor.com>
Date: Mon, 15 Apr 2024 09:21:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Fix int80 emulation for FRED
Content-Language: en-US
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
References: <20240412234058.1106744-1-xin@zytor.com>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240412234058.1106744-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/24 16:40, Xin Li (Intel) wrote:
> Commit 55617fb991df added a bunch of tests to the int $0x80 path, however
> they are unnecessary and event wrong in fact under FRED.
> 
> First FRED distinguishes external interrupts from software interrupts,
> thus int80_emulation() should NEVER be called for handling an external
> interrupt, and then int80_is_external() should be skipped under FRED.
> 
> Second, the FRED kernel entry handler NEVER dispatches INTx, which is
> of event type EVENT_TYPE_SWINT, so the user mode checking in
> do_int80_emulation() is redundant, and should be skipped.
> 
> It might be even better to strip down do_int80_emulation() to a lean
> fred_int80_emulation(), not to mention int80_emulation() does a
> CLEAR_BRANCH_HISTORY.
> 
> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>   arch/x86/entry/common.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)

Note: this is the minimal bug fix versions and belongs in x86/urgent.

	-hpa



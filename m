Return-Path: <linux-kernel+bounces-17902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5848254CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF858B230D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27372D7B5;
	Fri,  5 Jan 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="ctnF/fbz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FED2D7A5;
	Fri,  5 Jan 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <1d2bb04665d19a4722a0b9f7f552cab3@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1704463486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+1FNVgsj+qEWnvxHNGqdoPY64SlF8p/+fHrooM8zYkM=;
	b=ctnF/fbzbkDthaVPva5if5djG2bq6W+3+ARQNPmEDGhN7aeEywM7B8C2t10Un7VC2+MSuf
	CTbfuO0HBqfn8+HfDph0cBDfoPz1kXqSigPssFBonKnC7mMMI4WTbLrhmsS07KU9/lusXb
	88POJKP7oFoeTfm7wmlEpU+U2LApL+5A6ZFdKwZnaVg6Sfs14urLVrWErvwfO38ete3Y0d
	lpYgjJgZsBdc9855VN0dYyl4zWR8hFOuhv2pKlBV5C4sRA19oJNCYdsfvUT7Vf8DKVRCOx
	VES7OYzfLhuURqBE8dCshjgcRkR4QCY4ci7M55p5zwDRGv1uqxSA6SrjAYXDFQ==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1704463486; a=rsa-sha256;
	cv=none;
	b=E3nD/uSc3rlSDyQwsy+DdSrppLHlk5z48Dy0FmXC45LqO7knRCq13R1qHFHx95AKZxDyOB
	0ZzYwmpHIwbU6vfvqDk9JmWt8iY0vNQRfU1tHr5wZwiKHLJQPsAh4yHoWhcUwPMB3Ll/s6
	3hSm+TMBvNgwZEuWEGyLAkYxOykF1ARGXgXOO+eCBRmwy12eepYGyHqEBpo4aHNtuTHILU
	t3JR/mIhZnjR4bA670FDDjwFjfuNvuLGlFtdAq3ea1v3U/v4EgM0mvVBnZBdKe95JlvYWk
	DU5zreM+gKwv+sHLNjCpEZo1vX/JCTYeE9BrtDCs1zzu9rsy/i5sg9e/e9Qckg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1704463486; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1FNVgsj+qEWnvxHNGqdoPY64SlF8p/+fHrooM8zYkM=;
	b=W1PlfjcTslLslIr4fj9tv9upynqeeY0WXI+Op4qhcXRMM67a5Sxrgamo6/wWPZBmzfB7oy
	yChfeOngZMPWB4SILw+b1oBTk0nsfRxioCAoSzZUIjwWqqVVd2gpKu3h4aFry8wph6AI9i
	5iJ5rOsrgxXxpb78iqlGaratTaDnfPQqYjmfDAhflQRZK4sYc10dv9RfG/KAAoglSU5mkw
	bNhURUr2ClJHhRwBgr3h8nTM5uITDGznrnBKDdT3aXnNghPA0jPlaN/PiHKfCHQ8sFHj7Y
	FCw5Dv/ATBNNvR0f3IIvwTOKwVJLIr5qEZXmH7htFXiGyEFDBJyDn+J3OOJO+w==
From: Paulo Alcantara <pc@manguebit.com>
To: Salvatore Bonaccorso <carnil@debian.org>, Steve French
 <sfrench@samba.org>, Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N
 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Ben Hutchings
 <benh@debian.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-kernel@vger.kernel.org
Subject: Re: Information on use-after-free in smb2_is_status_io_timeout()?
In-Reply-To: <ZZgFEX3QNWWj_VxA@eldamar.lan>
References: <ZZgFEX3QNWWj_VxA@eldamar.lan>
Date: Fri, 05 Jan 2024 11:04:43 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Salvatore Bonaccorso <carnil@debian.org> writes:

> There is a Red Hat bugzilla report in
> https://bugzilla.redhat.com/show_bug.cgi?id=2154178 about a
> use-after-free in smb2_is_status_io_timeout() . While the commit noted
> initially there seems not correct, Ben Hutchings raised a question on
> more information in
> https://bugzilla.redhat.com/show_bug.cgi?id=2154178#c24 .
>
> (there is a CVE assigned for it, CVE-2023-1192)

That is supposed to be fixed by

        d527f51331ca ("cifs: Fix UAF in cifs_demultiplex_thread()")

While the commit refers to an UAF in ->is_network_name_deleted(), this
should also work for smb2_is_status_io_timeout(), AFAICT.


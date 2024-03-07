Return-Path: <linux-kernel+bounces-95391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D87A874D20
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E771F2396B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D709D1292DE;
	Thu,  7 Mar 2024 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1PNcKul5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HRUK/dSw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1PNcKul5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HRUK/dSw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE241292C0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809886; cv=none; b=TLcmApUV2Cy+l+a758nNdx66Fhg993rcAE/wY9W/qqBDpNw1og210CQwplkz9iMRe88yBQgngIRrGZCXsp2w/cLhem6a/lolfqxgEIoSrWSPEItWr82Jl/Os/MzlCh7m4Ptwz4Phc9py3oc/SNqb2dFVnV/ZbMbkeATfXvYK5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809886; c=relaxed/simple;
	bh=RaFxg+VMDKY8p5la2igQKbXDARffGvjf3CSB6hBiqq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBf7xfWFUq9WIM0K/uTmLWzM72yVeMZM0ZJZ9iKlH8IAIMn1H/XZqhfaN/E7kk7X0sGoGMHhte1M+Ln0KhvSmcBxBV/2VvLzW70s08P5cWuqcZhIMtEf4XVqebW+7C4DGRgyuDDciP9q7++NQK38Fo9yX9GLu/Wbff0SNasE08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1PNcKul5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HRUK/dSw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1PNcKul5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HRUK/dSw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FAEA8C697;
	Thu,  7 Mar 2024 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709807829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6U1HXfrC2xy0RBFUQxcEQNC0CB7CZr+Cp8pvfKVmy5k=;
	b=1PNcKul5pYqaLADNEX7AzDdtYPvuKZjN7bfPn0t8vcwv0YCGYCALhebIjgPoY9/HjsdUCd
	s3uYpkl1rrrnkSDR+d6qZJwsswO5GSqv8MDW95dt6MKM+MPhZwBLD0yad9DkENaFXHSEzU
	8s1cGSJvNrpbgTJHG+Fp4Oo7lxfVZOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709807829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6U1HXfrC2xy0RBFUQxcEQNC0CB7CZr+Cp8pvfKVmy5k=;
	b=HRUK/dSwa271duD6NAMCoOoIjSh2k/RNqOf0VFq2STc1x41C6DNlW8dcHe9PDbcvAgLpiS
	AAM2OE3T93YwEfCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709807829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6U1HXfrC2xy0RBFUQxcEQNC0CB7CZr+Cp8pvfKVmy5k=;
	b=1PNcKul5pYqaLADNEX7AzDdtYPvuKZjN7bfPn0t8vcwv0YCGYCALhebIjgPoY9/HjsdUCd
	s3uYpkl1rrrnkSDR+d6qZJwsswO5GSqv8MDW95dt6MKM+MPhZwBLD0yad9DkENaFXHSEzU
	8s1cGSJvNrpbgTJHG+Fp4Oo7lxfVZOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709807829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6U1HXfrC2xy0RBFUQxcEQNC0CB7CZr+Cp8pvfKVmy5k=;
	b=HRUK/dSwa271duD6NAMCoOoIjSh2k/RNqOf0VFq2STc1x41C6DNlW8dcHe9PDbcvAgLpiS
	AAM2OE3T93YwEfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32678136BA;
	Thu,  7 Mar 2024 10:37:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pHnZC9WY6WUGKwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 07 Mar 2024 10:37:09 +0000
Message-ID: <72c1d3a8-14ad-43e8-a68a-25be903698c4@suse.de>
Date: Thu, 7 Mar 2024 11:37:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-fabrics: short-circuit connect retries
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240305080005.3638-1-dwagner@suse.de>
 <22b01fb4-b543-43b2-949c-1873105dc343@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <22b01fb4-b543-43b2-949c-1873105dc343@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.26 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.17)[88.85%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.26
X-Spam-Flag: NO

On 3/7/24 09:00, Sagi Grimberg wrote:
> 
> On 05/03/2024 10:00, Daniel Wagner wrote:
>> I've picked up Hannes' DNR patches. In short the make the transports 
>> behave the same way when the DNR bit set on a re-connect attempt. We
>> had a discussion this
>> topic in the past and if I got this right we all agreed is that the 
>> host should honor the DNR bit on a connect attempt [1]
> Umm, I don't recall this being conclusive though. The spec ought to be 
> clearer here I think.

I've asked the NVMexpress fmds group, and the response was pretty 
unanimous that the DNR bit on connect should be evaluated.

>>
>> The nvme/045 test case (authentication tests) in blktests is a good 
>> test case for this after extending it slightly. TCP and RDMA try to
>> reconnect with an
>> invalid key over and over again, while loop and FC stop after the 
>> first fail.
> 
> Who says that invalid key is a permanent failure though?
> 
See the response to the other patchset.
'Invalid key' in this context means that the _client_ evaluated the key 
as invalid, ie the key is unusable for the client.
As the key is passed in via the commandline there is no way the client
can ever change the value here, and no amount of retry will change 
things here. That's what we try to fix.

The controller surely can return an invalid key, but that's part of
the authenticaion protocol and will be evaluated differently.

Cheers,

Hannes



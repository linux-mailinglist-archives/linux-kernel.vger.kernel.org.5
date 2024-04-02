Return-Path: <linux-kernel+bounces-128227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8CB8957ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F171F2319C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA6E12C53A;
	Tue,  2 Apr 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Kj2In7m7"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6C912BF23
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070836; cv=none; b=RdUgOimylfGzbOhGQ1jLfj3bYa59hxwhm8XTbKe8npVUeajzx16y2g1gCc6ElfC4k1BcpbWawSbCAkQbl09+A/a+e0/AufK1v8GSMchsUzWfC73vVaRMTNWvIrIFfdW/PhP16D3HM5twPCyWUuLi+PBsI31mra3vSeWUrqeG0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070836; c=relaxed/simple;
	bh=Sg8GnwOt4sP/I59dWNL7SnjRb5adsH8IbzdV5LUB0kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbDgJtVGrOMpb2bv8beBfgGdGSojeaEzUdtJdAF9J7cH5RrJxv4/rJqxkbJtnGLlu2Ae7n5azEjy8fv0wl5cIXQCLi1ywCX+QtclDrJPG47njiB3eWbLSMSyDacTcpGb2Tbd5VjQBMKdUvDtiuS7JWTEA3FC/3r5Y6Hvx9MZK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=Kj2In7m7; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.175.29] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 55A6F2FC0052;
	Tue,  2 Apr 2024 17:13:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1712070829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTZDTry4iLRYYk7znZMyIwOmtb4mpRhpVQzIYKZgUBM=;
	b=Kj2In7m7Cv9V3hoWpJUxThUI0AEr+NmsjEaGwl/dI+e3fkN6KMCa4TLYXPD9IawmNsWrnO
	QoM72gDZkYsEyfcDvgeOHzeHEzH+6sGgQx6oIjGFzDU6QXljCkyZ4Ge5r3Ff07lVNrMz3Y
	N5e8YBUAmUZhvvuw+ax5yK4HORBLh18=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=g.gottleuber@tuxedocomputers.com
Message-ID: <230e3f41-9f6b-42fd-a411-567abbaebbbe@tuxedocomputers.com>
Date: Tue, 2 Apr 2024 17:13:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Samsung 990 Evo
To: Christoph Hellwig <hch@lst.de>, Werner Sembach <wse@tuxedocomputers.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Georg Gottleuber
 <ggo@tuxedocomputers.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240328130923.61752-1-wse@tuxedocomputers.com>
 <20240402131658.GA31963@lst.de>
Content-Language: en-US
From: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
In-Reply-To: <20240402131658.GA31963@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 02.04.24 um 15:16 schrieb Christoph Hellwig:
> On Thu, Mar 28, 2024 at 02:09:22PM +0100, Werner Sembach wrote:
>> From: Georg Gottleuber <ggo@tuxedocomputers.com>
>>
>> On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
>> power consumption in s2idle sleep (2-3 watts).
>>
>> This patch applies 'Force No Simple Suspend' quirk to achieve a
>> sleep with a lower power consumption, typically around 0.5 watts.
> 
> Does this only apply to a specific SSD or all SSDs on this platform?
> How do these platforms even get into the conditional?  Probably
> through acpi_storage_d3 setting, which probably is set incorrectly
> for the platform?  Any chance to just fix that?

Yes, this only apply to a specific SSD. I tested these SSDs (on 
PH4PRX1_PH6PRX1):
* Kingston NV1, SNVS250G
* Samsung 980, MZ-V8V500
* Samsung 970 Evo, S46DNX0K900454D
* Samsung 980 Pro, S69ENX0T709932L

S2idle consumes around 0.4 watts with these SSDs. But with a Samsung 990 
Evo s2idle on this platform consumes 3.7 to 4.4 watts (6.8 vs 6.5 kernel).

With my quirk s2idle sleep consumption is at the same level of all other 
SSDs tested.

Other boards have different values (a bit less drastic: factor 3 to 8).

All measurements were taken with the battery disconnected and a
modified adapter plug.

Because of the isolated problems with this SSD I have not debugged 
acpi_storage_d3. Do you think that would make sense?

Kind regards,
Georg Gottleuber


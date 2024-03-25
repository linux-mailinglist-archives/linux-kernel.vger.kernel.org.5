Return-Path: <linux-kernel+bounces-118054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECD488B306
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33C8303AD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B3A6F07B;
	Mon, 25 Mar 2024 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vorpal.se header.i=@vorpal.se header.b="WVzsLXEs"
Received: from vorpal.se (vorpal.se [151.236.221.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566B6EB68;
	Mon, 25 Mar 2024 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.236.221.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403109; cv=none; b=k+vQyNlUpTRkWaJ+ZK8/u0H5e6G6QbIUZI2f/4seXe1glJFnEtXv2PUzAtpKJT8vNl7CZnkAVnuMDBcELRhz3ppG804h6mz7fcFIm76gzXzpOz+iHv1EjtF5J1dKOA2YGPDrLSQtgrSnPKntS8O9JoVWroq8/sjGXzbH62U26Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403109; c=relaxed/simple;
	bh=O24uEwJnaH8otP+xRGNd5TRmIAI75Ih4SIuvlsrr2CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDzQwI0Ir/Scv1pauAyrmS0wKsFhZk+v54BIwvPBL/TNxDWKURvCUjmN9S3oZ2FKkLseimNKNZKnXHeVKEotbW+SS2M5e5AczgHPBr+qOwnNcuihaG3B+M8+xz70aByY1R/Ye0tx1YeMYcFbZbUjeKcwzHRN7GL/QTjuSTQ1pDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vorpal.se; spf=pass smtp.mailfrom=vorpal.se; dkim=pass (2048-bit key) header.d=vorpal.se header.i=@vorpal.se header.b=WVzsLXEs; arc=none smtp.client-ip=151.236.221.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vorpal.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vorpal.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
	t=1711402623; bh=O24uEwJnaH8otP+xRGNd5TRmIAI75Ih4SIuvlsrr2CE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WVzsLXEsMVqe4Cv1FAnE0FQFjEsFcV2o+2DSsIHGanFcDrpSXZzpUijex9Ok5telR
	 EVRenBHO8MFE1uBsMHXL3YtVZR8SbWWUuywFqTG6eZZw/+R0l4rWbcFbD5RmdpQcer
	 r6MifNRRfb0dUFd1haIdSCu8IbdseuKigjZgEdrhZOkp9nze8KNErNtyUhUIsk+VAo
	 y/9Td1YrFVoNBymN0nNnySoXX5UjFBAhKxpQnTkFP3GMZNbJxKqa9JEAtrBaAJimll
	 0mO7Z1wsXeGDkfeKmnpOiI8kQ4kDFbSN3cGxl5Uq1zWU9Kh2pyL5LGegZjqQqGHvpz
	 /MBoKmtis4r/g==
Received: by vorpal.se (Postfix) with ESMTPSA id A519E140F6;
	Mon, 25 Mar 2024 21:37:02 +0000 (UTC)
Message-ID: <fb97f97e-c6d0-4584-813b-5b81facc4325@vorpal.se>
Date: Mon, 25 Mar 2024 22:37:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/x86: Add ACPI quickstart button driver
To: Hans de Goede <hdegoede@redhat.com>, Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240131111641.4418-1-W_Armin@gmx.de>
 <c1b08bbb-ad57-4f41-9b7b-40a6aeb3da9b@redhat.com>
Content-Language: en-US
From: Arvid Norlander <lkml@vorpal.se>
In-Reply-To: <c1b08bbb-ad57-4f41-9b7b-40a6aeb3da9b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-24 15:55, Hans de Goede wrote:
> Hi Armin and Arvid,
> 
> On 1/31/24 12:16 PM, Armin Wolf wrote:
>> This patch series adds support for the ACPI PNP0C32 device as
>> proposed in 2022 by Arvid Norlander. The first patch adds support
>> for the device itself, while the second patch was taken from the
>> original series.
>>
>> Both patches are compile-tested only.
> 
> Armin, thank you for creating a new cleaned up driver for the
> quickstart button support.
> 
> I have managed to get my hands on a Toshiba Portege Z830 and
> I have successfully tested this series. That is this makes
> the 2 quickstart application and the toggle-touchpad button
> work when the system is running normally.

That is some dedication! Sorry for completely dropping the ball on this,
real life happened and I had to prioritise. My beginning "carreer" as a
kernel developer was one of the things that ended up getting cut.

I'm going to do a quick bug report while I'm writing an email here. I
noticed on my Z830 that the readouts of the charge control thresholds
didn't seem to work when I last tested it. Setting worked just fine, but
reading it always returns 100%. Didn't get around to debugging this, but I
assume it a simple error.

Also my Z830 have developed a whole horizontal line of stuck red pixels
across the middle of the screen, so it seems quite unlikely I'll use it
much more or even keep it long term.

> Neither the quickstart buttons, nor the touchpad-toggle button
> which also uses the PNP0C32 interface, work to wakeup
> the system from sleep though.

This is probably a limitation of the hardware. Though there are IIRC some
BIOS options for what should wake the laptop from power-off, including any
keyboard press whatsoever. (Fun fact: The Toshiba ACPI interface allows
changing these BIOS settings from the OS, though you would have to do it by
hand from user space currently as it is not exposed in the driver.)

Best regards,
Arvid Norlander


Return-Path: <linux-kernel+bounces-54375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4704F84AE64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A851C229F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE80128390;
	Tue,  6 Feb 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMV3YfUG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DA127B73;
	Tue,  6 Feb 2024 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201108; cv=none; b=rDOdJvPPRhHTGHtY3exGzsCNzTr59V8uZbuYzx2OZPmHV50LPyAZp9mJZ7J/F2H8KfTwhILgZ65QI0wdlIlaCfoS6L3FYR8DPklpGxsh+/wiB9dn/S+9RH0mRZ6GqsFJUpiPpctLAhH4KcKqYn2EPILh3BvEBePISS3HR80ZF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201108; c=relaxed/simple;
	bh=oOvIdkoBKnKZKw6X5Z+NQlqyR7W+DH77E+FeljTxxfM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TDTn3pHifqMf0Rn7WA5KhIDKsGKQwvYqUXpSiftMi/UImVoi/BgvHZhOen9Mhy9RATDkzxGERoQS3IavgFny4i6Yo6yyH64fF15JLlB+dSNfNnkN5mJiQOPZW2JlWN3vu0+pQzFwNqgakrtll5tj/xygev+h1JT1Z7WbwwJEObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMV3YfUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93662C433F1;
	Tue,  6 Feb 2024 06:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707201107;
	bh=oOvIdkoBKnKZKw6X5Z+NQlqyR7W+DH77E+FeljTxxfM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=dMV3YfUG1wzWb5y+utV40WEadWjZQIIBhk9m4bwA21ujQZKT4qq4n9yCcCMvcjXOR
	 01TSiSd+cnWTq09MTNGhKdJfXkFvM1N6maP9PpmFpwCXkd4eU3FKrLOSNCE/d9rOz4
	 /Nko0xtnxwwhazfGgTFXtujwG/KwAqQbjMzFoP1wtcwMdlls4YhVTnxcP8qCvYjTdb
	 rcb4K6XzXw3gOcR6mj5Pj4pXaeK/5cwthshT01EnNcRYTJeQO5T6jARGEWxAkvA1us
	 Ipx9khT4C8Q3LXV+E/Qgo8QzfPTgEYoT/E05bPm+Tbane3hB95TdZcIF8sg1m9Ra4R
	 C2oDXpMzg0hNQ==
From: Kalle Valo <kvalo@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,  Michael Buesch
 <m@bues.ch>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ssb: make ssb_bustype const
References: <20240204-bus_cleanup-ssb-v1-1-511026cd5f3c@marliere.net>
	<2024020543-footsie-unreeling-1cd2@gregkh>
Date: Tue, 06 Feb 2024 08:31:44 +0200
In-Reply-To: <2024020543-footsie-unreeling-1cd2@gregkh> (Greg Kroah-Hartman's
	message of "Mon, 5 Feb 2024 04:46:46 -0800")
Message-ID: <87cyta9k8f.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Sun, Feb 04, 2024 at 05:44:21PM -0300, Ricardo B. Marliere wrote:
>> Now that the driver core can properly handle constant struct bus_type,
>> move the ssb_bustype variable to be a constant structure as well,
>> placing it into read-only memory which can not be modified at runtime.
>> 
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Greg, I saw your Reviewed-by email 7 times. Not sure if the problem is
on my end or your end but wanted to make sure you are aware of it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


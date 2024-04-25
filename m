Return-Path: <linux-kernel+bounces-159172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244FE8B2A38
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59A228238A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B0A154450;
	Thu, 25 Apr 2024 20:55:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD38153811;
	Thu, 25 Apr 2024 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078545; cv=none; b=f1dyZ5Pev6FuwE9V3jH/Ihssu6fOtp6WpCJVuKmDGqGbeukQ8ozSAz/2ai18hbGlani4mqX5i8Rbj71yavHhJtn/lSvlbQFFI8xxCnIHKg/vXx+A52QwljUQUI0ldj92ATtqDGnIsnoxb0waZr7BBWK39kHOHiOYf0w9DRZidLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078545; c=relaxed/simple;
	bh=zbbujS7tN+E213WjEhpCAckHTKMbIf1od+D0Ru3O0+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9wbENcqdKRJOMGQXh2DFK+okjXqLAFK1wBThriKyA3Yi3ESQAfGrNRHqTyblXUrji67u9dcvudzBC50S4wo5ERa6wowbkWctrf8f6aF5SHO62lmUIYUZs0hulO09oZ6RS00zsfxnPz+5+Q6c/gwQKBFGQ9B/kIspUNvkVX6uFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C09F22F;
	Thu, 25 Apr 2024 13:56:11 -0700 (PDT)
Received: from [10.57.64.58] (unknown [10.57.64.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C6CB3F73F;
	Thu, 25 Apr 2024 13:55:42 -0700 (PDT)
Message-ID: <8f94bbb8-3cdd-428d-89b9-1ae04c806c73@arm.com>
Date: Thu, 25 Apr 2024 21:55:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] thermal/debugfs: Fix handling of cdev states and
 mitigation episodes in progress
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <3297002.44csPzL39Z@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3297002.44csPzL39Z@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 4/25/24 15:01, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-pm/5774279.DvuYhMxLoT@kreacher/
> 
> and the only non-trivial difference between it and the v1 is a small
> rebase of the second patch (the v1 of which didn't apply).
> 
> It generally has been based on top of
> 
> https://lore.kernel.org/linux-pm/12427744.O9o76ZdvQC@kreacher/
> 
> but it should apply on top of the linux-next branch in linux-pm.git as well.
> 
> It is present in the thermal-core-next branch in that tree, along with the
> above series.
> 
> Thanks!
> 
> 
> 

I have also tested the patches, so feel free to add the tag as well:

Tested-by: Lukasz Luba <lukasz.luba@arm.com>


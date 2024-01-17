Return-Path: <linux-kernel+bounces-29386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F726830D98
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85621F232B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5227324A13;
	Wed, 17 Jan 2024 20:01:17 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220624A0A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521676; cv=none; b=TDSJouYNjVreex+h4PodxWdgHi28MzvAYkdwgb+WstYcFTPwjlMOHzVIwRLus8VLOAvbkVvNDnCoh3SobBDQuBoYuIUr/UdeG+SBpUObDttEIB6Ra4iDwSr1ECP/6lB1P0vIqzgC9E7NK+SGrQ9phRsNGqsjMONrb4E6Sr9VajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521676; c=relaxed/simple;
	bh=oiml74BdCG0MMBlREFjNZJ+K56mjQ0qjPlNX0jV1LqM=;
	h=Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type; b=mkR5xxMhu7/GK4Y/87ZvZTQSx/Tz0anB8IoqGIB/aCaxSqmes6A8VM4z5kmQJmZkagmFCWn8bjjhR8T+vQdKC1HiTPT8oU156oa4olhUBC+Bd38AANp87egdSW8eRY+ULb+gq0Az7VpOPvabn33WGjoeWEvuFdROvas7FXlKOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id F134540AB4; Wed, 17 Jan 2024 12:01:13 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id F08CC40A85;
	Wed, 17 Jan 2024 12:01:13 -0800 (PST)
Date: Wed, 17 Jan 2024 12:01:13 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Eric Mackay <eric.mackay@oracle.com>
cc: linux@armlinux.org.uk, Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com, 
    Valentin.Schneider@arm.com, akpm@linux-foundation.org, 
    anshuman.khandual@arm.com, catalin.marinas@arm.com, 
    dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, robin.murphy@arm.com, 
    vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com
Subject: Re: [PATCH] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
In-Reply-To: <20240116210644.116421-1-eric.mackay@oracle.com>
Message-ID: <affb2c00-695a-47af-77f6-ea1c3f298fb7@linux.com>
References: <ZaZnYrv/QThRjW2Q@shell.armlinux.org.uk> <20240116210644.116421-1-eric.mackay@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 16 Jan 2024, Eric Mackay wrote:

> Ack. I withdraw my nit.

Alright. Are we done and should I post V2?



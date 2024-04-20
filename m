Return-Path: <linux-kernel+bounces-152326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D1C8ABC6B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D27281B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AB83A8FF;
	Sat, 20 Apr 2024 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g/CqKTHZ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7B3232;
	Sat, 20 Apr 2024 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713630210; cv=none; b=KBm6TCgf5gfzgbz8A+VnC0B17iBV2RCe3elocn4xOwQMyeed2f5OmKAm4CFUlmEG0q5AWN5gBgxZbloiyZ4AIDWtlvPcyq4CrewX20xVVfLG0DkZ5u3CsKaMA1OWHeVf1alUgd/EGOTAvF9xIBIId3xNkUK3gj/4/6mbrmYdBJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713630210; c=relaxed/simple;
	bh=RLT258sp7GalJDrLQyBpaZMCCZHtEkxZf0okYYefj4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=it7yMRsZtIeUhDVTYd+YmkAHAik19DXMAYF8hAZF7I77OmGtSNuSmr3e9qgtzjSkEndK72GrEd1mmb2UW2/KafiSz/HAH1jhee3tNA2Q9eeF/9g/3t0vQ6OwyWn8eaOvKo1+pgJ+KFDmwLI8XzZ9T3A20jSgar5u+I2uluQ2q/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g/CqKTHZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XlyVr8ONFYpRf1VAWEncT5rB6E0YQsLA4SRkK7H7fh8=; b=g/CqKTHZztOlN1ER+/hEaENzrf
	uR6JpsTAf9iRs7u15dlaaj+JHu6cTbK4lefKrkt6wUcT7t3bw1OenoR7oow7NranK7oQulmA5jRFn
	ZdJjRjCs/DImvPtZBDTfNpmgeKuh+3Q2ErjNNkzo6QeHOL0wcOwgPYNqGmuD3i9ANogCK5QPvLuPp
	XyoOXsDfxRd7iJTSZz1fzbHpTLZc4yLSzRpa2OIYWHgjZAyyEYt6uKl7E8eDoLx7b4U4qO7apeCsk
	u2yOc+e1/LNzuV7E78b59/K/dbs6B6n3PQ0EhqtU70Iw5gWiRYlEaYcXIp1l01YPWxm+FUrMOomdi
	Nxeet0hA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryDUs-00000008nkw-2mDV;
	Sat, 20 Apr 2024 16:23:26 +0000
Message-ID: <04af9ead-8ef6-477e-98ad-c458e72f3108@infradead.org>
Date: Sat, 20 Apr 2024 09:23:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remove identation for common path
To: "sundar.R" <prosunofficial@gmail.com>, heikki.krogerus@linux.intel.com,
 gregkh@linuxfoundation.org, neil.armstrong@linaro.org,
 dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de,
 christophe.jaillet@wanadoo.fr
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
References: <20240420145522.15018-1-prosunofficial@gmail.com>
 <98f301b5-0161-467a-be2f-d2554a2265a1@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <98f301b5-0161-467a-be2f-d2554a2265a1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/20/24 7:59 AM, sundar.R wrote:
> On 20/04/24 20:25, sundar wrote:
>> Added check if pointer is null and removed identation for common path

In Subject and the line above, spell "indentation".

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html


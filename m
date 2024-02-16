Return-Path: <linux-kernel+bounces-68949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C185824C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1871C218A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5E912FF67;
	Fri, 16 Feb 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="qr9FDE3w"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A625912F588;
	Fri, 16 Feb 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100368; cv=none; b=bh2IU8BezUZbAyxLb2uoU+x21jB33oods6DOoOkRuYoPTex1WvvbHG+YAWQaiZuHY2xoJY9RpfCn/4f9tk4ZX1DbftmajZdZuWarPw6hQOqeQMqtGC+XLlQXPz8LcTUbhEkq+IbCucc2nEiKRipJaEeJ7xQp0b2egyei3UqbA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100368; c=relaxed/simple;
	bh=pYBoM0mhzhtx4t2Ns2s64gX2X6Q1CGuh8hISh7rZ6ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/xDnjxQ40UMLpDJWYIdCqzsNub++v1I6Mx8193SwdurpHpowDUtVIjlml5IuNfwWr8RNHomderq06TV1nPYV2v135l3QIh2CbfXaUkezDFkqTUNjUqGD5m26Tq4XYlqkSYrkPjvtzIT65rKnXbMlpvtWKkIzoIx1cgY68xKOyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=qr9FDE3w; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Tbxvv4hKDz6805;
	Fri, 16 Feb 2024 17:19:23 +0100 (CET)
Received: from [10.10.15.23] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Tbxvn6pPQz6806;
	Fri, 16 Feb 2024 17:19:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1708100363;
	bh=4a5FJHRhPv6BM4Esr+9xMu0svYse0I5hw/jYXGBBoRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=qr9FDE3w5YxPVXK4KbeDds8d3+luBbhshtRM9OSHniJKmembVE5WUpScAYBHQnSBV
	 p4Lj4sWxLD+3BJSMHwWQ8mPjiTiDcG4T+c6anLUh4ACQ1R3S6vq8C4wx5jHQQVGN24
	 iD0seql+OWWyVnMwq0+YnUAHdb6eu1N9qJNndqmw=
Message-ID: <9dae8e00-122b-4747-9f96-e4d0b31c54ec@gaisler.com>
Date: Fri, 16 Feb 2024 17:19:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] sparc: Fix typos
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, "David S . Miller"
 <davem@davemloft.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, sparclinux@vger.kernel.org
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-9-helgaas@kernel.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240103231605.1801364-9-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-04 00:16, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/sparc".  Only touches
> comments, no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: sparclinux@vger.kernel.org

Applied to my for-next branch.

Thanks,
Andreas


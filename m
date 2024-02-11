Return-Path: <linux-kernel+bounces-60708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEC78508BF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C2D1C2139C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ACC5A4CA;
	Sun, 11 Feb 2024 11:09:47 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4527282D6
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707649787; cv=none; b=WroIhd72GWT53nwtyCGdMIJiebKv05A0jM0ifQ2eF+wrUtYH5/mP6vZrONIgQ9T70ouyqDY8hGzTW3f12NmgT2ABS4LoqGJrILFRrN7uiQODGtvlp5Zs7GT3LgD0bRffs5R4Dhk5J/Wey7cK7oc9TshAMmM3JgcE4g/bUTFrHao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707649787; c=relaxed/simple;
	bh=hjdGMuo75ior+4/dXsb3UBDuU16lIyqd8sLml7XMOIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFonfnRlDiMaIRhMu6CUwbXGfP96vC1mAclrdC7ElWb7CVmJaiUudO8J3Ml4dZq+ibskYzy+o9vingQz55R9fmmwtwkj7QRZcb6y1vlzSN/OlpAPN5GbGEeGs5DT5yN/n7T4yMacWW7XPrClkWG8UH0rKxv5LDsxEkR8PJoSIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 41BB9ef3022150;
	Sun, 11 Feb 2024 12:09:40 +0100
Date: Sun, 11 Feb 2024 12:09:40 +0100
From: Willy Tarreau <w@1wt.eu>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests/nolibc: Add tests for strlcat() and
 strlcpy()
Message-ID: <20240211110940.GC19364@1wt.eu>
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-5-rodrigo@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129141516.198636-5-rodrigo@sdfg.com.ar>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 29, 2024 at 03:15:16PM +0100, Rodrigo Campos wrote:
> I've verified that the tests matches libbsd's strlcat()/strlcpy()
> implementation.
> 
> Please note that as strlcat()/strlcpy() are not part of the libc, the
> tests are only compiled when using nolibc.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>

I like it, simple and efficient, thank you!
Willy


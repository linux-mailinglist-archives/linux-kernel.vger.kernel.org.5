Return-Path: <linux-kernel+bounces-56291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A3E84C85A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F608287040
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D0A25108;
	Wed,  7 Feb 2024 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TF39cxwK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D424B2F;
	Wed,  7 Feb 2024 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300806; cv=none; b=QwoXcVnMJVhru0UfS9FALoyr3SZsQaPerxon6u+ndxKash+5hZ2706pr6b2UFYMrNCM2ytT7d8p1QBZx5DkEOURkOBkciUVO2jCHuOHAfDk+C2jfR/WrtABMR1KaRRsBnO2LQIXvJw33Oqbrcj+OnU3QrALzWyLq8kYyaZOCD54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300806; c=relaxed/simple;
	bh=xvUHhBukpzpilWeY4cmdhc/x/ajRglVk/WoxXocHRbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCMAtc5ShEHUsghETu9GOU5Ppc7+qoIRcKVFEc35WoLDNsURkMsFLRpD5qsaEdH4CEJfcE5hcKQ2764kO74oTvZApSRRP+mDkjysK7D3QlNQ3G393Yz2vzuhqcTQQcfChLJxntxwjgpe3N35viRN1WKSqYaZPDcR0zFYe58dZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TF39cxwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879C1C433C7;
	Wed,  7 Feb 2024 10:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707300806;
	bh=xvUHhBukpzpilWeY4cmdhc/x/ajRglVk/WoxXocHRbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TF39cxwK8ncJLrDGoLU4/+42jVdqN+B9QIzr5cwHANxCmEURqwBAJt7O3QpGR2qW1
	 pGgDcpF4D2TAmzxz/SBbpXAIR4GiwhjXlo93mHieNcMhyRNOuDsOsQW9K6C39ICPXe
	 RihihD/ipdnZrEkUJTmMUApuKZhdGEGuTwh2GU5Y=
Date: Wed, 7 Feb 2024 10:13:23 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Ahmet Sezgin Duran <sezgin.duran@linux.org.tr>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: remove redundant braces from single
 line if-else blocks
Message-ID: <2024020757-desktop-atlantic-749e@gregkh>
References: <b97e1f8927d81b9b72cdea7a30f300b35854c38d.camel@linux.org.tr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b97e1f8927d81b9b72cdea7a30f300b35854c38d.camel@linux.org.tr>

On Tue, Feb 06, 2024 at 11:53:38PM +0300, Ahmet Sezgin Duran wrote:
> >From de5c5bb23c77fe62987b446c740b971e85105526 Mon Sep 17 00:00:00 2001
> From: Ahmet Sezgin Duran <sezgin.duran@linux.org.tr>
> Date: Tue, 6 Feb 2024 22:28:55 +0300
> Subject: [PATCH] staging: rtl8192e: remove redundant braces from single line
> if-else blocks

Why is all of this here in the changelog body?

Please fix up and send a v2.

thanks,

greg k-h


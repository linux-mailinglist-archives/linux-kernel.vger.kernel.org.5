Return-Path: <linux-kernel+bounces-125858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C7D892D25
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD001F21728
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F2947F47;
	Sat, 30 Mar 2024 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="rYXzVmhb"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91643ADA;
	Sat, 30 Mar 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830879; cv=none; b=crK4fp1+7+SuVCRl8pM+LWWVv4Eu8HTX9IJ8WhWePXTrFDHDgqiGReR4Ncz4Yk08DcOL+7LsbqW3dkI3g5NuvYvTXrGrpYlrmeJecr1fwUBGrq34F1bbOPg1itA/vADzJZOKj82rc3MFy4JUXMrVN9hsJdkP1EW8ueZ4gDAGgoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830879; c=relaxed/simple;
	bh=TXAI3RXCGB05p8hlCrVXsjj246yWRNksUhI3azQSgIw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sls17pHXl8WT+UOxodEjmZiA++mjmmxtNxTv3FcbLgQ9K3p+NUAr+vwWvEhc6gfcpKMvS07+yURPkW5lQrrlJsc0BaAZIqMg04ohaJmjAG57qHooZCyeUKTE2CzeV10ZNd1v7j3ITiRlyusgP6QrjBK7Leld5c/MhqXQnmH4zRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=rYXzVmhb; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4V6TXX1TgGzDq84;
	Sat, 30 Mar 2024 20:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1711830876; bh=TXAI3RXCGB05p8hlCrVXsjj246yWRNksUhI3azQSgIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rYXzVmhbE8wC2nnZ310alf7JUOxaToz6sp/OhO7idNHMJt7HL9FGjgdCEpIJ0uR06
	 H2Z7LXRGrlq45IhxpCJxka6CfEBfuGD6onGZa6gFq9ma6pYxMApgGieta1UHSe1ORq
	 VsZvJFQaL4lTMm0jqZvesSmdtik3Oq8qlw4G55RM=
X-Riseup-User-ID: 45C7480A38457D1C0B75E721AF90462E48F89C6B20748927352DC4A4C85A4395
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4V6TXW69PQzFpmT;
	Sat, 30 Mar 2024 20:34:35 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 30 Mar 2024 20:34:35 +0000
From: friederhannenheim@riseup.net
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marge Yang <marge.yang@tw.synaptics.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input/touchscreen: synaptics_tcm_oncell: add driver
In-Reply-To: <ZgWuq1bDWNRtrImD@google.com>
References: <20240327214643.7055-1-friederhannenheim@riseup.net>
 <ZgWuq1bDWNRtrImD@google.com>
Message-ID: <5dcfdc9c77b1dcd73815b8eaec8a4717@riseup.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-03-28 18:53, Dmitry Torokhov wrote:
> [ now CCing for real ]
> 
> Hi Frieder,
> 
> On Wed, Mar 27, 2024 at 10:39:12PM +0100, Frieder Hannenheim wrote:
>> This is a bit of a stripped down and partially reworked driver for the
>> synaptics_tcm_oncell touchscreen. I based my work off the driver in the
>> LineageOS kernel found at
>> https://github.com/LineageOS/android_kernel_oneplus_sm8250 branch
>> lineage-20. The code was originally written by OnePlus developers but
>> I'm not sure how to credit them correctly.
> 
> So the first question is: does this device not use Synaptics RMI4
> protocol?
> 
> I am CCing Marge Yang of Synaptics who may shed some light on the kind
> of touch controller this is.
> 
> Thanks.
Hi Dmitri,

the synaptics-s3908 uses a command based protocol whereas rmi4 is
register-based (as far as I understand it, I haven't been able to read
up on it properly since information on the internet is sparse). So I'm
pretty sure that it can not be controlled via rmi4.

Best wishes,
Frieder 


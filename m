Return-Path: <linux-kernel+bounces-144046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E58A4137
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7AE281C03
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77706225CE;
	Sun, 14 Apr 2024 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OonXDz4i"
Received: from msa.smtpout.orange.fr (msa-209.smtpout.orange.fr [193.252.23.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677F61AACB;
	Sun, 14 Apr 2024 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083235; cv=none; b=b3f4GXY/6LfC+yX4MbCH32r0NSVdJABejuB9pF9+3l7D7dIObrLy3Ofv11JNIS8nen4wQpXub6cOhno/uRvNuAuWtcYdRLLYHXb5cvPPP1+KSHiLPpsEq6oOqR3GEzM6eCYag3dSbOEgh5HdC5AQiWhWOzvkQTd3J3Zz2MoPQ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083235; c=relaxed/simple;
	bh=jDlnti2lQ5TUf+Ng2sizJiP+tSXPGB7ct4OO0qR+tbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sya8N2/pN0a4CiAfRpnVIfy0esKBhKHobhbiGKze5yJuaU5oHdE4MXdguibu4hF0ejSatkV32Wv77/NvAcqyHI0Y1MD7ScIV3q/mtFBBwYV30Zose8VU05YVWS05J4ncoUoyt6FCWvql37Hcy9CvchSCa3n+9H/UIWOJbTbcRkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OonXDz4i; arc=none smtp.client-ip=193.252.23.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vvCbr5JOjLfMZvvCbrTiAE; Sun, 14 Apr 2024 10:27:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713083225;
	bh=OxIrx2tFq1zuxx5z2pTvueKJhMEhICscOMd9Ve8kTRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OonXDz4iDTszNlz/jrui+Hpepg7oyQZH40i/+616CGA4dxS/Z1+hOc+E1ioRzMLjv
	 SUpVV5zQ4moTaVYO9AftLlkz8d9Hwjw5bGtz9b4lS0bAI7gn2k8h9y3ts9F5gapHO3
	 YG8Dkc0+RCIL91CTBOwLwBYjr54oyN/UQo4jsi9AewbHyipA4G/h6msqVt/+HMaNGK
	 1skYyRvuKrPqn+RjRdWJDkEdpP276l+MOG9QWZUuVODN/JqhcEdki6KlabqUf6aEK0
	 bBJWXXMBOE7InEiKHs+nrIulCwPE1dr0CeKyDZxZ9eN4T2XVI3WXWvHIew1UaBkPPh
	 5EG+mBlXbFhnA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 10:27:05 +0200
X-ME-IP: 86.243.17.157
Message-ID: <c5e519ea-2602-417c-84e9-199b610d427e@wanadoo.fr>
Date: Sun, 14 Apr 2024 10:27:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] most: Remove usage of the deprecated ida_simple_xx() API
To: Parthiban.Veerasooran@microchip.com, Christian.Gromm@microchip.com
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <988c218ef3d91bffaf4c3db9b6fba0d369cbb2b2.1702326601.git.christophe.jaillet@wanadoo.fr>
 <cd56d073-04ad-40ad-968b-7e137d10f456@microchip.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <cd56d073-04ad-40ad-968b-7e137d10f456@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/02/2024 à 09:53, Parthiban.Veerasooran@microchip.com a écrit :
> On 12/12/23 2:01 am, Christophe JAILLET wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> ida_alloc() and ida_free() should be preferred to the deprecated
>> ida_simple_get() and ida_simple_remove().
>>
>> This is less verbose.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Acked-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> 

Hi,

polite reminder ;-)

CJ


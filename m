Return-Path: <linux-kernel+bounces-90208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE5286FBF7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D344B1C20B26
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5341946B;
	Mon,  4 Mar 2024 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="VQCfeBsg"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821A199B0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541263; cv=none; b=s7kHWTlg0WYHKCtcuGq2hh5Nvh7tuXoAhCMOpEhGnIKMxeo8MiUod4CnC8FH2ZtgYMS4SK4K1BKQZ8Rp/BJrsbhrGJSy16BSHCAJNEjkNqAz9FZBzTb+Zygb32IngAL6sAZRZO/5254HMyO9fkHGF1hmvlSG8u9VwaopkuDLCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541263; c=relaxed/simple;
	bh=AIER70+wQQL6n4G+pyv9mVrcPvrDqlkRRm4iNCfXdFc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lJ0pjEHdT5mjCBVAXRTiSXecC0bETfgyFmQlaaawW5h4Nt76TSoqypMwfBDHBoRcBu4z8eWatMCvzFuRVENpRZZhjijIViK7ElXTWFRyJvN4eHAmbc3y9c9T3qm1e6sVRoiJwSBKWV10DzBY/4985ht3MjwUT8LjPkdiha0F6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iitb.ac.in; spf=pass smtp.mailfrom=iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=VQCfeBsg; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 51F88104D0DF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:04:12 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 51F88104D0DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1709541252; bh=AIER70+wQQL6n4G+pyv9mVrcPvrDqlkRRm4iNCfXdFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VQCfeBsgSP+WBGbAFDRM8tmHvR6FG/N/B5IaIShHHmwx8GDRXM3YWk4LphPgbUZfA
	 nckDbs90mDKuOT0NV2TAdSp+Gyq3o5seHSWA66UDJBImC1wFfYFs1rxEgqQD1IMYQY
	 +6hgfMeZAQmdh180GXLgHticO+/VlUhk21591P18=
Received: (qmail 31813 invoked by uid 510); 4 Mar 2024 14:04:12 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <210100011@iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.508746 secs; 04 Mar 2024 14:04:12 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: 210100011@iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 4 Mar 2024 14:04:08 +0530
Received: from wm1.iitb.ac.in (wm1.iitb.ac.in [10.200.17.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 757253414E8;
	Mon,  4 Mar 2024 14:04:08 +0530 (IST)
Received: from webmail-sso.iitb.ac.in (localhost [IPv6:::1])
	by wm1.iitb.ac.in (Postfix) with ESMTP id 73E54608E11;
	Mon,  4 Mar 2024 14:04:08 +0530 (IST)
Received: from [10.9.9.42]
 by webmail.iitb.ac.in
 with HTTP (HTTP/1.1 POST); Mon, 04 Mar 2024 14:04:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Mar 2024 14:04:08 +0530
From: Aman Sharma <210100011@iitb.ac.in>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Gregkh <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: pi433: Updated bitrate range from datasheet
In-Reply-To: <1440d44b-c16d-4307-9457-5c3ae44716ff@moroto.mountain>
References: <91454ef9b4a12f01e13d69b675d81aff@iitb.ac.in>
 <1440d44b-c16d-4307-9457-5c3ae44716ff@moroto.mountain>
Message-ID: <74ec69941cb67e3a351ebd23d5ad4a5b@iitb.ac.in>
X-Sender: 210100011@iitb.ac.in
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Tbh this is my first patch and I don't have the hardware to test this. I 
thought updating the values from the datasheet directly might be a good 
idea as it would be the correct range. Please correct me if there is 
something that I missed / need to know.

On 2024-03-04 13:55, Dan Carpenter wrote:
> On Mon, Mar 04, 2024 at 11:23:40AM +0530, Aman Sharma wrote:
>> Updated bitrate range for FSK and OOK modulation from the RFM69 
>> Datasheet.
>> The values are mentioned in Section 2.3.2 of the datasheet.
> 
> Have you tested these as well?  Sending untested patches is not
> necessarily against the rules, but it seems like maybe you have this
> hardware and can test it.  Could you please talk about what testing you
> did?
> 
>> 
>> Signed-off-by: Aman Sharma<amansharma6122002@gmail.com>
>                             ^
> Missing space.
> 

I'll fix this if I am allowed to submit a new patch.

> regards,
> dan carpenter


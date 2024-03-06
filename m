Return-Path: <linux-kernel+bounces-94178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2408A873AF3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D497D282E7A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3896D135403;
	Wed,  6 Mar 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="nuzQc7yM"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E97FBBD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739743; cv=none; b=TxjeJXk1mXi0edVQiFfVQg40ka8wDtI50Gpxhg2yM/Gjd0+cH6fjw9ymN1dx/xgb2H/lXwFiYJYM7Vr+sQ0RhlgspRWHmanTrXZPz15qKhAH8E42DLSmIbeNsJCRJHB93ORqNZOnPiRTb51ccF2nnFMhAlRAs/yQQC6unkBijDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739743; c=relaxed/simple;
	bh=A6ejjzFnzfbN81Awuaf5GgmU1S8+eWIJJKABbBqLwdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5miVbPDC3fU/tIWK+djgfOXSkRVZ3a0LwPEcXqsrBLUsOCPCd4kyK5C9HpM3zFOyEiqIAi71UnxBFgQimEB8Lo0DDHnRGJKUMQRnM1TdX+aWuDNnJXTzSq83bJ1CLq3EZirE8g5Hz2aQR67V0Fd49iWcs/H7R7i+RdtytFwolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=nuzQc7yM; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id hsGKrdNNePM1hhtPQrQVTx; Wed, 06 Mar 2024 15:42:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id htPPrWiyq9NWuhtPQrNU8S; Wed, 06 Mar 2024 15:42:20 +0000
X-Authority-Analysis: v=2.4 cv=RpDDLjmK c=1 sm=1 tr=0 ts=65e88edc
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=mU1RsLrzvjGXDdw7Dd8A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cE2AQJoC9weqajQ/1asaazO4AMb6/FWugaonAa9OCjg=; b=nuzQc7yMPKokkq/Y37CgrQmVTv
	lGbTJyaq+elcu/qhEweeSfrq7gR1s2RiKnrfQhmffv1Gl9ZzpMW7X27+41dmKsp9n2yggVOw845FM
	CDgpoSccWDKm83pFPwaCOtq7lpdUOzRdm4i6TtmNmImW3z9O1gbWHIVtQV8eIBBcJ5MTv5rWCzyIi
	1oFqt6ereO1z33gwU9yw77wteOSebmm7Z7RV8Cyg7iP9A0LdsdySsSprtXm53EYlyChCluxlae9pX
	852Hs1ZtFOX9WdSjvZYZrNJre3xAF94WofPqZocbDrSAzz9FYa46KoNPw9JtKCcUEOF2K1UHLSnNL
	jMYukrMg==;
Received: from [201.172.172.225] (port=37704 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rhtPP-000nwp-15;
	Wed, 06 Mar 2024 09:42:19 -0600
Message-ID: <00b30dee-59ed-4782-8d1a-64b66c38c901@embeddedor.com>
Date: Wed, 6 Mar 2024 09:42:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] fsnotify: Avoid -Wflex-array-member-not-at-end
 warning
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZeeaRuTpuxInH6ZB@neat> <202403051548.045B16BF@keescook>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202403051548.045B16BF@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rhtPP-000nwp-15
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:37704
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFdCphMYoOrENxJVCsiWa7PqmXC0lEIvbUL3YoD9XeS3SSYL51yArL6KS5uulMM86gPsb92OnZDa7CEzPtSEeawQ5wf0fzykeYRFNEiYC4iW2BEA6avk
 C/2KNKFsL9mg+rKGBWnpG4O7mBfD/10gk7KozY3qTEX0PSjiYhH4W6d79sC3XFuw/E9q4LUGPtjvns6cg8uI9KLt9eJyfunyxtaRC9Tpwjc2eqjybwvPnK60



On 3/5/24 17:52, Kees Cook wrote:
> On Tue, Mar 05, 2024 at 04:18:46PM -0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>> ready to enable it globally.
>>
>> There is currently a local structure `f` that is using a flexible
>> `struct file_handle` as header for an on-stack place-holder for the
>> flexible-array member `unsigned char f_handle[];`.
>>
>> struct {
>> 	struct file_handle handle;
>> 	u8 pad[MAX_HANDLE_SZ];
>> } f;
> 
> This code pattern is "put a flex array struct on the stack", but we have
> a macro for this now:
> 
> DEFINE_FLEX(struct file_handle, handle, f_handle, MAX_HANDLE_SZ);
> 
> And you can even include the initializer:
> 
> _DEFINE_FLEX(struct file_handle, handle, f_handle, MAX_HANDLE_SZ,
> 	     = { .handle_bytes = MAX_HANDLE_SZ });
> 
> I think this would be a simpler conversion.
> 
> Also, this could use a __counted_by tag...
> 
> I need to improve the DEFINE_FLEX macro a bit, though, to take advantage
> of __counted_by.
> 

Yep, I like it.

I'll go and hunt down all those on-stack -Wflex-array-member-not-at-end
issues with this helper. :)

Thanks
--
Gustavo


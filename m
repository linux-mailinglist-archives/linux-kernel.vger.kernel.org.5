Return-Path: <linux-kernel+bounces-10756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6002D81DB51
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D858B21202
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B39CD27F;
	Sun, 24 Dec 2023 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cWzbjlDM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4191C8C4;
	Sun, 24 Dec 2023 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Sylrj4khsz9sWt;
	Sun, 24 Dec 2023 16:51:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1703433093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EviEQ2BuQoPRdrEs2nwAH3M+cLPQSNn/nTwXHYXawaE=;
	b=cWzbjlDMRycWQ9PJ8T4ZVMKHrQBI63u/jRUxfZUDx9gagVNJJ9x58C6CohuN3u//klVCmN
	lPHGNII5PYv9Jb/n01Pq+k7/mBmf4RssrSlr/70Sxmh4SrF0w42ATKnY8vIWg9lyPDPekh
	qW9lyahviASxe4hTnrOLYl2HbfufU/VaaNNmopvD+f3nUEg3YsfKvZrxohzLCzEYIlYhhV
	o7kXeTQ8E94nofdls8xHFa/pLbgi5ryIIT0jXSVAl6WNVv9FLDK6w4+L4eH/PwhssJziON
	GQOM+zU9a98gjynbgWNuPuq1S/NWlpOZdDvcdz88bLn1hUZypH9JUVKFZhKiHA==
Message-ID: <d13694c9-4409-4566-919b-7a577afd583c@mailbox.org>
Date: Sun, 24 Dec 2023 16:51:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Mikhail Khvoinitsky <me@khvoinitsky.org>
Cc: jkosina@suse.com, benjamin.tissoires@redhat.com, iam@valdikss.org.ru,
 jekhor@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <nycvar.YFH.7.76.2312121445510.24250@cbobk.fhfr.pm>
 <3a29c0a6-9b53-433d-a83d-5b68a87c1155@mailbox.org>
 <CAMMabwPd-m7a+EQV7zb=wU52=P1FkqFU1dg9=gyvaS1EP5tX3Q@mail.gmail.com>
Content-Language: en-US
From: "Uli v. d. Ohe" <u-v@mailbox.org>
Autocrypt: addr=u-v@mailbox.org; keydata=
 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
Subject: Re: [PATCH] HID: lenovo: Restrict detection of patched firmware only
 to USB cptkbd
In-Reply-To: <CAMMabwPd-m7a+EQV7zb=wU52=P1FkqFU1dg9=gyvaS1EP5tX3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 542453eb079ead27204
X-MBO-RS-META: 41c6fo1tznu8nfkgo56oisbjjyey7zgx

> So this means that the only reliable way is to add a sysfs parameter.
> I'll send a patch.

Thank you for the quick action!

Perhaps it would be possible to modify the firmware further in order to 
facilitate reliable detection of this modified firmware? But for now the 
solution with a sysfs parameter (and defaulting to the workaround) seems 
good.

Best regards,
Uli


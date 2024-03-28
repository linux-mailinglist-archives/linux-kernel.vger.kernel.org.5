Return-Path: <linux-kernel+bounces-123815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A94890E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9F71C27289
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A8A137776;
	Thu, 28 Mar 2024 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ad40VaPh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HwPTUbNX"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4539FDD;
	Thu, 28 Mar 2024 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667910; cv=none; b=WiXCxLlWflB6duvq3xRL6Rts9xVUCzFHfoOJblX7es7mUwr7dC2FNw/dFjJ2rVNPTofIDgYslSOn/2bDFCHNIRc7HGH1Rejd4UB5Q134gUP9tUdkjSt0s8MojH/VnU66Vm/AHeiwkDYz7JbdHjkB+/uBWVYx3r3W8d6WE3o2Zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667910; c=relaxed/simple;
	bh=KOaINKXdpcVFV7F2AKxfl7uztaO+GqjjudMvUNQbyJM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GocDWTM4oqdX8CHernQMM2vmBYDdUBNRDrm2CtsXXOGIChsdnzjIMXKEF/GEDr330sxNPT1yBuL7BpPGTCKfYZrb2maw6f2NWXZcA43+8QdnHB5TwAAJloC+g54mm5T6LlTZcizmhP5bwvQNwzM/ez0MvbJEqFlxifRJWKRnRGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ad40VaPh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HwPTUbNX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1F70D13800D1;
	Thu, 28 Mar 2024 19:18:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 28 Mar 2024 19:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711667907; x=1711754307; bh=cHVhiRJg3y
	oWV/TXtcjf/4iVMYBasTwoLlZblDkJ4RA=; b=ad40VaPhRu9xSA4WNIbnqsmNrX
	GGA3bW8UCcQZ+rRK5oEj6H9zsnZIasnNy0xmC8Eu0jiHuX+Tdx6Fojc2DLvq5rBP
	oqMj9RgxAGzLWEzlaKbqFGIeAceXhGAUlLGrJRCvWmqJPqxV70tpCkOcNQqUDKQg
	JkYqUO0UzrppBIHOKett+B8duGQUpes75uZokx+uw/AnZkACDrZXhEJU4zMOjvmW
	kLUAc/t/3dkn22m14/YqybKyFYfsuujaTtWFil/mMMKqShxlI5HHaU10PKVxupSj
	Zc3boOorLxzqCcVSbtlqd+cjiL+3EHKqX49JHiZq0diufqGUQvR68lY4IX2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711667907; x=1711754307; bh=cHVhiRJg3yoWV/TXtcjf/4iVMYBa
	sTwoLlZblDkJ4RA=; b=HwPTUbNXkiacbKSY49zz5LWFGH3gy69gK2PImqF5kRmN
	/VMf92nuMewwllCr2mxeXh0Rj1Vr55mwg1u7EXmY/daLNvBWIoua+UjcdVNeRTcK
	zpIgPn7JkDKz9VSMIIXCncV/UC2UTUNFaPb7cg66tYGAKD0MXPwM3b+J75cK6+sq
	RVnR0sbPhvrQQSf1b9AA/phn3xIh/AtFHxUZkd0w1WZu+SH2jKH0hny6dYHnuC6B
	Kldc6BJrqtXWKIV5+Ahmn9DwKN0tXucl1pw7YD8CSQEb7avxo6+hsyVeEI2/hnmW
	O0D6F3UFp/ddyApnHFWZXzhccZS53dmiixZD+is3yQ==
X-ME-Sender: <xms:wvoFZvc9b8R8XeI6qcHCKPMUQbsFKOa8vZuepu3UamS31f5neBOF0Q>
    <xme:wvoFZlNosy4pRDk79r7fSD1h8JIKaS3_lFm2etobxJZSaI-hq5aUkBOd1gVM3estz
    yWxgD70iMeeykipb_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:wvoFZohVAjAkLft2aV75WjhWEPT9cQl4j5W_ssbw7J5xgRleihfX5g>
    <xmx:wvoFZg8HGpgcHQ-AV5TGIW2WVFtY6TJaCK42Np1iXzXPmlicWW4aeQ>
    <xmx:wvoFZrs_hOWTkrESqbbtUb1k96bGKUdiL-Ywz-vebAgTGH-KgFPF4A>
    <xmx:wvoFZvHA2_VX4H9cCJBVdSgkulcwzixeiEOKhk3PLNgk7fDO6Bd9QA>
    <xmx:w_oFZpIJi8JakjUy4EqMgaYD3uSl84tbXqu2h2dNA-gwux_QNYsMvw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A707CB6008D; Thu, 28 Mar 2024 19:18:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ba922b28-e906-4d9a-90c7-8505d60f611d@app.fastmail.com>
In-Reply-To: 
 <opeccmuhptoldyr2xfwstb4uwwgfiupk3kmjkxvke2itq6cuyn@jcx4v3a5ww2f>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-3-arnd@kernel.org>
 <opeccmuhptoldyr2xfwstb4uwwgfiupk3kmjkxvke2itq6cuyn@jcx4v3a5ww2f>
Date: Fri, 29 Mar 2024 00:18:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Justin Stitt" <justinstitt@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Chris Down" <chris@chrisdown.name>, "Petr Mladek" <pmladek@suse.com>,
 "Bart Van Assche" <bvanassche@acm.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 02/11] scsi: devinfo: rework scsi_strcpy_devinfo()
Content-Type: text/plain

On Fri, Mar 29, 2024, at 00:14, Justin Stitt wrote:
>
> On Thu, Mar 28, 2024 at 03:04:46PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> scsi_strcpy_devinfo() appears to work as intended but its semantics are
>> so confusing that gcc warns about it when -Wstringop-truncation is enabled:
>> 
>> In function 'scsi_strcpy_devinfo',
>>     inlined from 'scsi_dev_info_list_add_keyed' at drivers/scsi/scsi_devinfo.c:370:2:
>> drivers/scsi/scsi_devinfo.c:297:9: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
>>   297 |         strncpy(to, from, to_length);
>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 
>> Reorganize the function to completely separate the nul-terminated from
>> the space-padded/non-terminated case. The former is just strscpy_pad(),
>> while the latter does not have a standard function.
>>
>
> I did the same in a patch sent earlier (few weeks ago):
>
> https://lore.kernel.org/all/20240305-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v3-5-5b78a13ff984@google.com/
>
> Maybe reviewers can chime in on which version is preferred and go from
> there.

I'm in favor of your version, it looks nicer and addresses the comment
that Bart had on mine.

     Arnd


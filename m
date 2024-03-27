Return-Path: <linux-kernel+bounces-121968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F4D88F001
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA8E1C28EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C7D15217B;
	Wed, 27 Mar 2024 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EkdbuNyE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tkxJ3E0C"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1E32C96;
	Wed, 27 Mar 2024 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711570935; cv=none; b=lYHTEkkXI5Ik5oWHzitCSG8mz+Bhh1vSLIozJjXpOcHF5mUte6/bu5zDPPuAOvwQYPieL+Vbq+CBwf0jktNRkZzLUvb3ZAL1ue2Ft2eClRVPczaHyhHNL75fBJbtwy589rWPS0uDaNdWt2OU5CgJ58GKy2CGrWYDmyWgvVv4JhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711570935; c=relaxed/simple;
	bh=ox9saau7I4d3lcNRbvzhI0S5aT9bYAoOR85d/CDfRzc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Ubvo2sLhkEHBkrdASohMFjDEuEDUhUQzwsDLqXVJYHrcrqDKQujdhnDFWo3QvvuWvbwuTcCebuyxjUfH1IRWtV/PtgSgmpf7f9gzlzTXHKB0Z+e8tJXqLMKbpbmJ8ADbvXZUvafVvlYUv0UwtKTi2LbkYZOrrYVAbzhslUEP6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EkdbuNyE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tkxJ3E0C; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2485413800AE;
	Wed, 27 Mar 2024 16:22:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 16:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711570932; x=1711657332; bh=Hlo09VbbHI
	++Ia41R+Oy/QfjK63GWjPxLHm+eujyF9k=; b=EkdbuNyEZzA9QsAi3mPl7twUPJ
	aNw4VGDcSh1aDD8sZP8qzpv44AczSWBqTO0G53hf4Oleb18sYKY4NhuwuN6RvAdq
	fByNV9QrW6oxQtozJTk5zJ1Av0Fb8P1/7v78VmGoAz+9GdE+b0/ZztRWgN2rLjeN
	sjhKajkQSa+HdAxU892qoqrwHEc/p3gVa90G9TQ+ms/xjTZS/NPj0xlsDSNH7eK5
	fWEowUWT7MUxrZ/wWG1d0qJ2Jpn2QFzVAzhrbug7y80t0sETJhTEMGS4CUNaEl8C
	Uju7rJEoDq5001fAxTRJYkZeYjqYSmMIkHI01bFbuuIMz7v/VH6SjFk3Nxnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711570932; x=1711657332; bh=Hlo09VbbHI++Ia41R+Oy/QfjK63G
	WjPxLHm+eujyF9k=; b=tkxJ3E0CYEYoADARnYDWw3+10+NwGtVi1xi79FXCMwXw
	iM4X9mYHpU5Q/IiQLYtb4suDZm1sWwIqo7dkbwjBeaAWwbKoqpz6CuKrThch65Cb
	aWfR07PiV6OlSghU56JKzPElIC8ox6q4mkgFZB+p4abkPWf/R7raMkYx++KRk7zG
	hnQJ6tRN9Ag3zPbo4lwZS0I825DgSR5FpqP5nTYVgGfg7rBRPlYTQJLcuTkprPTi
	yRi1AKSAZjI73PiRotLhIi807tlRyKMkZtYHgALhAfkJ9ypXb9WE3+zfTk5LdcT4
	5uTz5byIbxdpyPnyr1yeuR09vy9rgFgcMPpRTdQZkA==
X-ME-Sender: <xms:838EZuM6bat550SgvA6a7Vb9GP0JucCylN0IiQdVWv3CEoHftznDwg>
    <xme:838EZs8gpIutMszJM4nZORF_vjHoGR8BFDsi5b_kxwry-P9In5mHvnaEW42HqIEfS
    -vM4an7e8dQmeBz-ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:838EZlRKkKKouC5OZEExwZ-EDOA0VgN57ELv4VPYmeq0ShGf4w4p5w>
    <xmx:838EZuuJinxSit7CVt36OAgF8kGcvkEF9dS2gGm4stx0w8SY4iEmyg>
    <xmx:838EZmefzanIFh0b-GKrO7MHuFy_lmIa5UfPE-LPibGwoiWfjM-Ofw>
    <xmx:838EZi0Fns-0ivYI83BP-BXZ3gj8daBMfrd65rByx-6Ln-766C25fg>
    <xmx:9H8EZi29I2rkPBRThRTCgMusvgHZmsVE3Q4UWqPbVoSJh2y-_bfIAA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 72A35B60092; Wed, 27 Mar 2024 16:22:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <019b81ac-6ecb-44f4-b878-7a6f734010e7@app.fastmail.com>
In-Reply-To: <d7fd5998-8813-4f29-a8d2-b82adbdec11c@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
 <20240326145348.3318887-1-arnd@kernel.org>
 <d7fd5998-8813-4f29-a8d2-b82adbdec11c@kernel.org>
Date: Wed, 27 Mar 2024 21:21:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Damien Le Moal" <dlemoal@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 linux-kbuild@vger.kernel.org, "Masahiro Yamada" <masahiroy@kernel.org>,
 "Niklas Cassel" <cassel@kernel.org>
Cc: "Nicolas Schier" <nicolas@fjasle.eu>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "John Garry" <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] sata: sx4: fix pdc20621_get_from_dimm() on 64-bit
Content-Type: text/plain

On Wed, Mar 27, 2024, at 02:36, Damien Le Moal wrote:
> On 3/26/24 23:53, Arnd Bergmann wrote:
>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Looks good to me. I can take the patch through libata tree, unless you prefer
> taking the whole series ?

Please merge it through your tree.

> In case it is the latter:
>
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
>

Thanks,

    Arnd


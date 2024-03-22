Return-Path: <linux-kernel+bounces-111887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE339887235
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F61F1F21602
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F04605A3;
	Fri, 22 Mar 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kgwNwn08"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B167F60874;
	Fri, 22 Mar 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129973; cv=none; b=ZzxaFD25HmVAFQ55JuamBChNoIlBrOYBGCCQd4U/RIPhGjwhU4z99XemAeyNdCF6blHU1RMVXEJXeas98ZJ5i41zSijHFGXecXnbOSLVzfBUQax26O6aVBEND7ezq6oOwY8+tx+WhM3/06qAjHFl4HiXY+aL0vmg2WBefgtS2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129973; c=relaxed/simple;
	bh=cPpzkL33TNc8EjbO22UOd0Waan/BeO74C1s1p9UZ/a4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unCVsHDHhDwrfiiN/OPEFwVNN4kZgZqK5I9mfspxzcj2Nr+J/nZ4/HLJC0h0dGdSZgdfriIF/H+Hw3tMCy6XYwOVgjYzDPsac9HupfDn0tSzw5gRusThwD51Brhe++GQSJZ6gniq3Hd2xx98RWa05h5jaeqIashznQTqj4mtr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kgwNwn08; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V1VKb22wkzlgVnF;
	Fri, 22 Mar 2024 17:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711129964; x=1713721965; bh=VmpsveN1Jy+pI79mJoSzX1Tm
	iWIgqpdMBcYQ0YCsro8=; b=kgwNwn08fqIrxHP5H264S72bIhZb5jOd5P/pAbWr
	10b43ql298Ll0OdhuZl6sZ+SQPHzPNFSfKJjYVXeh9BY1K2zegzA7vH1mnjPnfjM
	FKBzy4bDVWu7O8eMuV1EPQBWHCtKrcSWoLPpktF66AS4wUAC/1kJzufGMdnNs7t6
	q62nT2xTeE0UTqel4BxzJFRA2elLKTNpfbKk1uNTklo+TMPgN4CM2FgMOUT58Z91
	m4vAdjX7Pgn88NAymF5V6woD9zN7GrsuQ+lc29MAkDz8NIJN+P0kxHny8Mi/8bc1
	i7RXpEKlbNBrfk2dtM5LEP+NrJzjyXCBIiVKPjVpX+ndeg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CnWJKX_Ztm_X; Fri, 22 Mar 2024 17:52:44 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V1VKK1wLtzlgTGW;
	Fri, 22 Mar 2024 17:52:36 +0000 (UTC)
Message-ID: <99874d1e-ff5c-4e8a-9922-752207119147@acm.org>
Date: Fri, 22 Mar 2024 10:52:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] block: implement NVMEM provider
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Jens Axboe <axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>,
 Jan Kara <jack@suse.cz>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Damien Le Moal <dlemoal@kernel.org>,
 Li Lingfeng <lilingfeng3@huawei.com>, Christian Brauner
 <brauner@kernel.org>, Christian Heusel <christian@heusel.eu>,
 Min Li <min15.li@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Avri Altman <avri.altman@wdc.com>, Hannes Reinecke <hare@suse.de>,
 Christian Loehle <CLoehle@hyperstone.com>, Bean Huo <beanhuo@micron.com>,
 Yeqi Fu <asuk4.q@gmail.com>, Victor Shih <victor.shih@genesyslogic.com.tw>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-block@vger.kernel.org
References: <cover.1711048433.git.daniel@makrotopia.org>
 <7555db6eb71d4ccb2b9d5ebe3b41dc34088c6316.1711048433.git.daniel@makrotopia.org>
 <e170642d-9ae8-4d5a-90d9-2837f1bcef9b@acm.org>
 <ZfyW8jTAgclicAWd@makrotopia.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZfyW8jTAgclicAWd@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 13:22, Daniel Golle wrote:
> On Thu, Mar 21, 2024 at 12:44:19PM -0700, Bart Van Assche wrote:
>> Why to add this functionality to the block layer instead of somewhere
>> in the drivers/ directory?
> 
> Simply because we need notifications about appearing and disappearing
> block devices, or a way to iterate over all block devices in a system.
> For both there isn't currently any other interface than using a
> class_interface for that, and that requires access to &block_class
> which is considered a block subsystem internal.

That's an argument for adding an interface to the block layer that
implements this functionality but not for adding this code in the block
layer.

Thanks,

Bart.


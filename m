Return-Path: <linux-kernel+bounces-83324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BFC86928D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9320F28DBEE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C71419B1;
	Tue, 27 Feb 2024 13:36:00 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907DC13EFED
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040960; cv=none; b=PQ27z4uv4YbLoVRxaJSwWg4G+CGM06hOyrIADy/TMitjcWBeCvnEW2BnVBzoUOeomy6yMZ1kPdGSQXUkhHMH6mnK9IHbZBmLS8mF7Yxjt2ocWVPdiJGHjv3neN4MWSexl/0SSSwZhjWUjNI2zSM8racxpf4y3MTqK6wgBBSLHhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040960; c=relaxed/simple;
	bh=2wdaSkoK4RlUYZqlfmfs/iKPXvB1JGP+8YFvkQgfVnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ubp3UGpFfu8rXgS+KqhOPXIEAvrDVHdKRhLa7VmEh8d8IZ5pqU+VWo7/ppuh8crSNpNDUOjPZeMBgYI6JT/K7RVuORWAa3OlBsNl4QvJEb0+YAjGXwyaEwPCecbIloMMRyeg2TzJLlzcjIYYWujUUS0geRdcib8q8uY7eIYFbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1709040952-086e2316ed00600001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id DpE5ORzyURXSjUcG (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 27 Feb 2024 21:35:52 +0800 (CST)
X-Barracuda-Envelope-From: WeitaoWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 21:35:52 +0800
Received: from [10.29.8.21] (10.29.8.21) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 27 Feb
 2024 21:35:51 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <594c4e2f-74c4-42dd-9b7c-c3468a55c7ee@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.21
Date: Wed, 28 Feb 2024 05:35:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] USB:UAS:return ENODEV when submit urbs fail with device
 not attached.
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] USB:UAS:return ENODEV when submit urbs fail with device
 not attached.
To: Oliver Neukum <oneukum@suse.com>, <stern@rowland.harvard.edu>,
	<gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<usb-storage@lists.one-eyed-alien.net>
CC: <WeitaoWang@zhaoxin.com>
References: <20240222165441.6148-1-WeitaoWang-oc@zhaoxin.com>
 <3ff16f34-07a9-4b7e-b51d-b7220f08d88d@suse.com>
 <41daf1a9-590a-e220-84a3-648eb895272b@zhaoxin.com>
 <8f4fe820-2385-40e7-a3c6-51102e57acad@suse.com>
From: "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
In-Reply-To: <8f4fe820-2385-40e7-a3c6-51102e57acad@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1709040952
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 819
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.09
X-Barracuda-Spam-Status: No, SCORE=1.09 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=DATE_IN_FUTURE_06_12, DATE_IN_FUTURE_06_12_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121398
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 DATE_IN_FUTURE_06_12   Date: is 6 to 12 hours after Received: date
	3.10 DATE_IN_FUTURE_06_12_2 DATE_IN_FUTURE_06_12_2

On 2024/2/27 17:05, Oliver Neukum wrote:
> 

> On 22.02.24 21:06, WeitaoWang-oc@zhaoxin.com wrote:
> 
>> Maybe, my description was not accurate enough, here not add new return
>> value to scsi layer,it just add a case to tell device is gone in the uas
>> driver internal and the ENODEV error code not return to scsi layer.
>> Here just notify SCSI layer of device loss through flag DID_NO_CONNECT.
>> This is also hope to fix this issue in the uas driver internal.
> 
> Hi,
> 
> sorry for the delay. OK, I see what you are aiming at. Could you redo
> the patch with a better description, like:
> 
> We need to translate -ENODEV to DID_NOT_CONNECT for the SCSI layer.
> 
Okay, Thanks for your suggestion. And I'll improve this patch
description in the next version.

Thanks & Best regards,
Weitao


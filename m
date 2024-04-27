Return-Path: <linux-kernel+bounces-161002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D94A8B459F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F841F21B88
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76E34594A;
	Sat, 27 Apr 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="BMOgbUMh"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF43FE47;
	Sat, 27 Apr 2024 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714215272; cv=none; b=TUVE5ziUXkXqzWgqsWfCUv8XC5PBCrSzOZ4xGyx6ZOkRy3dh2ZQKB09skVsV2YyvHMQSeSRCRpOsAnblMbkB/WO/X50T9NW/dnLihlfjnUuRXZkc9hQZod3LukAXwLYNvnkPeVG6F7WzRzCz+B+dC3Ha5qIgg6tubJUTC2j8sno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714215272; c=relaxed/simple;
	bh=nIM0kF53eMsKebnB69nMRQDFX/NcTU//w1F0rF/SQRg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=owUR1nRrIsXvJ4r3ceTWChMcYQ4qW554+XWFRvD1BVw7HMqhG+yznbJcxGnJ00oUbBDvfw7ZPIeszPz5PhAzQpKnSbnSCzCHJZlefitXPqJf612UwnnCkVvtGbxipLMH2zDS+h6bkDD6niCMAf53monVRG1b5anNVdamZN8iAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=BMOgbUMh; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714215266; x=1714820066; i=aros@gmx.com;
	bh=nIM0kF53eMsKebnB69nMRQDFX/NcTU//w1F0rF/SQRg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BMOgbUMhKKTlbilwnxSvpk31OIneoKREofnUEoFUEIQwsb4FxMUemulpbKq4diZf
	 dXAYIbagtP5xbocuFtOCUPixkxSm6HqEAGqeK/uW7g00/a8Ey2a+Dhc+qlEmeM6ny
	 bM2hfv/UPTTAOjFZwTyrnQLEoQKyuti/cu3RgT7y8Y0WsjhsT9Y4vSEqW665Xhipx
	 D86dnH1x8sTPvx+KxjvXv16IU063O5+xr73iRmziyVl5SARUACuhkck6HaQxVN6hW
	 NK14FuanYbuNsPR7HCrK9ppYMAFY+5ftNU7Lczj25ATfYGO+lqfECg2RRWfTThMMz
	 HY5vnxkGFASDiK/aaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.25.110.37] ([98.159.234.26]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2jC-1sVtyd2ozq-00niar; Sat, 27
 Apr 2024 12:54:25 +0200
Message-ID: <2330c23c-e99b-454a-b195-32c5b4332071@gmx.com>
Date: Sat, 27 Apr 2024 10:54:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: gregkh@linuxfoundation.org
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <2024042328-footprint-enrage-2db3@gregkh>
Subject: Re: [Intel-wired-lan] [BUG] e1000e, scheduling while atomic (stable)
Content-Language: en-US
From: "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <2024042328-footprint-enrage-2db3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rYE8ntWQoWfPXtJcQSmSMLornpL74RVw50TEcun9H6wYBruDar9
 20//qEowj3Bmqe1jd6rweWraI7/DlwppyjZc/uF9m/L2CpEYJFvLO47a3Rgl3skbVU+/C/X
 BXzONwUACKQ9jb/q+A8T0Lo5UpqS6a9fszZaIHn19jZcubsuAAszrxTdHwwBg4hbOcZf0Xm
 ig1x1KWwjX/vwc+24dWkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c3PofOWbFJA=;MkBOarjUdOXWIKcMz+jr/AJv3Lf
 zu/7HpVayyQ3UI6tsYjmtrSgyKno0fdV14P+Z39+8cEuvAxTIrncnYLbonRmpqYSZC0A2Pmte
 mu73kfnYUOAArwi1mz+1zhaUJBoOhB8bIDdPuRHaTRQMlwCyAREjl/cUPTzYCNPRlWKXFkK6I
 1elhvfI7TebjoTQ1+l+7bdGlANnYIpkNMmennAIADhIQt9rRmLQlRIqWgaGm+6xhuIolFHJYY
 xFJlyGi1lzXGYapcip/YCHmBwxeekRqszFjXfYLsryjedlMmaVsZvmNPihH3VJzbl1mFBP4ZP
 hKDYF9kJddiYxIk2HA7l7WR0yYYG0JOLqOJWKf4WdB7TKdCIFKfn2Q1zHnNEp+/V7inbciGR5
 mDbhPL6rB9IfZwPjm1D9wzl4J1ApKnsuYAgKdlrX99KR0ChoMIPBNB0mbYjcZLDZ0y/8Amu70
 z9NnnBElNV55GRchX6sIix6g60RudkibhrtwXDK9Q49RkrPZ8jBu4AoOipTz/9QOW7JQWl3x2
 94Bva5kvpHMJ8ysF0Wlrm00sKU+lUrIBuhGr9NEQ33fsO8fYcVFXF6NjDmrwLyfOqnPCHQwCk
 JshCHOrcL539LvJtTQe5TpEL08OGbqBg8vmayNnWriYPJ48C1tJs6ksQFLWTeqAsah6uTzz/6
 +CjwrqViNEFpBeLPOSB90nxjS5CfrK6yiUEKY/KOdN4pbCZ8hqA65cjtwvpvmESWG3cC2AsBs
 XDUvzgV0Qeer1JD0mEvqN2YX1PupAxqx5KMByM79XMZLO+Q0Bf/aNUutAHnx0rpxK9SdV5LNx
 Owj/CdCpS/MG8cnAt0wg35fkXgMA7ONxUfLMKZhkp7CpY=

Hello,

This fix is still not queued in 6.8 stable:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.8

Why?

Regards,
Artem


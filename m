Return-Path: <linux-kernel+bounces-74909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E4A85DFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AB1286A20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E507F7FBB1;
	Wed, 21 Feb 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WnL6F42n";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="289aKcgA"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9467FBA1;
	Wed, 21 Feb 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526303; cv=pass; b=cVgkAyz79VOKDaMYsIj69tfEW80TMWldVsLXCz/xs0l/L4RxWAcd4Jc1T+2CbjBC8Kod3eAucJgNpaPE5olY2eihSW1ZoM+/eh3KUiHQASbzyl51G9IezKFjE+tYBOG1qPqC/I360GcnOaF/qnrwGl7mBDrUxmZMHvvwZPLMOtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526303; c=relaxed/simple;
	bh=Yk/f5XifWhGXBDB2dBIer/YPFVx1NYJczki/GIL9pm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdoSV3F8MLcyd2CSxCFLnrcKPuCj1RTlILi2EEDo2VU0LBPMPpbN+LJ2JrrnCQuw2fyhB5OOR6lmXFEJ3c0E2Sr2EG4wtNbGN78dJr44FljkPnOSh5E84XYCc7r30p3IBH6LALzisZRCKbDFYBVhS/Cq9jK7z1Tll1HJLGKOyc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WnL6F42n; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=289aKcgA; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1708526292; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gNd+zI5sqYXi782KQQG4i1gGlvtRSk28pUr3JFmuDlexdios7wHWgWJIfkY0B9oajU
    TgTbHERDZlJ/nUvEKhg/NOA+T/0+kLbxC/H22KUofiyaq2cGDLEoKH0uChdTWcSOnKcD
    fSrNgQ6snVlEiD4MXQpX6Ts+am+v7E/5p7pj8ozCE/3HiGapGSqRcqAnOrBsbjLy24l0
    C5R/7PxaD6a9j4ZNYtX29yFucUHvJH88AW8doyLXLixu1+9N0h/SstlxCCfnmpSZrAOp
    s3+EWlHFo6dQTghxgvadj5Ce9cjz1J2prW/RCoBxG4Q08WIbne21MIsoEyBm2gho2QRW
    WOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708526292;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Kiw7sAnsh6n8rHnUUwg+xTvudXCU4yvOhcAFDzbeABU=;
    b=NIuR+50Zkn29+Oa3MK4HHaSwXfaNRqu0Q42AiesvueB9shP/SG2z/03A4E119II9Xt
    lflucqynIdCO4Bifb6uIKtoUYDBNxTXIWsL19F89SouOF9kIiuD+au+WeHDx8UFMQzyE
    njoJO5LERpwzXFK+I2TmdipR7UJ/Iz4ECcFo9ysveq6afLFdJJ53O4CRiWssY8miveHF
    AGlDWvLPdzxgrJsJ8RCK8sEfvGctJwsmn8J+/C+Qed3xr185Fsx4QgaUTDZN6TDyQ5gf
    Bf4Y56lC/pn+V3GzUfSrPYI1bYAuJiOWo1m2CQKAuo/41Ngoi902RoZUYQFTU75sPKUU
    rOfw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708526292;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Kiw7sAnsh6n8rHnUUwg+xTvudXCU4yvOhcAFDzbeABU=;
    b=WnL6F42nnKSH9gbtQ8gDzo/AZlSBr2Q+RKA5xDVelJ6+q6S5NEr2x2M5M6tFDJmFUo
    Pixlc6Crv7fEt+NEadCcxXc1yMAdY5VX76RPGD5y6U7zwkmDUyzl/NeL52U9lciPdiVh
    +++tfv7RSvBgWZeq+hBebdH1aZKuVWFctrP/DJ6lO1XLlxURdsOgJN864YJMkI0IYSnm
    ktiF37yhp7eKFsePnYX6x6bPCq7NNVgJSj6k1eviexAkloJJd0jQZKabDfs3ksF3ffW8
    eaudYRgfepkVsKxZAu7YkqhGe07oD9QxLstMxArwk8vIbzTyi/+KyPFt2NYUANTGmywz
    umKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708526292;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Kiw7sAnsh6n8rHnUUwg+xTvudXCU4yvOhcAFDzbeABU=;
    b=289aKcgAEnQjjLtvnkekJnaI8uOOwebsrVObWbyZDmU6iRbTFa8p9dQ+PAqthEVZb7
    ku5nnBe4jpuuV0D+yUBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USEbHoO0g=="
Received: from [IPV6:2a00:6020:4a8e:5010::923]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01LEcCELB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 21 Feb 2024 15:38:12 +0100 (CET)
Message-ID: <d4b3bc0b-95e3-470e-9993-a9f01a18364f@hartkopp.net>
Date: Wed, 21 Feb 2024 15:38:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: netlink: Fix TDCO calculation using the old data
 bittiming
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
 Maxime Jayat <maxime.jayat@mobile-devices.fr>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <40579c18-63c0-43a4-8d4c-f3a6c1c0b417@munic.io>
 <CAMZ6Rq+10m=yQ9Cc9gZQegwD=6iCU=s1r78+ogJ4PV0f5_s+tQ@mail.gmail.com>
 <54afa5e8-fb5e-4d90-8897-8f3c5a684418@hartkopp.net>
 <20240221-garden-petted-789304a1b1a5-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20240221-garden-petted-789304a1b1a5-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Marc,

On 21.02.24 15:24, Marc Kleine-Budde wrote:
> On 21.02.2024 15:14:02, Oliver Hartkopp wrote:
>> I have an old PCAN USB adapter (Classical CAN) which uses the pcan_usb
>> driver and wanted to set a 50kbit/s bitrate:
>>
>> ip link set can0 up txqueuelen 500 type can bitrate 50000 sjw 4
>>
>> First it complained about the SJW having a higher value than some phase-seg
>> value which was 2.
>>
>> Error: sjw: 4 greater than phase-seg2: 2.
>>
>> I always thought the driver automatically adapts the SJW value to the
>> highest possible and SJW=4 could always be set. Did this change at a certain
>> point?
> 
> Yes, that changed with b5a3d0864ee7 ("can: bittiming: can_sjw_check():
> check that SJW is not longer than either Phase Buffer Segment")
> 
> See discussion in https://lore.kernel.org/all/20220907103845.3929288-3-mkl@pengutronix.de/

Ok, thanks.

>> Anyway, then I reduced the given SJW value and the ip command did not give
>> any error message.
>>
>> But finally there was not CAN traffic possible with my "always working
>> setup".
>>
>> I'm running 6.8.0-rc4-00433-g92a355464776 from Linus' tree.
>>
>> Reverting this patch fixed my issue.
> 
> But what has the tdco calculation to do with non CAN-FD controllers?

Hm, I was using a Debian 6.1 kernel in between, which worked.

Then I booted my 6.8.0-rc4-00433-g92a355464776 again, reverted the patch 
and loaded the changed can-dev module by hand - which then also worked.

To double check now I was unloading the patched version and using the 
can-dev from /lib/modules again, also works ¯\_(ツ)_/¯

So, I'll have to make more investigations what really went wrong here.
I also was astonished about such CAN FD dependency.

Will come back with more info about my experienced issue.
So far please drop my blame for this patch.

Best regards,
Oliver


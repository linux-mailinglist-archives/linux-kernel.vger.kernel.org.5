Return-Path: <linux-kernel+bounces-13434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A783820694
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC0FB21279
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F498F5F;
	Sat, 30 Dec 2023 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tvWaz0mf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2A8BED;
	Sat, 30 Dec 2023 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703943398; x=1704548198; i=markus.elfring@web.de;
	bh=q+xMM/NgH5d7TuJc1tdVLKUPHj6VTivpdx+yAobBfvo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=tvWaz0mfO3j4OhKsNXSmCHQ/gG7MakVZJ+GMLFHMi+CVoYv53cCsf8dEqO708e6T
	 +Wj7NVD7POF4U+xSe2NKrVzjXnh0WArpRGPWewz69npV9QF2PupTkyYHbqC31HK/r
	 Se8LD+5F1N//xNsvmCpIwdbXALSKunEXZO1Av6dPLSEf6YTo2l4FDqMWK5PZZ02mO
	 sZItRIlXIAE1efdK4atAbJDnSzDKNwW8m00xLEpTPzlq8MjuvvWbmGBcA9IQ/TcQi
	 z34ZZySp5gaiGghdWCE+tlF68J6zwVIHIzjkfaoHTAQ5zWZEHT/dd9oPrlmAE6h7r
	 wJkSbVzuvS7/lQ/crw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpCqh-1qt2j32EZT-00qNj1; Sat, 30
 Dec 2023 14:36:38 +0100
Message-ID: <a3825ab2-8987-4b85-9db0-642035789c49@web.de>
Date: Sat, 30 Dec 2023 14:36:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scsi: ses: Move a label in ses_enclosure_data_process()
Content-Language: en-GB
To: James Bottomley <jejb@linux.ibm.com>, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <4616e325-e313-4078-9788-dd1e6e51b9e0@web.de>
 <9d24844f30604f969ac10da456801f594ce72f2d.camel@linux.ibm.com>
 <b65afa15-41e6-4d71-87bd-39fd688fa551@web.de>
 <a35c6128d4449fec00238c909e5f6f45ebf4bcba.camel@linux.ibm.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a35c6128d4449fec00238c909e5f6f45ebf4bcba.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D/HuRqdR5vqL+JG5RyJ5etFWIUnI7SJOtWGQiiXxY9rPjyAZwJe
 SEMQhkTtWj62LNmdBOpDSce68QJdjlRgmKlYX1Ybz4rD2sVw6ntK9UcxUaQ2/5o5hpVmWRh
 jrDc/CS+uF7XC07ea82ZRZ/RwOcp/enJZvpSmdfsM/NWWoVUmHoZV+x5wL0XKP+sTAC4a+Q
 +YnveLC93ajlmTeVcQa7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5UJyCjxbrcU=;r9spU924Fg/pPKmxs3Ci3gKTuYI
 xGLm3pAms5++4J9TkEM6sJfydLA9VEB+9656vNRU9/8NBpTfZxNDx98fpHVWQsNfkuT5wRc33
 pIJfN6WfhjHiY4UvknKfnCzIekPFv6vB0S4ubIw8uTa5SxGCMgkWazz5jJAVTKb5AUZ9Qolqo
 kGCLMjd7iBHQwkg6ygYMcbrk0vEL1/B+5eb88uQBpefMVt6HX5SkpIE51BS8mfEBXu10i7mb+
 zNknBW11nKH1ENTXeIe4wVZkfYcM1fcTxUt5It31OOfO11Q2n3fI4jPhJtZm+zJjjErKYsIWZ
 +LOpsa4FGrkzuO5Gvqez0EJOt0ou3pbbUlLG9cr5stNCPZfdmScr6AXKq0wkuBlzCB/xDxE+B
 w+QxsTNxGdDA2tGZfVzHoQBX/5meG+1bST4BU8Pyq05XtmzGCLL8CfuES53YRrtIfJ3D/giFg
 LVS/UBAoh8uyjLUsWU0JvBsSW8UDI4t7Zm2COiNU+XaLFaWMQaGKqO8CXltW0QcTm7MBDr5h/
 b1SiUOUsZ4NsaFmCEjgqScPxRqk14vf2I1YThZtV70didVMEGeDMM1FwNzXW6ZTHOQZRepqEm
 uCpwR7Kgvrfn/8c8vja0Xd20vf3cu1vG7EEj9/tm8U/Dj0iOItPayS4L0NZZWdzNt9mHAEqlZ
 NgfSYleHa4ZQnlz+U7NvEXK4iXTx2yjxLPDvfqgad1uWXbWVjAMhuJvQ7c4DvSvn0/mBWPfPt
 jkMMZPB1COd5z59TgkcvJBB2ruX/fmBRPVv+xDOC5om6n5oSG0gyT/HjpCW3nFhZtOaLt2rZS
 yoaEgmiGcLxGY13/EhuNB53ZhYzsJAcyavPa3gkWyAjSfcmkP9T26VggqYuOkVMuIl0hhowsk
 fsdS/qmRjECDvAEl0OmOjNFTek6lnvBPBnMcXIZf/feNwnZlC6e/L0T0r6ynQhNqDD1++Bnjg
 Ktt6rjoej662cV58CUI9P7lY7t0=

>> You probably know some advices from another information source.
>>
>> https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a=
+goto+chain+when+leaving+a+function+on+error+when+using+and+releasing+reso=
urces
>>
>
> Yes, but it's about using staged deallocation at the end of the
> function instead of in the if loops.  That's to *simplify* the exit
> chain and make the error legs less error prone because the teardown
> isn't repeated in if bodies.  It has no bearing on what you just tried
> to do.

I got the impression that there is a general conflict involved
according to different programming styles.


>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If coccinelle
>>> suddenly thinks this is a problem, it's coccinelle that needs
>>> fixing.
>>
>> This software tool can help to point source code places out for
>> further considerations. The search patterns are evolving accordingly.
>
> The pattern is wrong because kfree(NULL) exists as a teardown simplifica=
tion.

It might be convenient to view in this way.

If you would dare to follow advice from goto chains in a strict way,
I imagine that you can tend to stress the attention for more useful
data processing a bit more than such a redundant function call.

Regards,
Markus


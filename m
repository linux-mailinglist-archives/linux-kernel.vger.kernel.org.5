Return-Path: <linux-kernel+bounces-25449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6BA82D06B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 12:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923871C20A13
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 11:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747BD2100;
	Sun, 14 Jan 2024 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="UiCNCxTE"
Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85B77E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1705231078; bh=PPUeWA3hsgKvXXfk+8EK6nK6N40f1RHcnTddCLgPkz8=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=UiCNCxTETCEVuP3tWpeGBaJO06XY7iHoDSyaCVqbA/4mGI1M72ryLW7+09yUR+wwezf2lKYjIJ9QnzU3io1wT8tsoupMUDkjJ11Z9XKvqDSxi1vZfI1PmAMopXlgiFWlwIeUr0Brk8gehBNpstByzHa0oi2BjrxO4Xfzz0nRlmV+ZY94CiVeqd18P5Miolf/5zzI1FzGV+7Sx53COX583c/LO+dshE2OzaacnQQVhoXi/87us8P760zDq6y6a2wc5+e1W65fi32doSphd6gYusxwtc+7WH8Cxe+b2cDVmRlKgZtYbYQn0IRQ3EYCX0+1WailGN2m4i+N/xOl7tOL3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705231078; bh=y59RtRxc6xwc8c3SWC2EdcnsS/EQv4dqB3DsB/uj4mz=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=EF5RWZEIx6fslVbhFCvYXiwIbgwIhVfYqJtPXls0/Pt3HkXokTXli6LbSUk29yTDVidzhmyLJnTOygj+j+RebEp/C1+h/lx1W88zZ9nQvD3HP+UniVdqmazAHAy5dBIV3DFLbLMTQ+JLYJ2zWwARavKY5pPMNwmxsow6TbB7nUi2AIVicYajhzLxlYb0kpK7xKUGAcqjcT8dWmGUG4B2SulMLYI31o2KDS8vOLf+0QTu3n7K3t5ctgZchR4IJOoDBVG0PQEEc4U51ALIkj6weN+A2Ptx/tNhb8Mz+MFtzfkO8bF+LudWVJ+gMB3osN0v56U4O4Tq9k929xWEU21wrg==
X-YMail-OSG: th6FXykVM1kTy4u3VPZQ4UpX.9CUE1iQQW.hFM_o9gNradz4O26VgxNgil.Fdbe
 .6lb4k3xZkfTeE502fnVPmc6d7iMCr7uw7qBhaswC6A1fMHOZIi1SmzpxYDpq8e8mxdf9aJ6G1mL
 vXQuGjIQ9RDRUAsUEmxfJ2CbUcyFSnV1KtEx4262mHZW3781jqidd88IM3PndYB92O6vpmhcdg4t
 lCnTdaQuJkppJhGPvOgb0khpff7kN5fXUc_0Dws3BKSXTXXvLr09S2W9e1Ype_Zyz0urcq8aZvnj
 g3_uyzyui5_FU9xtDKQ6aSBZrimALu.m6VmDqm.2rZdkwVNBFKFk4uQHts3KjmQc1RV1_7WBdP6c
 No7lYQfJ6y9fNj02euZn0xJ2Z9ww9mbcd_o60WbT0.exmsiMI8vlwVxiJh2PXf5d5m9WXTm6KveR
 UeIJiCNnnvFQiK88RV0kNhbRUZA7fIp5d99JZFIY0YkYYSldyym53SD05K_sbZY6uUNogXWFYibx
 OxNmaBE_L.VfIxVRavUbiWMlLAsiQr_Z0rdyFTjkX5zGEuz3L87flt33YDvwxQlopyg9IQl3br5D
 MbJpbr5BBj4BEKEpx00dV59I5G9gJ8CoRbg_Wq3Ay42htBlenTjNkAu2ceZRa2T4Pf3rqCR5pYZ.
 oRpiIphgoePb20pp8JMOnbtLcl2W6unqDDvV3mv2p_k5oeE.jaE2UNu6xLZlmbYnEFY4uIOmdDeM
 PFDDPBonhZJHFQrD4XXjddYZthSbDGRZhqHnSnQiaJ0.DljfSEmuR7WS6OfjKfBpa07VEb8psyvU
 gWlVaC.7CjbZkmKeRDQnZBPSlYwxNc0IGwHKoqjzWnVemtSEnpfR_ax8jIpn6F3FXvUn0v5mLaII
 27GcA12glp6GSFILjAH7ePaKfgyd37pJ1lxHvdL1_uiUgjk.821FZaaLwBMeFEKIXMIue2oqMia1
 tks4JW_1WFFM4tIBZe6WRO8yQ.4zPTVJHaV5c7PILD7979dm0PupKZER03PfYUzT_Hvr74ppJ03P
 LLKANd9YXkP1Lqq6IzBK9_CW6lpGz0B1jprWaeKOgdB69IFMiCg4KQ44GieUAYMQ6D3tWUYEik2T
 jLMjemDD.RYQNm94uLOP4MJfMbLsYBZI5Hl9PM0DVOVEHw3U58JWF7mNVihkeTsNlApl0yC9Of3A
 5U3YddcU5pextZKT2NiEC9XR09ceAm9Ay_fcJQ20BSb2Di5hmLxH6Z.gPMQXRueKLg4yqAc0nPWy
 zCCtB0DCWpuw9K3FVT6D4Tsz8e1QLKElw4msBM6Z1prfYtxeWCdt7ANZ9RjQ93376rjrh16msgN2
 IPfbcnHW4Ba.Fnx0rRYtTchuoLQQkRrlgYSjaloUThX6pw6s0OclcUYOpNxjygShJFeVPG_p0zwK
 hWwOgjv93dDia.UBbuzNPwfy30BYU0YgRvt8xjnwqaazCoyJGVqpFNCaJDozDUVMd69AHogayJyV
 jqU8RZNaeb1gMTUzfuzqlLDx7q1cYf3QZuGJXSzAbqg0va3qhj79bykOc8Pj32f4QnnOydP4VgEu
 OZBwjUfpDNg4scVW1j3PG2QtnEvL5hfFp3NrkSEo.hJVmXfTBgkZFV_oJ5EAnKl.Ym39iui1H.sp
 wbLcI6dytSiWg7D6WUG4EVcK0behliJs9hQRjgMBkQnA58WPXpZYsc7CW0kRRxWtfx8FLR8xh8tH
 GSa3fSyhVJY2MnoX68vFFzmHPumrno4oBctPvYdGEk6tPf7wwXv6m27EuAL9loF8CmWiOAx4F4bF
 GxRWl.dYKKn8N1EX4kHjlNJidE6z4znUVhGWkXBJfD5Z8z.nIy3RrCMBOVE1_NcetC5eogg.sPH0
 Hiq6R4pYn1DdE1E9.y4Ch.0sH0cXoNTZb0yYf86yx95VWNF9OmjinCfKLfe6r8n1GxwunWr4cK9f
 b0a5WzxC5SshFWXZq8eWYSm6l_M4pO5yMAKAmEu4Bcl0yr9MPfzI5WqcZXTaydGedFxVMSG7g3LD
 hBUOvtFYf87etfubShVnopMzEmj1B07A6MP8XTjM0Z26VOK3MLj3qSEx9daSxLgWa1PMGi6Yhm9s
 5BJ0MmglMAf4kn1F9jNbc_b.2_SicM1POe5LrJJqu7rtdtEsEEtwg4TTPl40r3n9ao8i19nxZCv1
 o8GhogDQzb.tCUmNcg8fvQZoSJd4zE7h8ofrtPMpFkJqfaHeza1Sf6oHM_rH7pEbe6u_KUkziaSt
 a7eOSiUF7Nog-
X-Sonic-MF: <hkopp22@yahoo.de>
X-Sonic-ID: 91b2a64e-0248-42fe-a33f-4a6d1369e878
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 Jan 2024 11:17:58 +0000
Received: by hermes--production-ir2-7cc8d8ff75-p5cgp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2b92f031ec94ccfe06fcd93c95fb275f;
          Sun, 14 Jan 2024 11:17:55 +0000 (UTC)
Message-ID: <0219492d-3971-f8e0-8b46-22d442a2d442@yahoo.de>
Date: Sun, 14 Jan 2024 12:20:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: "Dr. Henning Kopp" <hkopp22@yahoo.de>
Subject: Why does Linux not implement pthread_suspend() and pthread_resume()?
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
References: <0219492d-3971-f8e0-8b46-22d442a2d442.ref@yahoo.de>
X-Mailer: WebService/1.1.22010 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi everyone,

I have a question regarding pthreads. In particular, I was wondering why 
there is no way to suspend and resume a thread in Linux.

In Windows, there is SuspendThread() and ResumeThread() from 
processthreadsapi.h. However in Linux, there does not seem to be a 
similar function in pthread.h.

When researching this issue i found multiple ways to work around the 
inability of suspending a thread, such as using mutexes. But my question 
is why nobody bothered implementing suspending/resuming threads.

I found one answer on stackoverflow [1] that mentions that 
pthread_suspend and pthread_resume_np is in the "Unix specification", 
but not implemented in Linux. I tried to follow up on this hint and get 
access to the Posix spec, but i am not affiliated with a university 
anymore, so i was unable to download the spec.

I read "man 7 pthreads". It mentions that there are two Linux 
implementations of Posix threads, that differ in some details from the 
Posix spec. However, it does not mention suspending or resuming threads 
at all.

I hope this is the right mailing list for my question. If it is 
off-topic, please accept my apologies.

So my question is: What is the reason that Linux does not implement 
functions for suspending and resuming threads?


Best regards
Henning


[1] 
https://stackoverflow.com/questions/11468333/linux-threads-suspend-resume/13399592#13399592 



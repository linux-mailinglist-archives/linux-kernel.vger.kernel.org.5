Return-Path: <linux-kernel+bounces-87854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2314F86D9FB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03518B20F58
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B3440863;
	Fri,  1 Mar 2024 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BMQ+bo5S"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA52BAE7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709263194; cv=none; b=SojCA+7sXdGACokDOckQBs3jc811vdKewihAdjM82H6UVmZmvOXrBpd4P9LzSun+49UjFfqsb+4xNXspSiEsDNTNkGFw3qkcf8ve1Z6NDPfVT3PQFQncz02IN43rKousHEn9LWQx+X9QlM/BEojmT7nVlw+v+hP5mM62Lr6H5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709263194; c=relaxed/simple;
	bh=8Muyc6Um08RJ7A0Vo91puVkqXNvR2U9O3zdpcDdYisc=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=aTo6vmOsgeeE2Bi9FtdIK04u/K6frSvrc7dScgvjnEeaf0oVIawECTpyRBDQcI9FXMs5L9Gz2IULRaZw+FQB2YRUbZpfOrqhFJTTStJwmjg2lULAei05ZsG65oZgbQjTr/zeS2DpQO/A6AfpoWJEpntKkwfjYBgONCgaaUfM7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BMQ+bo5S; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709263184;
	bh=eTqdWEieWXN7Ey3lgxJq/owsvh9NFXl/ga6sNC6fBzA=;
	h=Date:From:To:Subject;
	b=BMQ+bo5SPB8ilSVMYIsbbXgxK8LvNNyIeLHpgkzNoKCMebkzUp+F3iz/Y5VxAMIKd
	 YvvIhLcb8Kb+M9DnMSYI2nTeEo+RKeiGDhktIxp2cPYE5hP49Z2qF+suO0LZ00hokx
	 15to2guTQOwB8ROP7vAyGjmCY453gey2h01fNkM8=
Received: from localhost ([2409:895a:d8a2:3cd9:f2cc:45bd:3cb3:44dc])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 4EA98C80; Fri, 01 Mar 2024 11:19:42 +0800
X-QQ-mid: xmsmtpt1709263182t6qymyugd
Message-ID: <tencent_C5266B7D6F024A916BCA7833FDEA94A74309@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0am2DN7ke1ViPnixzWQWO/U8Nc0q3kbflC4g+olGa45MUaq559P2
	 S6VfDlARZfhosgPiGQcZUgJSaWyeGDl7SMvdmnf/bamfbw4GYh9E0jK/1sTpMUBD0gyWQSOZEp9A
	 7JulwGm5aZEDFD15NpEP7b/6R0VMlr/ZgoweNPMVPFVQaf6OHftkqHZB7zpHTOdKxzuKDFDtcboR
	 AiOTKL2o1Wktx4QhX0y7gIlzGsb/Ch4ynPFwz9hz0fRvx8JbtimgGhoyYXBc2e7ttThcdFbAUjxF
	 kHd6Xp5m8++paYtPYd2fh4HtaALQ8qK0gLO0Y0ue5cLFwkHoyqinbAxBpsQQUQg3PibCt/lMIaWG
	 FWvYDCnbvu9rjej7U/jPliHXiWik/tDKMvUozawIiNrg/6dyoidicRbjfO5BREcIXomcxy+E8ceO
	 PIvjXnOfVjHiOWbX5ZR1TpArWTp7baoVJtGPKIRs5UHG0s6ulnPBT2cPMKsv5+FEmNthMa/CGM0/
	 cdQTEvVVDtk1rNwaEcRYsxwFyGJUPKe8zoIsx+f0yxettH8ZOOP+G6MA6OrTalH5Q9C5GON8wKrK
	 ReZzP6TVIDvBuL4GhEhaWYfMVBfhp22DUiKEQJRfl3PI+Iz9doMp4AEJp+5c3HK2I1fj6zGbqmrN
	 AKnTOBaKU6HkADHmaB6iC9VLBb+j1/QafKD6+UllOTbgu04F/HEeoXniyjOtzbynq1xhMTWQgIVa
	 t6Dpgc0SNYfHH3cmMbhLMTsA+1qvad6yCzPZcD02UEIB2DEDrAF8Xqp+tuFSP7vYwov4bXgbO/rs
	 Z+w9XFIvHUDgBEvYhuxEArICB46Skiz6a3lA/ISpZAMdZXJS5h5EGLSeTLk1RSQI5LytEfaBGW22
	 wg+AIQRJUDfS0l/9ehatP19OgZcjBm2PYwkaIVrI5Tf3oXEtOluCmLUj20amd1neaFhOGs/G0E
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
Sender: kenneth-lee-2012@foxmail.com
Date: Fri, 1 Mar 2024 11:18:39 +0800
From: Kenneth-Lee-2012@foxmail.com
To: linux-kernel@vger.kernel.org
Subject: Question about PB rule of LKMM
X-OQ-MSGID: <20240301031839.ooe6da2wvbpl7ukq@kllt01>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, there,

I'm new to LKMM. May I ask a may-be-stupid question?

In the LKMM document, it said the pb link:

   E ->coe W ->cumul-fence* X ->rfe? Y ->strong-fence Z ->hb* F

can make sure E execute before F. But the cat file define pb as follow:

  let pb = prop ; strong-fence ; hb* ; [Marked]
  acyclic pb as propagation

So the acyclic rule is only on pb relationshit itself. So it won't
forbid F -rfe-> E, will it? It only forgit F -pb-> E. So how can
propagation rule ensure E execute before F?
  
Can anyone explain this? Thank you in advance.

- Kenneth Lee



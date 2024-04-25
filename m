Return-Path: <linux-kernel+bounces-158219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10488B1D21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988B51F21D39
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8422581211;
	Thu, 25 Apr 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dIfdBXPI"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D377F486;
	Thu, 25 Apr 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035174; cv=none; b=aYGpJc6AmtUGwE+Vl/bGXKhjbCz/r1/BBjFVKIfTcA4outpucsnb8oGfdx7WO+krrmVRJag3LV4EaitOHTaJ/7aLSqRGIMWtgsPuQPlLKVncDrhvREyvC1yHSPR0E+bMAdSbYYYAYhTnDcpU1de5xx12kmZ26BiEPpqyuxFv3WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035174; c=relaxed/simple;
	bh=2ii76LUBj9Ob19+f2whv+RVZumtvMFFoj0WwOmyLIt0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ao5sl5IWpyoDek6F6JF+utecVMQCIUsmDzAT0xk/pvp/QYfwIg71IfJ4EQs/FMhNcEmpt5/HWnrcpEaqdOzCYv6HltYDkyQ90JMtos+7zlwTi6wl/iXoioI0QEid6C8flc8PDcY6PuyDb2TP4Bl5lZPhS76Qo6on+G8p9tG3USs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dIfdBXPI; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714035117; x=1714639917; i=markus.elfring@web.de;
	bh=2ii76LUBj9Ob19+f2whv+RVZumtvMFFoj0WwOmyLIt0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dIfdBXPIujAhwTh6VZnWtncvA1XWiKqV9vpmVx6mtVKkAZ7C8ihefH1HCRvrH5ep
	 I+sZZEO/50ZvJcBLfa9cg1dIuGapn7oIVC/UKYrWQT9fJlUQGqisN3JMVLrsS2k8C
	 lxYiUrwi4R9M9J1/J9KJnFryPFEZgCzK/PvUXqBa55tzsBGo3ttIqzqMS47M0YmFU
	 XjsufLLyLN9ZdVyHpVCPqJIIwFqgrBOkPrzMnZKGzk2F0NPOkJP2zBAHXHkUF/wI9
	 /203G0Qb5/JOkJdR/f/1VFCLWJU5VZKDahErizDNM9HMhGZYoXoivB/ENICtwOG+W
	 gYjApMmG+MBiuJNjIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRW2D-1sNLPF40Qf-00NUmb; Thu, 25
 Apr 2024 10:51:57 +0200
Message-ID: <6e028bfa-9063-42ac-b40f-cf17a81c2af2@web.de>
Date: Thu, 25 Apr 2024 10:51:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Jameson Thies <jthies@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benson Leung <bleung@google.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Prashant Malani <pmalani@chromium.org>,
 Rajaram Regupathy <rajaram.regupathy@intel.com>,
 Saranya Gopal <saranya.gopal@intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20240424014821.4154159-2-jthies@google.com>
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Fix null deref in trace
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240424014821.4154159-2-jthies@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MWIAd9tfE9Cl5DWSBlawdxc9rLXN4r3w9oVfMsROo9DFxAP9QSb
 dAN5xhx39A6eJxpcr09q4YAV5nIQda6BWSBQrr3iHiQ9Y6JZm0SFInuOSpWh/yELwxqOoob
 9yiOlZC1rEZLPD//da/dOOGv0mPtYh2Q+7Quv9Zzg6a2dDM8q2XN3iutK6lkbuRhoLxDduv
 Dovre41suigX1sdGsANlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:82+JCbADl/Q=;8624TNLGloARLOYQ/BOLV+yGdVj
 tRYpiSQQIjL3i73JQ6pzaVWf4ROTq73TDcxAFVMTQivqidd3asU5pIHmHYQ21sgSYa2DWuM1u
 Ask9GZR9uCK5j43oaBoHQmvv2kWliElxtpcOMlZe1ZdXTaAudOnLQGewybrzEV7Av44h0qh9J
 UG54OdL/iJwJP4UcwgwN0AKGTf7GCAWd5LKEDrYpAY/5HmMqegr4x6WUb8XhNJJaXIIA1g5+L
 asGyFg2JlK6QcAkMa6n4fOWhNXjyGjgkhM1OpR/jQaskTU+xIuyLqppuGLKCnbE1yIUTolRyO
 ETCHoNDJDJJkcdnmlQ4J/R+y/aDC7ieB5LVLzJURXLmyjCK+UtYcQ/bnPrjaoljlsK7kIoVEx
 6qqtnmvq0VovcVOWntybaAu89CdGzsZ0BKCcGjMk1tHV3ZYtbwk8YSPXQQft1nxV1wCKSBg0r
 NNVR2gB4LFQkgtV0SMk5GGgRnI0//fxAO+Zb/cukiRXpXgqgyyQC99CjxQ1daa4kEPTXxDcz/
 iOAIev88+eyHDm23vE3vGj11niorw5Xn34hsnCc/sHBbeDbr6IvZcIVQg9CnVcwXGYTOULCSp
 j4kCYRCah/NPB1B1wHa6re98hlx7vmblpTn3QXXD1J6i3EfXch2X193YY5EBJ9kg0OCaOGrKh
 ld+zLLhNeRMAlExFy5EUOTxSW+0anFoKlmXp17hTPHuEVH/G8Rc9BpVjWwmP0qB3jLIRMlH9A
 TYlmjYdkTH/22/XwVSbc+NqcwFl2Pr5zv6Xnd19LbOl4ZmExDVvdDk5Qq16Um3oSLCjaMsrAA
 k6gea/TJZQ0IAvFXJQuTYftUJZTX+oALHCqiquNotVzQ8=

=E2=80=A6
> ucsi_register_altmode checks IS_ERR on returned pointer and treats
> NULL as valid. This results in a null deref when
> trace_ucsi_register_altmode is called.
=E2=80=A6

Can it be nicer to use the term =E2=80=9Cnull pointer dereference=E2=80=9D=
 for
the commit message here?

Regards,
Markus


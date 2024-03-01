Return-Path: <linux-kernel+bounces-88691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59D86E569
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0AD1F25C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD4371EB0;
	Fri,  1 Mar 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZQvK6iOT"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2871B43;
	Fri,  1 Mar 2024 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310246; cv=none; b=pF1dHwa6ywz0E2RYrXaHtW4/sKCMYi5M69hbRI4W3NVGdcBJymwKJqrgkcxgcw0IqUfS4ERsaKOiLGsG+ZbrY4kDjUydBmvU6bKUkmBY/naLxL/vxXW9rUbvegAo9L7tZhDRNZ5Kyrx5UhBR8d5yd8Zgt3f/+visiomWxuMT4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310246; c=relaxed/simple;
	bh=nq+dTB9sZf2knTv8a3VS+AYoILhfpagAL7MZwhJ2pmE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VBQlQXXa3JkzLOvAydCY9Kj5BIqRsbVH3WxY5wpVtFr6AvVuwUhrxpB9XoqlQkR80vgazH4FVbeluOsUrJ09ewyP0ft+Tc1kyp0M1eeDQqs+1mzuarkbgi9ZIho4MO9KKUAB2wDVken7KaklYwA9sC98590bXyNsflOhw0nyQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZQvK6iOT; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709310212; x=1709915012; i=markus.elfring@web.de;
	bh=nq+dTB9sZf2knTv8a3VS+AYoILhfpagAL7MZwhJ2pmE=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=ZQvK6iOT+bO4tPhYEnabsP9Xu4NuWKZALwGjgVtKfDNkBimaFc1j75CeTokSIHMX
	 TA7lfeNKK8zYRfMu6CfukWcyWBYTQ8pjL07uhrn9xzb7/qxGWgYA5oJeTf1OMX4lg
	 IBI/NNjcV4ooxaF+sVo2kKm8GR7TbYeOvpPkQ7SzrBiN7cBwKNCMurfiEiLDTAbic
	 XhE55G+pyxzYVDqx64R4vJ5MsnZ0ANCIV250WNE1ylhXo48WiH8JaW+eDP7g7QGoM
	 4R2M7H9eiPty88Gb7IwLop/KAOvrbunEbqGaVYNfD9SMZusNJ+98rvYHhgkwvtrdH
	 JSAzTrsoyEiDUWg0dw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKMA7-1rRbDv0YaF-00LuRI; Fri, 01
 Mar 2024 17:23:32 +0100
Message-ID: <0b89e175-47da-4e66-bb3b-a45a400dc3ae@web.de>
Date: Fri, 1 Mar 2024 17:23:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 RD Babiera <rdbabiera@google.com>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Yu Zhe <yuzhe@nfschina.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] usb: typec: fusb302: Use common error handling code in
 fusb302_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o7GcYrUfVXrYS2ZCPe02m7WMplSN24/yNpO+Dv2Zv7dcHv5XFlE
 15XhwzGS0OyPzBxck2FX65wbryPxGYv3vLUpqdTi9n/qNhVWghgdTzOnkgLnDYrXgAm+CWf
 0nxH0Fd4Or8KrPaAKyLXSVrwDdNdRuwYoMHLq1WH4Hpf0ZAXdEepTBfgsyUqYvo95B/hs6c
 R2wFjcDaj9Bu41DxZWCOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XMDho9cx+UU=;b58AOzK5r9e5ujBhpUnW+QTrDF0
 af00PfU+SJcQuUSRd2WXaqjA+9JhPY62tJ4czPaQZZEyNSnF2r8A1cMYCB0OqjEWN8x/UbKHR
 n/EI4JZOhELQcvnF+IScPTH/dwEV31E4iUIdolKQGsdkVRc8IKsaRXykZPpFkDerl3QrRzTAq
 1jApWXH7esPKjcqzaL7/Frn4Itj4TX/IVcbZDdifgN6fw+WB78D491AvPyZ72AbnaFBw3sUjv
 /4dLAcANQAoZmlP/JldAfoIQfYTRhHN1t0mUTrKCGP+XfjDIIdf7MlG6P/KikWWSndqNjr9jx
 Qcc4VUVXcJOfp0+qLuAxGo5G/VbygPezXoU/tpwnbYmUWWKKAxnLpDoSA7h4dta9J5kWGQ9Te
 sNydATeYIJh1hkc1GvMs16cYD52RtLjNgCxwWJp5AAk+jVRR7fddVl4ZrUWOCHu6UBqIMiIr3
 bdD55UqrmL+3AxZJvmzkP0OQ8Dz/OTkKObNv9XuSbAcw+xKKeEAHclXgMZUuTp2P1EHk1ZsMH
 wi1OzpMqvOFSiyjeaZEDJdf8IzerMZ4ZEyexnrOMZ2l7gDWwoH148dj4ULoTPEa9fWxNGUeZK
 kTgzbIhi3OhlSSilbqbpnTff6D41V2yRE4QxuvSQH1LsaQUMy6WORheU/hMglm5OtWprF4ch5
 vzfLJZeJtMMYJ9TqZBOI9HwE5r/PYTIHoWCoR4dZlfLvAIpZtgzZ/Pcn9cr67J46y4BP08F53
 i+SnzS6GokXepWVkqZlIYmOsHUgzqAio9QZRn2UxBW4vXB4vOzsl1s+DoADgQRaJIcOB5JgYl
 9VAVFqnlB11s4d2rF41EguskBOHPbEv56nRxIZJbYfXvY=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 1 Mar 2024 17:00:23 +0100

Add a label so that a bit of exception handling can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/usb/typec/tcpm/fusb302.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fus=
b302.c
index ef18a448b740..e1e030da1dec 100644
=2D-- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1741,10 +1741,9 @@ static int fusb302_probe(struct i2c_client *client)

 	chip->tcpm_port =3D tcpm_register_port(&client->dev, &chip->tcpc_dev);
 	if (IS_ERR(chip->tcpm_port)) {
-		fwnode_handle_put(chip->tcpc_dev.fwnode);
 		ret =3D dev_err_probe(dev, PTR_ERR(chip->tcpm_port),
 				    "cannot register tcpm port\n");
-		goto destroy_workqueue;
+		goto put_fwnode;
 	}

 	ret =3D request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
@@ -1761,6 +1760,7 @@ static int fusb302_probe(struct i2c_client *client)

 tcpm_unregister_port:
 	tcpm_unregister_port(chip->tcpm_port);
+put_fwnode:
 	fwnode_handle_put(chip->tcpc_dev.fwnode);
 destroy_workqueue:
 	fusb302_debugfs_exit(chip);
=2D-
2.44.0



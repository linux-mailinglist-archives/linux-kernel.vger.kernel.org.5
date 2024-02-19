Return-Path: <linux-kernel+bounces-71634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581C285A811
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE801F2324F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25113B1B2;
	Mon, 19 Feb 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G7p+DA6p"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E238DCA;
	Mon, 19 Feb 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358576; cv=none; b=sxefDSlvxztgrVTS3w58KVX0XSJ2BaqnFlD0NA7vpwKUfLpfcAQwGzIK7qUPzeOcB+AKc1ZmCs2+UFy+6J3POAW9Ngq0N0eopVeMHc3C0MyjCYAcrwp3UTVf9m6eldduji3xpxFu3BNDvmSTBMiF8Q4zJ74fQOnFMUlP64mhTWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358576; c=relaxed/simple;
	bh=cncWoi+d1RGf/a5S4CtVXG7UuuYdV2+VdmehADA5xXk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=b5I3+3/U5KfoDB6F8XUVdOxttehHZFdQns3IQ3b9vifMHY6qNjJ6OUqpyXONaiEJqOsTG9Uvkowm+nK7RnesL9qwlo4SXvZSwgUAL1eXTegcVJp5DrZ0sst64iMa64MUqJ2Q0j3XP1MlAuwNlkM9mBqTu7UeqLgZLPaQPqYYt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=G7p+DA6p; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708358571; x=1708963371; i=markus.elfring@web.de;
	bh=cncWoi+d1RGf/a5S4CtVXG7UuuYdV2+VdmehADA5xXk=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=G7p+DA6pcKaXx9Q3Y1diEzbjVjOtnwcyy802tGFqUgUfgH/GNrKDPjWmXsk5tmDM
	 2A2Jaka6hBuQVRWC2spH5I8cAuEvWftG4tSV+PPMSn0elJoD59BNmtwxpxO26DPXX
	 O4FDtdvyZq3eyPV693YvA/MHMZR/u5Ni3o8JrcgwGkHeShtcp43fETR70wWVJmoE/
	 Yq/N1bVRgOSxo4KiT2MZXHm9YqiaBLiVl4wkzgMB/7VRbSOfkt0v9t4NJZGrk4n5O
	 n37CsQQyhwFv8mM+tCFdrFH1trskuNz4cvODPvWgSzwmnfSuhvVlXZQ77QQO0Toym
	 JGYuFys8ZSgBurBBtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43KW-1rc6171ZZ2-00022S; Mon, 19
 Feb 2024 16:57:17 +0100
Message-ID: <9427c0fd-f48a-4104-ac7e-2929be3562af@web.de>
Date: Mon, 19 Feb 2024 16:57:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Niklas Cassel <cassel@kernel.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Michal Simek <michal.simek@amd.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, git@amd.com
References: <ZdMp+QBiays6fprk@x1-carbon>
Subject: Re: [PATCH v3] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZdMp+QBiays6fprk@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9aWKjUNLAvFXdNdeXmCqi+CsGU2Divcei5WtZvrpJavhTUscivm
 55foQ1f/sOC7AxbquVlmIOkb+6d0GcrDsQ+zcY5d5PeOZwe/njLFetb5RygpGkMfcKRyBsZ
 1xxlUZwuf9eP6S8WizF73OVcoZBLhHC949XKxW/fHQth9pvUsRQRm4XC3BKVoyGePBf/3er
 7WpFHOMHyXIeqwEyM/jCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z5xuQVR5D3s=;KNcmfynmW+sNHysCEHwpCQStPRZ
 pdnqcgbpuIgdUNxYxMSLajE01VRdbF+HGWWtdFHjwBd0Z6h1B+DmhyhU3LnxLQXgNlWxq3h6e
 4NfopGQNzZd6iaaEJ9LKOA9w3tI+OkihBR8HTlyTfnEBijfjWJDckglN0yZFRmJtAhTAMHi/8
 gJu3uADKqqDUCFdOkBNBfip7YQtF4sE3l5WJvpFTuyA5vXpJbkqxq20VzGi0s6BlQzQKmfPTj
 GKBCBjGQQcolZM52h3HWHJlDCcP9EyFHOCKRRUIIFUkWbuueFFzB/rUeI9StMEMPkqdNSXOwP
 1wSfbJWLXU5cz88oIvgv9WPbUsN07l7dgIFIBzxUzTL9gfoqU5PK4sUSXyECWwh9TH4msvjDl
 RylTWLsquVGe/uUNaHpSgMeWGN+A/ZM4LchUzoCe8Elok1KGAN/uJEmgoRNuX8k12+JgIcRfT
 qutvdDWPDT8lcD7P3ULplJuE6iS9p3pJZPfKU7263deybEwL62UHPDo/ncGHAMUSrpIbpjKbY
 QNMRJ6Zx171tK9DbdU+NI5MO5X+iIqqeetXF9x3QEmLR/lVQRTMgdWeOj9uHnuuQTemm/4l96
 EudWJ1LAYLHwJSXs4nLOW7psAWm7UZAwPG8dX5SZJwFCRjGYhwVKQfbg6IN0fJYhT6har5lQR
 6DMZijbRT367FPzsBSm5ngz/iAJ0vq7cQcMG4RP5f5Viso/eSzWIJtvFtn2ETM7jwQ8rKtKWm
 ulhXHNH6OA86NC+RJaQuofeLCihE0oKJvWfVkUbOzEGmmdIVhpichQEwC5X3bV7BB4ZvIejyQ
 3fhXmJJOjWtlYVH08b47kaQvfxSb0OcKPnb9e/DPsI+Jo=

> > Platform clock and phy error resources are not cleaned up in Xilinx GT=
 PHY
> > error path.
> >
> > To fix introduce the function ceva_ahci_platform_enable_resources()
=E2=80=A6
> Applied:
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=
=3Dfor-6.8-fixes

The error code =E2=80=9C-EINVAL=E2=80=9D was set before the statement =E2=
=80=9Cgoto disable_resources=E2=80=9D
multiple times in the adjusted implementation of the function =E2=80=9Ccev=
a_ahci_probe=E2=80=9D.
I suggest to add a jump target so that a bit of exception handling
can be better reused at the end of this function.


How do you think about to apply the following script for the semantic
patch language (Coccinelle software) accordingly?


@replacement1@
identifier rc;
@@
 <+...
 if (...)
 {
    ... when !=3D rc
-   rc =3D -EINVAL;
    goto
-        disable_resources
+        e_inval
    ;
 }
 ...+>
 return 0;
+
+e_inval:
+rc =3D -EINVAL;
 disable_resources:
 ahci_platform_disable_resources(hpriv);

@replacement2 disable neg_if, drop_else@
identifier replacement1.rc;
statement is;
@@
 if (...)
    is
 else
 {
    ... when !=3D rc
-   rc =3D -EINVAL;
    goto
-        disable_resources
+        e_inval
    ;
 }


Regards,
Markus


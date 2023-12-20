Return-Path: <linux-kernel+bounces-7187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1994881A2F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4B71C23B90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD9840BF2;
	Wed, 20 Dec 2023 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FqFNtAdX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE640BE8;
	Wed, 20 Dec 2023 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703087145; x=1703691945; i=markus.elfring@web.de;
	bh=y9/SF/RlbFa6tJGr2SNUeo6dSgsWOw7zO6EMmsQosaY=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=FqFNtAdXBaDNocXhGLCcukoUjH6Py3e6U1axwjxwT3ekIuncVMrDQWYvXu1F7FRE
	 sbiX6DBs5fAZhe4FCKtJ44hH/e9vPeCPIxOxT7zLAysefxYyFCz984qhj91zQ+f6H
	 Z7ROAT8ka03gwhw51G5kftKVNctx4R2dYwT3X36lcWjfchpV0DYn6iAt5SOZFrwEm
	 drgmoegLG/75cHsw3xBb1E7i6gq1BTDwAvy8NPcMqZ8GQ8oF3oanM1XrROSDBaF9X
	 sanvs102YCO+0XBCH6utw+h2QrR6BtmX6Rb2buSO1hgc971XeHFlOtJyGpNHiASK4
	 KYkCDo0KqabzRIHDcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mho0A-1qlKun2pJw-00dyvj; Wed, 20
 Dec 2023 16:45:45 +0100
Message-ID: <f55fa198-6a3f-4fa9-8633-e9557055d784@web.de>
Date: Wed, 20 Dec 2023 16:45:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
 linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Avadhut Naik <avadhut.naik@amd.com>,
 John Allen <john.allen@amd.com>, Muralidhara M K <muralidhara.mk@amd.com>,
 Tony Luck <tony.luck@intel.com>, William Roche <william.roche@oracle.com>
References: <20231218190406.27479-2-yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 1/3] RAS: Introduce AMD Address Translation Library
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231218190406.27479-2-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I5sQTZH+KKLnMclZnQxi8hZyHH/nG3eF43/591+yxQP4SptVF0B
 bLykw5Ge0CU30i5wHTOc6SRsUee6XUhiMZyj6UwguICE3EB1Y1XZqNNyTN6NlTK+iG8h6s/
 jWn6VpLKdULU9ec9RKVbtmJ46et8b3qPRL7tBOsK7gcxwlyMbvTBuG2+wBGaguEoO+zRkYW
 4py+yq34vUehYUFnzKjyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0kCr/Ov+mKA=;ltTillqJmpXYVa64om7RWVan0VJ
 rJIKNy6v//3qtuDqMIL/hX1YrLQT62DkDtYHevo+cnFog7C8k2SEhWviOzEGPgurcQk2p49yM
 0Wp4JhU5Cuf0nq1gJdIC7WUpkOUXNivQqZFEYpLL/ZDyaQK+ncxU5WFoyqbcYAsqzPBgSk+2W
 dWmvErgpyqu7PwEcFVxiiCdlNfFjWv25bH+YgKPhlKmSnY5m22GPOvs+KjoXA2yrK2pYje7mD
 fvC+ePuViv+RUfvQegpwebs0sU56808AJ32lDi7K+DRD4WzmgMiaSuQ4XHtaq3uYBpCWp9tX1
 qGIieTB1i8641N5X3j4pBopCnK/GCSCgbQCwo/IcyBMUZV1pLDPGJh3O78PhojIs2TEmJaUq7
 x3I3lvR5ZAqmAQNAO72+nbKMFBAcdD2SxcXe7LIpPukt1qy2Vkj6u2WRyjBysb6R/90Imegn7
 l62jRWCymDlXn21iv5/M6lQ8oGjWguaI92algkrbQk+R19OVLxx33lGHdx+nwYn5xEd2ArIOo
 +bljMLCwc0yBbrpLbNtFbcnjwk8CZPkrcI/2gjDuzXdVL5Wi5WYGffgTpdRxdab5AbjLwOh7z
 dBv8N2SGwtVwnMZFcvArxOWo/NUAV0NlGfSSrBFDuD8tEY0DzvgXnnaMoaIoHw7q6A3B7jtHx
 VzVAw4qa8zjfVvfdN8fpUcRSvQ9KrCV8FXfsIGLvPrRY8NlEM3r9iq+NFbByr+Di41CjvmoFB
 ubJF3QiHUVltAGO2EC1RbKHPG10pJx3jN1mOSnyM2z0FfJOIxh/dZUZe+UYIqnCl9UqINOBRC
 /sj+C5iAgl8en6w/RbKDvMyJPnrOw35Co34fLJWipuIHlrJFfc+c4QhosiWYsxVPj2S75DkOy
 /iqJH3Q5ZhW7PBzNUsL2ZX74VHLycGdz6P8w3Zv8Q4kM9zmpRaxCeaALnhEEHiyXpt9cLdrag
 Zuj/ag==

=E2=80=A6
> +++ b/drivers/ras/amd/atl/access.c
> @@ -0,0 +1,106 @@
=E2=80=A6
> +static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_i=
d, u32 *lo)
=E2=80=A6

I suggest to reconsider the usage of double underscores for identifiers.
How do you think about to avoid that this software depends on undefined be=
haviour?
https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+d=
efine+a+reserved+identifier

Regards,
Markus


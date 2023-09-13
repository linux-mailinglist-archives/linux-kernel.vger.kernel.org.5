Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2607679E23D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbjIMIga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbjIMIg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:36:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D648196
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:36:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-403061cdf2bso40070145e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1694594184; x=1695198984; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uolj6bycuQLgVCoKuVx7OW6O8ol63jhVI8+H9GWvM7E=;
        b=Vmz3kM5iod7g2/kTmUqwIehe1BC7Wxz1zWFdOdF3TiSQsYUBaxOQUqq9BK9dTs12l4
         Qa+A/Qt0st2kubPQLk7YJt3Gt5Q8uWWQdCBrh4fgdJ/9NpqSmGxukKY5YTWplAhyXtxX
         Wz+yaTS3GyCnYY7Mf22/8xGWnpd2yPH7dfL3a4/+4+gw7TrrxzEuwcNiVnskIJ9aXhBz
         1NRE7h54vKgvrb8aYRScrg+awzMReU669L344JEz2BXhFyS35akvZVZRfvXNw+F5mOLb
         cua7JIXoBMe7BQsGydTrHjsbtx62c3IYrvZH3zepxtKy60RzQKp8BwJl0bI1/72YViQK
         bcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694594184; x=1695198984;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uolj6bycuQLgVCoKuVx7OW6O8ol63jhVI8+H9GWvM7E=;
        b=Fv9LOClj8fjb6C1E79Kg9U8AFwvjmpJwD1fCXOYp15zEpluAQQ3npGI8j/UW1FNk4x
         YkjEyccDCL/wLX4SWzpk07IrRKOsTqj8VbxGrfXulnbZZox4Zh4tOsqymrAZytGTotYE
         lQLn3yEmSDwiJt0CuCQxBwXCQUdq/0A5KAFS7vOOxLnQrzsehf7h0iclqKIYJB6INIRj
         SmQklrVx0QnsQ+krxU2it0xguds9kpt2ViYZkBeHvNoVxqz6td9pYZyQ1IFb3jEOx4x1
         zKRiQHEdcHcMG+0jHpLZJ25BH+6oArAzwOTJlUEXdEuV4asUqy+LXagoLSVPXnF+HCzO
         rjjQ==
X-Gm-Message-State: AOJu0YxF8/ohSZaJqS0YbN9BQMKWfSh2ldO+de0CKzT7V/+2/A2raYju
        1gbeu36oB3hCiMj0jOOc/0m9BA==
X-Google-Smtp-Source: AGHT+IGXZEXOiBFL14tbu7JB9wJiL81o7SR10ExAo1isVi5iswnBwwcoSwfHQtzWGjeJP8MxZaq/dw==
X-Received: by 2002:a05:600c:2159:b0:402:f503:6d1b with SMTP id v25-20020a05600c215900b00402f5036d1bmr1463747wml.0.1694594183662;
        Wed, 13 Sep 2023 01:36:23 -0700 (PDT)
Received: from smtpclient.apple (clnet-p106-198.ikbnet.co.at. [83.175.106.198])
        by smtp.gmail.com with ESMTPSA id y17-20020adff151000000b0031c5dda3aedsm14955606wro.95.2023.09.13.01.36.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:36:23 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v2 1/3] crypto: mxs-dcp: Add support for hardware provided
 keys
From:   David Gstir <david@sigma-star.at>
In-Reply-To: <CVH49V57VE6R.2488KOQMR5AKQ@suppilovahvero>
Date:   Wed, 13 Sep 2023 10:36:11 +0200
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        sigma star Kernel Team <upstream+dcp@sigma-star.at>,
        David Howells <dhowells@redhat.com>,
        Li Yang <leoyang.li@nxp.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2794F55-D63B-448D-B954-C3C25E0B474D@sigma-star.at>
References: <20230912111115.24274-1-david@sigma-star.at>
 <20230912111115.24274-2-david@sigma-star.at>
 <CVH49V57VE6R.2488KOQMR5AKQ@suppilovahvero>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

thanks for the review!

> On 12.09.2023, at 19:32, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Tue Sep 12, 2023 at 2:11 PM EEST, David Gstir wrote:

[...]

>> - /* Payload contains the key. */
>> - desc->control0 |=3D MXS_DCP_CONTROL0_PAYLOAD_KEY;
>> + if (key_referenced) {
>> + /* Set OTP key bit to select the key via KEY_SELECT. */
>> + desc->control0 |=3D MXS_DCP_CONTROL0_OTP_KEY;
>> + } else {
>> + /* Payload contains the key. */
>> + desc->control0 |=3D MXS_DCP_CONTROL0_PAYLOAD_KEY;
>> + }
>=20
> Remove curly braces (coding style).

Will fix that and all similar cases for v3.


>> +static int mxs_dcp_aes_setrefkey(struct crypto_skcipher *tfm, const =
u8 *key,
>> + unsigned int len)
>> +{
>> + struct dcp_async_ctx *actx =3D crypto_skcipher_ctx(tfm);
>> +
>> + if (len !=3D DCP_PAES_KEYSIZE)
>> + return -EINVAL;
>> +
>> + switch (key[0]) {
>> + case DCP_PAES_KEY_SLOT0:
>> + case DCP_PAES_KEY_SLOT1:
>> + case DCP_PAES_KEY_SLOT2:
>> + case DCP_PAES_KEY_SLOT3:
>> + case DCP_PAES_KEY_UNIQUE:
>> + case DCP_PAES_KEY_OTP:
>> + memcpy(actx->key, key, len);
>> + break;
>=20
> I don't understand why the "commit" is split into two parts
> (memcpy and assignments in different code blocks). You should
> probably rather:
>=20
> switch (key[0]) {
> case DCP_PAES_KEY_SLOT0:
> case DCP_PAES_KEY_SLOT1:
> case DCP_PAES_KEY_SLOT2:
> case DCP_PAES_KEY_SLOT3:
> case DCP_PAES_KEY_UNIQUE:
> case DCP_PAES_KEY_OTP:
> memcpy(actx->key, key, len);
> actx->key_len =3D len;
> actx->refkey =3D true;
> return 0;
>=20
> default:
> return -EINVAL;
> }
> }
>=20
> Or alternatively you can move all operations after the switch-case
> statement. IMHO, any state change is better to put into a singular
> location.

Makes sense. I=E2=80=99ll change that.


>> diff --git a/include/soc/fsl/dcp.h b/include/soc/fsl/dcp.h
>> new file mode 100644
>> index 000000000000..df6678ee10a1
>> --- /dev/null
>> +++ b/include/soc/fsl/dcp.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2021 sigma star gmbh
>> + * Authors: David Gstir <david@sigma-star.at>
>> + *          Richard Weinberger <richard@sigma-star.at>
>=20
> Git already has author-field and commit can have co-developed-by so
> this is totally obsolete.

Also noted for v3.

Thanks,
- David

--
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, Austria
UID/VAT Nr: ATU 66964118 | FN: 374287y


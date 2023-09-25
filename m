Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FC57AD0BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjIYGzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjIYGy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:54:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC25A9;
        Sun, 24 Sep 2023 23:54:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9b0168a9e05so463708166b.3;
        Sun, 24 Sep 2023 23:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695624891; x=1696229691; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pf0aQ+Sv6KbDPHkAJ+ayk0XpSbN6luZYg+Z+TqWeS98=;
        b=kEOdFUX3m28fZ2Jv041Nmu+gOi1Q+8AbwD8VQS3hbtYn3pSMSWjtSyCusKkxRyvwra
         uyuovicU0NNU98tUVlTIA4NocjiX1wOIDHFpPQxJOEtI1tJY0cX6G777lcRVa2HLDNh3
         RSoKw56Yp3hcAjCHSc6MaG9R/wnJ1boowsFeyqzXt3ghewO6J96pb40paVGZIYdPBVi/
         ziYbnw4uS8LVwybObZpW8/Og9BrU8ERE3TVunehy/yiSf1/b/24Dxe5QUQ6a86Cwd3gd
         d2+ww1K1th9V7bqbMP9/C7+uueZXz7Z2VOdRuVxRM+mctiKsnOsoSyIVNrT1RlH5u7ei
         pEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695624891; x=1696229691;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pf0aQ+Sv6KbDPHkAJ+ayk0XpSbN6luZYg+Z+TqWeS98=;
        b=V1XUH7R9zuWHJYYTihmRqIFcQfLuLWfTJ4ETIzO/dxYP184xWRUwkO8P6JYCoBX0J6
         HTI8MexUd/lsbFN5HmGKUD4guu5dxg6v/yIoEzDN/PwsQnzZZ7FiNohjOb8XhegfVp6N
         Zip5fZN7K8RTqPazzsDbqrRKFQr0ijnOehVpkLU6WAHZFvbInfv5Udb1wlp73zwbPQQw
         6MYMmFmZ2RxWOi47E+ejxCiwKuIXEv6/zwnPP+KhW0+bz0u61iTUNo7CfQYiPk4yHT1n
         9QyO+QeA4LPyv1ugb+xxQj2kL2ov6ZcVN3E2LhBOmnNgejnhTzjN46EMsRqFFjoFtTlU
         DSfg==
X-Gm-Message-State: AOJu0YwofE2JVjYbvTEWjUqEWKrwESqX8tqS1JXquEJpwX2yaZlWRHd8
        PIBX9x9qxC56+jl2F4lTarg=
X-Google-Smtp-Source: AGHT+IHU3XpLf8k6c9a+n9uMpp/2ubpuORfBRoVNOhfxz1vRej8uHibjAflU73vELK4WGQFMwOPLRQ==
X-Received: by 2002:a17:907:b15:b0:9ad:a4be:3c46 with SMTP id h21-20020a1709070b1500b009ada4be3c46mr5263378ejl.0.1695624891171;
        Sun, 24 Sep 2023 23:54:51 -0700 (PDT)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906b09200b0099c53c44083sm5876949ejy.79.2023.09.24.23.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 23:54:50 -0700 (PDT)
Message-ID: <430aff196be793003b96fd544f9f64c2eba3ca78.camel@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: max31827: use supply pin name
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     Rob Herring <robh@kernel.org>,
        "Matyas, Daniel" <Daniel.Matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Sep 2023 08:54:49 +0200
In-Reply-To: <0cb70677-6dfd-43e0-a3c5-cae3b861a7d1@roeck-us.net>
References: <20230921142005.102263-1-antoniu.miclaus@analog.com>
         <20230922211201.GA3600661-robh@kernel.org>
         <CY4PR03MB3399B818487F87D7297EC33F9BFEA@CY4PR03MB3399.namprd03.prod.outlook.com>
         <0cb70677-6dfd-43e0-a3c5-cae3b861a7d1@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-09-24 at 05:02 -0700, Guenter Roeck wrote:
> On Sat, Sep 23, 2023 at 02:19:45PM +0000, Miclaus, Antoniu wrote:
> >=20
> >=20
> > > On Thu, Sep 21, 2023 at 05:20:03PM +0300, Antoniu Miclaus wrote:
> > > > The actual hardware pin name for the supply of max31827 is vdd.
> > > > Update the dt-binding to reflect the hardware properties accordingl=
y.
> > >=20
> > > Changing this breaks the ABI. I see the old one wasn't used by the
> > > driver, but that's just one driver potentially. You need some
> > > justification here why it's okay to break the ABI.
> > >=20
> > As I mentioned also in the commit description, the supply should match =
the
> > actual hardware pin name. Otherwise it might create confusion. Usually =
vref
> > refers to an external voltage reference pin used for ADC/DACs which is =
not
> > exactly the case for this part, taking into account that there is no "r=
eference"
> > word mentioned in the datasheet at all. VREF and VDD are usually separa=
te
> > hardware pins. There is a hint indeed in the dts example that the vref-=
supply=20
> > might be referenced to a vdd regulator node, but from my point of view
> > that is not enough. Moreover the current vref-supply is not handled at =
all in
> > the driver, it is only mentioned in the dt-binding (That's why I added =
a second
> > patch in the series handling the supply).
> >=20
> > If the justification is not enough to apply this change, then I can kee=
p only the
> > second patch, which handles the regulator in the driver and use the=C2=
=A0 old `vref`
> > naming which currently appears only in the dt-binding.
> >=20
>=20
> That would have been a good argument when the property was introduced, bu=
t if
> there are any systems with existing bindings out there they will use the =
old
> name and fail after this change is applied.
>=20

How about introducing the new property and add 'deprecated: true' to the ol=
d one. I
guess the second patch would still remain as-is. Or is this just not worth =
the noise?

- Nuno S=C3=A1


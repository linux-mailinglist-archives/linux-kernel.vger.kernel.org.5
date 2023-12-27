Return-Path: <linux-kernel+bounces-11874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E80681ECC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D803B1F21386
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A56153AC;
	Wed, 27 Dec 2023 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPMNBC1Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79A5384;
	Wed, 27 Dec 2023 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dc026661efso332648a34.2;
        Tue, 26 Dec 2023 23:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703660750; x=1704265550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jme0gNNn2yz7pmVcmuBf1Jv+ICxsRpClAe8QaSHZLRU=;
        b=IPMNBC1QZ6XMgmK12ZbMvGmrdxxFFIy1IGd8EZJDlWHD7XsGMACio+L5mJETa2Z4nr
         ZUi6bKCQ5z4Mg8KNeF0fBKfQqqUMKq9axfII6YuWDi2jik2EnXMh+0tUtIAfa/L2U/Oy
         lgOiiGZf1DT1iRW6EYLKSNm1PnObRNpsUKpqqyYuyqEMt7iFwd0pAt9pBsDffPLLo4FL
         keezndliJbm9tSZE2w3AWqlF0KHcpPPns1SqbkfGq2UYq2laYhw3umw/oWWXWY/mDzWL
         ODY/ChwUMeoMivQM4beD/VWAcEnXKqyJLCHnbA8/S0em58iz0AuNZ2vHc0j0qXD7FlUN
         YawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703660750; x=1704265550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jme0gNNn2yz7pmVcmuBf1Jv+ICxsRpClAe8QaSHZLRU=;
        b=lS5GZovg4ea/zUYakslhAYpc2QJClpM9bXOn5yyQ908TTRNwRMtviA6UCSZQNGvq7s
         tsLAtzDPv1DvPlTn73fDgTKVZZVJNv0Q+JYkmALVdR+2Wyjq2VNlIM56Cq6uPVjkdIcO
         ZcLMifJ+kIWFnZNhDXx7K7VU/CWPk+dXS7H9LjdoFIU0U/aGsKJ0P2FqLImDNkl7pa5L
         sZwmJrStI3VQ4X0XuYYTkUrjy3mN+rR+UrbimAj4NFVVaXEdSJzJhNZ5prlNWOaFLve9
         WBiK9YBTeFQshfeL+lt8yHSTU+nBE25GERl5P2q936FHObbFDcPyBYqksU0iDP8S9XAn
         /Y8g==
X-Gm-Message-State: AOJu0YzHy9Wh6S+ZTIGrOevtKh5dWMM2kPR6gibG9AtlVtvSTmQXzyf3
	IkrpVD5MBhOKAJtptibqLpfB2EI4v8FoAkzyX6g=
X-Google-Smtp-Source: AGHT+IEJoe1RPY0B6nXUzwHfRh5Cl4oZAP+AqUbcGdQNcwlhRmZIU1JTEDeLNEe5y9MLoY0G8ZZetOEd2BSb6X64C2o=
X-Received: by 2002:a05:6830:a41:b0:6db:dc52:385a with SMTP id
 g1-20020a0568300a4100b006dbdc52385amr3005210otu.19.1703660749830; Tue, 26 Dec
 2023 23:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
 <20231226100431.331616-2-qiujingbao.dlmu@gmail.com> <170359073827.2315471.1581188151554847748.robh@kernel.org>
In-Reply-To: <170359073827.2315471.1581188151554847748.robh@kernel.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 27 Dec 2023 15:05:38 +0800
Message-ID: <CAJRtX8Q+OJ1wZPkbDiySfdzTc6uDQT_8PZGJmxSbO95tUhcNDw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: sophgo: add MFD subsys support
 for Sophgo CV1800 series SoC
To: Rob Herring <robh@kernel.org>
Cc: inochiama@outlook.com, aou@eecs.berkeley.edu, conor@kernel.org, 
	linux-rtc@vger.kernel.org, chao.wei@sophgo.com, 
	krzysztof.kozlowski+dt@linaro.org, unicorn_wang@outlook.com, 
	linux-kernel@vger.kernel.org, palmer@dabbelt.com, conor+dt@kernel.org, 
	a.zummo@towertech.it, dlan@gentoo.org, paul.walmsley@sifive.com, 
	alexandre.belloni@bootlin.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 7:39=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Tue, 26 Dec 2023 18:04:28 +0800, Jingbao Qiu wrote:
> > Add devicetree binding for Sophgo CV1800 SoC MFD subsys.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  .../bindings/mfd/sophgo,cv1800-subsys.yaml    | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800=
-subsys.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>

I'm sorry for that. My current patch depends on a CLK patch that has
not been merged yet.
So should I wait for the clk patch to merge before submitting?
the depends patch link:
https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20M=
B4953.namprd20.prod.outlook.com/

> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/sophgo,cv1800-subsys.yaml:
> Error in referenced schema matching $id: http://devicetree.org/schemas/rt=
c/sophgo,cv1800-rtc.yaml
> Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys.example.dts:25=
:18: fatal error: dt-bindings/clock/sophgo,cv1800.h: No such file or direct=
ory
>    25 |         #include <dt-bindings/clock/sophgo,cv1800.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings=
/mfd/sophgo,cv1800-subsys.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_bin=
ding_check] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202312=
26100431.331616-2-qiujingbao.dlmu@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

Best regards,
Jingbao Qiu


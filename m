Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B139D791D94
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbjIDT1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIDT1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:27:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92C8132;
        Mon,  4 Sep 2023 12:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1693855651; x=1694460451; i=frank-w@public-files.de;
 bh=JOyYNXQbvT7zGevNvcTmAT8zY8LHjzNroXyQl+AN5To=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S2LqrL2QcOX335jSqQyOv/dqgjJb/zdVPKdEkT2GqCfCyghrDwkHAQUzF+/bD5caclpkyLF
 gceYVOnMLmWa2mloBXl51aPExyywpGbt0g+ckyMkYjteuMwvBWunYFlFkvWhHKYQ7W9VvPzoo
 2BaueA7AlENvC43NMhqqAeHSG/Ft2KrXL1vR2Kcht/fV2bvTBAvESqiLJRR6bby4tnPT/gQNz
 1GBmy6ryjs0yjK4LdvtepHDpq4SsMpVt1aliAuROYweTluTsHhv9poP7usPWMKdNAKw8uBgSx
 LQ3O3fw/lnQpuQO2Gvpn1mMxAJ5y2o57ryey5E2YnoN1ehBJQJoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.145.232] ([217.61.145.232]) by web-mail.gmx.net
 (3c-app-gmx-bs26.server.lan [172.19.170.78]) (via HTTP); Mon, 4 Sep 2023
 21:27:31 +0200
MIME-Version: 1.0
Message-ID: <trinity-aa735349-6232-4b6b-b754-793596c329af-1693855651148@3c-app-gmx-bs26>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Aw: Re:  Re: RecursionError when try to check bindings (ubuntu
 22.04 / Python3.10)
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 4 Sep 2023 21:27:31 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20659635-21ae-5023-99b8-a61e8651ca5a@linaro.org>
References: <trinity-cb228db4-32f9-4606-b733-2d148073de5d-1693739337284@3c-app-gmx-bap43>
 <fe976c19-0f40-5e35-6704-6d014eccd376@linaro.org>
 <trinity-387c30fb-f681-4886-a86c-3f66c77bd5f5-1693852391761@3c-app-gmx-bs26>
 <20659635-21ae-5023-99b8-a61e8651ca5a@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:PINsUkHz9746Or0d7YihwdQH0xc0Op6D4TUbF8IkJvFu11Yy6YMZoN764sSkUeZkMlFZE
 byk/8TXRt6IOZzFDTOA2Dvb8t8GYEJqInyVtWRpVp7phmiOzu+wqT/mAovz+7oASZqnMFSavzOOo
 p1fV2UwbFvJzmIYKfkvfCwAugC4+/thSNCU3Uny5LKuDU2YBJCfMLkty+3aRKA2IhzWVKN4eiwF9
 yEOVkUC1ckbAI/2YeskAuZFyzEpa7katYcjXubFzf8e7RpZ3Q+8C34o5eQuUZByjp4fcr4ywM4dN
 ow=
UI-OutboundReport: notjunk:1;M01:P0:FE04klbmU+I=;WEoRiQ+XlmDT0/qHQ0T8ScH/GNS
 Xu1GxHV3UYfL/ibJr3tw/wovI/rKvULG640qZiyrnv+Fdwvdnm4f9yBKgjkGP0zGxSBwf4AkF
 4nRCS1ONku+rrJRBIVs3KSdbQDqoCah0Sv8Qh1s4OwzialsujpN1fJKwH+gTSmo4J05Cb/4Zf
 gEaq9bv2omZLCwYZ2GPW/qoEyGgS5K4OVPo50ivPx2RjB81ZxnQW3OXSVp5o+aEyuKhDAn+rz
 cgAPmaA8jXcS7Vpmt18lSADEe2S0H70iBRoTOjhNi88KFBX9Sz5P5gCbI/RO7mcGkMytt9x1N
 qJql11MQFZP8xCu7mVx0xcC1yYIyG7l7LwB9Ax8lhHQKQEOeMEzMj/IGwAPb1elF04noqCcP9
 dV7wVcjU/e8o7FxHWrhM9xAHWKeV1wK9zR2aQM9cxNcvJoSwP2naB3Y+xNbNLoKUgHoqNiRSQ
 vLd/aQsSIho7yA0harAXKK1zab0ejM3e2Oh2C5aPUeItovogeY0sTsM6N4Ouw6/vEbwCrBWjz
 9WQxIdPzQ0abCBDi7F5BH7DGsekQjo3x1ej8ETBKo9+fIRWqtPLBONHMJRbXD+wkwIuzyh9LD
 z08Hw8wZ8aqO315txLB6Tq2YzMhqoSreYw8G0KqNVlUbf3JmfBI+w+xGXwbWWM8Jmh/4fYi/A
 cmiFO5DRdRk5rL+hDxYNm/4DjuE4seOFSvSOE1f2v8pootzPvd3El3INHw8WYsNBErYmxAErM
 yxrlGrLtBLt57cwvk9Nxyhq1ebvTf1Av9pLMLKwVpNLNWCiLzz3/8d9kGNaaCwPhFUxWoOMWD
 c0Ajoj1dWMwNro7eIo7IXDUw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



regards Frank


> Gesendet: Montag, 04. September 2023 um 21:21 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> An: "Frank Wunderlich" <frank-w@public-files.de>
> Cc: "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof=
.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.k=
ernel.org
> Betreff: Re: Aw: Re: RecursionError when try to check bindings (ubuntu 2=
2.04 / Python3.10)
>
> On 04/09/2023 20:33, Frank Wunderlich wrote:
> > Hi
> >
> >> Gesendet: Montag, 04. September 2023 um 20:18 Uhr
> >> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> >> An: "Frank Wunderlich" <frank-w@public-files.de>, "Rob Herring" <robh=
+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
> >> Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
> >> Betreff: Re: RecursionError when try to check bindings (ubuntu 22.04 =
/ Python3.10)
> >>
> >> On 03/09/2023 13:08, Frank Wunderlich wrote:
> >>> Hi,
> >>>
> >>> i tried to check a binding-file with 6.5 kernelsource and get this e=
rror
> >>>
> >>>   LINT    Documentation/devicetree/bindings
> >>>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> >>>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >>> Traceback (most recent call last):
> >>>   File "/home/frank/.local/bin/dt-mk-schema", line 38, in <module>
> >>>     schemas =3D dtschema.DTValidator(args.schemas).schemas
> >>>   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/val=
idator.py", line 354, in __init__
> >>>     self.schemas =3D process_schemas(schema_files)
> >>>   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/val=
idator.py", line 271, in process_schemas
> >>>     sch =3D process_schema(os.path.abspath(filename))
> >>>   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/val=
idator.py", line 248, in process_schema
> >>>     dtsch.is_valid()
> >>>   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/sch=
ema.py", line 145, in is_valid
> >>>     for error in self.DtValidator(self.DtValidator.META_SCHEMA).iter=
_errors(self):
> >>>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/v=
alidators.py", line 242, in iter_errors
> >>>     for error in errors:
> >>>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/_=
validators.py", line 362, in allOf
> >>>     yield from validator.descend(instance, subschema, schema_path=3D=
index)
> >>>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/v=
alidators.py", line 258, in descend
> >>>     for error in self.evolve(schema=3Dschema).iter_errors(instance):
> >>>
> >>> block from line 242-258 repeats many times (~2000 lines in log)
> >>>
> >>>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/v=
alidators.py", line 242, in iter_errors
> >>>     for error in errors:
> >>>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/_=
legacy_validators.py", line 216, in recursiveRef
> >>>     lookup_url, next_target =3D validator.resolver.resolve(each)
> >>>   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/v=
alidators.py", line 835, in resolve
> >>>     url =3D self._urljoin_cache(self.resolution_scope, ref).rstrip("=
/")
> >>> RecursionError: maximum recursion depth exceeded in comparison
> >>>
> >>> make[2]: *** [Documentation/devicetree/bindings/Makefile:68: Documen=
tation/devicetree/bindings/processed-schema.json] Error 1
> >>> make[2]: *** Deleting file 'Documentation/devicetree/bindings/proces=
sed-schema.json'
> >>> make[1]: *** [/media/data_nvme/git/kernel/BPI-R2-4.14/Makefile:1516:=
 dt_binding_check] Error 2
> >>> make: *** [Makefile:234: __sub-make] Error 2
> >>>
> >>> my command is (after importing defconfig, also tried a clean before)=
:
> >>>
> >>> ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make dt_binding_chec=
k
> >>>
> >>> already did an update of dtschema with "pip3 install dtschema --upgr=
ade" and also an uninstall/install of this python-package
> >>>
> >>> $ pip3 show dtschema
> >>> Name: dtschema
> >>> Version: 2023.7
> >>> Summary: DeviceTree validation schema and tools
> >>> Home-page: https://github.com/devicetree-org/dt-schema
> >>> Author: Rob Herring
> >>> Author-email: robh@kernel.org
> >>> License: BSD
> >>> Location: /home/frank/.local/lib/python3.10/site-packages
> >>> Requires: jsonschema, pylibfdt, rfc3987, ruamel.yaml
> >>> Required-by:
> >>>
> >>> any idea what can be the cause?
> >>
> >> Can you share the reproduction steps? This probably is some error in
> >> schema which is then not nicely handled by dtschema.
> >
> > there is not much more than i already told...
> >
> > git checkout v6.5 #to have clean mainline version
> > ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make defconfig #use ma=
inline default config
> > ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make dt_binding_check
> >
> > it does not tell me a special binding file which is broken...it seems =
it has a problem with the self generated processed-schema.json, but it del=
etes the file.
> >
> > maybe there is a way to skip this removal to analyse this file...have =
looked into my site-packages, but have not found the position of file dele=
tion
> >
> > btw. i get the same error also if i do not pass a file to dt-validate =
command...
>
> Cannot reproduce it. Are you sure you are no mixing Python versions or
> packages (e.g. pip and pip3)?

i do not call python directly but it does not matter

$ pip -V
pip 22.0.2 from /usr/lib/python3/dist-packages/pip (python 3.10)

$ pip3 -V
pip 22.0.2 from /usr/lib/python3/dist-packages/pip (python 3.10)

$ python -V
Python 3.10.12

$ python3 -V
Python 3.10.12

but it is fixed by upgrading jsonschema package to 4.17

pip3 install jsonschema=3D=3D4.17.0

maybe this can be defined as depency for dtschema...at least 4.6 is not wo=
rking (the version i had before)

i guess you have already a newer version of jsonschema package

> Best regards,
> Krzysztof
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F279791CF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbjIDSd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbjIDSdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:33:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD2BCC8;
        Mon,  4 Sep 2023 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1693852391; x=1694457191; i=frank-w@public-files.de;
 bh=J4q/9pAlgV6We5hShQiWw26tQ8kQmBIIDgIC0hj0mzE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nZaAyflbLKUXcADeSwNdcb+fcWdFxwPpzH4UK8D/Wctv04aABK6AZU5x3mbQhPx1tOpHmX0
 G9br4PQg7j3C11ygqVqDiD81qexmOt3wjOESVeYsnuSFpjfiP4JpkHAdEvpO1ECHlXiZ0Qa1T
 piY6YlvweAoyAPPqbbE9U7jeKv/vCIVTFwHK6BNAEAYj6BvDptOUHc+WhXTko/TV3QTrSe5eH
 OwQ14naqpgT50+Elt7mHTQLqXpiTnJahRzZBx+U0jNemaE281NAGQYZ0LL9NWzj0uJD7nHIkf
 SL9fzSR4gRJCVTWePpplTRaMlGXl26A73HUNIWg6vE7J4h/doEnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.145.232] ([217.61.145.232]) by web-mail.gmx.net
 (3c-app-gmx-bs26.server.lan [172.19.170.78]) (via HTTP); Mon, 4 Sep 2023
 20:33:11 +0200
MIME-Version: 1.0
Message-ID: <trinity-387c30fb-f681-4886-a86c-3f66c77bd5f5-1693852391761@3c-app-gmx-bs26>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Aw: Re: RecursionError when try to check bindings (ubuntu 22.04 /
 Python3.10)
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 4 Sep 2023 20:33:11 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <fe976c19-0f40-5e35-6704-6d014eccd376@linaro.org>
References: <trinity-cb228db4-32f9-4606-b733-2d148073de5d-1693739337284@3c-app-gmx-bap43>
 <fe976c19-0f40-5e35-6704-6d014eccd376@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:gy+LzjGy5IPY1LMJgvN5KRy93EOom/sU4y2CmCKMtaHLzXjnRdyWrt3uliMO0SuTj8G1g
 F4EI4Q+rjbNM3VNKLdf7KbePdvFu64mtPfWJesCydcewThJpTlDQ2bmoFpHjbBlD2K+yCIYZBRki
 LbnckxpVqVDApJQoY2xuUe1JOugWOHl0w4or4nRc7/yhy0d1OgSYe7KyUAshGnFSyDJVclZi0CsY
 S4Wm53BUCSaSMa4cNy0NiZCsjUXWN0lsKEmjiR4fPAtW9lvI7QCzJOWAPOLOEH6MkQXixXVVaHHk
 rw=
UI-OutboundReport: notjunk:1;M01:P0:tIe/Q5z1JfM=;XIaPYgaCBeW6+lc8EcoK4TdJ0Yy
 PuCl1h9k08kW3mR8AFTFHT1ky1yIm+E6KArX9fa98jqtwOgfxB11Hdsp4M9jodLKARSiuSrdU
 zR41rUUDziWYakteuqfbp7Icf7cYZ+CtOqif4ys1CF8YXFwHo0HVgqdLgF8bXTZimQVL69Y/H
 WWt9Z5qEBvTLcVFXib0z6DzqYdM8J8tXK2XSBbpTsokyphf/J1rQ+N4EJi82E4fX0ympqts5x
 bN6Bsl6lww8436eXgiP7IF9b/5oy6vpEJPMzRp8TGOWRALaibOTLwJqgPc5kpq8uiFcJjdTbO
 /MHqBLIdmA3xsC5QMoAptRIjN6KAQ5wpOJ2DTdIM1uvwQuqLdntORtbT3dmXVyNirC+/RkSqN
 e5s2NOeg2wGA6a4H0EMwSl/G956AkuJoP+hfNbOwNsImBC6Wcm0m71nujxHj1PtPKlxDKTO/Z
 hkfHtGrVDaJKWj+DsnwzgVKwxuEivLQhKJM27cjK96Qli7bND0wns+U/2FQUFxje1W8SeLwRg
 VLqZppouM7KDVYZIGroFH6zwjPY2NnXcNYWs2tiG9wo5ZVme8q3jbqQiv/7Kx4C7E3zeVJZ2E
 I0xyLpEtRX99ABs9DJWbjUUSu8/2ciOcSmpPNtc4SwDmegKvHxRdplSbIVaVvcyDFZFAXaSB1
 0fWvQTgOGJSle+/HPIM1a/3hhI4c7MWBlnxYxJ7qTjtCxWC+hFVhYy156cbyJZTGLeAE1NtE+
 f7pE0LqHdDAogjYGDGBNQIU/xgPXj+H+GpnO4Fx67VJvVNf6x5l71FgOc+rUBrHrltOm3Qrv6
 19N1YbMwLIjhGRQaSmV3nVMw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Gesendet: Montag, 04. September 2023 um 20:18 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> An: "Frank Wunderlich" <frank-w@public-files.de>, "Rob Herring" <robh+dt=
@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
> Betreff: Re: RecursionError when try to check bindings (ubuntu 22.04 / P=
ython3.10)
>
> On 03/09/2023 13:08, Frank Wunderlich wrote:
> > Hi,
> >
> > i tried to check a binding-file with 6.5 kernelsource and get this err=
or
> >
> >   LINT    Documentation/devicetree/bindings
> >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > Traceback (most recent call last):
> >   File "/home/frank/.local/bin/dt-mk-schema", line 38, in <module>
> >     schemas =3D dtschema.DTValidator(args.schemas).schemas
> >   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/valid=
ator.py", line 354, in __init__
> >     self.schemas =3D process_schemas(schema_files)
> >   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/valid=
ator.py", line 271, in process_schemas
> >     sch =3D process_schema(os.path.abspath(filename))
> >   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/valid=
ator.py", line 248, in process_schema
> >     dtsch.is_valid()
> >   File "/home/frank/.local/lib/python3.10/site-packages/dtschema/schem=
a.py", line 145, in is_valid
> >     for error in self.DtValidator(self.DtValidator.META_SCHEMA).iter_e=
rrors(self):
> >   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/val=
idators.py", line 242, in iter_errors
> >     for error in errors:
> >   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/_va=
lidators.py", line 362, in allOf
> >     yield from validator.descend(instance, subschema, schema_path=3Din=
dex)
> >   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/val=
idators.py", line 258, in descend
> >     for error in self.evolve(schema=3Dschema).iter_errors(instance):
> >
> > block from line 242-258 repeats many times (~2000 lines in log)
> >
> >   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/val=
idators.py", line 242, in iter_errors
> >     for error in errors:
> >   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/_le=
gacy_validators.py", line 216, in recursiveRef
> >     lookup_url, next_target =3D validator.resolver.resolve(each)
> >   File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/val=
idators.py", line 835, in resolve
> >     url =3D self._urljoin_cache(self.resolution_scope, ref).rstrip("/"=
)
> > RecursionError: maximum recursion depth exceeded in comparison
> >
> > make[2]: *** [Documentation/devicetree/bindings/Makefile:68: Documenta=
tion/devicetree/bindings/processed-schema.json] Error 1
> > make[2]: *** Deleting file 'Documentation/devicetree/bindings/processe=
d-schema.json'
> > make[1]: *** [/media/data_nvme/git/kernel/BPI-R2-4.14/Makefile:1516: d=
t_binding_check] Error 2
> > make: *** [Makefile:234: __sub-make] Error 2
> >
> > my command is (after importing defconfig, also tried a clean before):
> >
> > ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make dt_binding_check
> >
> > already did an update of dtschema with "pip3 install dtschema --upgrad=
e" and also an uninstall/install of this python-package
> >
> > $ pip3 show dtschema
> > Name: dtschema
> > Version: 2023.7
> > Summary: DeviceTree validation schema and tools
> > Home-page: https://github.com/devicetree-org/dt-schema
> > Author: Rob Herring
> > Author-email: robh@kernel.org
> > License: BSD
> > Location: /home/frank/.local/lib/python3.10/site-packages
> > Requires: jsonschema, pylibfdt, rfc3987, ruamel.yaml
> > Required-by:
> >
> > any idea what can be the cause?
>
> Can you share the reproduction steps? This probably is some error in
> schema which is then not nicely handled by dtschema.

there is not much more than i already told...

git checkout v6.5 #to have clean mainline version
ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make defconfig #use mainli=
ne default config
ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make dt_binding_check

it does not tell me a special binding file which is broken...it seems it h=
as a problem with the self generated processed-schema.json, but it deletes=
 the file.

maybe there is a way to skip this removal to analyse this file...have look=
ed into my site-packages, but have not found the position of file deletion

btw. i get the same error also if i do not pass a file to dt-validate comm=
and...

$ which dt-validate
/home/frank/.local/bin/dt-validate

this is also a python-file which is installed outside of the site-packages=
, but i don't know why

> Best regards,
> Krzysztof
>
>

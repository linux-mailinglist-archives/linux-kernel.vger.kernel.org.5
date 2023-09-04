Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD15791D89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbjIDTRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjIDTRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:17:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB0F18C;
        Mon,  4 Sep 2023 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1693855049; x=1694459849; i=frank-w@public-files.de;
 bh=7n7aU70Tg3MImEK0j4GtqIdB1VNQQ7Mr1r4mYZKUkSs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Wsa/NjVeg+ls6cCRMnKFx/H5AJpONsOEkrN0IbicD1n2iKKLt4oMpUQu/rYf3KvcRhMlqUl
 JqEcs4fTi+YOLIaFwcSjzuq2U2v95ZMNdM5tNTF8aEcn2u8D4oMhf5iq/oUO4+QZxzePjyBdV
 IMbEvwJ1/V0jyluNvJYgyoygjXOhsistdBe+gihJu27PudLrxIgAL3SloGtUPkS6o4plRtA+u
 tmqGsWgZfyNhhOws3GQSV34iunjpFRrQsz9Nh+2+Rq9t6C8h18HJ5t5Bfo2Nxk9DkV6wyQy7P
 hUiTaYlqQZ5VA22etDTcFDwwllrHfZJsskOgWTt3HHU0qGNuw6LA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.145.232] ([217.61.145.232]) by web-mail.gmx.net
 (3c-app-gmx-bs26.server.lan [172.19.170.78]) (via HTTP); Mon, 4 Sep 2023
 21:17:29 +0200
MIME-Version: 1.0
Message-ID: <trinity-8d643f61-ce43-48b9-8ad5-7767929bdc35-1693855049644@3c-app-gmx-bs26>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Aw: Re: RecursionError when try to check bindings (ubuntu 22.04 /
 Python3.10)
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 4 Sep 2023 21:17:29 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <fe976c19-0f40-5e35-6704-6d014eccd376@linaro.org>
References: <trinity-cb228db4-32f9-4606-b733-2d148073de5d-1693739337284@3c-app-gmx-bap43>
 <fe976c19-0f40-5e35-6704-6d014eccd376@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:VebmP1g4uosqZ8f+q/wX4bch9tw4XXZoe6PwpmPLpPPNp99q1UlQKcsYnwdczIdpWSGvn
 r3//Z1ln3+G08b0OLqlfnajtOoCvqZRb5MPrjODL1+G0JIgpxQ/5nyZo0tDOWo3YgLHCfMwCMX6f
 gan9zn3IW1evxYsh6uGN+nbH2bdmRqnKcKQ++xaHEpABqnivBp7/hQiacXyZWMCI0VFY5VF/BbO3
 BtKSMXUqa2cej8cHfTseZ1SvTN4DR1dVzp5TlfQUPwEqB/VjssUMe+5YfO0a6kCBQ0kX/ez/JwJM
 OY=
UI-OutboundReport: notjunk:1;M01:P0:pd/dxhH/tWY=;fk11MLkmDDB46j70sM9JNCdwnY4
 XzDPtt4Lw8IukVC2Pb88SgbSpchwfWMviH/k0UeM2KovI7NObLpM1HF8lS8tb22lY24QIoLYr
 wpOVfUIpcuSkgcYyQqQuuLcPeUZJR8DQcpawjx/DOQPoEeJN3bC06x6TGORVE//aP8yW5pEjB
 PBM9xJwMAU5B0nboBjCdoKNjmlpek6F2dsa7CbTTXYWaMd87zYT4/heIYaVhwptltpVoJhe9g
 OCQW7Y7Z0sEh6H/m/oJsawpjnRcgMc2RJZNMSgclLglloG02d7w7OqhbS/WugP1MdygimUJoB
 z4wWenpe6JGRhJQbWEfrT8uX9O/2P1yKQGKGINWyU8eJSDX1kJbz3sMlGtCCjs68BIdEzm/og
 zNJVX4+y2XXE0B9XavcN6g5QvavILPapPmybU1ygz0hEE9ghV73+faMZE1lysobFSqaCknOFL
 Xr4zONdTdjB0REwUPAoDP7k7iq7ogX3FokGxclxXtD0iPpvgeXu4Y9N7uPCWz08LLm4YRMy4z
 4LQLqlEDDJGPJKhZP3iAyX0lgpM4fPvbjAcHCiTQJR6BvuB3WTXwNcWEvSwlvdwFXxHK3lBK9
 NZT0bqiYJm1/l9kAgpQNTYkzqcL/4otppwtWONrEhghAaqe61eeRL4TWUQ2mzHS9t9B4pv3RP
 +kBgDZVetBquJ75AJV37wdtlVYjC+rpyQHVMzG00cTHFrq0lMt+N4f3xqC/J8Dam1ZQbxcDO3
 8tgEi6UGgcthh/Ou6VRJTn66h7PZgMgTxvqkRhVBq1/cYU9kx1TYqJZDENo/7nmXHxO2+tDMz
 tIKNcICwFDNe/N4JcOi+l7dA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

seems like this fixes it (at least i get over the faulty point see now the=
 DTEX lines):

pip3 install jsonschema=3D=3D4.17.0

seems my previous version was 4.6.0

Requirement already satisfied: jsonschema in /home/frank/.local/lib/python=
3.10/site-packages (4.6.0)

first tried upgrade of this, but this results in 4.19 which is not compati=
ble with dtschema

ERROR: pip's dependency resolver does not currently take into account all =
the packages that are installed. This behaviour is the source of the follo=
wing dependency conflicts.
dtschema 2023.7 requires jsonschema<4.18,>=3D4.1.2, but you have jsonschem=
a 4.19.0 which is incompatible.

so i set the last version told to be compatible

regards Frank


> On 03/09/2023 13:08, Frank Wunderlich wrote:
> > Hi,
> >
> > i tried to check a binding-file with 6.5 kernelsource and get this err=
or
> >
> >   GNU nano 6.2                                                        =
    dt.log
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


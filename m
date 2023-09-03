Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23C790B88
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjICLJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbjICLJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:09:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD54124;
        Sun,  3 Sep 2023 04:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1693739337; x=1694344137; i=frank-w@public-files.de;
 bh=u8/szVbittwkRsWyf3e5cgTsrKMvXaYnL6wjccfCDI4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=pUiXolxN/GrMlTeVVI5WbP0hrg7+ZdtWU28sne+EM293HM6NX9vsjoZi+Y+FZ9qqe+IsRl1
 vZY3HmHjfrtHwmXrr0jSuq3C9RvuMSPom5sL2ZnKdM0akGzXhy6euMZ9sX60BPSc/qHtXmVeG
 Moaz9oJtiSwEkdb0NLGykYnstGvpxVWUpNucjMT14yfbXmBRsg62wqxw0NAK1XP37wKO7gkEu
 9ymZZUZkExWljfoWV04ePOXh2ySss3xVCkg5Ria7rAgKfAymuKMkpvpvna+DiEjdw/gFPBupk
 WYPMwOTy2inPvTTUpvntx77XAbEkFZZUgE7s2N0psg9TESujYIDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.159.177] ([217.61.159.177]) by web-mail.gmx.net
 (3c-app-gmx-bap43.server.lan [172.19.172.113]) (via HTTP); Sun, 3 Sep 2023
 13:08:57 +0200
MIME-Version: 1.0
Message-ID: <trinity-cb228db4-32f9-4606-b733-2d148073de5d-1693739337284@3c-app-gmx-bap43>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RecursionError when try to check bindings (ubuntu 22.04 /
 Python3.10)
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 3 Sep 2023 13:08:57 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:OwC3cXbrWuDlCByBlHW2m7NqkIDL2tZb6sUR0yxDtK6LCImgIyfnPZ/Otp1r2ynRF5TZ2
 iT1Qq0W5PUH8zM7FqOykS3+txSvtCX+ZGna34AJngdBPq8DeXTC+LCpCW0VAXz2V26wubQvntyVe
 ajWdrlNeaabfjQZHRpGwiqAV8D3UBD64klp8fTN6NZULqoel5Sh3VmhMGbgCWnynBcdTLxgTI9Oo
 pPgjfW/BkFOZuIzD1yo5uScVhXnwLCkBEtbfE1XbA+zF6WWUkmCB876JNL9XUo9zu6R4c6B7+0O3
 UM=
UI-OutboundReport: notjunk:1;M01:P0:5PCjodAlLA8=;geT5mhRf1Bf/p7+J0rUb5l7pefm
 36Zu88UWuvEf/Em42f/DOlGrYTeXQzAAdiS/1qqD4Szq1jL/e2vfB/p9o2D1G5P5xVr9MMlNY
 IGNXKA/alP2jGpqSuYM6zgW9zD8Cyjhs2bZRpqHctyq6jTmdK+JArxK1O5okRyebTW0naxxD1
 S7asGIuyvEqx682Kpyp4nU+8BKAJoPkDye7NbdYzwVikKSi3dOb3qO2NTp7aWQnoj4EVQZkIN
 09PhH+e8xGA6thPc/BG9wQl061bFtgYoRlzNhgDsOjYLc6gge14nHpIFzH1UUoDyjE2gkEiV7
 IOQGS6PYlk+ba3uPy76i7JDhJvCDlCk0Td3NcLKZq358QJRXn1HKCGfNnoEoqsFDgR26silOe
 cmqL2TfH14QKgWBq0BYCDOJzEXIAmb85HuBa7fXUomi5FIvdyhWr0obAfQDVIP37/Dk94gr/T
 dyB1pVThy0h4oFaXUifn6qXDyIKKfyVDcmpMaaCesmYkf4wGPqJ1KrJVVb6+UQlA3ky3ODOPL
 S0zpHOzYD3kfJUkkmrHIU1nNKsjkJqVQ+2IRl75ZdawcmrV8zZrjNhkZvJp0DIFhuGXrI80mZ
 FxE4FN7DDiUnxS7gXzgJw4fQETXhOmDen7wvVGW10gSZCPKkwAkYM7NdHwtsgzSoLgeWujdrs
 Puv7pXcDo8jK4s9Fflb82n9/EmyYWJHTZmcgGPaHH1gJteCTdG4mUQaBC3DJHOzh9GKV1y8ta
 x/sK9bbp0l4jjFp9TG3f1KuN+dMvVx3XdtlDpiZOostnqocYgsSxSRj4+c48QQN0fog2K9E+O
 mdK3ewloXk7Ntvv4eBlpUW++ZI8dCD7GFcLM7LDhsXea4=
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

Hi,

i tried to check a binding-file with 6.5 kernelsource and get this error

  GNU nano 6.2                                                            =
dt.log
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
Traceback (most recent call last):
  File "/home/frank/.local/bin/dt-mk-schema", line 38, in <module>
    schemas =3D dtschema.DTValidator(args.schemas).schemas
  File "/home/frank/.local/lib/python3.10/site-packages/dtschema/validator=
.py", line 354, in __init__
    self.schemas =3D process_schemas(schema_files)
  File "/home/frank/.local/lib/python3.10/site-packages/dtschema/validator=
.py", line 271, in process_schemas
    sch =3D process_schema(os.path.abspath(filename))
  File "/home/frank/.local/lib/python3.10/site-packages/dtschema/validator=
.py", line 248, in process_schema
    dtsch.is_valid()
  File "/home/frank/.local/lib/python3.10/site-packages/dtschema/schema.py=
", line 145, in is_valid
    for error in self.DtValidator(self.DtValidator.META_SCHEMA).iter_error=
s(self):
  File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/validat=
ors.py", line 242, in iter_errors
    for error in errors:
  File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/_valida=
tors.py", line 362, in allOf
    yield from validator.descend(instance, subschema, schema_path=3Dindex)
  File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/validat=
ors.py", line 258, in descend
    for error in self.evolve(schema=3Dschema).iter_errors(instance):

block from line 242-258 repeats many times (~2000 lines in log)

  File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/validat=
ors.py", line 242, in iter_errors
    for error in errors:
  File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/_legacy=
_validators.py", line 216, in recursiveRef
    lookup_url, next_target =3D validator.resolver.resolve(each)
  File "/home/frank/.local/lib/python3.10/site-packages/jsonschema/validat=
ors.py", line 835, in resolve
    url =3D self._urljoin_cache(self.resolution_scope, ref).rstrip("/")
RecursionError: maximum recursion depth exceeded in comparison

make[2]: *** [Documentation/devicetree/bindings/Makefile:68: Documentation=
/devicetree/bindings/processed-schema.json] Error 1
make[2]: *** Deleting file 'Documentation/devicetree/bindings/processed-sc=
hema.json'
make[1]: *** [/media/data_nvme/git/kernel/BPI-R2-4.14/Makefile:1516: dt_bi=
nding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

my command is (after importing defconfig, also tried a clean before):

ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make dt_binding_check

already did an update of dtschema with "pip3 install dtschema --upgrade" a=
nd also an uninstall/install of this python-package

$ pip3 show dtschema
Name: dtschema
Version: 2023.7
Summary: DeviceTree validation schema and tools
Home-page: https://github.com/devicetree-org/dt-schema
Author: Rob Herring
Author-email: robh@kernel.org
License: BSD
Location: /home/frank/.local/lib/python3.10/site-packages
Requires: jsonschema, pylibfdt, rfc3987, ruamel.yaml
Required-by:

any idea what can be the cause?

regards Frank


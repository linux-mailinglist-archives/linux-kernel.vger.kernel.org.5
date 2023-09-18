Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538F67A418C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbjIRGuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjIRGuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:50:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468569F;
        Sun, 17 Sep 2023 23:50:00 -0700 (PDT)
Received: from localhost (89-26-75-29.dyn.cablelink.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0203B66003B0;
        Mon, 18 Sep 2023 07:49:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695019797;
        bh=/fk3WgWVIYNC71tqjOyEDy5t6GDP5pCDuBwKWMnwgxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8kgdFNsDeMRL6vqcTTQWRS4ULKyBARTk6YDzIJGP0giAKjB77H8rH5FIkbfal5Lr
         m4qSH0C4uewsXm/CleX3j9mrtcuyNZ7Kh09gtuP0oVkZDTstRKcWyN8j1vCSdoIyJ4
         cYN8W6nIJrOlyUQcyHVEc6SccOCFJFGCrNdMJ8htc95VcYYZSmxNtA/PD3WU2XkAFq
         4AeJTjwplgQ92u/gkzWzl9LWIpuMx39KuwNqq16QRULcX955sCVeVB3npl1ZySq1Dl
         jIKotKXefBTLe0dLrwozioMgBz/jFmEOO6lOgnJPnhAjGY4X5p4GkGdItmtgVFCkJx
         7Si/joxR7ImPg==
Date:   Mon, 18 Sep 2023 08:49:54 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Beckett <bob.beckett@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: Re: [PATCH v12 6/7] dt-bindings: media: wave5: add yaml devicetree
 bindings
Message-ID: <20230918064954.iuomunsckduawiay@basti-XPS-13-9310>
References: <20230915-wave5_v12_on_media_master-v12-0-92fc66cd685d@collabora.com>
 <20230915-wave5_v12_on_media_master-v12-6-92fc66cd685d@collabora.com>
 <30384744-94d7-2675-63ad-d8531e3156d1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30384744-94d7-2675-63ad-d8531e3156d1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,

thanks for your review.

On 17.09.2023 09:56, Krzysztof Kozlowski wrote:
>On 15/09/2023 23:11, Sebastian Fricke wrote:
>> From: Robert Beckett <bob.beckett@collabora.com>
>>
>> Add bindings for the wave5 chips&media codec driver
>>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>
>So this is v12 and still no tested?

I have tested it, multiple times actually since V11. (For some reason
that indentation issue slipped by me though ...)
If you mean the tested by tag, the patch was completely unnoticed until
v10 by the community, which was partially because me and the previous
commiters didn't use the right recipients for this patch. So from that
point of view this is more like v2.

>
>A nit, subject: drop second/last, redundant "yaml devicetree indings".
>The "dt-bindings" prefix is already stating that these are bindings.
>Basically three words bringing zero information.

Okay so:
`dt-bindings: media: wave5: add devicetree`
?

>
>> ---
>>  .../devicetree/bindings/media/cnm,wave5.yaml       | 66 ++++++++++++++++++++++
>>  1 file changed, 66 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/cnm,wave5.yaml b/Documentation/devicetree/bindings/media/cnm,wave5.yaml
>> new file mode 100644
>> index 000000000000..b8f383621805
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/cnm,wave5.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/cnm,wave5.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Chips&Media Wave 5 Series multi-standard codec IP
>> +
>> +maintainers:
>> +  - Nas Chung <nas.chung@chipsnmedia.com>
>> +  - Jackson Lee <jackson.lee@chipsnmedia.com>
>> +
>> +description: |-
>
>Do not need '|-' unless you need to preserve formatting.

Ack.

>
>> +  The Chips&Media WAVE codec IP is a multi format video encoder/decoder
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +        - cnm,cm521c-vpu
>
>It does not look like you tested the bindings, at least after quick
>look. Please run `make dt_binding_check` (see
>Documentation/devicetree/bindings/writing-schema.rst for instructions).
>Maybe you need to update your dtschema and yamllint.

Here my testing output:
```
❯ make dt_binding_check DT_SCHEMA_FILES=cnm,wave5.yaml
   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/dtc/dtc.o
   HOSTCC  scripts/dtc/flattree.o
   HOSTCC  scripts/dtc/fstree.o
   HOSTCC  scripts/dtc/data.o
   HOSTCC  scripts/dtc/livetree.o
   HOSTCC  scripts/dtc/treesource.o
   HOSTCC  scripts/dtc/srcpos.o
   HOSTCC  scripts/dtc/checks.o
   HOSTCC  scripts/dtc/util.o
   LEX     scripts/dtc/dtc-lexer.lex.c
   YACC    scripts/dtc/dtc-parser.tab.[ch]
   HOSTCC  scripts/dtc/dtc-lexer.lex.o
   HOSTCC  scripts/dtc/dtc-parser.tab.o
   HOSTLD  scripts/dtc/dtc
   LINT    Documentation/devicetree/bindings
./Documentation/devicetree/bindings/media/cnm,wave5.yaml:19:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
   CHKDT   Documentation/devicetree/bindings/processed-schema.json
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   DTEX    Documentation/devicetree/bindings/media/cnm,wave5.example.dts
   DTC_CHK Documentation/devicetree/bindings/media/cnm,wave5.example.dtb
```

Again sorry about missing the indentation warning, but nothing else was
highlighted.

Both dtschema and yamllint seem to be up-to-date:
```
❯ python3 -m pip --version
pip 23.2.1 from /home/basti/.local/lib/python3.8/site-packages/pip (python 3.8)
❯ pip3 show dtschema
Name: dtschema
Version: 2023.7
Summary: DeviceTree validation schema and tools
Home-page: https://github.com/devicetree-org/dt-schema
Author: Rob Herring
Author-email: robh@kernel.org
License: BSD
Location: /home/basti/.local/lib/python3.8/site-packages
Requires: jsonschema, pylibfdt, rfc3987, ruamel.yaml
Required-by: 
❯ pip3 show yamllint
Name: yamllint
Version: 1.32.0
Summary: A linter for YAML files.
Home-page: 
Author: Adrien Vergé
Author-email: 
License: GPL-3.0-only
Location: /home/basti/.local/lib/python3.8/site-packages
Requires: pathspec, pyyaml
Required-by: 
```

>
>Missing blank line

Ack, will add that.
>
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: VCODEC clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: vcodec
>
>Drop clock-names, not really useful for one entry.

Ack

>
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  sram:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>
>Drop blank line

Ack

>
>> +    description:
>> +      The VPU uses the SRAM to store some of the reference data instead of
>> +      storing it on DMA memory. It is mainly used for the purpose of reducing
>> +      bandwidth.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>
>Keep the same order as listed in properties:

Ack

>
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>
>Best regards,
>Krzysztof

Sincerely,
Sebastian

>
>_______________________________________________
>Kernel mailing list -- kernel@mailman.collabora.com
>To unsubscribe send an email to kernel-leave@mailman.collabora.com

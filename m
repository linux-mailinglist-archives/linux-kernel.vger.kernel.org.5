Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A407C633B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbjJLDUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjJLDUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:20:52 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA339E;
        Wed, 11 Oct 2023 20:20:50 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c4f1f0774dso356036a34.2;
        Wed, 11 Oct 2023 20:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697080850; x=1697685650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vNG7kOTp0E3II+uSMqFswlod5Ow+9hu5BlR/XYnJYVI=;
        b=VQAj9/3JS7nnukClMdEZCbOmHZMrJG59uqVEwjVoaDvGf9+5kw0XD71QWVA9NlfCu8
         lrvtm8MGXZq4ksChLMoju2ljyDvxsYpCWcen/fqFGfu+QDGLHanXkvRUsUR7GDUVnY4Z
         QVxMx4IWPDbS7m8jdB7Bc6ZqIuHX/oxJtfopADyE1MiQksuKezb8w01CGi2CEaLVwazO
         dk+vhPqhP6o901xq2pIGtMIXeTgmXkHGT6acT0s447CRVRZGuuQxUBRHGJYt4QO6CY6u
         WA3Nm4UZFJ4ueMYBuP/EGq62BMQlCcfP8ePrqJNhT1O7/OfUHNrBxUtiZdtRFqMD8lj5
         gbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697080850; x=1697685650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNG7kOTp0E3II+uSMqFswlod5Ow+9hu5BlR/XYnJYVI=;
        b=n3yHOXgNcxl0EavIiBDmJr6ENMB2V0LxJ/gbxx6HMfcfJh5JUBpRoom9ESiSzrug/1
         cKXKATFMH4+bV5H5epKvbJEj87dZa3FFXmuNX6+b3YN+aogikkXwUOF0cwNI6CtS26Gi
         f6OYEjwge8rnqUl0HDL1Yg5Y/h+dVQWWHCXTQA3GV+lH6uvAQvsy18rTxRIsYYiUVj7O
         bsnseBvg1sMD3WMa/px5ZVI3sn60CJBpSsEdYxubd+WQU0A3XLmbciEszkzJbqk1ghAX
         qqYPmSS0mHXvDO00k2Hi+iyYNnDdm5SmpNwJO15HQrHc0qWIE9owee4SshoKKrCPLApt
         cBwQ==
X-Gm-Message-State: AOJu0Yx/Rv3FpDXentfdzQ9wW6x885cxCNabfuKHE1U/wLr925pQwsR7
        YLUqj+DZqc7CesiQXQsgp1z+vrz/CIoUQRoteM1h4sj4eyk=
X-Google-Smtp-Source: AGHT+IEJ/Ts2npz7DwaEYA5Fetgq6XGZn7nXYSITpB9w7w3c+Qb6n8AU6Cql2mmsAsXtCsIvXXwq2JtHuU0mI/8mHxU=
X-Received: by 2002:a9d:4e91:0:b0:6b8:f588:2c79 with SMTP id
 v17-20020a9d4e91000000b006b8f5882c79mr25179667otk.1.1697080850001; Wed, 11
 Oct 2023 20:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231011051152.133257-1-linux.amoon@gmail.com> <169700589265.2911018.855796610271678067.robh@kernel.org>
In-Reply-To: <169700589265.2911018.855796610271678067.robh@kernel.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 12 Oct 2023 08:50:33 +0530
Message-ID: <CANAwSgQxG7GNFnJ8mR_ktnbpfOZLA2JwsEt3qbO0RDEemf21ig@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
To:     Rob Herring <robh@kernel.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 11 Oct 2023 at 12:01, Rob Herring <robh@kernel.org> wrote:
>
>
> On Wed, 11 Oct 2023 10:41:48 +0530, Anand Moon wrote:
> > Add the binding example for the USB3.1 Genesys Logic GL3523
> > integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> > hub.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > New patch.
> > ---
> >  .../bindings/usb/genesys,gl850g.yaml          | 28 +++++++++++++++++--
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb-hcd.example.dtb: hub@1: 'reset-gpios' is a required property
>         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb-hcd.example.dtb: hub@1: 'vdd-supply' is a required property
>         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb-hcd.example.dtb: hub@1: 'peer-hub' is a required property
>         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb-device.example.dtb: hub@1: 'reset-gpios' is a required property
>         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb-device.example.dtb: hub@1: 'vdd-supply' is a required property
>         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/usb-device.example.dtb: hub@1: 'peer-hub' is a required property
>         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231011051152.133257-1-linux.amoon@gmail.com
>
> The base for the series is generally the latest rc1. A different dependency
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
> your schema. However, it must be unset to test all examples with your schema.
>

Can you share an example to add two examples in this binding?
one for usb5e3,608 and other for usb5e3,610, usb5e3,620,
I have tried but I got an error for duplicate

I have tried to modify it with the following example

+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: usb5e3,608
+    then:
+      properties:
+        reset-gpios: true
+        vdd-supply: false
+        peer-hub: false
+    else:
+      $ref: usb-device.yaml
+      required:
+        - peer-hub

but it still shows me his warning,

  DTC_CHK Documentation/devicetree/bindings/usb/usb-hcd.example.dtb
/home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-hcd.example.dtb:
hub@1: 'peer-hub' is a required property
        from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#

I could not find any binding which supports these properties.
  - reset-gpios
  - vdd-supply
  - peer-hub

Please suggest to me how to resolve this warning.

Thanks
-Anand

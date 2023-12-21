Return-Path: <linux-kernel+bounces-7708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F2B81ABD9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1C91F24826
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D6010FF;
	Thu, 21 Dec 2023 00:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H53huOBb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E9610EB;
	Thu, 21 Dec 2023 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7b7d55d7717so10444839f.2;
        Wed, 20 Dec 2023 16:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703119469; x=1703724269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fixDV/PBfstTPYlfQh0KnMaKDB6N+aKH9jm856xZlM=;
        b=H53huOBbcH66wLZZUdX7QmXXU3Yc7ATseRP+0xI9YrTzMslbATnTvlUuZirZiifRyp
         hccCdfyfC7x7jNWqCyk1YLelZq8mvOHkP2MIANJvUzgG4q0rhmVkglsh9nIdmDP+SXnd
         WWv3xwWKQi8/8vpqe+A/u3ZmtTQQG/YgPiAtIGIlW0+1+WnrhqxnwrhuJbVnu3XhJFLk
         vw5JjUhY52gkA2lWvcVqhZDcij1SCfOLIbndxXv/DufxE8B82J+AzhlYKPegwpOK74A8
         25Gxk5IfKGZOwqcxUXHhZQ+cIK3bR9mLeEt+BnmWDf+pTIGjQMtFi6Dgs26bHExDISWv
         vDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703119469; x=1703724269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fixDV/PBfstTPYlfQh0KnMaKDB6N+aKH9jm856xZlM=;
        b=fqhukwri9IIrRs75CHo1JSHQ++t/G6K027/eSvRJrS4E4O2wFawZZ8zJezzPoDC6Ip
         rp6Ok/sR9mRBl8YL/k41ah65nPYAEIkSQLbEf6bdIP6U6SZjMNriSBVo4d6u1eq11ROU
         +0STMAkK0LRbUYksEYhdBTQJC0F333eFFLoO3RBNRnQL5oSwqkxeYjqjQSVEtcY3yM36
         ZfUEwxcxfY8ZfyOxmH/3gMXVkmvUpzLuTR+93fXJnLNx3Dg4wOMB4B8hjqdvWjg8u7MO
         +le/6N6CRxUol6FVrabrRdhhuDtSg5iNJrheMLA/v2iwQR57aKWfK1WjQckbdraBFbrU
         Q4rg==
X-Gm-Message-State: AOJu0Yzs3Jsm9giPVXQgtvbEdUokIfRI3WUpgkhTCKZtPbV0hdnb7v46
	AIFK7P4FTCbVb8WCr7xbC4RF/eTAko8OFCie510=
X-Google-Smtp-Source: AGHT+IE1v3zE8p80V7WUEaDPtzDfdDBx/oDJ6zVRlbWEjN9Z6MF44fr5JO0hoMXWlR6InA7H23fqFItogjg1PHsUiTI=
X-Received: by 2002:a5e:da48:0:b0:7ba:7baf:6db2 with SMTP id
 o8-20020a5eda48000000b007ba7baf6db2mr1469143iop.34.1703119469285; Wed, 20 Dec
 2023 16:44:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219080021.2048889-1-kcfeng0@nuvoton.com> <20231219080021.2048889-2-kcfeng0@nuvoton.com>
 <170297774900.1297817.5593278746406765111.robh@kernel.org>
In-Reply-To: <170297774900.1297817.5593278746406765111.robh@kernel.org>
From: Ban Feng <baneric926@gmail.com>
Date: Thu, 21 Dec 2023 08:44:18 +0800
Message-ID: <CALz278aJ08fOU2XZMZJJ2Ocp+XwovJ0+nHK-=0dWqbXf+522OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, corbet@lwn.net, kwliu@nuvoton.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, jdelvare@suse.com, 
	kcfeng0@nuvoton.com, krzysztof.kozlowski+dt@linaro.org, 
	linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org, robh+dt@kernel.org, 
	Bonnie_Lo@wiwynn.com, conor+dt@kernel.org, DELPHINE_CHIU@wiwynn.com, 
	linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Tue, Dec 19, 2023 at 5:22=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Tue, 19 Dec 2023 16:00:20 +0800, baneric926@gmail.com wrote:
> > From: Ban Feng <kcfeng0@nuvoton.com>
> >
> > Adding bindings for the Nuvoton NCT7363Y Fan Controller
> >
> > Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> > ---
> >  .../bindings/hwmon/nuvoton,nct7363.yaml       | 62 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 ++
> >  2 files changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct=
7363.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

Our design is based on [1], and adds fan-common.yaml to
Documentation/devicetree/bindings/hwmon/,
I didn't see any errors when executing dt_binding_check.
This design is suggested by reviewer, and  [1] is still reviewing:
[1]: https://patchwork.kernel.org/project/linux-hwmon/patch/20231107105025.=
1480561-2-billy_tsai@aspeedtech.com/

How to modify our patch to achieve referencing patch not merged yet?

>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/h=
wmon/nuvoton,nct7363.yaml:
> Error in referenced schema matching $id: http://devicetree.org/schemas/hw=
mon/fan-common.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/h=
wmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-0: False schema does not al=
low {'pwms': [[1, 0, 50000]], 'tach-ch': ['']}
>         from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7=
363.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/h=
wmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-1: False schema does not al=
low {'pwms': [[1, 1, 50000]], 'tach-ch': b'\x01'}
>         from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7=
363.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/h=
wmon/nuvoton,nct7363.example.dtb: fan-1: tach-ch: b'\x01' is not of type 'o=
bject', 'array', 'boolean', 'null'
>         from schema $id: http://devicetree.org/schemas/dt-core.yaml#
>
> doc reference errors (make refcheckdocs):
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/=
devicetree/bindings/hwmon/nuvoton,nct736x.yaml
> MAINTAINERS: Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml

I will modify this typo in v3.

Thanks,
Ban

>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202312=
19080021.2048889-2-kcfeng0@nuvoton.com
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


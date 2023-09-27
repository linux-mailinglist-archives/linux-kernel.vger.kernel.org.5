Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EF37AF896
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjI0DZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjI0DXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:23:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB5E1588F;
        Tue, 26 Sep 2023 19:45:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6927528c01dso1592839b3a.0;
        Tue, 26 Sep 2023 19:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695782726; x=1696387526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo4eZj80i7lnqXGQPNze2DYnN/vFdAqsTiyd8wFnr7M=;
        b=lH367FjzaNb/cCTaqhZVZrrUX9Y3Zdmc/6Ha58QzTys2UWbQYsgxNLfJxp6tA0syrb
         WO3ZjAZSMU2+nV19ZHgGOT8jQME51AUi84LMOTs0txr/10UqLyoFBZkXNyV2iOKOK8sL
         1gbOv9GyQehUIeaHWMZmPxyn3A7Px2wmgHpIa8HDuNOW0GKIcttP+7NMfCvCan5rR03M
         fb//qS4aX+x4CTGvDtCk/ZvOopA4YspuCvt85GTRg+LEfZSUBtHQxYSkBMN/0QQT8bsD
         kCZISuxoFP/HkZfg+23fGwLhpAeEqfY8sk27o8TejPy6DEDn5HGlY7+tf1j7IVNN56XY
         9/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695782726; x=1696387526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zo4eZj80i7lnqXGQPNze2DYnN/vFdAqsTiyd8wFnr7M=;
        b=kznuYqtKdiLT3AA3B9DRr8MUyuMVpEf6CjNCYnZBNgsaQKV37+nfQ16Dvf1lHrwl1A
         H5VhFBD5eUH3LAowVF+5lNZjwsZKuVrkdhghO9bZ6UqyR3cQJDb4GVaZ3QaroPjqzg9u
         YR/+BgGPva4xJ7tYeMpc5qKHD4NENzZ3vHHm36tPIrSEGq4wSsvUZFqPuMqedFZBMF02
         3yk9iR2nmXP4/pvgWdsCpcHtfzzTdib3CiBBX71NnWGJlALneg+pM77A+5IGov9XpYUi
         UAejTwZjBHXSUU3ZNWINiHNEMJyeLtDAGAruHOX3lOaHwYtwVlu2W8R3kCr3uGms+uME
         mqeg==
X-Gm-Message-State: AOJu0YzkRMd/YiC4ngmBa1hb1o7UsjXk7ul9XH5Wx0z2fstcfqz+nZmR
        AmhrR9owuv0ZWlL4i7aAN3CyUIfwL9tIN39meAXBPRDtkOg=
X-Google-Smtp-Source: AGHT+IFJwBoarpWS3kZn6qektf8GP/bw3F60AtAYeDyv1lSkI64iQsPlykC+Te7ZnpXbLxHzGbxbTvWQAYCIJEG/Ncs=
X-Received: by 2002:a05:6a21:6d88:b0:15d:f804:6907 with SMTP id
 wl8-20020a056a216d8800b0015df8046907mr846347pzb.0.1695782725738; Tue, 26 Sep
 2023 19:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230927023321.3955170-1-chancel.liu@nxp.com>
In-Reply-To: <20230927023321.3955170-1-chancel.liu@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Sep 2023 23:45:13 -0300
Message-ID: <CAOMZO5AnDuU1cd2oLuNd-HSv7LEnn7y4PWjqzRoQdf-PaaU-TQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx93: Add audio device nodes
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 11:33=E2=80=AFPM Chancel Liu <chancel.liu@nxp.com> =
wrote:

> +                       mqs1: mqs {
> +                               compatible =3D "fsl,imx93-mqs";
> +                               gpr =3D <&anomix_ns_gpr>;
> +                               status =3D "disabled";

No clocks here?

Please convert Documentation/devicetree/bindings/sound/fsl,mqs.txt to yaml.

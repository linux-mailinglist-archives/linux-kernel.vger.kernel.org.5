Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E38477FCD5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353688AbjHQRR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353481AbjHQRRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:17:22 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E7BF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:17:21 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34ba9d6561aso173625ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692292640; x=1692897440;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSGKblR3OXJrnjJWxLl6H+gcDsbsJZ3wuLzAauLCVPY=;
        b=pdbMCorYR90h1GxmM0EvND2ko9AWC4J/xp5mGuhJiLdSspKz4KwBjGLqFQtps7D40q
         28rOpmKZB/3WFdHJQDiOWybkeAs6EGCooYG8PQ/iYhTQXaNsQgrtPjnJFe4XJoNivl04
         QTnwZprpvC8GeG9Khycx5aFD9KUimbHCcXd8vTG8OfAwboZleROqNqvCKR1PIC01OxRv
         dlpNTp+w2oCiOUezCwAEiLAAxvk/kFc1MTXPKOtFBdMrrmbvviLWAHdND9yLOV3LP41C
         nymR7MGKEFwGWX2ujj397xl7RyXFUOnjFXB8GVSHoT1041w3Wc2bQwebaaoI0vtpovkx
         lfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692292640; x=1692897440;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSGKblR3OXJrnjJWxLl6H+gcDsbsJZ3wuLzAauLCVPY=;
        b=SbJzEfyYJMqE/deasEEK644BJp/zZKJh3/Zmt+eZWqCCLq6AvYTL0vQNWVieWKLRwm
         RpYHV8TvI3NrMmzd6Hhj2Ip0aMuv/mFu/dvJlSpHGq4nxG4717ulLK0gIWQ3eOFlxJB+
         cvh5k0LQGCiA0B/ynTWkH4nUnf/garGakKl/KBK/SYdSw1csQKT8kujno/ZzzydIEIxd
         aMSvGQGmqKskNGW+7uKxcu+8bbeBXkcqgui2vbaYYGwU9amu7cmpcvO9SQfsHE9KGKlV
         wYVg8uFz4IDyl0iUOuXJUxJxqt2XhK8OvQq61ZAjrA4/GVasPPrTQNjc92nGZHV7/SPE
         xLaQ==
X-Gm-Message-State: AOJu0Yw6wu1z7+EoKHBFJFqCFAufLv3vIhlWGHfnoLcbgFOA8qS0P8md
        +xZ0/kHoWMXpplfhKEdYyBpSj/3fSpm5ow==
X-Google-Smtp-Source: AGHT+IGe2iegOMwHHgT19hUvVPOKArg8EKL4EEAfjjAuPARY+lm7QDpCKkqyh4qHa1l+LeWMEXtnqg==
X-Received: by 2002:a92:c249:0:b0:348:8ebc:f759 with SMTP id k9-20020a92c249000000b003488ebcf759mr239495ilo.6.1692292640636;
        Thu, 17 Aug 2023 10:17:20 -0700 (PDT)
Received: from smtpclient.apple ([103.149.144.245])
        by smtp.gmail.com with ESMTPSA id t1-20020a056e02060100b0034a9a9a2016sm3228875ils.23.2023.08.17.10.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 10:17:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Clus Tom <ssunkkan@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Add support for more XMC series
Date:   Fri, 18 Aug 2023 01:17:06 +0800
Message-Id: <2F4A4D23-1C71-42B9-8B2C-06496F773BDA@gmail.com>
References: <abd705350b650717dbbc187815d384e7@walle.cc>
Cc:     miquel.raynal@bootlin.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, pratyush@kernel.org, richard@nod.at,
        tudor.ambarus@linaro.org, vigneshr@ti.com
In-Reply-To: <abd705350b650717dbbc187815d384e7@walle.cc>
To:     Michael Walle <michael@walle.cc>
X-Mailer: iPhone Mail (20G75)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, I'm using the latest kernel.


> =E5=9C=A8 2023=E5=B9=B48=E6=9C=8818=E6=97=A5=EF=BC=8C01:10=EF=BC=8CMichael=
 Walle <michael@walle.cc> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> =EF=BB=BFHi,
>=20
>>> XMC parts seem to have SFDP tables and they should work out of the box
>>> without any patches with the generic spi nor driver [1]. Therefore,
>>> you don't need any entry at all.
>> I think it is related to the PARSE_SFDP flag.
>> The XMC flash part supports SFDP, so i don=E2=80=99t needto add
>> NO_SFDP_FLAGS() macro.
>=20
> Correct. If the flash is working with PARSE_SFDP, it has SFDP and
> all the information of the flash_info table is pulled from the SFDP
> tables, except for the part name. Therefore, you don't need any entry
> at all. The flash should just work out of the box. Are you using the
> latest kernel?
>=20
> -michael

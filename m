Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6688E77C5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjHOCdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjHOCco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:32:44 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15ED10D0;
        Mon, 14 Aug 2023 19:32:43 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-56d0f4180bbso3711539eaf.1;
        Mon, 14 Aug 2023 19:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692066763; x=1692671563;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hlrmRxGLs/F9DipX5bUXix2iv7UjJrjeQCKjVDbSg4=;
        b=h6mXIiKE0O3Y08U5/64fqjrUPBQre19/pWOepTuSEqs4CwW4mmRDAtyIHFC7Izr0mK
         BUR2vOM2Gnd7EarkFvJ7dT+IVTrzxC5jcnViF3aXUeh2KGLeHTrWgTzk4gwAr4p8+BSO
         Sbld71OqoQ5vIfZdwo/B+DIXc2iQITJ+QWBC4nMOYwmsu/umuUewZ8PUUL9kAcVbqEw2
         mKQQQqnUvtCuKnWHiWjuEz1qYf21Kve0rH1T8HIrJk95PJlBnkt9Ld2WadyApYajXsrs
         wAwOGpgu9K1jPUaMVA7tspadXg8cUh7OlmhybkLuRtyvGpotFcYmcIpkgzeUnE+nCx6x
         yeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692066763; x=1692671563;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hlrmRxGLs/F9DipX5bUXix2iv7UjJrjeQCKjVDbSg4=;
        b=Q83uJzLjLxRize/Ww4c9tv1R+TvbLVXIe3xpP88igJcPgiuPkis4Dw0bMot5Kmm52k
         Q1gpt4LTqvWldViXAKpQ7EegZb/evDUcKmHOXM5IyMGcRA4uzhkPSREhKU16SLRBr1Xt
         Kse7WnU6OjwZrbx3i9oRlNgF2Otru604hjPhQZPuvyG7JGxQoirJstjBQmfFRHk2jNQa
         NqzvE1ad89cZY6ycveqcusmNA6P/5S+zfb9limimmM3IyoOHqhOJV1NDCbT6J00Sug6t
         /ZPCK0hbTXbll/8Bk4pNDJGkS7rArf7GbI+vFdS3lv8/t5NakRj65fSPN1sSP0Er++il
         LtYQ==
X-Gm-Message-State: AOJu0YyGKxMAyTp9Bc7qSz0vXtSSkXi7YBQL6TN93PN8+PvIs/FAvDT7
        noNkBah4kjUefBZus/d/PuM=
X-Google-Smtp-Source: AGHT+IEHLVcZrXYkf4lPLUJYIE6Kr7VuFAGnc8GiUv44goBA/vP6bdh6hOU12wVcfQ0Q/YURKf+4oA==
X-Received: by 2002:a05:6358:418b:b0:134:ece4:1e74 with SMTP id w11-20020a056358418b00b00134ece41e74mr7753239rwc.21.1692066762816;
        Mon, 14 Aug 2023 19:32:42 -0700 (PDT)
Received: from smtpclient.apple ([2401:e180:88a1:80ef:f4f9:717b:5cd:3109])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b00640dbbd7830sm8857152pfm.18.2023.08.14.19.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 19:32:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Mining Lin <mimi05633@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/2] dt-bindings: rtc: nuvoton: Add DT compatible
Date:   Tue, 15 Aug 2023 10:32:30 +0800
Message-Id: <8BF54CCD-FCCB-430A-A78E-53DC55F3C286@gmail.com>
References: <d23de35f-8d55-4f80-a6ce-281f83fd4243@molgen.mpg.de>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d23de35f-8d55-4f80-a6ce-281f83fd4243@molgen.mpg.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: iPhone Mail (20G75)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Paul,

Thank you for your comments.
I  originally wanted to judge whether to match chip data by DT compatible, b=
ut it does not make sense.
Therefore, I will remove it in the v4 version.

Thanks.
Best regard,
Mia

> On Aug 10, 2023, at 3:55 PM, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>=20
> =EF=BB=BFDear Mia,
>=20
>=20
> Thank you for your patch. It=E2=80=99d be great if you mentioned nct3015y i=
n the commit message summary/title. Maybe:
>=20
> dt-bindings: rtc: Add compatible nct3015y to nuvoton,nct3018y
>=20
>> Am 09.08.23 um 11:51 schrieb Mia Lin:
>> Add DT compatible "nuvoton,nct3015y" to select
>=20
> What do you mean by =E2=80=9Cto select=E2=80=9D?
>=20
> Also, maybe add how you tested this.
>=20
>> Signed-off-by: Mia Lin <mimi05633@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml b=
/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
>> index 4f9b5604acd9..67fc60fd395c 100644
>> --- a/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
>> +++ b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
>> @@ -15,7 +15,9 @@ maintainers:
>>    properties:
>>    compatible:
>> -    const: nuvoton,nct3018y
>> +    enum:
>> +      - nuvoton,nct3018y
>> +      - nuvoton,nct3015y
>=20
> Would sorting the list be useful?
>=20
>>    reg:
>>      maxItems: 1
>=20
>=20
> Kind regards,
>=20
> Paul

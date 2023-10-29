Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08977DABD2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 09:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjJ2IzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 04:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2IzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 04:55:15 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5596C5;
        Sun, 29 Oct 2023 01:55:12 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 46e09a7af769-6ce2d4567caso2318182a34.2;
        Sun, 29 Oct 2023 01:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698569712; x=1699174512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fYIGNwFWZy4nwypsvGihJFy/e8948/9zR6WomBIKnU=;
        b=AbUQibrqrUBI67t4jcBCq0YOwqx32CIjT/+xJpZHJMOszvWgjcmqoBmrMtyIZBS8OX
         +DIly+ny+XN8dthIySNdTsX1ZocbDaHNR10PmjASvfvjPcunFdcUyS3cVWSlet7eULxX
         S84B52O2UglTGPHNAy8T/F0eeaFhi/xCYzoYwMrD4aa+QyoujpgUrMPJRzk9q5weSMmT
         +gGjobX+16hw7Sj8boLgzL8GOGTFiGlR4yxeHoi7XRhQ39Ays4Q11PmfVYKKbusQngdY
         qrb2RZndCuzZp5PRaWwmWKFcbOoMzGL76cHnlF+A8+CN+fATSwuxYO29L00M/p21fOFP
         fNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698569712; x=1699174512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fYIGNwFWZy4nwypsvGihJFy/e8948/9zR6WomBIKnU=;
        b=rQSZ9Sz+UWRMjdIA7l1EqoiB86WnYxF7PUtEEZHMS6gdg2MAGMI3bbcxWTEfGBejy+
         5eVHw5B4U1u1yI34MDcPPPGH44aIVvqaTNqftuMffixGLXS9nkyXigOl6CzdVyBwmWbZ
         PQGv+GEOJnY/sssrj/oQShjRoICZnXEh1wxzaylmsDg7K149obsOy2DzSJhu5Q5ETgzs
         6IZyI2yVNH3kbsCgbn1uK/cEoZc3E206scHOC9VFjdwLJTSRhtAllZkYzg4HkTJDwc1a
         crTWPs/fjTQ7PE0cz8berI+n/e7S1m6o8d8QdpvoCI2JbnECtV8sIkN7F/usaRRFCqWX
         BGWQ==
X-Gm-Message-State: AOJu0YwxF44K558E+eDTj7BYPH1pMGoB7AeawRvQmo7OidvPhAMit5QE
        4cLHHC2g5gxWwMQfLrq2iYlHgEtBm4FzT2wpo3UmgZE4cfV0z1iY9Bs=
X-Google-Smtp-Source: AGHT+IFZHQmbDLfXhXXI4CZ0tpJamLJRv8QboOXFYf+whs+m+uYeATaqQTaFFgLW66ajgPLwyFXsyNBhdrZLdNz/2A8=
X-Received: by 2002:a05:6358:5924:b0:168:de6b:6c70 with SMTP id
 g36-20020a056358592400b00168de6b6c70mr6747254rwf.1.1698569711567; Sun, 29 Oct
 2023 01:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <025c3d36-587e-480c-b913-2a3916674c54@kernel.org>
 <20231028082056.43276-1-579lpy@gmail.com> <29d2e5dc-7eb1-4dba-a2fe-4829fdb65a95@kernel.org>
 <CAELPsEZV2rgt7M_UxyhB-QZ+TWcYjgi_PORO9Tk4Lofp2AFTmw@mail.gmail.com> <99a72af9-272b-4971-9eaf-64a171b59eb7@kernel.org>
In-Reply-To: <99a72af9-272b-4971-9eaf-64a171b59eb7@kernel.org>
From:   peiyu li <579lpy@gmail.com>
Date:   Sun, 29 Oct 2023 16:55:00 +0800
Message-ID: <CAELPsEao2Zsi+n7261TZn8EVR0RmTuWNJx-JXtokApKaVJk=HQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: hwmon: lm87: convert to YAML
To:     Krzysztof Kozlowski <krzk@kernel.org>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 10:58=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> You even removed my address when replying this!
>
> > run checkpatch.pl,resulting in not finding an extra space.Now running t=
he
> > dt_binding_check on my computer will cause an error regarding the
> > ti,ds90ub960.yaml
> > file when I specify the file to be checked as lm87.yaml. This error wil=
l occur
> > even if I specify other files, I am not sure if it will have an
> > impact.I'll submit
> > v4.If there are still issues,please tell me the reason again.Sorry agai=
n.
>
>
> v4 did not improve. Please explain me carefully how did you implement
> these two feedbacks from first version, so 25th of Oct:
>
> > Please use scripts/get_maintainers.pl to get a list of necessary
> people and lists to CC.
>

I will send the next patch to all necessary people and cc all necessary lis=
ts.

> > Also, please use filename like compatible.
>

In the next version I will change the file name to "ti,lm87.yaml",
which is the same as "compatible".

> Best regards,
> Krzysztof
>

Thanks,
Li peiyu

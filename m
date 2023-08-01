Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC0A76BC15
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjHASNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjHASNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:13:34 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA281718;
        Tue,  1 Aug 2023 11:13:33 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so22722701fa.3;
        Tue, 01 Aug 2023 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690913611; x=1691518411;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SX9SROyYlg4Z57m8wNgFv1TluRxtlys2GnXNOmheIgY=;
        b=GOtKLuKzbaetr/yM0mQawdNUEwqvjTx+JHn63H7hSXRklQ9faYuUsEznr5ur6NQxDp
         9l5Jn8SR19Lh/pTZACMPzLUvsBmSFaY+QlfF3x6gMUTmbLjiOmc3+QLzZkeo9BOwcDgA
         f5vy2wd7vFRQn49Zm8Peo8t9tOpjX3nt2rb9u+FXZF+o4RdystjWEylo8eT/XCnku4XS
         tqAD47o00ArSAOYNIsvw4xKi2eJlt5L/kk7+MBXaLpJsu3yflqvYMQBEIQDw69uTATZI
         5O8VsciWwFq+ISyPjMqwBEzbScyuyV5GJiZquGbTXV/VO1ZLEo8gVjYbk6HPeEUULPMQ
         LPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690913611; x=1691518411;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SX9SROyYlg4Z57m8wNgFv1TluRxtlys2GnXNOmheIgY=;
        b=XyLL6OGqiA/CSB7wiIHdI3IDHs5+9J1aDfipNiqpmcYv1MIl1eTTZ5W0Wx720U4KSC
         5WbM/q+kzLzddWnBqJnTvx26zA9wcANAAHfZ7TOzEWBuOsxUyjfNk2RzGLVubKmqqk08
         dWgh5i6Luo5vlD8YntaAax9PrjTtnsltxTm6ktD1Vk32tMTgP197F7CKsuWxF2Uh3XE3
         y44g5e+W9H20Pm1EG3EHNVIoaMVz3DyEtT70GnCeJgG3UMXKBOcSO+SjNqSJLhPhhsrC
         LZ10UbvANatfLNOlVyMe6HpxCcyN5v+bKEaJ9J59tzZYHCPqkxzULwQthVf7G9WyWCwc
         pi7A==
X-Gm-Message-State: ABy/qLbWUFMVHeA0jNkJiOc0Fl4RG+yA4AjUQOli0Mi66+kSgU+WA01E
        qwAiB8lHD7KE9xaW1QS4L3c=
X-Google-Smtp-Source: APBJJlGvIAUJQe2AwNnP7ttKEzBGssvzjJCeL8BP9V27t4d3RAQ/LD74zzqRS9TyJDksK9ur5/CjHA==
X-Received: by 2002:a05:651c:1028:b0:2b9:f007:9910 with SMTP id w8-20020a05651c102800b002b9f0079910mr2450664ljm.53.1690913611362;
        Tue, 01 Aug 2023 11:13:31 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.6.234])
        by smtp.gmail.com with ESMTPSA id f14-20020a2e6a0e000000b002b9e0d19644sm1771838ljc.106.2023.08.01.11.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 11:13:31 -0700 (PDT)
Date:   Tue, 01 Aug 2023 21:13:30 +0300
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samu Onkalo <samu.p.onkalo@nokia.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] misc: adps990x: convert to OF
User-Agent: K-9 Mail for Android
In-Reply-To: <20230801191026.02512438@jic23-huawei>
References: <20230731110239.107086-1-clamor95@gmail.com> <20230731110239.107086-3-clamor95@gmail.com> <a16db5ac-2b9a-45ab-b693-2f459d689c7d@app.fastmail.com> <7C51AA15-DEBE-486B-9788-F84B260F8880@gmail.com> <c7526061-2f4e-4843-825c-98d9494af625@app.fastmail.com> <20230801191026.02512438@jic23-huawei>
Message-ID: <8A489018-9C77-4013-B055-89853ACBF8C6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



1 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 21:10:26 GMT+03:00, =
Jonathan Cameron <jic23@kernel=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=B2(-=D0=BB=D0=B0):
>On Mon, 31 Jul 2023 17:38:59 +0200
>"Arnd Bergmann" <arnd@arndb=2Ede> wrote:
>
>> On Mon, Jul 31, 2023, at 16:58, Svyatoslav Ryhel wrote:
>> > 31 =D0=BB=D0=B8=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 16:18:16 GMT+03:00, =
Arnd Bergmann <arnd@arndb=2Ede> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(=
-=D0=BB=D0=B0): =20
>> >>On Mon, Jul 31, 2023, at 13:02, Svyatoslav Ryhel wrote: =20
>> >>> Add ability to use device tree bindings keeping existing setup=2E =
=20
>> >>
>> >>I see that there are no more in-tree users of the old
>> >>apds990x_platform_data, so I think it would be best to completely
>> >>remove that codepath and merge that structure into struct
>> >>apds990x_chip, to simplify the probing and avoid the extra
>> >>allocation=2E =20
>> >
>> > Thank you very much for your review, but is it mandatory to drop pdat=
a=20
>> > in this particular patch set? To be honest this driver needs serious=
=20
>> > upgrades and refactoring, and I have no dedication to invest my time=
=20
>> > into refactoring it, moreover, I am not a maintainer of this driver,=
=20
>> > nor a full time kernel maintainer of any kind=2E I am doing what I am=
=20
>> > doing only because one of my devices uses this als but it is not=20
>> > something crucial=2E =20
>>=20
>> We have a lot of drivers that are lacking the cleanup I'm asking
>> for, so I don't think I'd mandate it at this point, but I don't
>> actually expect the patch to be any more complicated in the end,
>> so just try it out=2E
>>=20
>> I think at the minimum, please remove the include/platform_data
>> header and move the contents into the driver itself, I'd be fine
>> with that=2E If you can easily do further cleanup by dropping
>> the separate allocation and folding the apds990x_fw_probe()
>> function back into apds990x_probe(), please do that, just stop
>> at the point where you feel it gets too complicated=2E
>>=20
>
>It's a long shot, but this looks pretty close in register map to
>the apds9960 in IIO=2E
>
>Maybe try adding the ID to that driver and cross your fingers?

If you pay me for a broken phone or repair if smth goes wrong, sure, why n=
ot=2E

>There is some stuff going on around the register address / commands
>that I haven't figured out but it looks similar for the byte access
>path and that may be all the IIO driver is using=2E
>
>If you are fine testing, it's possible someone else might do the
>leg work (if me I'll emulate just enough to convince myself I didn't
>break it too badly)=2E Won't be high on my list, but maybe I'll get
>a boring wet weekend sometime=2E=2E=2E
>
>Jonathan
>
>>     Arnd
>

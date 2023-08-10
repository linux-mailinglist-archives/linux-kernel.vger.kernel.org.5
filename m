Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8884377795A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjHJNQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHJNQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:16:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46BC10E6;
        Thu, 10 Aug 2023 06:16:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so1875247a12.1;
        Thu, 10 Aug 2023 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691673372; x=1692278172;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAuRIb9hwyIu6dnXcH+TXEAAfJ99BNcUhSMFW29Ah70=;
        b=sRrQlKiNnZ7svKfAek7DmHQQeVDV5TvUCLnQ862Xr1UYovByLii4ywFObEu4sv3NF/
         biUPBLmcUWV0Yo/dPcp3rxw2Fds1Kf+Yu9YKtwPzyZIT5zBjXvpIs0sXdZnYsEJaqzE0
         47D/k4i6nYaql12YAAoAuwyhbZ9VO1fyeyB4sbk6nb8qKq7gOZNiaE3Cf+PdvKi7NbCA
         JHjlOkYWVnKonQyDEMIhVWQBY2V6LVaBsLJuVFv4FtpwaBh2T6A1kdUAGYYMx/RVA0qr
         v/6+HCnQzDdVrRSppBs3roQmz/n+SxxNQxhjzENrh5Oq0Zls+rXtGHDxM51TNFxhX4Jc
         WQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673372; x=1692278172;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAuRIb9hwyIu6dnXcH+TXEAAfJ99BNcUhSMFW29Ah70=;
        b=HrjGoQhBHT+kgrU1luqJIF4k1UDI9TqA8vSY/IX6PArjbupGPMqgxi5KkpZa6rZ/Y+
         Ka9ZpegWiTLDOhYSSOOEYFy7f1iNhMw9s4c7FjFLZC8iBrhIde16bwlKM2iaAnqSBc0o
         52n7Xe60eT3XXzm1ib83KLQQRrj8ChYIMgjgZOHhiBbA/8kZwFGSCGJCJTaoW0WSdSiS
         tnOuQfDGdXRbcZmChBtn/FlIGaFzKys88coo2WSVfkltwNMLuujJnZQ6Ye8o1bKxBm7n
         Mw9jKczv0S9zIJdGi3lhHrAbCeqUU4wlkBM5ZsMam94tV5REAQVRZTFqsLyQ+ReEiE0q
         2t/Q==
X-Gm-Message-State: AOJu0Yy9bYHp1VFa2xp62ZzCzkohog66gkDV1XxjLFvPA3fR3PtyAODj
        DMnfExyWbWFsT4wxGldg3I8=
X-Google-Smtp-Source: AGHT+IHNI3HnqX57z6jfrhpjJsEH/IGWIeQH5dVXv7HkFv0eLYEnRGHjapQoJzGJnuxNaHPbS1GIew==
X-Received: by 2002:a05:6402:11c9:b0:51e:5bd5:fe7e with SMTP id j9-20020a05640211c900b0051e5bd5fe7emr2622631edw.17.1691673372147;
        Thu, 10 Aug 2023 06:16:12 -0700 (PDT)
Received: from ?IPv6:2001:a61:3488:8a01:c631:bde5:1eff:9b66? ([2001:a61:3488:8a01:c631:bde5:1eff:9b66])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm798722eds.86.2023.08.10.06.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 06:16:11 -0700 (PDT)
Message-ID: <2505544e4b5fdd5280b3f8406b223cebae6086df.camel@gmail.com>
Subject: Re: [PATCH v5 0/3] Add new channels for adis16475
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>, jic23@kernel.org,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Aug 2023 15:16:10 +0200
In-Reply-To: <20230808075059.645525-1-ramona.bolboaca@analog.com>
References: <20230808075059.645525-1-ramona.bolboaca@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-08 at 10:50 +0300, Ramona Bolboaca wrote:
> changes in v5:
> =C2=A0 patch 1: added documentation for all supported attributes
> =C2=A0 patch 2: added documentation for all supported attributes
> =C2=A0 patch 3: no changes
>=20
> Ramona Bolboaca (3):
> =C2=A0 iio: Add IIO_DELTA_ANGL channel type
> =C2=A0 iio: Add IIO_DELTA_VELOCITY channel type
> =C2=A0 iio: imu: adis16475.c: Add delta angle and delta velocity channels
>=20
> =C2=A0Documentation/ABI/testing/sysfs-bus-iio |=C2=A0 45 +++++++
> =C2=A0drivers/iio/imu/adis16475.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 165 +++++++++++++++++++++---
> =C2=A0drivers/iio/industrialio-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0include/uapi/linux/iio/types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0tools/iio/iio_event_monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A05 files changed, 199 insertions(+), 19 deletions(-)
>=20

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


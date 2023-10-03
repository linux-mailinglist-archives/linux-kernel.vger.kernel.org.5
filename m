Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4E67B754A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbjJCXkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbjJCXku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:40:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B8FAC;
        Tue,  3 Oct 2023 16:40:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6934202b8bdso1191856b3a.1;
        Tue, 03 Oct 2023 16:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696376446; x=1696981246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0fSEFVKmg/mrYWqi0FgqbjNYAcaKpEfdNhmmRTanwg=;
        b=R3rlUyJ4drxMARhNOneOSR4WiFGrJhBIu2wIzJkXQp/alSQamHkEwOFW1OJ5+YnVCL
         hBg+roRZ7lEb00aKqKdh1psJsRrc20Kxuktq8+76Nebs92LzfNH1mUyxaacQDwnDm5wD
         z/3o3JNe6N7dpvTwppgy4X9ygATAThY7bHMqK4CiewmRTZdIVXwCfCTfdTvkpW27Whn4
         H9wWZP50V//TwukE5mzrvdOb5ZlJyOvmI7IkR/Yd2z975HqGY0HJZr42y1M45WAcEGgr
         mu4CNg621at/b4+U63+GBHc7mtVwcnfQuv/oLPDWy6NwhNQHjMaKXh9hT2iznb6KYxQ6
         ybBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376446; x=1696981246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0fSEFVKmg/mrYWqi0FgqbjNYAcaKpEfdNhmmRTanwg=;
        b=WrlgEd1IxxuufiD58TB3W09LwTT8cJ6Wq97TIXYo+otbweuSsAKEpMfHFmslVFZqkP
         SrlCiKCXO7NaCwuLBYno/YAB5VGCgRwLbU4O26/RBRBpTmJTnhDJPQOC1v09gPpfUzot
         t69cudw9DYOdft2/HqtwcMj5EyPIM+1hnQpwYth6h9342QdPoTQC/gEqHQDS4ztSucok
         o/fLTs3uAVxtCI16sXfwW7ccbmPyA0yzp1CFMNwmebhd3/eBT2RyJ91l65UmEjCjb41M
         Fng39t2f+cOPThbvhEc3uY6mbACkbJOsWC4/BMPAAeGQtDzfKTR3fkUjPzWLHGHTc4ks
         6eNA==
X-Gm-Message-State: AOJu0Yx3xDIvsK2d/LWUQjV79QFhNvdhchkralybru8O9GiC4QU5nkJR
        FkRnYwEScTCAPualvhtQYKk=
X-Google-Smtp-Source: AGHT+IFyNlN9+Qc2HQr8gl9pLSzDW0Rt4y8um2j8dkfL5IcpKQOPiWy60gWhEpbfU9cmRSXbLy+kRQ==
X-Received: by 2002:a05:6a00:3995:b0:68c:57c7:1eb0 with SMTP id fi21-20020a056a00399500b0068c57c71eb0mr1063616pfb.11.1696376446274;
        Tue, 03 Oct 2023 16:40:46 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-68-80.dynamic-ip.hinet.net. [36.228.68.80])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78d09000000b00690c2cd7e0esm1928519pfe.49.2023.10.03.16.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:40:45 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        minhuadotchen@gmail.com, rdunlap@infradead.org, src.res@email.cn
Subject: Re: [PATCH v3 0/3] convert TW translation sparse.txt to RST
Date:   Wed,  4 Oct 2023 07:40:41 +0800
Message-Id: <20231003234041.3929-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8734yrekon.fsf@meer.lwn.net>
References: <8734yrekon.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>   docs: sparse: move TW sparse.txt to TW dev-tools
>>   docs: sparse: convert sparse.txt to RST
>>   docs: sparse: add sparse.rst to toctree
>>
>>  .../translations/zh_TW/dev-tools/index.rst    | 40 +++++++++++++++++++
>>  .../{sparse.txt =3D> dev-tools/sparse.rst}      |  2 +-
>>  Documentation/translations/zh_TW/index.rst    |  2 +-
>>  3 files changed, 42 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/translations/zh_TW/dev-tools/index.rst
>>  rename Documentation/translations/zh_TW/{sparse.txt =3D> dev-tools/spars=
>e.rst} (99%)
>
>So this series introduces a new warning:
>
>WARNING: Unparseable C cross-reference: 'int'
>Invalid C declaration: Expected identifier in nested name, got keyword: int=
> [error at 3]
>  int
>  ---^
>
>That is ... somewhat unhelpful.  I eventually tracked it down to this
>piece in sparse.rst:
>
>> =E6=89=80=E4=BB=A5=E6=9B=B4=E7=B0=A1=E5=96=AE=E7=9A=84=E8=BE=A6=E6=B3=95=
>=E5=8F=AA=E8=A6=81=E9=80=99=E6=A8=A3=E5=81=9A=EF=BC=9A
>>=20
>> 	typedef int __bitwise pm_request_t;
>>=20
>> 	#define PM_SUSPEND ((__force pm_request_t) 1)
>> 	#define PM_RESUME ((__force pm_request_t) 2)
>>=20
>> =E7=8F=BE=E5=9C=A8=E4=BD=A0=E5=B0=B1=E6=9C=89=E4=BA=86=E5=9A=B4=E6=A0=BC=
>=E7=9A=84=E9=A1=9E=E5=9E=8B=E6=AA=A2=E6=9F=A5=E6=89=80=E9=9C=80=E8=A6=81=E7=
>=9A=84=E6=89=80=E6=9C=89=E5=9F=BA=E7=A4=8E=E6=9E=B6=E6=A7=8B=E3=80=82
>
>That needs to be a literal block to be parsed properly.  I have taken
>the liberty of changing the first line above to:
>
>> =E6=89=80=E4=BB=A5=E6=9B=B4=E7=B0=A1=E5=96=AE=E7=9A=84=E8=BE=A6=E6=B3=95=
>=E5=8F=AA=E8=A6=81=E9=80=99=E6=A8=A3=E5=81=9A::
>
>...and the warning is gone.
>
>Thus: series applied, but please properly build-test changes like this
>in the future.
>
>Thanks,
>
>jon

Got it, thank you for doing this.
I will do build-test with care in the future.

Min-Hua

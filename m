Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0FC8037AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346019AbjLDOzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjLDOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:55:34 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B129B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:55:39 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce46470647so615064b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701701738; x=1702306538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECEVktnNpUXpGoY7MofBhZHrCIiW0FRv5VOwOFl73MQ=;
        b=b2Sxz9bWEEJY8zCgUxbEdvh6UDpN1bV1PqSADF2TRYkt6Mh0A14p3vMtYH2XgsTsKO
         pwYG2LarKkBWh82C1EUxL6cNS9yik6J0pEE66UCmK6rU3rG8B2VN+XZKZ4S3lr5eK6y4
         E8nqX4gch4GwDRmF3KCvl8XHR9/GTwtv0cN6N+9xcLIwDBeZ5lukt4AEHCdbLqDqiYml
         g+ZZTNbEqojb7K7bBKB6t+tyoK4e7miTsM3NOrkURQOs3T9Qg6MP/hRYSUhlKyKeNlk7
         p5wvzxqOIdmMTXli4SuZIpfdhkGKtxU0q2Fe1KIsObUbkbnhvllfNT410rtIzms/U70M
         jXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701701738; x=1702306538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECEVktnNpUXpGoY7MofBhZHrCIiW0FRv5VOwOFl73MQ=;
        b=hEWKNTeAXBZsKFd272TZWmkbLJTFH+DYZ1FyBPF5zQAuu2A2i9XJzV8WKmlMsk+sZi
         XsemwduLTt8eAlUHciX/uwOfurIzv4nZUww0rEYqfgyTv0NAJrP7ueP+4ocPHG4XlLiq
         ZCgx3j0R9jtCa6fOv3nIVOjAF47ez29uulAeUbPvgFDvQ8OrPRPJOnT/ETeTZyBogOsF
         4/cGOS+eTo4f0l6Z2h2bnPQ6N8m7GowGGg/DfizlYDjsTwaJnEZzG8B6nn0aF8vzG9+X
         fCCoDndZ5VbZnJqUT+hmFnQQw+7Pt5q0MrW4U1Bons6LON2nhQPGtqPyxV9+8yQQSKCT
         cqvA==
X-Gm-Message-State: AOJu0YwCTf88Fx4okm4Drv8Ojk5hCdLdidOckrVBdmHvF13ua810uPr2
        3gBayETRxvoqb9FEcDZiI2hmQtSALmXTvqfPLNwP+g==
X-Google-Smtp-Source: AGHT+IE61hyEtN0sXTa9zACdyfMXQB5XPSbT1eqxKDZKJptlwkTbAzQaMLBoHLqfOCG77V6pdVueQ5n8yk1VPt4SbZE=
X-Received: by 2002:a05:6a00:2e21:b0:6cb:d24b:878d with SMTP id
 fc33-20020a056a002e2100b006cbd24b878dmr2212551pfb.2.1701701738519; Mon, 04
 Dec 2023 06:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20231130162133.035359406@linuxfoundation.org> <CAEUSe78tYPTFuauB7cxZzvAeMhzB_25Q8DqLUfF7Nro9WsUhNw@mail.gmail.com>
 <2023120134-sabotage-handset-0b0d@gregkh> <4879383.31r3eYUQgx@pwmachine>
 <2023120155-mascot-scope-7bc6@gregkh> <4cf40ef6-058f-4472-88c9-3dc735175c85@linaro.org>
 <2023120223-diagnosis-niece-3932@gregkh>
In-Reply-To: <2023120223-diagnosis-niece-3932@gregkh>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 4 Dec 2023 08:55:27 -0600
Message-ID: <CAEUSe78X7_bwDiHwxS1u0TNTyuqDifoa36yjh=BgcByPp1i86w@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, 1 Dec 2023 at 17:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Dec 01, 2023 at 08:34:26AM -0600, Daniel D=C3=ADaz wrote:
[...]
> > It failed in more architectures than we initially reported. FWIW, this =
error can be easily reproduced this way:
> >
> >   tuxmake --runtime podman --target-arch arm     --toolchain gcc-8  --k=
config imx_v4_v5_defconfig
>
> Fails for me:
>
> $ ~/.local/bin/tuxmake  --runtime podman --target-arch arm     --toolchai=
n gcc-8  --kconfig imx_v4_v5_defconfig
> Traceback (most recent call last):
>   File "/home/gregkh/.local/bin/tuxmake", line 8, in <module>
>     sys.exit(main())
>              ^^^^^^
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/cli.py", line 170, in main
>     build.run()
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/build.py", line 652, in run
>     self.prepare()
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/build.py", line 318, in prepare
>     self.runtime.prepare()
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/runtime.py", line 423, in prepare
>     self.prepare_image()
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/runtime.py", line 443, in prepare_image
>     do_pull()
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/utils.py", line 36, in retry_wrapper
>     ret =3D func(*args, **kwargs)
>           ^^^^^^^^^^^^^^^^^^^^^
>   File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packag=
es/tuxmake/runtime.py", line 441, in do_pull
>     subprocess.check_call(pull)
>   File "/usr/lib/python3.11/subprocess.py", line 408, in check_call
>     retcode =3D call(*popenargs, **kwargs)
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.11/subprocess.py", line 389, in call
>     with Popen(*popenargs, **kwargs) as p:
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.11/subprocess.py", line 1026, in __init__
>     self._execute_child(args, executable, preexec_fn, close_fds,
>   File "/usr/lib/python3.11/subprocess.py", line 1950, in _execute_child
>     raise child_exception_type(errno_num, err_msg, err_filename)
> FileNotFoundError: [Errno 2] No such file or directory: 'podman'
>
> Are you sure that's the right command line to use?  :)

Yes, it just needs `podman' to be installed. The Tuxmake team will
change that cryptic message into something easier to parse.

FWIW, `--runtime docker` also works (if Docker is installed), and
`--runtime null` simply makes Tuxmake rely on the cross-compilers you
have installed.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

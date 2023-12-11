Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DF480DF4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbjLKXMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345166AbjLKXMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:12:24 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616A59A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:12:30 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b6fa79b547so299074739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1702336350; x=1702941150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzlKTDy/RIEAdRnxop/v7aizphXAOoNjFGr5djxk17I=;
        b=2v0U1YVak/gh+PyyOxHQFg8+3jlQ3YUmaFGVjMHC/s3iBhfFCf6WmZpFMJy1CFKctT
         Jtiqig4a2vc2+D2c5r1Aa8ahd41JRZOzr8jzF2f+XpUujbB7qdRx8fc+8OYqgjGyqw1Y
         ssaQB+zpOH/C9K2BhTOTGnil+zcVDwjw7PUp8UfWHEMAAcMhIsmBbBF7Jf9QnG8DJaEL
         Klvutsrkvtfq/f0Pxy7ote/Q+l+RwSdWxX3v3RF/+MDHImv+qlWkmROwVpoLmn5F0Ri9
         a+cqt/qkMxhylsM3XoCydu/rbVf1A2gAxTOL46hsJsY1QbCRVdLL/0KXjrr7TSG3vvb5
         AUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702336350; x=1702941150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzlKTDy/RIEAdRnxop/v7aizphXAOoNjFGr5djxk17I=;
        b=W7X5uY1hjIObiIHArAeqcDNhxUcXh333j0FNbjiiDTqbFNexQsN++hnihz98zFxvRA
         q+ePhIvNodFu55uwmNtlB1ZKhDz1WKIGdVC520kpSvk7ftEkxUsF+Q60oGGMYEBTb8Wd
         RAug7lHQXBT2e1mcpb9VTSLqzyYRQPoA2Pzo07yy5FmdvOT8Sqbj99zHPSm4ti48rNlS
         B1X9OdcERvjCv40remWwgep2bIF3/UaX6KupcKscmC8FMw9AYQXnEKRQnNAuaWq/ba7t
         s6SIKxSzW+oJMkhRT+4B7ODGvEqEcc+v1sP5g5Wv1XsbRqd/CwEtG2iX1Z+BovCm3zx7
         XE9A==
X-Gm-Message-State: AOJu0YwFHZNPAAbbsr24nwGR3T9o+p8DLdTLfeDxnCdJpe6zygXrnmQU
        6V+mi7ScrY1LScGo54rbo9QX8xYbrFKmtRfsd7KyMA==
X-Google-Smtp-Source: AGHT+IHY1fYWDJPUV8SQB9YLhJzscvke6ZJL/pin8flSX56KTuPcOW+twpGkORoR+m65xh7PMYfnOBMu3UHmIQaQ0hc=
X-Received: by 2002:a05:6e02:1c09:b0:35d:59a2:2cb with SMTP id
 l9-20020a056e021c0900b0035d59a202cbmr8110442ilh.107.1702336349600; Mon, 11
 Dec 2023 15:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20231211182045.784881756@linuxfoundation.org>
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 12 Dec 2023 08:12:18 +0900
Message-ID: <CAKL4bV7DjZiNLNcWrMx9A+pYSaObc5F04=4ia9YkYaso3_3b+Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Tue, Dec 12, 2023 at 3:26=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.7-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)
[    0.000000] Linux version 6.6.7-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Tue Dec 12 07:24:53 JST 2023

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

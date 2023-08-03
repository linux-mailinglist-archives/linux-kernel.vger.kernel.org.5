Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2E776E55A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbjHCKQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjHCKPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFC9448E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691057679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nbDG2XLgsFKEHrq3JdTfOdsEgiqhe9GVbea4Q7TpxDw=;
        b=WIfRiSoloqq7K31cUywzNhTagpBTYgnLWYDtd7vIIyh6q/1jYojkBUKL4Lg/bVXK33HzcI
        YACO15mX6t6bTjeY2UCTIY01rf4EWvNo7DBa9f4S3QnEtZ2LyWpPKPq2+Sz7ANTFYPr0Gw
        y0VIaeV2kE0S1Tem2AeHxp79bkxRDTc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-GQvGpYw6ONKGVCMfYrbV4w-1; Thu, 03 Aug 2023 06:14:38 -0400
X-MC-Unique: GQvGpYw6ONKGVCMfYrbV4w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63cceb8c21aso9005296d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057678; x=1691662478;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbDG2XLgsFKEHrq3JdTfOdsEgiqhe9GVbea4Q7TpxDw=;
        b=cNV8DinBqpnIlrHdkOPztiVcK8qkug7F74eFICMbWiHoS7Zv3rZh5x+OATweGBTg8H
         xfuCpgDVi3XBpCd+wottHN0FIJpr55Xo4iyW/ldvROtZ3EwwvrKQtmMGo+p7mTw7w41Q
         MtbnlCruRSeZLHwbF81WMoY88duxUEO5Nv8fSDg+n1uWSCsqTovviQttOziit9A8YuW5
         IaeRWvIzQwAkoVSIMhFfstXAgY1c8fpPfRYDPwGyfRovp75f/6K3fAikwuuEkyAzYP93
         gCiEaUJ17cnN7p5G5a2HmJSkQkYtk4zX4P+BlL2Yg7c1+Mbz9xaBrBI5Gt8YOICgH9Kt
         67ig==
X-Gm-Message-State: ABy/qLYgR4iKpaK26PtZ6TECsMbEJgOzq2DoOPME+1gJJ9w3DTG5Q2ZI
        Q4Wb9B3dBeOECDZH5+eVqjnVNue0UovDJbcJbUH9ESr7uPYUVXyoOUyI/hjOWcFFle5NDi3t6Qd
        kfKPrd0eE9qMEsrlwp2xpeiTb
X-Received: by 2002:a05:622a:302:b0:403:ae9e:2a6d with SMTP id q2-20020a05622a030200b00403ae9e2a6dmr27780965qtw.43.1691057678192;
        Thu, 03 Aug 2023 03:14:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGKX5dQObhExOhtEMNJ2gYmlrfS6JE+5CLYIjzbNPAGvPIi5bQuZXDpfCcp9FZFRaqTM4SH4A==
X-Received: by 2002:a05:622a:302:b0:403:ae9e:2a6d with SMTP id q2-20020a05622a030200b00403ae9e2a6dmr27780951qtw.43.1691057677952;
        Thu, 03 Aug 2023 03:14:37 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id n2-20020ac81e02000000b00403f0e47dd6sm6093367qtl.67.2023.08.03.03.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:14:37 -0700 (PDT)
Date:   Thu, 3 Aug 2023 06:14:36 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/2] scripts: add kconfig lookup script
Message-ID: <ZMt+DGRQIZ52miGF@brian-x1>
References: <20230801174922.333700-1-bmasney@redhat.com>
 <20230801174922.333700-3-bmasney@redhat.com>
 <CAK7LNAQ-nhy1_xFYiwuvOKvfUVSjvnEb4ZnJ8EMWo7uJun89Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ-nhy1_xFYiwuvOKvfUVSjvnEb4ZnJ8EMWo7uJun89Zg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 03:23:16PM +0900, Masahiro Yamada wrote:
> Everyone tends to have their own utility scripts
> on their machines.
> 
> I think this patch set falls into that category
> as "create a wrapper script of grep" is what everyone
> does to reduce typing.
> 
> 
> 
> 
> FWIW, I have the following scripts in my ~/bin directory.
> 
> 
> 
> $ cat ~/bin/kgrep
> #!/bin/sh
> 
> exec find . -name .repo -prune -o -name .git -prune -o -type f \
> \( -name 'Kconfig*' -o -name 'Config.in' \) \
> -print0 | xargs -0 grep --color -n "$@"
> 
> 
> $ cat ~/bin/mgrep
> #!/bin/sh
> 
> exec find . -name .repo -prune -o -name .git -prune -o -type f \
> \( -name 'Makefile*' -o -name 'Kbuild*' -o -name "*.mk" \) \
> -print0 | xargs -0 grep --color -n "$@"
> 
> 
> 
> 
> masahiro@zoe:~/ref/linux(master)$ kgrep -A5 TSL2772
> ./drivers/iio/light/Kconfig:564:config TSL2772
> ./drivers/iio/light/Kconfig-565- tristate "TAOS TSL/TMD2x71 and
> TSL/TMD2x72 Family of light and proximity sensors"
> ./drivers/iio/light/Kconfig-566- depends on I2C
> ./drivers/iio/light/Kconfig-567- help
> ./drivers/iio/light/Kconfig-568-   Support for: tsl2571, tsl2671,
> tmd2671, tsl2771, tmd2771, tsl2572, tsl2672,
> ./drivers/iio/light/Kconfig-569-   tmd2672, tsl2772, tmd2772 devices.
> 
> masahiro@zoe:~/ref/linux(master)$ mgrep efivarfs.o
> ./fs/efivarfs/Makefile:6:obj-$(CONFIG_EFIVAR_FS) += efivarfs.o
> ./fs/efivarfs/Makefile:8:efivarfs-objs := inode.o file.o super.o vars.o
> 
> 
> 
> That's my local way to satisfy my demand.
> I do not intend to force my way or merge it in the upstream.

OK, fair enough.

Those are useful little utilities and simpler than what I posted. If
something like these had been in the scripts/ directory, then I
wouldn't have spent the time to write yet another script that does
basically the same thing. I get what you are saying, however having
a script to lookup a Kconfig by name or module will be useful to other
people.

Brian


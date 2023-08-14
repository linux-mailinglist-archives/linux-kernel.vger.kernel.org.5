Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F89E77BFCA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjHNS1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjHNS13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:27:29 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757F6B0;
        Mon, 14 Aug 2023 11:27:28 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1c0fff40ec6so3111473fac.2;
        Mon, 14 Aug 2023 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692037648; x=1692642448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAhMGvofRWfSgtz5u4k2nIYitbgyVcQrqD+LU5q4Ia0=;
        b=Ws546J6GtLIWv08o2rhn9cjjrVaCn6kpHmZqn+BvFYFqKUGJxBnosqnlNdyQxwt9xH
         nZFT3zozeJVWDDeMtZ7k+lrNnq8jtqIZfL5zrIVIKCUw/LOMpyc7N2Hwgsnf2NTBniGx
         MCX4zvH9CtlDTLt4rc/i8+GW95LhOSvoAe0QEDJcgkf1Aw8nDy/QxuBW+5aJzupw72cy
         nrfbs/N84aaaPHT5HTUPleyVpzEbzb2Hg+AeVUJnwGFSnBKhL2tJbMKRHAIutoPzI2By
         RR/LjlkG5CrWR+cGbNj51zyb7VXD9+eFqfF3qG694yaJI6JOwunl4lKVKT5ApVocVtq4
         N5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692037648; x=1692642448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAhMGvofRWfSgtz5u4k2nIYitbgyVcQrqD+LU5q4Ia0=;
        b=cI/PY2IZbrTwCdAbQOeRsZ9wZr0e7cyJldrCttysbkU5d5+p9wUuaHYIiwNxEg3qrH
         EHQeKDAx27xdsNbC3eRSGuAJsYF4/gvD5GyGFnuMwpk5GSH+l9Ofzrfsw155ZptRwKHS
         J2TmcXv+iwn7OG4YVHDqGrpLUEOYA68HvMxTyfdWz6tvSlyvGpPtpru1HlQjsBSCyzif
         lYW3kVMrbLLrckmBLKaHMqWxnu5cYNC8RxVCcimui48KJUfQg2y6kaPw7K6wxIh34l+h
         aC3bCDy52NpISDzwq1JPmOr+tSknrvK5/AFsLHelhf8n3aRdAjEtZK8Msd+B3jHJeb+K
         tGGA==
X-Gm-Message-State: AOJu0YwQDPUntZTBe4xTL1oF1rAe2wwbeLI/bsR7gj9eMoHHyuAvOfGi
        bmyPfV5W4hW2mcDxVnWAxGs=
X-Google-Smtp-Source: AGHT+IHY2MBDjJscwi+JytvRjdu3eZXlT95uCAtcbonJrBznwoHoRu7QVwAp/m4acx9nPzxqVnw9yQ==
X-Received: by 2002:a05:6870:6013:b0:1be:ccce:7991 with SMTP id t19-20020a056870601300b001beccce7991mr10048539oaa.13.1692037647724;
        Mon, 14 Aug 2023 11:27:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i6-20020a02b686000000b0041627abe120sm3173833jam.160.2023.08.14.11.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:27:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Aug 2023 11:27:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/89] 5.15.127-rc1 review
Message-ID: <bdc5a048-6707-4fc9-876b-6ae2b3befbcf@roeck-us.net>
References: <20230813211710.787645394@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 11:18:51PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.127 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 501 pass: 501 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

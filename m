Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D456794202
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbjIFRZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjIFRZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:25:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AAF19AF;
        Wed,  6 Sep 2023 10:25:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdbf10333bso425365ad.1;
        Wed, 06 Sep 2023 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694021109; x=1694625909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtFBuHMyCxNyxeApH/j4q1M9/7VaTqahchmwQtB5wY4=;
        b=CBr3xK6fSAPCVhaHYhuZKnS1TVQCOtr2fnqOmlK86BapUOdqaZwx9LaZIepe3xEHSa
         Neoah7Ml4b0JfghXaY82xY/RAgqnEvOvy+MtUszLOHRHypcterd+Z50QRiko5qm1eqPA
         vxtNeC8bhtz3L39fnRrEo62Yw9hkKOrCkM8WsuzjW7/iNkwA+y5BkUTYcmaFiitiSkch
         ORwu3s7CuwApmt7QUrhzyJE32BVL2gqHorq/OiUHca1H0bBz665bjg2vbJI/EeeRn/Kx
         viI5XNn24+3l67GSvSRjTucPsESkwANvaSD7yTPSMFVgWL7c1bbu7QZ3LpAcYBx71KMF
         /E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694021109; x=1694625909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtFBuHMyCxNyxeApH/j4q1M9/7VaTqahchmwQtB5wY4=;
        b=RZDPACO6jnR7rd5hdgMBrz4I7OiEyIVmdA31lCSj10KkiB59B+CGSdgezYGJWKrVmW
         ZjBMRlYGsrKM1sJoRMDm2gN0NAnzMZ3MuhRSbQmCv8wFqksk78cn18Opmz8lz7OsbgTB
         m+E6mSVwYG5bPLg95tusiQCRza9sdZ+6xSNvsz9KafvbX7fFwK6HAIubL+YpaG5NuTXb
         ScO+qz1DSRMNhUzem8x84l93Q9dngdAaPHm8xfOMUBNPP/oebEU9+JpNM8jFCQ80EfwA
         uyyU0Qvl2XB8B2HrVmkXWedJrQvhgsfCPNazCK/9zgHdCxUjzalAEeR9km+jh7e18YOS
         HHdg==
X-Gm-Message-State: AOJu0YyCRgFZb85JIJ1hbTJxttEtTUVZ7wgcXGMoh7WhkgpV5nvK7kGV
        wTAgacw+0TP9o9IuPdKgUx0=
X-Google-Smtp-Source: AGHT+IHiUGqLqClcNly8GWQ1LCsg0F2QHzXdqWOkKYboKfOPj11Hds+dP2qX1/OuWnUWPTzuQILbOg==
X-Received: by 2002:a17:902:ecc8:b0:1bc:7001:6e5e with SMTP id a8-20020a170902ecc800b001bc70016e5emr20699856plh.32.1694021108559;
        Wed, 06 Sep 2023 10:25:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ja5-20020a170902efc500b001a183ade911sm11377213plb.56.2023.09.06.10.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 10:25:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Sep 2023 10:25:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 00/34] 6.5.2-rc1 review
Message-ID: <b98a68ac-24a4-43e4-9d4e-a60c52d377e0@roeck-us.net>
References: <20230904182948.594404081@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 07:29:47PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 524 pass: 524 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

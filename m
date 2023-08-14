Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B8C77BAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjHNOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjHNOFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:05:00 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0B810DE;
        Mon, 14 Aug 2023 07:04:59 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3492c49c649so14014305ab.3;
        Mon, 14 Aug 2023 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692021899; x=1692626699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV6sC89XapYZVMX/+VdYxzq6EyZ0EWd1ZtLJeqKLEQk=;
        b=QopZHpibMKfchlO2kbVDZ+nGghMuuDea0R+TfjJ1dN5Qdqx2Ew6oGdQNX8HtIhDuHF
         yTO1XoOFX7dyo3VEJWMmhGh9gW3Bq9SfQ1dhYvHbeotAqn4tT6miA5xIBQYN7fpnwYzQ
         4jq3RUdjCTo3KdvY7ZzxumNZFUCe0UBQEWy703w7d+56I1SiMTGpQnH+rdFUqQIq2l6M
         avYjFizniwwi6b/DOD7Lqk6cHEWxPULWCjVqnDueddkq75X+8IbYG1ew9XqwnKc3onb4
         FzjQrOpB7q+AKDkroXKUuVUUSluRZ0wI1RcYgXbBwbFZdgvO387oS2kJB9yFZTwvQAuv
         MriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692021899; x=1692626699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV6sC89XapYZVMX/+VdYxzq6EyZ0EWd1ZtLJeqKLEQk=;
        b=O4FHEOamc4ZrzSzjhU6t5PYdA98jKheWGow8MU6hxghRL5ulsJyB/y8z95gUVstI90
         1SGYvFw41ROksN9OTWLrBtdM4Z2Sx+CpI1ZMs1KPC6Ollt8jyQKI52gz+fWyjZ7rnjio
         co2B0c9iMp6TabEz5IkYGkdRtuBnkn/NQm0ctTan5FTSmGGMCEmyOuIPRtNm6iDoeTxu
         TkJei/nRIesxomJY29DhdXouv8+MhJjglv7yBPcCgFgEz1g7zHKgv5Ol/8ZTrKDEwUlT
         rncICBdlWZ10jnpZARN5MkmDoHE5h3JFpT8z+5RKbG9aRatzn3m9nHN6xI+bk/yecJBq
         FRxw==
X-Gm-Message-State: AOJu0YzZi0LnAcWLLL+04o+v+kpoAg001qENy2p/2i+TfN6dXqT36YQ9
        NyXCPTyJNqlK46lKvSCmu4A=
X-Google-Smtp-Source: AGHT+IGIB82kZi2sR4+R1Uj/yPYzrGQoPS2ZRRUXuUiCM6qKgcOMpHCZsh5vkYECo1Xcr7StrG6qPg==
X-Received: by 2002:a05:6e02:1a81:b0:348:8ebc:f759 with SMTP id k1-20020a056e021a8100b003488ebcf759mr14316486ilv.6.1692021898776;
        Mon, 14 Aug 2023 07:04:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h10-20020a92d08a000000b00348abdfad8esm3147800ilh.32.2023.08.14.07.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:04:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Aug 2023 07:04:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
Message-ID: <b392e1a8-b987-4993-bd45-035db9415a6e@roeck-us.net>
References: <20230813211718.757428827@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
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

On Sun, Aug 13, 2023 at 11:17:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.

Booting with f2fs root file systems still crashes in this release
candidate. Would it make sense to mark f2fs as broken in v6.1.y ?

Guenter

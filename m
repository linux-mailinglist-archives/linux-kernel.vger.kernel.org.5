Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9C27580DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjGRP3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjGRP3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:29:03 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A81392;
        Tue, 18 Jul 2023 08:29:03 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-579ef51428eso62995837b3.2;
        Tue, 18 Jul 2023 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689694142; x=1692286142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyE0/fDKwt8r/GBJ63+HlewaRDyQRINPAaWQSmZkqf4=;
        b=VgyYyQPCaB/LoR/abJvGjHy3yDhmSQAO/vfOSiIEVQYd99sfkUY107eN3492Qosld5
         ev6jaZAbBA9TE1L+p1k2DRhkvvZ2lCQwshoR8sb+r0IiOHlN+GX8MRM/p4TJT97lbGf3
         ulxM1KGiX+tNk7y5A3KEkltuQs6n/jLyeRVRnWwtGZtZmw0G2qvYOTPOJygdsV8zfM6Z
         2bj0OQeHsCi+7h5muOs9ffUwf3X+LlTgcd8Q/d5T+CRl3zLFTtbkjwKdVVZKYvzSB/nS
         EEwww57F+DuMZZTzQSjktJlbg2kh2FSsWyDt+MC1/jHX+9AEZBO1uttdfbX/uqlK7b1w
         uFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689694142; x=1692286142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyE0/fDKwt8r/GBJ63+HlewaRDyQRINPAaWQSmZkqf4=;
        b=VcS3fRC8YEgw3LtnHMMTCBx3Qv5J7LYC+WO3Fm5lO+nleVTtJS5CzR/H5I9BaP0/YB
         +GbMxyeWHVhaKZvkuWVvKC2M/pPeaD2rJRk7Z/ReTEJS3aSVRDP/8X7TvEywkLNe/Y98
         +wTPnCM6zhX9eHaQJkConttfy4mw/4sAGkisk02YUpNG4fLsUBUyiX5JxX7Kq1lMvq2y
         ZTpYVhjQkN26Od3RpHFmfcHB6YWqIWj3yvp/dk5hmkoRLwPrw9aKxagCRa/KQ5Cm3Wk0
         NBfoai2xw5GgVu9BuQ85GGVlW1BRAK2abmkQepaLckbkk/VvLq9RMy3/o1OQkDftU9WB
         XGpw==
X-Gm-Message-State: ABy/qLYfiU1TazU0bgg1WOUDPUTPlAFPBbWQAvb6IXvc6eq9yPq4Ymz4
        SfpabfTRwlM5UrzyOH2R+b0=
X-Google-Smtp-Source: APBJJlEhiEn8AIISGAC2VhfGSVlNDoIeULmev8wfh7LlZmym8UELY9e1bBIEHgz1Y1zlVNY92IuaOQ==
X-Received: by 2002:a81:91c5:0:b0:579:e318:4c01 with SMTP id i188-20020a8191c5000000b00579e3184c01mr3107023ywg.19.1689694142299;
        Tue, 18 Jul 2023 08:29:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u84-20020a816057000000b0057a9a46e2b7sm507979ywb.80.2023.07.18.08.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 08:29:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 08:29:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/589] 6.1.39-rc3 review
Message-ID: <83d8c38b-0b27-4489-9c72-318775739aac@roeck-us.net>
References: <20230717201547.359923764@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717201547.359923764@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:34:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 20:14:46 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 521 pass: 521 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7917FB082
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjK1Cwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjK1Cwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:52:35 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CAE1A3;
        Mon, 27 Nov 2023 18:52:41 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso2566814fac.0;
        Mon, 27 Nov 2023 18:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701139961; x=1701744761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOA20k+fjIhtDIB/S3Q33exhkPrzn40IFpX+eHmxmcA=;
        b=S0mSBgokCdtFmslKezOzzr9mVtU766c6ADwMwq/Hxtq2VYfOL09Mn0/EItu3CUW4LH
         n+gPoNqF64F39HkiensMZUc7fXpJmoaGwV79EV7xWd//LISoFgYiV94HYUtJkdyfDG9o
         +bd3yh1+j52DQ6ixf/CY8znDglDkQe3YX5pM3MeH32nrH6ia2EPVAIimlo26GznqkHLL
         Avhf4H8hX2PovbgD3Trt7Z/S160sKvOZNJvXSWN8qbf60c+e0pLYMcy7Ksx8eMpsAU+I
         4ubnU3GPW8uZpEOyNziUuxuenQDG+mM8OfwYvPVcbBjXoROSiO2J5ll1a6xo4ooOHjhe
         dtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701139961; x=1701744761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOA20k+fjIhtDIB/S3Q33exhkPrzn40IFpX+eHmxmcA=;
        b=cRRUHitqwF3qrdICzY6lYNu08djhSsWrGg74rMa1FpTR/L2BU69hssMCNSqAq70AB8
         //yDeiBqnvdk3Z1RnCxOyImRJE362z+exqOmrNWmsG6D5atEJpIeZtyV+utDijSeZpSf
         GPns63jYiQMK6noL/MJu9GFeLNRRQsLEfTcOhorILMdltqtyVNrvt27mZacAQJsFImVF
         fW24HeFfs9q682J3rUHY2rnf+KYNGDI98xO3+26cUkVxTWHIijFrf3z76kjfDuC59YMD
         m6r7/lPX3czAsvz7hT9u7P5OUwKQsrwEDNfkfLUGQ6pEIDEIy3HTqYkg16sOPLqTcqUM
         C7AQ==
X-Gm-Message-State: AOJu0YzmoYN65U2yVnSy7l5RdDbWU8qhmzUR4fiplLp6LkFQgWjHwI8g
        7PL+vxW5sctxw9JPTPLm9ts=
X-Google-Smtp-Source: AGHT+IEBPCerUI08J0mEX4PcSIhU2+HNaHQxERiDdDbD1fOMwMsrSVyDN5B0gO6PGmNufqlqK2w4mg==
X-Received: by 2002:a05:6870:75ca:b0:1c8:b870:4e22 with SMTP id de10-20020a05687075ca00b001c8b8704e22mr16301855oab.3.1701139960940;
        Mon, 27 Nov 2023 18:52:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id xa2-20020a0568707f0200b001f9e0871eafsm2352416oab.21.2023.11.27.18.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 18:52:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 27 Nov 2023 18:52:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/187] 5.10.202-rc3 review
Message-ID: <f0c7a42b-58c6-4d01-80dc-0c8852149e82@roeck-us.net>
References: <20231126154335.643804657@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154335.643804657@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 03:46:55PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.202 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 

For v5.10.201-188-g80dc4301c91e:

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 495 pass: 495 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

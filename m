Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72DE7BAEC0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjJEWSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjJEWSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:18:14 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0817F1;
        Thu,  5 Oct 2023 15:18:12 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3514bf96fd2so6396485ab.0;
        Thu, 05 Oct 2023 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696544292; x=1697149092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3ykGcA4xlf9dRz1IpNQ+ZCL6mA883W90HgWdDG0/kg=;
        b=gfFRDNRksouoKuCRd2aXQvj/qycXNLH9neg94vYNUbN3ZghrLHcNWRZanr5ZhfI5fE
         7fUZWiBeCZAFanOuBQAfOczPI4wP6ALfF9Putazd8yKGeiQaS6/ccdGNRRp6vTg3Ci++
         lcTCGPfcV1itx8fM5INLjEdQ+lhBg0oACIrQAnjo++vftdpkjygWLqaJk6LdgqL2sZqb
         b4CFr6z2PnLbFF145ftUodvgZv2Dspw5Lvk8cmq1QkL/3Ypfv8x3lfD1wKhJGKl4m4ev
         8NYDp7BcltidDbfo1MTP/4gKftESQJLKpV8IkRVupZ/kPeDE9dLHSiX1Ng8hWznbz2p5
         3New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696544292; x=1697149092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3ykGcA4xlf9dRz1IpNQ+ZCL6mA883W90HgWdDG0/kg=;
        b=Fbl9LpxULyfWuC7OLfms8yq15o0LNEmLgZDskXTri8Zou55dz2ycyU0CSPm4vyDxHy
         3JO1DmDoyQOmcw1dXNzT5V7nJrlYRugP18Ydq+QoDE+F7kBr7G2VvXu0mlXyGx/NTALy
         3qo8UFgCAXgXG3cXEgHHWJ8Uc6GXHqbkAP85hdQcXfybVPg9QlyVU3wOEm5EHrBKJvOS
         lYyOhQ3lf7jcSPnhLNEeKGX+F8ciFfMQSi9ol8SIAvvwkpwu/TLFp1e5shoRHfHJ2rDW
         FIBFvcLDFp7w2vi/fVapgeZu+DGgN8E5KEdvNbckn1HxVMvPuALgtigMFf76ycGZydzB
         4mdA==
X-Gm-Message-State: AOJu0Yw5oMZ27vtYGkdcGgV1UnnJYlGypepR8YHFl6eHOem9i02Sf3jp
        dWdBgQs/Ij9+w/0L6OIIZ2M=
X-Google-Smtp-Source: AGHT+IErM//mCsTqWqkcMqsDDVLGCeMiV7qRXjuFjI+2a6TGcaV2A0gyWKlRlyxwHXpRXsi4aaE4xg==
X-Received: by 2002:a05:6e02:1d9b:b0:34c:b981:52d4 with SMTP id h27-20020a056e021d9b00b0034cb98152d4mr7851116ila.31.1696544292193;
        Thu, 05 Oct 2023 15:18:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h26-20020a02c4da000000b00439f4bf154csm42651jaj.46.2023.10.05.15.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 15:18:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 5 Oct 2023 15:18:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Message-ID: <67d917e7-c5ca-4215-a92e-96fd52fc4c31@roeck-us.net>
References: <20231004175203.943277832@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
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

On Wed, Oct 04, 2023 at 07:53:51PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.134 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 158 fail: 2
Failed builds:
	i386:tools/perf
	x86_64:tools/perf
Qemu test results:
	total: 509 pass: 509 fail: 0

Guenter

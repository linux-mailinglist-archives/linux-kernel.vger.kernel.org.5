Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55F67D5A38
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbjJXSMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjJXSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:12:01 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E358810DA;
        Tue, 24 Oct 2023 11:11:58 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5ac376d311aso22859157b3.1;
        Tue, 24 Oct 2023 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698171118; x=1698775918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSqGcfPDMAQJZbk5712WGjiVTfSLolcvvugGpbe3I98=;
        b=LmpN6slHkpH3qJKZJT63ECduEkrM0EJA5WrL1b6euotl5Hlr85OLW2Qb91NMePjFi5
         nj5GAhpNKpa41hFaEqYz02dz6zTtsqlbZmGTc42p2KBm+iinoda4/BtP8nh0tD8JwH/f
         VMYcyn3VbDPEblkPNgHvxmp4swrRz2USzBEjHyxj58R8NEXHLWUZF4lUV1NL/fjjuCRS
         m/NS7DD+jmnC5quHt6NXt06vqqesp3uwzD/eZgHsHriBYzZ2ZK4Wvyp8uQVEQQ3UhM0h
         9n+QOO5HWSKY6sh/TKxQwE0QsU7+n6eZXkUKOedVcYTi5SRsQLLncqpcnwp8BvefDVX1
         NoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698171118; x=1698775918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSqGcfPDMAQJZbk5712WGjiVTfSLolcvvugGpbe3I98=;
        b=XVcql6LQiI4EbHyH0xLhfO96euhbdnOgsIf7NIpE7e6HhuTtuojt/7CN6Pgyx+rkha
         dubcaFB3ttIG0dFVe16i5wvwsB5BUQUnQgk59mDd1IwEPN5w+l12K7DZdWoErKnCGKB0
         +a42uMgKqJ5HdUyHs44ydQSFFaCyUfQx/O1xVaWPqGGVkKLwc4AlGQlXJbhCaRG/qsdr
         Y3oy9JrWdJ+fPyZsIlCCtaiVkjRWLcd1kmBsZzLeIDTQVr3/kT4Vi1n3DIg/QK9amvXL
         w9ExmdncolAhSGnO2V5RHmjhbK09h2IrPwyx9VEzdfWRgH/YtoMFbZxz6Y/7lXAsGpSf
         gtrw==
X-Gm-Message-State: AOJu0YyY8E9oHmzXMrQx//qBLor0NTca07gN29j7jSi7sPcyVTHeV1H2
        ilhdNThCO5u2inMv58PyV2Y=
X-Google-Smtp-Source: AGHT+IGo8qG9Uq/Oh2cHbKXi40hnTB4WA1qnHbMVz2nb9wBIDZjtOntSpoNtANEIVGZgQLpRUoyw+A==
X-Received: by 2002:a81:6c58:0:b0:5a7:f933:c8c4 with SMTP id h85-20020a816c58000000b005a7f933c8c4mr13738496ywc.14.1698171118021;
        Tue, 24 Oct 2023 11:11:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ee6-20020a05690c288600b005a7b8fddfedsm4232438ywb.41.2023.10.24.11.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:11:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 24 Oct 2023 11:11:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/196] 6.1.60-rc1 review
Message-ID: <8843b9c4-090f-4938-bfe8-16cafd4a0cec@roeck-us.net>
References: <20231023104828.488041585@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
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

On Mon, Oct 23, 2023 at 12:54:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.60 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 529 pass: 529 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

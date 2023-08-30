Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A61078D1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbjH3CEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241670AbjH3CEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:04:22 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5168CDA;
        Tue, 29 Aug 2023 19:04:18 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-792979d4cb5so120311039f.2;
        Tue, 29 Aug 2023 19:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693361058; x=1693965858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTtXfWy3siOXzQeZ46HnlLwi43B/raOmYWONvMXKE+I=;
        b=F41ptmRQiu1rTdFUc9H/3nEljNO+MTjZkYCvgfJjhSJiPcTGYcwsr4Pu8AkPQ1IjSa
         mdDGpYLQxFQKT2S1M9qcqdOipw7VA9qSoJ1LR+w2NRCBUh+YI/PmILssfibtvFBQsWlJ
         4znBdiXdN9ummBBg1ynpddSyYdMa4qM52gy0dpIIQqyj8mhffm9N60MbBSlvc6m0Edov
         OQQZUF4Wr/TXZtr3pa6enz76FX+VSpZbOYyBlkSpEpA6HS7U1DYk9nfS7DU8M/KKZRSM
         tCx03JA8yNlbIKcAiP4Cazu8gJ+4JCtcAt3p1AtYFXRrBWoDEK60+PmOqBbB6oCnCrDu
         cfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693361058; x=1693965858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTtXfWy3siOXzQeZ46HnlLwi43B/raOmYWONvMXKE+I=;
        b=jgKlehcnpVJreBQKN8+aqcBmke1WLym9A7fKxZr8aeg+rvGEob0aqUM5hZKBCKa8RS
         wmreSLEtd4aaylRq48nshIn1VZ1Hb5nnLaYhoDbGCfUhIWLJNAMj9KhB5olTzft5oVkh
         wYtBZaTOkl62ph+uHL9GxArpazUXD/BpUaLPhWlKxzKTZxFCr1yeSq5AcSA+/sZb5RGp
         vnQr1wkNkaOVqyHH/spiG6E0R8Goum8/EQunmJnSzJq3a6DIYNcnCnc0UjN7Im6oeYp/
         HuRGnWl0KnHNm3fC/YnSDYuINXa5h5+XmU7x8ONHQ4uhwrdL/PLLZm/oDO1DPfBGR0Ht
         qUWg==
X-Gm-Message-State: AOJu0Yx6MY6gsPnOenUU9fRoL5495WHAatwwm2bvpuhpRhbKCxyyTkYn
        CEWQ7dIbAz7OjYJvui1Yhj8=
X-Google-Smtp-Source: AGHT+IG8nMrw/xTXVOLdRnwnw6/1vDoK/H4V6wWT02ni4GkNDQhr6SwQmKDGyjzyPHC0i1BW5WbkPw==
X-Received: by 2002:a5e:a804:0:b0:790:f866:d71b with SMTP id c4-20020a5ea804000000b00790f866d71bmr1147268ioa.13.1693361058123;
        Tue, 29 Aug 2023 19:04:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f22-20020a02a816000000b0042bb09e9345sm3472062jaj.90.2023.08.29.19.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 19:04:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Aug 2023 19:04:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
Message-ID: <6b336824-42b3-443f-8c3d-356626caf7fa@roeck-us.net>
References: <20230828101157.383363777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:11:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 522 pass: 522 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

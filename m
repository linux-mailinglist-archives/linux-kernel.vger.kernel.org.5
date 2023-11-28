Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CBB7FB09D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjK1CvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1CvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:51:19 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353FB191;
        Mon, 27 Nov 2023 18:51:26 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b58d96a3bbso3017354b6e.1;
        Mon, 27 Nov 2023 18:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701139885; x=1701744685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6uV7n3X6HVLF/lWIg26Jp+5T1ga/ib38IAe8pZ1ZMY=;
        b=kgSWcyRnVcVDGI+auy8LTGefJbAb8/5Vdd1We5N/jR7Ysr4Wa1WrAS5fPJq0rwDPtW
         wX6Yss7ki3IKP6nlKlaLd6CaDCjwUpn0G8Lw1JqJHRyu2bp0O8YJhhQ9CnfY7oMGHHg8
         C8VU/yfHdAm0UqPd/Frfa4ZCeyA/voaNTIcorR0n/SHL3aZVaPnAiddnwcKy1YwrJT98
         i2/Y4Iiu2i6LeQav7BRElUKr2iPUS9kVgPOP13dWNq4vt9dv6cwXYoYXcvR8h6s6venj
         oPix8W0DKcDxK4sUCC65TBnsmSH3wMLPpHLdbPR4kBeqG+pq09sIdBGrAYjeH55pZkJO
         aTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701139885; x=1701744685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6uV7n3X6HVLF/lWIg26Jp+5T1ga/ib38IAe8pZ1ZMY=;
        b=bhWS6+Bdxc+eveEvzZAKXGeaYUFRacZuPqQT7yU3fd+k0DTn3OXlMYRRK/JpZrlMjn
         roP6DxOfN3h7HzO9myUuM+G0CCb5JEg9uEv5xe4iaa4NM5HYdcGXZoCLNJhDmEb+WEgB
         +11FUwMs7ZLe7GOJ3aPJbll/5v+SxivBDO1UCMI+ef9Vz+18c3fE70iDMUEvVmCAG1pj
         zjlBOlR+Z1MzonitO6qatoA/ucudYvfXBLCKl2Q67yN1PBneUfVtVmuIHmEEL2uwIbJu
         qEHIVC+43EASDIqhuvatYkYTPv2PnNKO/UxD3YG1XNJkUdOMC8k35MtuRQ4wcOq1LIp5
         0p7Q==
X-Gm-Message-State: AOJu0YzXBL3KTCOILudmSJIVYR7fK/qLsexQHQCmdd30JNw5OEOsbUdC
        G0aDjqiJ+tzStg2L9MMjI+8=
X-Google-Smtp-Source: AGHT+IEIc3+IcUWJtvyCPpyFZr95hglIiRWuef0qXvSKUbQfwJ24tMT9W5hOehFavJMwdZE4Ve0MAA==
X-Received: by 2002:a05:6808:2181:b0:3ad:f866:39bd with SMTP id be1-20020a056808218100b003adf86639bdmr18616249oib.27.1701139885358;
        Mon, 27 Nov 2023 18:51:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m23-20020a056808025700b003b29c2f50f0sm1695999oie.18.2023.11.27.18.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 18:51:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 27 Nov 2023 18:51:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 4.19 00/92] 4.19.300-rc3 review
Message-ID: <bed5d4ab-0367-46bd-bec5-3234a8f3cbf4@roeck-us.net>
References: <20231126154323.146332656@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154323.146332656@linuxfoundation.org>
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

On Sun, Nov 26, 2023 at 03:45:59PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.300 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 

For v4.19.299-93-g263cae4:

Build results:
	total: 147 pass: 147 fail: 0
Qemu test results:
	total: 441 pass: 441 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E984079D10E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjILM24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjILM22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:28:28 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85476198B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:27:53 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c09f1f9df2so4162905a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1694521673; x=1695126473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LW6egm8EfUZADa4f85G/hF9JcQWbHdUo0uisWQrhFUM=;
        b=YIzduL8BWfo7AgR38AQeWFOQe35chQxU71S/DSaUErn8Oii6Rb8FsrZL3hOXFn5G98
         +3BLShwXHmWd1SraYl111kvAlTnNkt0Ug2QKHJfHQhZTe+q+bExFi+ny0TEfYYbpDZ9n
         St3ugm+DCawskuiriapxPJsIy8su2rDule+0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521673; x=1695126473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW6egm8EfUZADa4f85G/hF9JcQWbHdUo0uisWQrhFUM=;
        b=rfmVCwccb5LC9vGWU7OgZLLed5CzCYrAj/6raFSxZ4h9wbD59WL8QGttwhI78tlOpa
         mRTad+IB0hjGWrb0wQ/SHEmThDvTiyx/xl3yS4edfL58FQmU6PpxmZKKhRaZ66csYh/4
         UnOe9Ib1KpqqVQGGOb0MTO/3uUQNDQsdub9B4v8b10W/WUmbdnWX9/0qpFbtjY5EpYYd
         DPD2c6hz2xUcVUEe1kGrZEoRjw6oV/YLXv0rT1vIXUJtM5hHHd0Jh9Tyj+ZoE6sOmkut
         ltRNTaEgJQtl2E99veYGkvJPGE2IS6DqkpVRsauZfL/jKpgl6XR02SRLibX1FWNGRpr6
         WvGA==
X-Gm-Message-State: AOJu0YwOZw5LFICUDTktf2ZVmEWnztRR3LFwHXGJvcCvJ7YtiTHVFiCT
        IRZxHxwPnTrHwPbmsxkE6tHHzA==
X-Google-Smtp-Source: AGHT+IHYhWSb/77EH45rfz5++hlmG6uS2RjCpx31TFlOZp/3hO4QCJww5a7Duz2eTIkBC4CZcJrFgA==
X-Received: by 2002:a9d:69d8:0:b0:6b9:a192:aaf3 with SMTP id v24-20020a9d69d8000000b006b9a192aaf3mr11865415oto.17.1694521672873;
        Tue, 12 Sep 2023 05:27:52 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id a23-20020a056830101700b006c09291cde6sm3979906otp.0.2023.09.12.05.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:27:52 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 12 Sep 2023 07:27:50 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 000/737] 6.4.16-rc1 review
Message-ID: <ZQBZRh24I128Tftp@fedora64.linuxtx.org>
References: <20230911134650.286315610@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:37:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.16 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

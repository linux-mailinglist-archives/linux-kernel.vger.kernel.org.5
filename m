Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CB27E48DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjKGSzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbjKGSzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:55:50 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8A112F;
        Tue,  7 Nov 2023 10:55:48 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc68c1fac2so54907815ad.0;
        Tue, 07 Nov 2023 10:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699383347; x=1699988147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F33xq5Mgs3IYtFG5bTStA5S74EFyo6Vi0hYjrdDVkhY=;
        b=QFW9+DYmfjFji1/b6iJHTmjZJ18ycMzMVnQgnvTpX7RMYz2oH4N/fF6aMF5pffxJo/
         UXAcmhwwqFc4iLmEtbx4uke7mvSePG5vQn4vxUVHb34/Wz8uUhKBTo++Gqv555rOaews
         66QK7MkHx/32Cu91aw3uNNRzQRRhiYJ0+JPLTGagNtUtJPPeD01JrNY4FVdJNAOXUa/B
         TFUHKKpUvRfFVOvY0KJJkOLg1GiqruXYjbrzkjOUk4BB85hU8imbz0g2M6Av1b6QPZjG
         c4f5bLMx+yea8bt9ZJQepN8ULTHlV3qpB/orblMaI7k9Xt8X+LrSXJZDb5TZ5/yctSnU
         AGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383347; x=1699988147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F33xq5Mgs3IYtFG5bTStA5S74EFyo6Vi0hYjrdDVkhY=;
        b=cRO9tFCVKaC1/LJRVaZmVjsp2v85gDAgZL/sLg2uQxfRs7YajKy1bpxalSmqLY4/pK
         QSczsydyykjso4eq1UVM2eQJOEVNwn1myIVXA3M4spFpNIqr7BjjxRvRnl5foAJwfxCE
         dJjYZ5tKiemXVJA2We75jXFAMCVNbQhl6jRvm97IpVUniMfPBYktJ5vnia5VqSljzu2V
         UWFlCVW799m1jArW5qCed/B32aWwZVC3dA4E+H+F9UilUtqAOsGEVk/nJ8fe53WXkkAv
         UQyXAKDvTyvptaQdEjZiJF6lLiwYlY8xTF6zRZFoTHDOhy414vcDKuPCiXQALCN3YYNw
         k0wA==
X-Gm-Message-State: AOJu0YxOs3MMhVNhoY6jxD6Cz0ouTKMDgchVwmea1/k4rbggho/xGtKG
        vSh2xLqjQ9XZ24kujSJVA7I=
X-Google-Smtp-Source: AGHT+IHv+OpuqtzoZIn53hugD5zVP8LeEjugBfyrroW0Ll6SIqNcJ8OaUAz8SazezOGrEsJgS3CsXw==
X-Received: by 2002:a17:902:fa85:b0:1cc:4467:a563 with SMTP id lc5-20020a170902fa8500b001cc4467a563mr23630682plb.3.1699383347568;
        Tue, 07 Nov 2023 10:55:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id je5-20020a170903264500b001cc530c495asm163886plb.113.2023.11.07.10.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:55:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Nov 2023 10:55:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/128] 5.15.138-rc1 review
Message-ID: <90f5338e-15f0-427b-bae5-8789e6d7d9df@roeck-us.net>
References: <20231106130309.112650042@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:02:40PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.138 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 158 fail: 2
Failed builds:
	i386:tools/perf
	x86_64:tools/perf
Qemu test results:
	total: 509 pass: 509 fail: 0

The perf build failures have already been reported, so I won't go
into detail.

Guenter

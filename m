Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA647E48CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjKGSyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKGSyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:54:16 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D124999;
        Tue,  7 Nov 2023 10:54:14 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso6004434b3a.2;
        Tue, 07 Nov 2023 10:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699383254; x=1699988054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcovPiqh3ZN8EmlsfBuDM5UBPxHcc18AWG1aumkNSb0=;
        b=WHdENny/wEmfqwEtd+VOnYMbIOTK8S9WtAEMd6fMTB9Uy3OjjSAWBYVm233mREwx6y
         EiDTYrrCTS7TcqTM+MUp423VqTfS4Sx4Rf1r7+zIUUZXix+PPLuoLO2xhrFr8426PX0G
         rcthp7WCEyzYxmWB6wOFE/1ONI/8KQebYEhniZywOWHXd2L3ZzQWgnaOrtNP4hsulv8k
         AEIHlTS6VN11fKGS/pb4dUembtaOYDmgog8ArFOI0GN1/5n/aVs6rnXVUc87dXHE9ZX4
         m1VwP03pRrxtWt3NsKCo0DfX63+0TBZWG77xe3oF3QSnRPri6Ggb1wNgARk+HGAUBsIB
         m50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383254; x=1699988054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcovPiqh3ZN8EmlsfBuDM5UBPxHcc18AWG1aumkNSb0=;
        b=nFnT3fmiPl4/4GKLfYWXFY/HOY7k8rdLsrElHZKxDjokIYMJ2DyuZOud2GnZ9HjmTF
         3JYvuGn2OJ/4Oc5oM6arNJgyridU+e6yko4Y5MSI+RVUEtJ89KrfuSAyhk3wkFv7aRbQ
         30C868YbpaiJ9SGHf25CdKEUSKrnVEE9PajlrlPnJCcIfNPP8NWNaxjGlO5r2wfIOcYe
         5yA6lADY9gRDP2CcOrmjlgBvWfmO5kt0YgjHziahCdGmzsCbBDp0FtzFA13JscifKAgu
         L6GCCz25V69PqkwxMgMMXMCnDcSt2oc4Mdl19xd09d765WFz6XEsBkqc7j22qpkvfDZt
         theA==
X-Gm-Message-State: AOJu0YySZGqZ1SvmTVuc1KGPNdqB6mdwcxlIu47iMbmxAHchz3C3KDAf
        T5maIg6G4g+9j2YODN9YlKI=
X-Google-Smtp-Source: AGHT+IERFM9k2Z7HrqAlDdPa4kjbDT1FL4xRcV63M/IKwDXhc97xffoYlPz1/GSE2Bda5/giJ5UMTQ==
X-Received: by 2002:a05:6a21:47c1:b0:181:a230:d3fb with SMTP id as1-20020a056a2147c100b00181a230d3fbmr16550790pzc.17.1699383254268;
        Tue, 07 Nov 2023 10:54:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f29-20020a056a000b1d00b006c03fa6300dsm7549396pfu.117.2023.11.07.10.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:54:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Nov 2023 10:54:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/62] 6.1.62-rc1 review
Message-ID: <07b2c463-ab45-4631-9e02-cd44f63746c0@roeck-us.net>
References: <20231106130301.807965064@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:03:06PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.62 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 529 pass: 529 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

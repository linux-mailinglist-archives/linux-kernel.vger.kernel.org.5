Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1179E7FB089
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjK1Cy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1Cy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:54:27 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03731A3;
        Mon, 27 Nov 2023 18:54:33 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d64c1155a8so3323610a34.2;
        Mon, 27 Nov 2023 18:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701140073; x=1701744873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXG7yYq+gzZKwaIr6oNQcjt6SGtfnc8h+m5ojKiAAHk=;
        b=a8UnWcOJGO8WQcjg8Ii1yStDGoGVFJavjPZxOmvpL+gy4Rvkp9nXE0jxNaJglTYhZb
         aLGERfLujmnOMt7M9B/pM7FH/4eSgY5vARoMlFd167PlqPtv1a+6an7ehDgHcfVT+zb1
         /AmWIpHU2qsiS141V8xKJE0sN4LhV8gs/OJhAiehuoBF6pmO4l0cKQM7+j1xB8E+BmmG
         o6bkSF7WVplSGxrEPLFfsZ2f6XGXSejAZd6jTpHeoBY/v6ejJfC7xAKo9PdZ88TJSI5v
         Hek59DTscEvOxzmiZYfs3XMftMlSWNWpwE/IKEG2zNmpSimYvOrOys5YDDeZWAqiHawQ
         T4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701140073; x=1701744873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXG7yYq+gzZKwaIr6oNQcjt6SGtfnc8h+m5ojKiAAHk=;
        b=RVUpLsPYbtSsryIutPPJFqIvIOWw0zK1QpTeENCGfLxs2FCX4nGkzJvWJuScDf41OP
         bmyntgtRKMdvxcXbiMSSEk2L3U3PocdmGpQQ/bzdeBYS5H9i8PUx9PU/nQHSF6bPHU9m
         044XvVBcH9DoC9Ka08Bi14y5xgNOFovvP+sPk/ik6PVf1MBtvR6LSYBiqlhebrCW2AOL
         LdPfHBDagDF0qGjoSebRcPYXRD+cXpXiYOGWpQ9DmcorQiAMDLPr/uyYqZS+Jds03JvS
         4gKBkyKlyBmWHaItnJUgwzn9ZREGpAPQTFXEqZar+01lN+8E/5XiNpWaQTgdk3JDf/RG
         Hr4g==
X-Gm-Message-State: AOJu0Yyco2JNM8NMWmVGwrEYg94aRREdY9pjM6+uI5r8ra7RxDsCe5t3
        XQlM4R1H6Pjgo0ZoP2Uog+w=
X-Google-Smtp-Source: AGHT+IGMItql6/9OgBmgcM57vuT+mVS0uORZ/2iVRrSjWrvWmM2TDewTz3SzPWvPZhW+bDRcyjbffA==
X-Received: by 2002:a05:6870:c98b:b0:1f9:9ad0:cd3d with SMTP id hi11-20020a056870c98b00b001f99ad0cd3dmr19483078oab.4.1701140073264;
        Mon, 27 Nov 2023 18:54:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id wx20-20020a0568707e1400b001fa38903b92sm1207745oab.15.2023.11.27.18.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 18:54:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 27 Nov 2023 18:54:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 6.5 000/483] 6.5.13-rc4 review
Message-ID: <c4432a43-3187-46f8-b848-46dd72c7715a@roeck-us.net>
References: <20231126154413.975493975@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154413.975493975@linuxfoundation.org>
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

On Sun, Nov 26, 2023 at 03:47:04PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.13 release.
> There are 483 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 

For v6.5.12-484-gecc37a3a8d33:

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

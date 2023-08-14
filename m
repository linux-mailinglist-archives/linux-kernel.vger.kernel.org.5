Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E977BFC2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjHNSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjHNSYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:24:24 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D3171E;
        Mon, 14 Aug 2023 11:24:20 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3491568afd4so15071925ab.0;
        Mon, 14 Aug 2023 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692037459; x=1692642259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZDklDNQJpAN7KPXalyCNclz9eeHqWLCM+NxvkRxFaU=;
        b=N8H07U/I5GgzIPOK/S65R903olCLdbQCoQiVfM96zFvIejZvc9WeofRmF0Sh2RGzHL
         zCzXQx9wc9OX4cLfVps5UWq7AdjdiTuam4qlB8ixt6/0/a0iBUTs/rbVJL1m0/5qDUg8
         aDmPOTSThu2b2Svgde38PC/J/MIAaWZWKS0B64IKtJP1DpTlK2ZuNKll/dGiFQPFjyR+
         lT3vswl9TXWYeLrTE77QpaEGJrfXAV+8FjKd2JOIrbAOoHyYLtAs8CmsCNkLd9zB+r+c
         6MUDEV/qq33wTkk02gtwG2TMeV6R1IwoFAoJGquqWbaYi4/Jt5aTMSM2KnLrIABsLcHh
         PtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692037459; x=1692642259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZDklDNQJpAN7KPXalyCNclz9eeHqWLCM+NxvkRxFaU=;
        b=ic53wZc9JsD1qqGpfJ5lJhyaklwNsfn0faISpik0d+yFZp32iEQaCK5tDO5Ff8rmRd
         EhyTte+D8psR7MdM2z3ldwP54uhSPSokIbOFa1jiIyK4snxZmG4BOlc8HbxeSQ5ZnNUJ
         hVL6qrD1/k0vfh6D8tzwXETlX+IjQVaDLTVSsxcjGyIcJmWZ0rkuYZpN0eFxXMFK2CO6
         FzLPTYKWMMOOoh86O2z1O2PVH4s21vNV0jYOV5EwHHRSML5LJd3D/Qqzd4WnhdYtfQ8m
         ZG4PjiW3QbDHYB6sfMHQiqkx/p5EcX44d1INdgnem0zdwnFZYmFYmHPJZX7+VmNMeiHE
         KuhQ==
X-Gm-Message-State: AOJu0YzOaH6LsXLRK77JZlBEdWoq8F2EMW3bHVD00/q9hnem5xcvsmnz
        Qo7sqFRRU+7bv1J6evVITYy+lSniBSk=
X-Google-Smtp-Source: AGHT+IENfY1ebaSlzPk7gUjp6hvKBvoVikVUlX5UkJWyd7QkXd7OH+A+7T2kh2EcgCiPHcNzRq+IaA==
X-Received: by 2002:a05:6e02:2190:b0:349:5059:a017 with SMTP id j16-20020a056e02219000b003495059a017mr17071139ila.17.1692037459496;
        Mon, 14 Aug 2023 11:24:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b9-20020a92ce09000000b003491422ca27sm3322585ilo.45.2023.08.14.11.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:24:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Aug 2023 11:24:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/68] 5.10.191-rc1 review
Message-ID: <a6891135-ad39-42a0-a361-c94564804f87@roeck-us.net>
References: <20230813211708.149630011@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
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

On Sun, Aug 13, 2023 at 11:19:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.191 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 487 pass: 487 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

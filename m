Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF0C7E0FFF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 15:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjKDO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjKDO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 10:58:34 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CFDD42;
        Sat,  4 Nov 2023 07:58:31 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a86b6391e9so36167417b3.0;
        Sat, 04 Nov 2023 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699109911; x=1699714711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RCIFmDrTCEZ9fkuE9JYWgeYYH0SPqzgX2A8UTA7/q8=;
        b=GMs9f+Mjx26zGHgiMd9WjEtmemY0ybPN0mu0Gn6jYKjPNh/SzHO5fOSpt6m3fE3C8O
         cmnoWEhW6+uHfUX6A/78t0Bz9Xk/LyCrM0QuDpn9gw3HaQdTm9i5i0er+6PFcowFDl3L
         lw3fdlVDPhxXHmjrCFMA1QFWXgizx2T2lwvP+THJt9y7oL2SVjj9OgT6FEK+5MP1I8nl
         7HV3MJZDRMkjl/YHDJoGL5YWFOeCNRVzqEzoU6CyWZ3sFrspKxlTKnIXDhNmU9NUFvxk
         eJxZ8X/idHVarPmMc00yX6+ShocJPjiRtbw6kuPw8LPLXdowjQU6Y9Q4fvVxd2OGvgoQ
         Xrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699109911; x=1699714711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RCIFmDrTCEZ9fkuE9JYWgeYYH0SPqzgX2A8UTA7/q8=;
        b=cpNF8cNaG7J2J9VjB94xYHEqvwk4OV5GQXgtACmXn1ekBnocKiQNV3MS4HvKUdR59j
         uwHfKUn2M7v20+8BsrmU5veUFwUuCrzQR07KeP/tuXK/6q+2MXfr6B3xFwTmRKCE0kq7
         0BQOGT9I/h3UD8BMc649CpQRYrkEHGCTIT85yQ5cvFbQds0UzBDqV5cBPxedF5FKc68a
         W3/UCtoQ6HWfsGAAIVWazy/f0HvwcUSpxT2vyt+MCz1j/YrVYfgb1rKVKh+25KwWaSNq
         V+VhDc7QrVPEwyE2Zx8Ni1VVxsmFA6M5Y3dlcyTYvKI8cwBtyBZ9dX9pTLireQK2av1j
         ZL1Q==
X-Gm-Message-State: AOJu0YxUZGKLHeDz4b73041tZTHifQ2I/Kx3jaDfHfEQg3hmj1YBKf85
        zTtva/L9xnKfGMCtu9liEhwz7t6PZgs=
X-Google-Smtp-Source: AGHT+IHVHdzUi+Hexm77XHNlzP/CYLjuWUbXPXbgBFV+KzjKNlVr6IoIrK+hnwSpPYOfWEw2YMx4uA==
X-Received: by 2002:a81:788b:0:b0:5a7:d86c:988 with SMTP id t133-20020a81788b000000b005a7d86c0988mr5387059ywc.28.1699109910748;
        Sat, 04 Nov 2023 07:58:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j8-20020a816e08000000b005a8c392f498sm2140238ywc.82.2023.11.04.07.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 07:58:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 4 Nov 2023 07:58:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] hwmon: (dell-smm) Document the WMI SMM interface
Message-ID: <1bfb887d-57ef-4e3b-9514-b9e402bb4f20@roeck-us.net>
References: <20231103185716.11007-1-W_Armin@gmx.de>
 <20231103185716.11007-9-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103185716.11007-9-W_Armin@gmx.de>
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

On Fri, Nov 03, 2023 at 07:57:15PM +0100, Armin Wolf wrote:
> Document the WMI SMM interface so that future developers
> can better understand how it works.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  Documentation/hwmon/dell-smm-hwmon.rst | 33 +++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> index d8f1d6859b96..fea8cf76088e 100644
> --- a/Documentation/hwmon/dell-smm-hwmon.rst
> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> @@ -186,8 +186,7 @@ SMM Interface
>  The driver uses the SMM interface to send commands to the system BIOS.
>  This interface is normally used by Dell's 32-bit diagnostic program or
>  on newer notebook models by the buildin BIOS diagnostics.
> -The SMM is triggered by writing to the special ioports ``0xb2`` and ``0x84``,
> -and may cause short hangs when the BIOS code is taking too long to
> +The SMM may cause short hangs when the BIOS code is taking too long to
>  execute.
> 
>  The SMM handler inside the system BIOS looks at the contents of the
> @@ -210,7 +209,35 @@ The SMM handler can signal a failure by either:
> 
>  - setting the lower sixteen bits of ``eax`` to ``0xffff``
>  - not modifying ``eax`` at all
> -- setting the carry flag
> +- setting the carry flag (legacy SMM interface only)
> +
> +Legacy SMM Interface
> +--------------------
> +
> +When using the legacy SMM interface, a SMM is triggered by writing the least significant byte
> +of the command code to the special ioports ``0xb2`` and ``0x84``. This interface is not
> +described inside the ACPI tables and can thus only be detected by issuing a test SMM call.
> +
> +WMI SMM Interface
> +-----------------
> +
> +On modern Dell machines, the SMM calls are done over ACPI WMI:
> +
> +::
> +
> + #pragma namespace("\\\\.\\root\\dcim\\sysman\\diagnostics")
> + [WMI, Provider("Provider_DiagnosticsServices"), Dynamic, Locale("MS\\0x409"), Description("RunDellDiag"), guid("{F1DDEE52-063C-4784-A11E-8A06684B9B01}")]
> + class LegacyDiags {
> +  [key, read] string InstanceName;
> +  [read] boolean Active;
> +
> +  [WmiMethodId(1), Implemented, read, write, Description("Legacy Method ")] void Execute([in, out] uint32 EaxLen, [in, out, WmiSizeIs("EaxLen") : ToInstance] uint8 EaxVal[], [in, out] uint32 EbxLen, [in, out, WmiSizeIs("EbxLen") : ToInstance] uint8 EbxVal[], [in, out] uint32 EcxLen, [in, out, WmiSizeIs("EcxLen") : ToInstance] uint8 EcxVal[], [in, out] uint32 EdxLen, [in, out, WmiSizeIs("EdxLen") : ToInstance] uint8 EdxVal[]);

I don't think this has to violate formatting rules.

Guenter

> + };
> +
> +Some machines support only the WMI SMM interface, while some machines support both interfaces.
> +The driver automatically detects which interfaces are present and will use the WMI SMM interface
> +if the legacy SMM interface is not present. The WMI SMM interface is usually slower than the
> +legacy SMM interface since ACPI methods need to be called in order to trigger a SMM.
> 
>  SMM command codes
>  -----------------
> --
> 2.39.2
> 

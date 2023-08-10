Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AC2777DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbjHJQRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjHJQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:17:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487B9E75;
        Thu, 10 Aug 2023 09:17:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc65360648so9704155ad.1;
        Thu, 10 Aug 2023 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691684266; x=1692289066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOF4rikTAqnSet00nnYs1BlFsNV8We9b+hBH5WP3K1Q=;
        b=NW7PtI2omRJQwz5j9I47xVSpBtuM0r/jvQSVAu20fW7F6jYOgD7jVMZ/2UpILCqstG
         uAlX5ozKpT6/QTfTRH603TRC2mdKsevqzSoVtMjG2l1kDfgAFUj916IcuCgQ4Id2aqD1
         vjJcZzCdV+TKVoCNAUT0Aa3icjIJo28kYxI4JFgb0cA5d/ACpe96+gkrik5avD+ZVO6K
         N9tYnkKonoKtd74+JkYCS6H4me+tYpcMCKdojau5RsVHv/A/zSB0BYHPZfIJflzPsCsh
         /Lo2pLTwG4dUdqYC6vEZnga+RgbXvlS1UVdZwAxg26ZomVm2XyJa8kfUZrUb+0gMaSAm
         DYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684266; x=1692289066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOF4rikTAqnSet00nnYs1BlFsNV8We9b+hBH5WP3K1Q=;
        b=Un1E6Yk/fCiYEZHoSu9TiTj77GKEik+IKy92nC2DulSgyAi66lNItAQj/3XmhkPstS
         tYBnZ0DvbkToJznEGCKh94XLplhH83jRrl0+oZiUXQROPvWDEHCSBauZMApU4n91we5z
         5bDS79RBeKNapRwUI61OeRKYC/QXZUIAXXPBYVyt7XkjWu3/ViMxgtjuHBlQ/tNBu+Vc
         eJatE9CTUtBrXE/bcdi/+Y2C0M9nYpytkE+sRnDahfdiQudk2UlDLVn9ic18KD1nfQme
         U3FNLkZh4EIrmncL541sxDyfBzred+OBY5d0ahu9qynWjIUnUaIVV9WICs17KrYxhevJ
         jfMA==
X-Gm-Message-State: AOJu0YzG/hz/8SHBkQikhtGSDXdWWfHrHJdDhA15FDFVxaOjTvna6Unp
        l096sdOAFnLK0MkVdNlqOBI=
X-Google-Smtp-Source: AGHT+IFtdnD0Wc5kd3GPuzylx11TdYN81tnwP0NDmtwwhPTKPCCtmkPEWp/DV4T0w7rvUTr6ukuIYg==
X-Received: by 2002:a17:903:489:b0:1b8:475d:ebf6 with SMTP id jj9-20020a170903048900b001b8475debf6mr2870573plb.0.1691684265713;
        Thu, 10 Aug 2023 09:17:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903019100b001bbb25dd3a7sm1968197plg.187.2023.08.10.09.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:17:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Aug 2023 09:17:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 01/15] hwmon: (adt7475) fix Wvoid-pointer-to-enum-cast
 warning
Message-ID: <905ce7b7-4b74-42d5-a0d1-f433a7b6cf2a@roeck-us.net>
References: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
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

On Thu, Aug 10, 2023 at 11:31:43AM +0200, Krzysztof Kozlowski wrote:
> 'chip' is an enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
> 
>   adt7475.c:1655:10: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Series applied.

Thanks,
Guenter

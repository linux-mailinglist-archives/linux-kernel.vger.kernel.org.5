Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C77E790830
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjIBOKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIBOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 10:10:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66C210EB;
        Sat,  2 Sep 2023 07:10:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c1e780aa95so19585955ad.3;
        Sat, 02 Sep 2023 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693663827; x=1694268627; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOjoPdlsy/hK3SkoijywSdUkPheBDdLNqjg4I33Inwg=;
        b=Hk9X/ohbJxP0K573lIr6itXlDVGSb8wVOaECuL6FEFHf0i9HWYzgbWRPtbg79xS0DI
         Cbx4Kti15FYXZpWBX1y/o6kM9pictcWgY9SpgY6eqTDA4U1SUW5JgdGph7YoJF9V9Q84
         flnHHNCby+d2xloHe7X2WGXleT4hphLdbVtLXfcidlp9ePFZEYDSeWaT3DojarPdVxRK
         0Hkw3q2SQINI0HXkUvt57SgbNSZGdxBNKQ40UxFcNhNEZ1Xqnrt/AktR1BNsLAx5LfR0
         NopAT2uGNmHLJ3nYia4j3VUa2Rl7FRd41JmRf+yIVZaJY1K2P0j+B2H61OEq+/nRfLrZ
         Dt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693663827; x=1694268627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOjoPdlsy/hK3SkoijywSdUkPheBDdLNqjg4I33Inwg=;
        b=RYhqPgpKMb09H2HTEJqrjFeB/dAMLW67OyHfvopTRUv5Kl/Z/yOwBsJoevBzfm48MS
         ybhpuN9V5IRQF+Fxzqu1vZPTrQ3WWwisVgXL+SL+qgpIFVI82EZmZx154rJaC5Nku6f6
         IhDBK1kQdljn5+rGBSwpmLC3YvP/rF8sdIwEcoNWFUNB8+CCjlpN9z6k/gi22OnEG2GI
         K94YqlIyECMC5ELW9JSP5y91Ra1Ue3fzKp1qFajmSJS9wR61dh60lT/uTvWePlTA3crX
         vIXJedSkIf64KXEDwAyWqZa//2p2ZuNYwEmSRwcC9mYlGq5M5a69r4t/xXjQfdI8+Sfi
         qHcw==
X-Gm-Message-State: AOJu0YzBdfsNMzDgzoUeiijhq1PvX3zEZyXDcxOZThufk66+tyihqcFe
        t/xedciZt+jSI3tVFoUYWZWC2MKb59A=
X-Google-Smtp-Source: AGHT+IFAeqKNzYGilZTwc9s6+cRhJTi6j1unopmzhK7PfotImS5CVF1oleQ+nqr2gFqxjV/FqDFbeA==
X-Received: by 2002:a17:902:7044:b0:1bd:ca21:c83 with SMTP id h4-20020a170902704400b001bdca210c83mr4066532plt.68.1693663827041;
        Sat, 02 Sep 2023 07:10:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z1-20020a170903018100b001bba373919bsm4649941plg.261.2023.09.02.07.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 07:10:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 2 Sep 2023 07:10:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-usb@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH v4] hwmon: add POWER-Z driver
Message-ID: <56da4837-cfe3-4234-96f7-e7b67358dcdb@roeck-us.net>
References: <20230902-powerz-v4-1-7ec2c1440687@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230902-powerz-v4-1-7ec2c1440687@weissschuh.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 09:47:01AM +0200, Thomas Weiﬂschuh wrote:
> POWER-Z is a series of devices to monitor power characteristics of
> USB-C connections and display those on a on-device display.
> Some of the devices, notably KM002C and KM003C, contain an additional
> port which exposes the measurements via USB.
> 
> This is a driver for this monitor port.
> 
> It was developed and tested with the KM003C.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied to hwmon-next.

Thanks,
Guenter
